//
//  RateCellTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 01/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class RateCellTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRateCellTests_PrepareForReuse_ResetSubviewsValues() {
        let item: Item = (.EUR, 2.5)
        let cell = RateCell.instantiate()
        let presenter = RateCellPresenter()
        
        presenter.present(item, in: cell)
        
        XCTAssertEqual(cell.titleLabel.text, item.currency.rawValue)
        XCTAssertEqual(cell.subtitleLabel.text, item.currency.name)
        XCTAssertEqual(cell.textField.text, "2.5000")
        
        cell.prepareForReuse()
        
        XCTAssertNil(cell.titleLabel.text)
        XCTAssertNil(cell.subtitleLabel.text)
        XCTAssertEqual(cell.textField.text, "")
    }

}
