//
//  ExchangeRatesTable.swift
//  ExchangeRateAppModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class ExchangeRatesTable: Codable {

    public let table: String
    public let no: String
    public let tradingDate: String?
    public let effectiveDate: String?
    public let rates: [Rate]

}
