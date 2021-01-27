//
//  ExchangeRateCellViewModel.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppCommon

public class ExchangeRateCellViewModel {
    
    private let rateModel: RateModel
    
    public init(rateModel: RateModel) {
        self.rateModel = rateModel
    }
    
}
