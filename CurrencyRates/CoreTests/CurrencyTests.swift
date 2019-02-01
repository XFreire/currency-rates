//
//  CurrencyTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class CurrencyTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrencyHasName() {
        let currency: Currency = .EUR
        XCTAssertNotNil(currency.name)
        XCTAssertEqual(currency.name, "Euro")
    }
    
    func testCurrencyHashable() {
        let currency: Currency = .EUR
        XCTAssertNotNil(currency.hashValue)
    }

}
