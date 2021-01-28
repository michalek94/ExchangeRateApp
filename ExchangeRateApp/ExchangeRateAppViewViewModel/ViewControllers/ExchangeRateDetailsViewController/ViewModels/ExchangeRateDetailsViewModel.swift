//
//  ExchangeRateDetailsViewModel.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppService

public protocol ExchangeRateDetailsViewModelFlowDelegate: class {
    func onBackRequested()
}

public protocol ExchangeRateDetailsViewModelDelegate: class {
    func onDataLoadingStarted()
    func onDataLoadingFinished()
    func onDataReady()
}

public class ExchangeRateDetailsViewModel: BaseViewModel {

    public weak var flowDelegate: ExchangeRateDetailsViewModelFlowDelegate?
    public weak var delegate: ExchangeRateDetailsViewModelDelegate?
    
    public var viewTitle: String { currencyName.capitalized }

    private let interactor: ExchangeRateDetailsInteractor
    private let table: ExchangeRateTable
    private let currencyCode: String
    private let currencyName: String

    public init(interactor: ExchangeRateDetailsInteractor,
                table: ExchangeRateTable,
                currencyCode: String,
                currencyName: String) {
        self.interactor = interactor
        self.table = table
        self.currencyCode = currencyCode
        self.currencyName = currencyName
    }
    
}
