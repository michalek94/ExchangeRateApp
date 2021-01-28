//
//  ExchangeRatesTableSectionData.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 28/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel

struct ExchangeRatesTableSectionData {

    public var dataCount: Int { data.count }
    public var sectionTitle: String { String(format: "Tabela %@.%@ - %@", table.table, table.no, table.effectiveDate ?? "") }

    private let table: ExchangeRatesTable
    private let data: [ExchangeRateCellViewModel]

    public init(table: ExchangeRatesTable,
                data: [ExchangeRateCellViewModel]) {
        self.table = table
        self.data  = data
    }

    public func getCellViewModel(atIndex index: Int) -> ExchangeRateCellViewModel? {
        return data[index]
    }

}
