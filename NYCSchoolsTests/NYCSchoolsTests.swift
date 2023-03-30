//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by Kuba Szulaczkowski on 3/30/23.
//

import XCTest
@testable import class NYCSchoolsChallenge.NetworkingManager
@testable import class NYCSchoolsChallenge.SchoolListViewModel

final class NYCSchoolsTests: XCTestCase {
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testDecodingSampleSchools() throws {
        _ = try decoder.decode(SchoolDirectoryResponse.self, from: School.sampleJSON.data(using: .utf8)!)
    }

    func testDecodingSampleTestResults() throws {
        _ = try decoder.decode(TestResultsResponse.self, from: TestResults.sampleJSON.data(using: .utf8)!)
    }
    
    func testRequestAndDecodeSchoolsAPI() async throws {
        let _: SchoolDirectoryResponse = try await NetworkingManager.shared.request(SchoolListViewModel.schoolDirectoryURL)
    }
    
    func testRequestAndDecodeTestResultsAPI() async throws {
        let _: TestResultsResponse = try await NetworkingManager.shared.request(SchoolListViewModel.testResultsURL)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
