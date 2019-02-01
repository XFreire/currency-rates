//
//  RateListViewControllerTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 01/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class RateListViewControllerTests: XCTestCase {

    var viewController: RateListViewControllerMock!
    var cellPresenter: RateCellPresenter!
    var viewModel: RateListViewModelMock!
    var repository: RateRepositoryMock!
    
    override func setUp() {
        repository = RateRepositoryMock()
        cellPresenter = RateCellPresenter()
        viewModel = RateListViewModelMock(repository: repository)
        
        viewController = RateListViewControllerMock(viewModel: viewModel, cellPresenter: cellPresenter)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRateListViewController_ViewDidLoad_TableViewDelegateAndDatasourceIsSet() {
        viewController.loadView()
        viewController.viewDidLoad()
        
        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertNotNil(viewController.tableView.delegate)
    }
    
    func testRateListViewController_ViewDidLoad_ViewModelDidLoadIsCalled() {
        viewController.loadView()
        viewController.viewDidLoad()
        
        XCTAssertTrue(viewModel.didLoadCalled)
    }
    
    func testRateListViewController_ViewDidLoad_TableViewHasTheCorrectNumberOfCells() {
        let expectation = self.expectation(description: "testRateListViewController_ViewDidLoad_TableViewHasTheCorrectNumberOfCells")
        viewController.loadViewIfNeeded()
        viewController.viewDidLoad()
        let tableView = viewController.tableView!
        viewModel.didUpdateRates = { _ in
            expectation.fulfill()
            XCTAssertEqual(tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0), 33)
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testsRateViewController_CanDequeueRateCells() {
        let tableView = viewController.tableView
        let cell = tableView?.dequeueReusableCell(RateCell.self)
        XCTAssertNotNil(cell)
    }
}
