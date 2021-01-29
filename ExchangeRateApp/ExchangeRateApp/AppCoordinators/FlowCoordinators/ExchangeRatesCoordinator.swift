//
//  ExchangeRatesCoordinator.swift
//  ExchangeRateApp
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppView
import ExchangeRateAppViewModel
import ExchangeRateAppModel
import ExchangeRateAppService
import ExchangeRateAppCommon

public class ExchangeRatesCoordinator: NavigationFlowCoordinator {
    
    private let window: UIWindow
    private let dependencies: Dependencies
 
    public init(window: UIWindow,
                dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
        super.init()
    }
    
    public override func createMainViewController() -> UIViewController? {
        let interactor = ExchangeRatesListInteractor(manager: dependencies.connectionManager)
        let viewModel = ExchangeRatesListViewModel(interactor: interactor)
        viewModel.flowDelegate = self
        let viewController = ExchangeRatesListViewController(viewModel: viewModel)
        return viewController
    }
    
}

extension ExchangeRatesCoordinator: ExchangeRatesListViewModelFlowDelegate {
    public func onExchangeRateDetailsNeeded(in table: ExchangeRateTable, with currencyCode: String, _ currencyName: String) {
        let interactor = ExchangeRateDetailsInteractor(manager: dependencies.connectionManager)
        let viewModel = ExchangeRateDetailsViewModel(interactor: interactor,
                                                     table: table,
                                                     currencyCode: currencyCode,
                                                     currencyName: currencyName)
        viewModel.flowDelegate = self
        let viewController = ExchangeRateDetailsViewController(viewModel: viewModel)
        push(viewController: viewController)
    }
}

extension ExchangeRatesCoordinator: ExchangeRateDetailsViewModelFlowDelegate {
    public func onBackRequested() {
        popLastViewController()
    }
}
