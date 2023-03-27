//
//  SchoolListScreen.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

import SwiftUI

struct SchoolListScreen: View {
    let schools: [School]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(schools, id: \.dbn) { school in
                    NavigationLink {
                        SchoolDetailScreen(school: school, results: TestResults.sampleData[0])
                    } label: {
                        SchoolListItem(school: school)
                    }
                }
            }
            .navigationTitle("High Schools")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListScreen(schools: School.sampleData)
    }
}
