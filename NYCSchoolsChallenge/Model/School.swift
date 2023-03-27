//
//  School.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

typealias SchoolDirectoryResponse = [School]

struct School {
    let dbn: String
    let schoolName: String
    let totalStudents: Int?
    let graduationRate: Double?
    let borough: String?
}

extension School: Decodable {
    enum CodingKeys: CodingKey {
        case dbn, schoolName, totalStudents, graduationRate, borough
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        schoolName = try values.decode(String.self, forKey: .schoolName)
        totalStudents = Int(try values.decode(String.self, forKey: .totalStudents))
        graduationRate = Double((try? values.decode(String.self, forKey: .graduationRate)) ?? "")
        borough = try? values.decode(String.self, forKey: .borough)
    }
}

extension School {
    static let sampleData = [
        School(dbn: "21K728", schoolName: "Liberation Diploma Plus High School", totalStudents: 206, graduationRate: nil, borough: "BROOKLYN")
    ]
}
