//
//  School.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

typealias SchoolDirectoryResponse = [School]

struct School {
    let dbn: String
    let name: String
    
    let overview: String?
    let phoneNumber: String?
    let email: String?
    let website: String?
    
    let totalStudents: Int?
    let graduationRate: Double?
    let attendanceRate: Double?
    let latitude: Double?
    let longitude: Double?
    let borough: String?
}

extension School: Decodable {
    enum CodingKeys: String, CodingKey {
        case dbn, phoneNumber, website, totalStudents, graduationRate, attendanceRate, latitude, longitude, borough
        case name = "schoolName"
        case overview = "overviewParagraph"
        case email = "schoolEmail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        name = try values.decode(String.self, forKey: .name)
        
        overview = try? values.decode(String.self, forKey: .overview)
        phoneNumber = try? values.decode(String.self, forKey: .phoneNumber)
        email = try? values.decode(String.self, forKey: .email)
        website = try? values.decode(String.self, forKey: .website)
        
        totalStudents = Int(try values.decode(String.self, forKey: .totalStudents))
        graduationRate = Double((try? values.decode(String.self, forKey: .graduationRate)) ?? "")
        attendanceRate = Double((try? values.decode(String.self, forKey: .attendanceRate)) ?? "")
        latitude = Double((try? values.decode(String.self, forKey: .latitude)) ?? "")
        longitude = Double((try? values.decode(String.self, forKey: .longitude)) ?? "")
        borough = try? values.decode(String.self, forKey: .borough)
    }
}

extension School {
    static let sampleData = [
        School(dbn: "21K728", name: "Liberation Diploma Plus High School", overview: "", phoneNumber: "", email: "", website: "", totalStudents: 206, graduationRate: nil, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BROOKLYN"),
        School(dbn: "08X282", name: "Women's Academy of Excellence", overview: "", phoneNumber: "", email: "", website: "", totalStudents: 338, graduationRate: 0.612999976, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BRONX    ")
    ]
}
