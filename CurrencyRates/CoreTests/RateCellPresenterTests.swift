//
//  RateCellPresenter.swift
//  CoreTests
//
//  Created by Alexandre Freire on 01/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class RateCellPresenterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRateCellPresenter_PresentItemInCell_FillDataCorrectly() {
        let item: Item = (.EUR, 2.5)
        let cell = RateCell.instantiate()
        let presenter = RateCellPresenter()
        
        presenter.present(item, in: cell)
        
        XCTAssertEqual(cell.titleLabel.text, item.currency.rawValue)
        XCTAssertEqual(cell.subtitleLabel.text, item.currency.name)
        XCTAssertEqual(cell.textField.text, "2.5000")
    }

}
