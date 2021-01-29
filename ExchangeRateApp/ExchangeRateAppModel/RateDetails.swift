//
//  RateDetails.swift
//  ExchangeRateAppModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class RateDetails: Codable {

    public let no: String?
    public let effectiveDate: String?
    public let bid: Double?
    public let mid: Double?
    public let ask: Double?

}
