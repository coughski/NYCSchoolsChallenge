//
//  SchoolListScreen.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

import SwiftUI

struct SchoolListScreen: View {
    let schools: [School]
    let results: [TestResults]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(schools, id: \.dbn) { school in
                    NavigationLink {
                        SchoolDetailScreen(school: school, results: resultsFor(school))
                    } label: {
                        SchoolListItem(school: school)
                    }
                }
            }
            .navigationTitle("High Schools")
        }
    }
}

extension SchoolListScreen {
    func resultsFor(_ school: School) -> TestResults? {
        results.first { $0.dbn == school.dbn }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListScreen(schools: School.sampleData, results: TestResults.sampleData)
    }
}
