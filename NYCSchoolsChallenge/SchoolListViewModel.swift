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
    @Published private(set) var testResults = [TestResults]()
    
    private static let schoolDirectoryURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    private static let testResultsURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    
    func fetchData() async {
        async let callSchools: Void = fetchSchools()
        async let callResults: Void = fetchTestResults()
        let _ = await [callSchools, callResults]
    }
    
    private func fetchSchools() async {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        schools = (try? decoder.decode(SchoolDirectoryResponse.self, from: School.sampleJSON.data(using: .utf8)!)) ?? []
//        
        do {
            schools = try await NetworkingManager.shared.request(Self.schoolDirectoryURL)
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
            testResults = try await NetworkingManager.shared.request(Self.testResultsURL)
        } catch {
            dump(error)
        }
    }
}
