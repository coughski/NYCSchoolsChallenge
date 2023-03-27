//
//  TestResults.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

typealias TestResultsResponse = [TestResults]

struct TestResults {
    let dbn: String
    let schoolName: String
    let numOfSatTestTakers: Int?
    
    let satCriticalReadingAvgScore: Int?
    let satMathAvgScore: Int?
    let satWritingAvgScore: Int?
}

extension TestResults: Decodable {
    enum CodingKeys: CodingKey {
        case dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore, satMathAvgScore, satWritingAvgScore
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        schoolName = try values.decode(String.self, forKey: .schoolName)
        numOfSatTestTakers = Int(try values.decode(String.self, forKey: .numOfSatTestTakers))
        
        satCriticalReadingAvgScore = Int(try values.decode(String.self, forKey: .satCriticalReadingAvgScore))
        satMathAvgScore = Int(try values.decode(String.self, forKey: .satMathAvgScore))
        satWritingAvgScore = Int(try values.decode(String.self, forKey: .satWritingAvgScore))
    }
}

extension TestResults {
    static let sampleData = [
        TestResults(dbn: "21K728", schoolName: "LIBERATION DIPLOMA PLUS", numOfSatTestTakers: 10, satCriticalReadingAvgScore: 411, satMathAvgScore: 369, satWritingAvgScore: 373),
        TestResults(dbn: "08X282", schoolName: "WOMEN'S ACADEMY OF EXCELLENCE", numOfSatTestTakers: 44, satCriticalReadingAvgScore: 407, satMathAvgScore: 386, satWritingAvgScore: 378)
    ]
}
