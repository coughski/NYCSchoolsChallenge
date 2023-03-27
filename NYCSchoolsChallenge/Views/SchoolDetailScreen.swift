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
        VStack(alignment: .leading, spacing: 48) {
            VStack(alignment: .leading, spacing: 8) {
//                Text(school.schoolName)
//                    .font(.title2)
                
                HStack(spacing: 32) {
                    if let borough = school.borough {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Borough")
                                .foregroundColor(.secondary)
                            Text(borough.localizedCapitalized)
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(Color("publicNavy"))
                        }
                    }
                    
                    if let numStudents = school.totalStudents {
                        VStack(alignment: .leading) {
                            Text("Students")
                                .foregroundColor(.secondary)
                            Text("\(numStudents)")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(Color("publicNavy"))
                        }
                    }
                    
                    if let gradRate = school.graduationRate {
                        VStack(alignment: .leading) {
                            Text("Grad. rate")
                                .foregroundColor(.secondary)
                            Text("\(gradRate.formatted(.percent.rounded(rule: .up, increment: 0.1)))")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(Color("publicNavy"))
                        }
                    }
                    
                    Spacer()
                }
            }
//            .padding()
//            .background {
//                RoundedRectangle(cornerRadius: 16, style: .continuous)
//                    .foregroundStyle(.white)
//                    .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
//            }
            
            testResultsSection
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
        .navigationTitle(school.name)
    }
    
    @ViewBuilder
    var testResultsSection: some View {
        if results == nil {
            Text("SAT score data unavailable")
                .foregroundColor(.secondary)
                .italic()
        } else if let results {
            VStack(alignment: .leading, spacing: 16) {
                Divider()
                
                Text("SAT Scores")
                    .font(.title2)
                
                HStack(alignment: .bottom, spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("Test takers")
                            .foregroundColor(.secondary)
                        Text("\(results.numOfSatTestTakers ?? 0)")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(Color("publicNavy"))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Reading")
                            .foregroundColor(.secondary)
                        Text("\(results.satCriticalReadingAvgScore ?? 0)")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(Color("publicNavy"))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Math")
                            .foregroundColor(.secondary)
                        Text("\(results.satMathAvgScore ?? 0)")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(Color("publicNavy"))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Writing")
                            .foregroundColor(.secondary)
                        Text("\(results.satWritingAvgScore ?? 0)")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(Color("publicNavy"))
                    }
                    
                    Spacer()
                }
//                .padding()
//                .background {
//                    RoundedRectangle(cornerRadius: 16, style: .continuous)
//                        .foregroundStyle(.white)
//                        .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
//                }
            }
        }
    }
}

struct SchoolDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SchoolDetailScreen(school: School.sampleData[1], results: TestResults.sampleData[0])
        }
    }
}
