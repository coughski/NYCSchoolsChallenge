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
                actionRow
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
    
    var actionRow: some View {
        HStack(alignment: .bottom, spacing: 32) {
            if let website = school.website, let url = URL(string: website) {
                Link(destination: url) {
                    VStack {
                        Image(systemName: "link")
                            .imageScale(.large)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.boardBlue)
                            .frame(width: 40, height: 40)
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.boardBlue, lineWidth: 2)
                            }
                        Text("Website")
                    }
                }
//                .frame(width: 70)
            }
            
            if let email = school.email, let url = URL(string: "mailto:\(email)") {
                Link(destination: url) {
                    VStack {
                        Image(systemName: "envelope.fill")
                            .imageScale(.large)
                            .fontWeight(.light)
                            .foregroundColor(.schoolOrange)
                            .frame(width: 41, height: 41)
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.schoolOrange, lineWidth: 2)
                            }
                        Text("Email")
                    }
                }
//                .frame(width: 60)
            }
            
            if let phone = school.phoneNumber, let url = URL(string: "tel:\(phone)") {
                Link(destination: url) {
                    VStack {
                        Image(systemName: "phone.fill")
                            .imageScale(.large)
                            .fontWeight(.light)
                            .foregroundStyle(Color.nycGreen)
                            .frame(width: 39, height: 39)
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.nycGreen, lineWidth: 2)
                            }
                        Text("Phone")
                    }
                }
//                .frame(width: 60)
            }
            
            if let latitude = school.latitude, let longitude = school.longitude {
                var urlComponents = URLComponents(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)&z=18")
                let _ = urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: school.name))
                if let url = urlComponents?.url {
                    
                    Link(destination: url) {
                        VStack {
                            Image(systemName: "map.fill")
                                .imageScale(.large)
                                .fontWeight(.light)
                                .foregroundStyle(Color.brown)
                                .frame(width: 39, height: 39)
                                .background {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.brown, lineWidth: 2)
                                }
                            Text("Map")
                        }
                    }
                    
                }
//                    .frame(width: 40)
            }
            
            Spacer()
        }
        .foregroundColor(.publicNavy)
    }
    
    @ViewBuilder
    var basicStats: some View {
        Divider()
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
        .background(Material.thick)
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
                
                ScoreChart(scores: results)
            }
        }
    }
}

struct SchoolDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SchoolDetailScreen(school: School.sampleData[1], results: TestResults.sampleData[1])
        }
    }
}
