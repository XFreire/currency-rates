//
//  RateListViewModel.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

typealias Item = (currency: Currency, amount: Double)

protocol RateListViewModelProtocol {
    var baseCurrency: Currency { get set }
    var baseAmount: Double { get set }
    var count: Int { get }
    
    func didLoad(then completion: () -> Void)
    func item(at index: Int) -> Item?
}


