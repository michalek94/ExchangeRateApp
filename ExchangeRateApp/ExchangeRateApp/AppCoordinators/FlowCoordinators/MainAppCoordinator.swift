//
//  MainAppCoordinator.swift
//  ExchangeRateApp
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel
import ExchangeRateAppModel
import ExchangeRateAppService
import ExchangeRateAppCommon

public class MainAppCoordinator: NavigationFlowCoordinator {

    private let window: UIWindow
    private let dependencies: Dependencies
 
    public init(window: UIWindow,
                dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
        super.init()
    }
    
    public override func start() {
        super.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        switchToExchangeRatesCoordinator()
    }
    
    private func switchToExchangeRatesCoordinator() {
        let coordinator: ExchangeRatesCoordinator = ExchangeRatesCoordinator(window: window,
                                                                             dependencies: dependencies)
        start(childCoordinator: coordinator)
    }
    
}
