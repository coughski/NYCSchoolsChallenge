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
        
        overview = (try? values.decode(String.self, forKey: .overview))?.replacingOccurrences(of: "Â", with: "")
        
        phoneNumber = try? values.decode(String.self, forKey: .phoneNumber)
        email = try? values.decode(String.self, forKey: .email)
        
        var rawWebsite = try? values.decode(String.self, forKey: .website)
        if let rawWebsite {
            website = !rawWebsite.hasPrefix("http") ? "http://" + rawWebsite : rawWebsite
        } else {
            website = nil
        }
        
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
        School(dbn: "08X282", name: "Women's Academy of Excellence", overview: "The Women’s Academy of Excellence is an all-girls public high school, serving grades 9-12. Our mission is to create a community of lifelong learners, to nurture the intellectual curiosity and creativity of young women and to address their developmental needs. The school community cultivates dynamic, participatory learning, enabling students to achieve academic success at many levels, especially in the fields of math, science, and civic responsibility. Our scholars are exposed to a challenging curriculum that encourages them to achieve their goals while being empowered to become young women and leaders. Our Philosophy is GIRLS MATTER!", phoneNumber: "718-542-0740", email: "sburns@schools.nyc.gov", website: "schools.nyc.gov/SchoolPortals/08/X282", totalStudents: 338, graduationRate: 0.612999976, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BRONX    ")
    ]
}
