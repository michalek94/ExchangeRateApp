//
//  AppDataProvider.swift
//  ExchangeRateAppCommon
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public protocol CustomHeadersProvider {
    var customHeaders: [String: String] { get }
}

public class AppDataProvider: CustomHeadersProvider {

    public var customHeaders: [String: String] {
        return ["Accept": "application/json"]
    }

    public init() { }

}
