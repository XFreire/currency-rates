//
//  RateListViewControllerMock.swift
//  CoreTests
//
//  Created by Alexandre Freire on 01/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit
@testable import Core

class RateListViewControllerMock: RateListViewController {

    // MARK: Properties
    
    var didUpdateRatesCalled: Bool = false
    var textDidChangeCalled: (Bool, String?)?
    var setupBindingsCalled = false
    var setTextFieldAsFirstResponderCalled = false
    
    // MARK: Initialization
    override init(viewModel: RateListViewModelProtocol, cellPresenter: RateCellPresenter) {
        super.init(viewModel: viewModel, cellPresenter: cellPresenter)
        tableView = UITableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didUpdateRates = { [weak self] _ in
            self?.didUpdateRatesCalled = true 
        }
        // Do any additional setup after loading the view.
    }
    
    override func textDidChange(textField: UITextField) {
        super.textDidChange(textField: textField)
        textDidChangeCalled = (true, textField.text)
    }
    
    override func setupBindings(with cell: RateCell) {
        super.setupBindings(with: cell)
        setupBindingsCalled = true
    }
    
    override func setTextFieldAsFirstResponder(_ textField: UITextField) {
        super.setTextFieldAsFirstResponder(textField)
        setTextFieldAsFirstResponderCalled = true
    }
}
