//
//  Dependencies.swift
//  ExchangeRateApp
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppService
import ExchangeRateAppCommon

public class Dependencies {
    
    public let dataProvider: AppDataProvider = AppDataProvider()
    public let connectionManager: ConnectionManager
    public let environment: AppEnvironment = AppEnvironment()
    
    init() {
        connectionManager = ConnectionManager(dataProvider: dataProvider,
                                              environment: environment)
    }
    
}
