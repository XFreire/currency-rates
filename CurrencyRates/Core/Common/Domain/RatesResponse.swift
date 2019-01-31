//
//  RatesResponse.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

struct RatesResponse: Decodable {
    let base: Currency
    let rates: [Currency : Double]
    
    private enum CodingKeys: String, CodingKey {
        case base, rates
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base = try container.decode(Currency.self, forKey: .base)
        let dictionary = try container.decode([String : Double].self, forKey: .rates)
        
        var rates = [Currency : Double]()
        
        dictionary.forEach { key, value in
            guard let currency = Currency(rawValue: key) else {
                return
            }
            rates[currency] = value
        }
        self.rates = rates
    }
    
    func rate(for currency: Currency) -> Double? {
        guard currency != base else {
            return nil 
        }
        return rates[currency]
    }
}
