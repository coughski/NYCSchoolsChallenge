//
//  SchoolListViewModelSuccessTests.swift
//  NYCSchoolsTests
//
//  Created by Kuba Szulaczkowski on 4/30/23.
//

import XCTest
@testable import NYCSchoolsChallenge

final class SchoolListViewModelSuccessTests: XCTestCase {
    func testSuccessfulLoadSchoolList() async {
        let networkingMock: any NetworkingManagerImpl = NetworkingManagerSchoolResponseSuccessMock()
        let viewModel = SchoolListViewModel(networkingManager: networkingMock)
        XCTAssertTrue(viewModel.schools.isEmpty)
        await viewModel.fetchSchools()
        XCTAssertFalse(viewModel.schools.isEmpty)
    }
}
