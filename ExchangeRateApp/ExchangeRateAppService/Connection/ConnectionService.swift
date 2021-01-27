//
//  ConnectionService.swift
//  ExchangeRateAppService
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class ConnectionService {

    public let manager: ConnectionManager

    public init(manager: ConnectionManager) {
        self.manager = manager
    }

}
