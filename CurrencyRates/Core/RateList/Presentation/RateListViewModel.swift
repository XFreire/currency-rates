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
    var didUpdateRates: ([Item]) -> Void { get set }
    func didLoad()
    func item(at index: Int) -> Item?
}

final class RateListViewModel: RateListViewModelProtocol {
    
    // MARK: Properties
    private var items: [Item]
    private let repository: RateRepositoryProtocol
    private var timer = Timer()
    
    var didUpdateRates: ([Item]) -> Void = { _ in }
    
    var baseCurrency: Currency {
        didSet {
            print("currency: \(baseCurrency)")
        }
    }
    
    var baseAmount: Double {
        didSet {
            print("amount: \(baseAmount)")
        }
    }
    
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
    
    func didLoad() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getRatesMultipliedByCurrentAmount), userInfo: nil, repeats: true)
    }
    
    @objc private func getRatesMultipliedByCurrentAmount() {
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
            
            DispatchQueue.main.async {
                self.didUpdateRates(self.items)
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
