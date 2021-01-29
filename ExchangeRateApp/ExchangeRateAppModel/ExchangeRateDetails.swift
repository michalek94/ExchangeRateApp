//
//  ExchangeRateDetails.swift
//  ExchangeRateAppModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class ExchangeRateDetails: Codable {

    public let table: String
    public let currency: String
    public let code: String
    public let rates: [RateDetails]

}
