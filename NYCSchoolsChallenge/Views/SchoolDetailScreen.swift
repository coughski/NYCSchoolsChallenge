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
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                basicStats
                overview
                testResultsSection
                Spacer()
            }
            .padding()
        }
        .safeAreaInset(edge: .top, alignment: .leading, spacing: 0) {
            schoolNameHeader
        }
    }
    
    var basicStats: some View {
        HStack(alignment: .lastTextBaseline, spacing: 32) {
            Statistic("Borough", statistic: school.borough)
            Statistic("No. of Students", statistic: school.totalStudents, format: .number)
            Statistic("Grad. rate", statistic: school.graduationRate, format: .percent.rounded(rule: .up, increment: 1))
            Statistic("Attend. rate", statistic: school.attendanceRate, format: .percent.rounded(rule: .up, increment: 1))
            Spacer()
        }
    }
    
    var overview: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let overview = school.overview {
                Divider()
                NavigationLink {
                    ScrollView {
                        Text(overview)
                            .font(.system(.title2, design: .rounded))
                            .foregroundColor(.publicNavy)
                            .padding()
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Overview")
                            .foregroundColor(.secondary)
                        HStack(alignment: .center) {
                            Text(overview)
                                .font(.system(.title2, design: .rounded))
                                .foregroundColor(.publicNavy)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }
        }
    }
    
    var schoolNameHeader: some View {
        VStack(spacing: 0) {
            Text(school.name)
                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(.publicNavy)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 8)
            Divider()
        }
        .background(Color(uiColor: .systemBackground))
    }
    
    @ViewBuilder
    var testResultsSection: some View {
        Divider()
        if results == nil {
            Text("SAT score data unavailable")
                .foregroundColor(.secondary)
                .italic()
            
        } else if let results {
            VStack(alignment: .leading, spacing: 16) {
                Text("SAT Scores")
                    .textCase(.uppercase)
                    .font(.headline)
                    .foregroundColor(.publicNavy)
                
                HStack(alignment: .bottom, spacing: 32) {
                    Statistic("Test takers", statistic: results.numOfSatTestTakers, format: .number)
                    Statistic("Reading", statistic: results.satCriticalReadingAvgScore, format: .number)
                    Statistic("Math", statistic: results.satMathAvgScore, format: .number)
                    Statistic("Writing", statistic: results.satWritingAvgScore, format: .number)
                    Spacer()
                }
            }
        }
    }
}

struct SchoolDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SchoolDetailScreen(school: School.sampleData[0], results: TestResults.sampleData[0])
        }
    }
}
