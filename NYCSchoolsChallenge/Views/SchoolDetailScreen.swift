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
                
                    HStack(alignment: .lastTextBaseline, spacing: 32) {
                        Statistic("Borough", statistic: school.borough)
                        Statistic("No. of Students", statistic: school.totalStudents, format: .number)
                        Statistic("Grad. rate", statistic: school.graduationRate, format: .percent.rounded(rule: .up, increment: 1))
                        Statistic("Attend. rate", statistic: school.attendanceRate, format: .percent.rounded(rule: .up, increment: 1))
                        Spacer()
                    }
                    
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
                
                testResultsSection
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
        .safeAreaInset(edge: .top, alignment: .leading, spacing: 0) {
            VStack(spacing: 0) {
                Text(school.name)
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.publicNavy)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                Divider()
            }
            .background(Color(uiColor: .systemBackground))
        }
    }
    
    @ViewBuilder
    var testResultsSection: some View {
        Divider()
        if results == nil {
            Text("SAT score data unavailable")
                .foregroundColor(.secondary)
                .font(.caption)
                .italic()
            
        } else if let results {
            VStack(alignment: .leading, spacing: 16) {
                Text("SAT Scores")
                    .textCase(.uppercase)
                    .font(.headline)
                    .foregroundColor(.publicNavy)
//                    .bold()
                
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

struct Statistic<Label, Content>: View where Label : View, Content : View {
    let label: Label
    let content: Content
    
    init(@ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.content = content()
    }
    
    var body: some View {
        Group {
            LabeledContent {
                content
            } label: {
                label
            }
        }
        .labeledContentStyle(.vertical)
    }
}

extension Statistic where Label == Text, Content == Text {
    init<S, F>(_ label: S, statistic: F.FormatInput?, format: F) where S : StringProtocol, F : FormatStyle, F.FormatInput : Equatable, F.FormatOutput == String {
        self.label = Text(label)
        
        if let statistic {
            self.content = Text(statistic, format: format)
        } else {
            self.content = Self.placeholder
        }
    }
    
    init<S>(_ label: S, statistic: S?) where S : StringProtocol {
        self.label = Text(label)
        if let statistic {
            self.content = Text(statistic)
        } else {
            self.content = Self.placeholder
        }
    }
    
    private static var placeholder: Text {
        Text("—")
    }
}

struct VerticalLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            configuration.label
                .foregroundColor(.secondary)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            configuration.content
                .font(.system(.title, design: .rounded))
                .foregroundColor(.publicNavy)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
    static var vertical: Self { Self() }
}

struct SchoolDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SchoolDetailScreen(school: School.sampleData[0], results: TestResults.sampleData[0])
        }
    }
}
