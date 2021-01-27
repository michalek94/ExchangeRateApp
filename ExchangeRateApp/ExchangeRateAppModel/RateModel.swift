//
//  RateModel.swift
//  ExchangeRateAppModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class RateModel: Codable {
    
    public let country: String?
    public let symbol: String?
    public let currency: String
    public let code: String
    public let bid: Double?
    public let mid: Double?
    public let ask: Double?
    
}
