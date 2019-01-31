//
//  RateRepository.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol RateRepositoryProtocol {
    func rates(base: Currency, then completion: @escaping (RatesResponse) -> Void, catchError: @escaping (Error) -> Void)
}

final class RateRepository: RateRepositoryProtocol {
    
    // MARK: Properties
    private let webService: WebService
    
    // MARK: Initialization
    init(webService: WebService) {
        self.webService = webService
    }
    
    // MARK: RateRepositoryProtocol
    func rates(base: Currency, then completion: @escaping (RatesResponse) -> Void, catchError: @escaping (Error) -> Void) {
        webService.load(RatesResponse.self, from: .rates(base: base.rawValue), then: {
            completion($0)
        }, catchError: {
            catchError($0)
        })
    }
}
