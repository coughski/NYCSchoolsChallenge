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
                ForEach(viewModel.schools, id: \.dbn) { school in
                    NavigationLink {
                        SchoolDetailScreen(school: school, results: resultsFor(school))
                    } label: {
                        SchoolListItem(school: school)
                    }
                }
            }
            .navigationTitle("High Schools")
            .task {
                await viewModel.fetchData()
            }
        }
    }
}

extension SchoolListScreen {
    func resultsFor(_ school: School) -> TestResults? {
        viewModel.testResults.first { $0.dbn == school.dbn }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListScreen()
    }
}
