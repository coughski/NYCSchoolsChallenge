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
    
    @State private var overviewExpanded = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                links
                basicStats
                overview
                testResults
                Spacer()
            }
            .padding()
        }
        .safeAreaInset(edge: .top, alignment: .leading, spacing: 0) {
            schoolNameHeader
        }
    }
    
    var links: some View {
        ScrollView(.horizontal, showsIndicators: false) {
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
                }
                
                Spacer()
            }
        }
        .foregroundColor(.publicNavy)
    }
    
    @ViewBuilder
    var basicStats: some View {
        Divider()
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .lastTextBaseline, spacing: 24) {
                Statistic("Borough", statistic: school.borough?.localizedCapitalized)
                Statistic("Students", statistic: school.totalStudents, format: .number.notation(.compactName))
                Statistic("Grad. rate", statistic: school.graduationRate, format: .percent.rounded(rule: .up, increment: 1))
                Statistic("Attend. rate", statistic: school.attendanceRate, format: .percent.rounded(rule: .up, increment: 1))
            }
        }
    }
    
    var overview: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let overview = school.overview {
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Overview")
                        .foregroundColor(.secondary)
                    VStack(alignment: .trailing, spacing: 8) {
                        Text(overview)
                            .font(.system(.title2, design: .rounded))
                            .foregroundColor(.publicNavy)
                            .multilineTextAlignment(.leading)
                            .lineLimit(overviewExpanded ? Int.max : 5)
                        Button(overviewExpanded ? "LESS" : "MORE") {
                            withAnimation {
                                overviewExpanded.toggle()
                            }
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
    var testResults: some View {
        if let results, let takers = results.numOfSatTestTakers, let reading = results.satCriticalReadingAvgScore, let math = results.satMathAvgScore, let writing = results.satWritingAvgScore {
            Divider()
            VStack(alignment: .leading, spacing: 16) {
                Text("SAT Scores")
                    .textCase(.uppercase)
                    .font(.headline)
                    .foregroundColor(.publicNavy)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom, spacing: 32) {
                        Statistic("Reading", statistic: reading, format: .number)
                        Statistic("Math", statistic: math, format: .number)
                        Statistic("Writing", statistic: writing, format: .number)
                        Statistic("Total", statistic: reading + math + writing, format: .number.grouping(.never))
                        Statistic("Test takers", statistic: takers, format: .number)
                        Spacer()
                    }
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
