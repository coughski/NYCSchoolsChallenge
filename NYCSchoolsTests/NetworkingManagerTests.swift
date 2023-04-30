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
    
    func testInvalidStatusCodeFails() async throws {
        let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLSessionProtocol.self]
        let session = URLSession(configuration: config)
        
        let testStatusCode = 404
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: url, statusCode: testStatusCode, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        // ???: assert fails
//        XCTAssertThrowsError({ () async throws -> SchoolDirectoryResponse in try await NetworkingManager.shared.request(session: session, url.absoluteString) })
        
        do {
            let _: SchoolDirectoryResponse = try await NetworkingManager.shared.request(session: session, url.absoluteString)
            XCTFail("Must throw error")
        } catch {
            guard let error = error as? NetworkingManager.NetworkingError else {
                XCTFail("Error must be NetworkingError")
                return
            }
            
            XCTAssertEqual(error, NetworkingManager.NetworkingError.invalidStatusCode(statusCode: testStatusCode), "Status codes must match")
        }
    }
}
