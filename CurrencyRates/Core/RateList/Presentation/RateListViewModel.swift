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
    
    func rates(then completion: @escaping () -> Void)
    func item(at index: Int) -> Item?
}

final class RateListViewModel: RateListViewModelProtocol {
    
    // MARK: Properties
    private var items: [Item]
    private let repository: RateRepositoryProtocol
    
    var baseCurrency: Currency
    
    var baseAmount: Double
    
    var count: Int {
        return items.count
    }
    
    // MARK: Initialization
    init(repository: RateRepositoryProtocol, baseCurrency: Currency  = .EUR) {
        self.repository = repository
        self.items = [Item]()
        self.baseCurrency = baseCurrency
        self.baseAmount = 1.0
    }
    
    func rates(then completion: @escaping () -> Void) {
        repository.rates(base: baseCurrency, then: { [weak self] response in
            guard let self = self else { return }
            self.items = []
            self.baseCurrency = response.base
            
            // Append current currency to items array
            self.items.append((currency: self.baseCurrency, amount: self.baseAmount))
            
            // Append rates
            let ratesMultipliedByCurrentAmount = response.rates.mapValues{ $0 * self.baseAmount }
            
            ratesMultipliedByCurrentAmount.forEach {
                self.items.append((currency: $0, amount: $1))
            }
            
            completion()
            
            }, catchError: { _ in
                #warning("Implement")
        })
    }
    
    private func getRatesMultipliedByCurrentAmount() {
        repository.rates(base: baseCurrency, then: { [weak self] response in
            guard let self = self else { return }
            self.items = []
            self.baseCurrency = response.base
            
            // Append current currency to items array
            self.items.append((currency: self.baseCurrency, amount: self.baseAmount))
            
            // Append rates
            let ratesMultipliedByCurrentAmount = response.rates.mapValues{ $0 * self.baseAmount }
            
            ratesMultipliedByCurrentAmount.forEach {
                self.items.append((currency: $0, amount: $1))
            }
            
            }, catchError: { _ in
                #warning("Implement")
        })
    }
    func item(at index: Int) -> Item? {
        guard index < count else { return nil }
        return items[index]
    }
    
    
}
