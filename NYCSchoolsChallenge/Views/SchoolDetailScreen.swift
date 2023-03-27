//
//  SchoolDetailScreen.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

import SwiftUI

struct SchoolDetailScreen: View {
    let school: School
    let results: TestResults?
    
    var body: some View {
        VStack {
            Text(school.schoolName)
            
            if let results {
                HStack {
                    VStack {
                        Text("Takers")
                        Text("\(results.numOfSatTestTakers ?? 0)")
                    }
                    
                    VStack {
                        Text("Reading")
                        Text("\(results.satCriticalReadingAvgScore ?? 0)")
                    }
                    
                    VStack {
                        Text("Math")
                        Text("\(results.satMathAvgScore ?? 0)")
                    }
                    
                    VStack {
                        Text("Writing")
                        Text("\(results.satWritingAvgScore ?? 0)")
                    }
                }
            }
        }
        .navigationTitle(school.schoolName)
    }
}

struct SchoolDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SchoolDetailScreen(school: School.sampleData[0], results: TestResults.sampleData[0])
        }
    }
}
