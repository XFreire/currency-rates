//
//  RateListViewController.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class RateListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(RateCell.self)
            tableView.estimatedRowHeight = 70
        }
    }
    
    // MARK: Properties
    private var viewModel: RateListViewModelProtocol
    private let cellPresenter: RateCellPresenter
    
    // MARK: Initialization
    init(viewModel: RateListViewModelProtocol, cellPresenter: RateCellPresenter) {
        self.viewModel = viewModel
        self.cellPresenter = cellPresenter
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var count = 0
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.didLoad()
        
        viewModel.didUpdateRates = { [weak self] items in
            guard let self = self else { return }

            if self.count == 0 {
                self.tableView.reloadData()
                self.count += 1
            }
            else {
                for i in 1..<items.count {
                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? RateCell else { continue }
                    self.cellPresenter.present(items[i], in: cell)
                }
            }
        }
    }
}

extension RateListViewController {
    @objc func textDidChange(textField: UITextField) {
        guard let numberString = textField.text else { return }
        
        // Bind text to viewModel
        viewModel.baseAmount = Double(numberString) ?? 0
    }
}
extension RateListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(RateCell.self)
        guard let item = viewModel.item(at: indexPath.row) else { return cell }
        
        cellPresenter.present(item, in: cell)
        
        return cell
    }
}

extension RateListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topIndexPath = IndexPath(item: 0, section: 0)
        let secondRowIndexPath = IndexPath(item: 1, section: 0)
        
        guard let tappedCell = tableView.cellForRow(at: indexPath) as? RateCell else {
            return
        }
        // Enable UITextFields of tapped cell
        tappedCell.textField.isUserInteractionEnabled = true
        
        // UITextField becomes first responder and add target
        tappedCell.textField.becomeFirstResponder()
        tappedCell.textField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        // Move tappedCell to the top
        tableView.moveRow(at: indexPath, to: topIndexPath)
        
        guard let secondCell = tableView.cellForRow(at: secondRowIndexPath) as? RateCell else {
            return
        }
        
        // Disable text field of second cell
        secondCell.textField.isUserInteractionEnabled = false
        
        // Bind currency to viewModel
        guard let currencyString = tappedCell.titleLabel.text,
            let currency = Currency(rawValue: currencyString),
            let amountString = tappedCell.textField.text else { return }
    
        viewModel.baseCurrency = currency
        viewModel.baseAmount = Double(amountString) ?? 0
     }
}
