//
//  ExchangeRateDetailsViewModel.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppService

public protocol ExchangeRateDetailsViewModelFlowDelegate: class {

}

public protocol ExchangeRateDetailsViewModelDelegate: class {

}

public class ExchangeRateDetailsViewModel: BaseViewModel {
    
    public weak var flowDelegate: ExchangeRateDetailsViewModelFlowDelegate?
    public weak var delegate: ExchangeRateDetailsViewModelDelegate?
        
    private let interactor: ExchangeRateDetailsInteractor
    
    public init(interactor: ExchangeRateDetailsInteractor) {
        self.interactor = interactor
    }
    
}
