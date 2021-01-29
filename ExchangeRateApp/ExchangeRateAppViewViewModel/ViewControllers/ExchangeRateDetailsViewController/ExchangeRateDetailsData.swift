//
//  ExchangeRateDetailsData.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel

struct ExchangeRateDetailsData {

    public var dataCount: Int { data.count }
    public var sectionTitle: String { String(format: "Tabela %@ - %@ - %@", details.table, details.code, details.currency.capitalized) }

    private let details: ExchangeRateDetails
    private let data: [ExchangeRateDetailsCellViewModel]

    public init(details: ExchangeRateDetails,
                data: [ExchangeRateDetailsCellViewModel]) {
        self.details = details
        self.data  = data
    }

    public func getCellViewModel(atIndex index: Int) -> ExchangeRateDetailsCellViewModel? {
        return data[index]
    }

}
