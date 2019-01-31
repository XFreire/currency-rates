//
//  RateCellPresenter.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

final class RateCellPresenter {
    
    func present(_ item: Item, in cell: RateCell) {
        cell.subtitleLabel.text = item.currency.name
        cell.titleLabel.text = item.currency.rawValue
        cell.textField.isUserInteractionEnabled = false
        if item.amount == 0 {
            cell.textField.text = "0"
            cell.textField.placeholder = "0"
        } else {
            cell.textField.text = String(format: "%.4f", item.amount)
        }
    }
}
