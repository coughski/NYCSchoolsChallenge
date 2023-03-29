//
//  SchoolListScreen.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

import SwiftUI

struct SchoolListScreen: View {
    @StateObject private var viewModel = SchoolListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.search(), id: \.dbn) { school in
                    NavigationLink {
                        SchoolDetailScreen(school: school, results: resultsFor(school))
                    } label: {
                        SchoolListItem(school: school)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("High Schools")
            .task {
                await viewModel.fetchData()
            }
            .searchable(text: $viewModel.searchString, tokens: $viewModel.searchTokens, placement: .automatic, prompt: "Search") { token in
                token.tokenView
            }
//            .searchSuggestions {
//                Text("Additional suggestions").searchCompletion("suggestion")
//            }
            .toolbar {
                sortMenu
            }
        }
    }
    
    var sortMenu: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                Picker(selection: $viewModel.sortOrder, label: Text("Sort")) {
                    ForEach(SortOrder.allCases) { sort in
                        HStack {
                            Text(sort.rawValue.localizedCapitalized)
                            Spacer()
                            //                                    if viewModel.sortOrder == sortOrder {
                            //                                        Image(systemName: viewModel.sortAscending ? "chevron.up" : "chevron.down")
                            //                                    }
                        }
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .menuStyle(.button)
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

extension SchoolListScreen {
    func resultsFor(_ school: School) -> TestResults? {
        viewModel.testResults[school.dbn]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListScreen()
    }
}
