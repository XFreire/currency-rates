//
//  RateRepositoryTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 01/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class RateRepositoryTests: XCTestCase {

    var repository: RateRepositoryProtocol!
    
    override func setUp() {
        repository = RateRepositoryMock()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRateRepositoryExistence() {
        XCTAssertNotNil(repository)
    }
    
    func testRateRepository_SuccessCompletion_ReturnsData() {
        let expectation = self.expectation(description: "testRateRepository_SuccessCompletion_ReturnsData")
        var response: RatesResponse?
        
        repository.rates(base: .EUR, then: {
            response = $0
            expectation.fulfill()
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.base, Currency.EUR)
            XCTAssertEqual(response?.rates.count, 32)
        }, catchError: { _ in
            expectation.fulfill()
            XCTAssertFalse(true, "Should not enter in error clousure")
        })
        
        wait(for: [expectation], timeout: 5)
    }

}
