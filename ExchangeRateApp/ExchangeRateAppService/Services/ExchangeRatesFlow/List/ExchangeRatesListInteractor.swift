//
//  ExchangeRatesListInteractor.swift
//  ExchangeRateAppService
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import Alamofire

public protocol ExchangeRatesListInteracting {
    func fetchExchangeRatesList(with table: ExchangeRateTable,
                                completionHandler: ((DataResponse<[ExchangeRatesTable], AFError>) -> ())?)
}

public class ExchangeRatesListInteractor: ConnectionService, ExchangeRatesListInteracting {
    public func fetchExchangeRatesList(with table: ExchangeRateTable,
                                       completionHandler: ((DataResponse<[ExchangeRatesTable], AFError>) -> ())?) {
        let urlString: String = String(format: "%@%@/%@", manager.baseUrl, "exchangerates/tables", table.rawValue)
        let url: URL = URL(string: urlString)!
        manager.requestArray(url, completionHandler: completionHandler)
    }
}
