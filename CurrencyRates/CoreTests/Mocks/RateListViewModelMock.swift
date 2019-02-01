//
//  RateListViewModelMock.swift
//  CoreTests
//
//  Created by Alexandre Freire on 01/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
@testable import Core

final class RateListViewModelMock: RateListViewModel {

    var didLoadCalled: Bool = false
    
    override func didLoad() {
        super.didLoad()
        didLoadCalled = true 
    }
}
