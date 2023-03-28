//
//  ScoreChart.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/27/23.
//

import SwiftUI
import Charts

struct ScoreChart: View {
    let scores: TestResults
    
    var body: some View {
        Chart {
            BarMark(
                x: .value("Score", scores.satCriticalReadingAvgScore ?? 0),
                y: .value("Section", "Reading")
            )
            .foregroundStyle(Color.boardBlue)
            .cornerRadius(8, style: .continuous)
            .annotation(position: .overlay, alignment: .trailing, spacing: 12) {
                Text("Reading")
                    .font(.system(.title3, design: .rounded))
                    .bold()
                    .foregroundColor(Color(uiColor: .systemBackground))
            }
            .annotation(position: .trailing, alignment: .trailing, spacing: 8) {
                Text("\(scores.satCriticalReadingAvgScore ?? 0)")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.publicNavy)
            }
            
            BarMark(
                x: .value("Score", scores.satMathAvgScore ?? 0),
                y: .value("Section", "Math")
            )
            .foregroundStyle(Color.nycGreen)
            .cornerRadius(8, style: .continuous)
            .annotation(position: .overlay, alignment: .trailing, spacing: 12) {
                Text("Math")
                    .font(.system(.title3, design: .rounded))
                    .bold()
                    .foregroundColor(Color(uiColor: .systemBackground))
            }
            .annotation(position: .trailing, alignment: .trailing, spacing: 8) {
                Text("\(scores.satMathAvgScore ?? 0)")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.publicNavy)
            }
            
            BarMark(
                x: .value("Score", scores.satWritingAvgScore ?? 0),
                y: .value("Section", "Writing")
            )
            .foregroundStyle(Color.schoolOrange)
            .cornerRadius(8, style: .continuous)
            .annotation(position: .overlay, alignment: .trailing, spacing: 12) {
                Text("Writing")
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(Color(uiColor: .systemBackground))
            }
            .annotation(position: .trailing, alignment: .trailing, spacing: 8) {
                Text("\(scores.satWritingAvgScore ?? 0)")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.publicNavy)
            }
        }
        .chartXScale(domain: [0, 800], range: .plotDimension(endPadding: 50))
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 8))
        }
        .chartYAxis {
            AxisMarks(values: .automatic) {
                AxisValueLabel(offsetsMarks: false) {}
            }
        }
        .frame(height: 200)
    }
}

struct ScoreChart_Previews: PreviewProvider {
    static var previews: some View {
        ScoreChart(scores: TestResults(dbn: "", numOfSatTestTakers: nil, satCriticalReadingAvgScore: 0, satMathAvgScore: 100, satWritingAvgScore: 800))
    }
}
