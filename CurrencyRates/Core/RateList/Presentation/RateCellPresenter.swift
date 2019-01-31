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
        cell.titleLabel.text = item.currency.name
        cell.subtitleLabel.text = item.currency.rawValue
        
        cell.textField.text = "\(item.amount)"
    }
}
