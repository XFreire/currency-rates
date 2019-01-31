//
//  RateRepository.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol RateRepositoryProtocol {
    func rates(base: Currency, then completion: (RatesResponse) -> Void, catchError: (Error) -> Void)
}
