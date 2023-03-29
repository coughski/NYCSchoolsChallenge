//
//  SchoolListViewModel.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/27/23.
//

import SwiftUI

@MainActor
final class SchoolListViewModel: ObservableObject {
    @Published private(set) var schools = [School]()
    @Published private(set) var testResults = [String: TestResults]()
    
    @Published var sortOrder = SortOrder.name {
        didSet {
            schools.sort(by: sortOrder.predicate)
        }
    }
//    @Published var sortAscending = true
    
    @Published var searchString = ""
    @Published var searchTokens = [SearchToken]()
//    @Published var suggestedSearchTokens = Borough.allTokens + OtherTokenEnum.allTokens
//    @Published private(set) var searchResults = [School]()
    
    func search() -> [School] {
        if !searchString.isEmpty {
            return schools.filter { $0.name.lowercased().contains(searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)) }
        } else {
            return schools
        }
    }
    
    private static let schoolDirectoryURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    private static let testResultsURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    
    func fetchData() async {
        async let callSchools: Void = fetchSchools()
        async let callResults: Void = fetchTestResults()
        let _ = await [callSchools, callResults]
    }
    
    // Given more time, I would display errors to the user in the form of an alert
    private func fetchSchools() async {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        schools = (try? decoder.decode(SchoolDirectoryResponse.self, from: School.sampleJSON.data(using: .utf8)!)) ?? []
//        
        do {
            schools = try await NetworkingManager.shared.request(Self.schoolDirectoryURL)
            schools.sort(by: sortOrder.predicate)
        } catch {
            dump(error)
        }
    }
    
    private func fetchTestResults() async {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        testResults = (try? decoder.decode(TestResultsResponse.self, from: TestResults.sampleJSON.data(using: .utf8)!)) ?? []
//
        do {
            let resultsList: TestResultsResponse = try await NetworkingManager.shared.request(Self.testResultsURL)
            for result in resultsList {
                testResults[result.dbn] = result
            }
        } catch {
            dump(error)
        }
    }
}

enum SortOrder: String, CaseIterable, Identifiable {
    case name
    case size
    
    var id: Self { self }
    
    var predicate: (School, School) -> Bool {
        switch self {
            case .name:
                return { $0.name < $1.name }
            case .size:
                return { $0.totalStudents ?? 0 < $1.totalStudents ?? 0 }
        }
    }
}

protocol Tokenizable: RawRepresentable, CaseIterable, Identifiable where ID == String, RawValue == String {
    var tokenView: Text { get }
}

extension Tokenizable {
    static var allTokens: [SearchToken] {
        allCases.map(\.searchToken)
    }
    
    var searchToken: SearchToken {
        SearchToken(token: self)
    }
    
    var tokenView: Text {
        Text(rawValue)
    }
    
    var id: String { rawValue }
}

//protocol Suggestable: Identifiable {
//    var suggestionView: any View { get }
//    var completion: String { get }
//}

struct SearchToken: Identifiable {
    let token: any Tokenizable
    
    var tokenView: some View {
        token.tokenView
    }
    
    var id: String {
        token.id
    }
}

//extension SearchToken: Suggestable {
//    var suggestionView: any View {
//        tokenView
//    }
//
//    var completion: String {
//        token.rawValue
//    }
//}

enum Borough: String {
    case Bronx
    case Brooklyn
    case Manhattan
    case Queens
    case StatenIsland = "Staten Island"
}

extension Borough: Tokenizable {}

enum OtherTokenEnum: String, Tokenizable {
    case other
}
