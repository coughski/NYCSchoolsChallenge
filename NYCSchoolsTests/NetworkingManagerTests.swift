//
//  NetworkingManagerTests.swift
//  NYCSchoolsTests
//
//  Created by Kuba Szulaczkowski on 4/29/23.
//

import Foundation
import XCTest
@testable import class NYCSchoolsChallenge.NetworkingManager

class NetworkingManagerTests: XCTestCase {
    func testSuccessfulValidResponse() async throws {
        guard let path = Bundle.main.path(forResource: "SchoolsStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static schools file")
            return
        }
        
        let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLSessionProtocol.self]
        let session = URLSession(configuration: config)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let staticSchools = try! decoder.decode(SchoolDirectoryResponse.self, from: data)
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let response: SchoolDirectoryResponse = try await NetworkingManager.shared.request(session: session, url.absoluteString)
        
        XCTAssertEqual(staticSchools, response)
    }
}
