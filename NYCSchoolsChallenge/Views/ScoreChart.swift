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
            
            BarMark(
                x: .value("Score", scores.satMathAvgScore ?? 0),
                y: .value("Section", "Math")
            )
            .foregroundStyle(Color.nycGreen)
            
            BarMark(
                x: .value("Score", scores.satWritingAvgScore ?? 0),
                y: .value("Section", "Writing")
            )
            .foregroundStyle(Color.schoolOrange)
        }
        .chartXScale(domain: [0, 800])
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 8))
        }
        .chartYAxis {
            AxisMarks(values: .automatic, stroke: StrokeStyle(lineWidth: 0))
        }
        .frame(height: 200)
    }
}

struct ScoreChart_Previews: PreviewProvider {
    static var previews: some View {
        ScoreChart(scores: TestResults.sampleData[0])
    }
}
