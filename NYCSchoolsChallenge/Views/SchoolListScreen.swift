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
            .navigationBarTitleDisplayMode(.inline)
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
                navigationTitle
                sortMenu
            }
        }
    }
    
    @ToolbarContentBuilder
    var navigationTitle: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("")
        }
        ToolbarItem(placement: .navigationBarLeading) {
            Text("High schools")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundColor(.publicNavy)
                .padding(.bottom, 6)
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
