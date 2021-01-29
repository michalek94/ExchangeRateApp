//
//  ExchangeRateDetailsInteractor.swift
//  ExchangeRateAppService
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import Alamofire

public protocol ExchangeRateDetailsInteracting {
    func fetchExchangeRateDetails(with table: ExchangeRateTable,
                                  code: String,
                                  from fromDate: String?,
                                  to toDate: String?,
                                  completionHandler: ((DataResponse<ExchangeRateDetails, AFError>) -> ())?)
}

public class ExchangeRateDetailsInteractor: ConnectionService, ExchangeRateDetailsInteracting {
    public func fetchExchangeRateDetails(with table: ExchangeRateTable,
                                         code: String,
                                         from fromDate: String?,
                                         to toDate: String?,
                                         completionHandler: ((DataResponse<ExchangeRateDetails, AFError>) -> ())?) {
        var urlString: String = String(format: "%@%@/%@/%@", manager.baseUrl, "exchangerates/rates", table.rawValue, code)
        if let fromDate = fromDate { urlString.append("/\(fromDate)") }
        if let toDate = toDate { urlString.append("/\(toDate)") }
        let url: URL = URL(string: urlString)!
        manager.request(url, completionHandler: completionHandler)
    }
}
