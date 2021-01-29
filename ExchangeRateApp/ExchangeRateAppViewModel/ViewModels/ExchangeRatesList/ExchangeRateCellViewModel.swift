//
//  ExchangeRateCellViewModel.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppCommon

public class ExchangeRateCellViewModel {

    public var exchangeRateCodeCurrencyName: String {
        return R.string.localizable.exchangeRatesListViewControllerExchangeRateCellExchangeRateCodeCurrencyNameLabelText(code, currency)
    }

    public var exchangeRateDate: String? {
        switch table.table {
        case ExchangeRateTable.tableA.rawValue, ExchangeRateTable.tableB.rawValue:
            return R.string.localizable.exchangeRatesListViewControllerExchangeRateCellExchangeRateDateLabelEffectiveText(table.effectiveDate ?? "")
        case ExchangeRateTable.tableC.rawValue:
            return R.string.localizable.exchangeRatesListViewControllerExchangeRateCellExchangeRateDateLabelTradingEffectiveText(table.tradingDate ?? "", table.effectiveDate ?? "")
        default:
            return nil
        }
    }

    public var averageExchangeRate: String? {
        switch table.table {
        case ExchangeRateTable.tableA.rawValue, ExchangeRateTable.tableB.rawValue:
            return R.string.localizable.exchangeRatesListViewControllerExchangeRateCellExchangeRateLabelTablesABText(rate.mid ?? 0.0)
        case ExchangeRateTable.tableC.rawValue:
            return R.string.localizable.exchangeRatesListViewControllerExchangeRateCellExchangeRateLabelTableCText(rate.bid ?? 0.0, rate.ask ?? 0.0)
        default:
            return nil
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
