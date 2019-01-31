//
//  CurrencyRatesResponseTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class RatesResponseTests: XCTestCase {

    final class Dummy {}
    
    var response: RatesResponse!
    
    override func setUp() {
        let path = Bundle(for: Dummy.self).path(forResource: "rates", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        response = try! JSONDecoder().decode(RatesResponse.self, from: data)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRatesResponseExistence() {
        XCTAssertNotNil(response)
    }
    
    func testRateResponse_FromJSON_ReturnsTheCorrectData() {
        XCTAssertEqual(response.base, Currency.EUR)
        XCTAssertEqual(response.rates.count, 32)
    }
    
    func testRateResponse_RateForCurrency_ReturnsTheCorrectRate() {
        XCTAssertEqual(response.rate(for: .GBP), 0.90181)
        XCTAssertNil(response.rate(for: .EUR))
    }
}
