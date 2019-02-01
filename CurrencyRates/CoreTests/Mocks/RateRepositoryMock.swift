//
//  RateRepositoryMock.swift
//  CoreTests
//
//  Created by Alexandre Freire on 01/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
@testable import Core

final class RateRepositoryMock: RateRepositoryProtocol {
    func rates(base: Currency, then completion: @escaping (RatesResponse) -> Void, catchError: @escaping (Error) -> Void) {
        let path = Bundle(for: RateRepositoryMock.self).path(forResource: "rates", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let response = try! JSONDecoder().decode(RatesResponse.self, from: data)
        completion(response)
    }
    
    
}
