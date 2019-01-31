//
//  RateListAssembly.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

final class RateListAssembly {
    
    // MARK: Properties
    let webServiceAssembly: WebServiceAssembly
    
    // MARK: Initialization
    init(webServiceAssembly: WebServiceAssembly) {
        self.webServiceAssembly = webServiceAssembly
    }
    
    func viewController() -> UIViewController {
        return RateListViewController(viewModel: viewModel(), cellPresenter: cellPresenter())
    }
    
    func viewModel() -> RateListViewModelProtocol {
        return RateListViewModel(repository: repository())
    }
    
    func repository() -> RateRepositoryProtocol {
        return RateRepository(webService: webServiceAssembly.webService)
    }
    
    func cellPresenter() -> RateCellPresenter {
        return RateCellPresenter()
    }
}
