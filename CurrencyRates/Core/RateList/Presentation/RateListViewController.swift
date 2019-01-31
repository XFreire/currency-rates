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
        }
    }
    
    // MARK: Properties
    private let viewModel: RateListViewModelProtocol
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.rates { [weak self] in
            self?.tableView.reloadData()
        }
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
        
        // UITextField becomes first responder
        tappedCell.textField.becomeFirstResponder()
        
        // Move tappedCell to the top
        tableView.moveRow(at: indexPath, to: topIndexPath)
        
        guard let secondCell = tableView.cellForRow(at: secondRowIndexPath) as? RateCell else {
            return
        }
        
        // Disable text field of second cell
        secondCell.textField.isUserInteractionEnabled = false
         
        #warning("Add textfield delegate or notifications")
    }
}
