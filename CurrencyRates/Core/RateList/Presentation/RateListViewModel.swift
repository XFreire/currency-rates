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
    var didGetError: (Error) -> Void { get set }
    func didLoad()
    func item(at index: Int) -> Item?
}

class RateListViewModel: RateListViewModelProtocol {
    
    // MARK: Properties
    private var items: [Item]
    private let repository: RateRepositoryProtocol
    private var timer = Timer()
    private var rates: [Currency : Double]
    var didUpdateRates: ([Item]) -> Void = { _ in }
    var didGetError: (Error) -> Void = { _ in }
    var baseCurrency: Currency {
        didSet {
            print("currency: \(baseCurrency)")
        }
    }
    
    var baseAmount: Double {
        didSet {
            print("amount: \(baseAmount)")
            items = calculateItems(with: baseCurrency, and: baseAmount)
            didUpdateRates(items)
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
        self.rates = [Currency : Double]()
    }
    
    func didLoad() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getRatesMultipliedByCurrentAmount), userInfo: nil, repeats: true)
    }
    
    @objc private func getRatesMultipliedByCurrentAmount() {
        repository.rates(base: baseCurrency, then: { [weak self] response in
            guard let self = self else { return }
            self.baseCurrency = response.base
            self.rates = response.rates
            
            self.items = self.calculateItems(with: self.baseCurrency, and: self.baseAmount)
            
            DispatchQueue.main.async {
                self.didUpdateRates(self.items)
            }
            
            }, catchError: { [weak self] in
                self?.didGetError($0)
        })
    }
    func item(at index: Int) -> Item? {
        guard index < count else { return nil }
        return items[index]
    }
}

extension RateListViewModel {
    @discardableResult
    func calculateItems(with currency: Currency, and amount: Double) -> [Item] {
        var items = [Item]()
        
        // Append current currency to items array
        items.append((currency: self.baseCurrency, amount: self.baseAmount))
        
        // Append rates
        let ratesMultipliedByCurrentAmount = rates
            .mapValues { $0 * baseAmount }
            .map{ (currency: $0, amount: $1) }
            .sorted{ $1.currency.rawValue > $0.currency.rawValue }
        
        items.append(contentsOf: ratesMultipliedByCurrentAmount)
        
        return items
    }
}
