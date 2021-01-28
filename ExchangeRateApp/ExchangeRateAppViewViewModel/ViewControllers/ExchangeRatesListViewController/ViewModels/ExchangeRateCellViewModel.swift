//
//  ExchangeRateCellViewModel.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppCommon

public class ExchangeRateCellViewModel {
    
    public var exchangeRateCodeCurrencyName: String {
        R.string.localizable.exchangeRateCellTitleLabelText(rate.code, rate.currency)
    }

    public var exchangeRateDate: String? {
        switch table.table {
        case ExchangeRateTable.tableA.rawValue, ExchangeRateTable.tableB.rawValue:
            return R.string.localizable.exchangeRateCellExchangeRateDateLabelEffectiveText(table.effectiveDate ?? "")
        case ExchangeRateTable.tableC.rawValue:
            return R.string.localizable.exchangeRateCellExchangeRateDateLabelTradingEffectiveText(table.tradingDate ?? "", table.effectiveDate ?? "")
        default: return nil
        }
    }

    public var averageExchangeRate: String? {
        switch table.table {
        case ExchangeRateTable.tableA.rawValue, ExchangeRateTable.tableB.rawValue:
            return R.string.localizable.exchangeRateCellExchangeRateLabelABText(rate.mid ?? 0.0)
        case ExchangeRateTable.tableC.rawValue:
            return R.string.localizable.exchangeRateCellExchangeRateLabelCText(rate.bid ?? 0.0, rate.ask ?? 0.0)
        default: return nil
        }
    }
    
    public var code: String { rate.code }
    public var currency: String { rate.currency }
    
    private let table: ExchangeRatesTable
    private let rate: Rate
    
    public init(table: ExchangeRatesTable,
                rate: Rate) {
        self.table = table
        self.rate = rate
    }
    
}
