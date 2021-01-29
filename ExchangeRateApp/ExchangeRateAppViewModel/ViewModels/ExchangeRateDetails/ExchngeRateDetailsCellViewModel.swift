//
//  ExchngeRateDetailsCellViewModel.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppCommon

public class ExchangeRateDetailsCellViewModel {
    
    public var exchangeRateTableNo: String {
        return R.string.localizable.exchangeRateDetailsViewControllerExchangeRateDetailsCellExchangeRateTableNoLabelText(rate.no ?? "")
    }
    
    public var exchangeRateDate: String {
        return R.string.localizable.exchangeRateDetailsViewControllerExchangeRateDetailsCellExchangeRateDateLabelEffectiveText(rate.effectiveDate ?? "")
    }

    public var averageExchangeRate: String? {
        switch details.table {
        case ExchangeRateTable.tableA.rawValue, ExchangeRateTable.tableB.rawValue:
            return R.string.localizable.exchangeRateDetailsViewControllerExchangeRateDetailsCellExchangeRateLabelTablesABText(rate.mid ?? 0.0)
        case ExchangeRateTable.tableC.rawValue:
            return R.string.localizable.exchangeRateDetailsViewControllerExchangeRateDetailsCellExchangeRateLabelTableCText(rate.bid ?? 0.0, rate.ask ?? 0.0)
        default:
            return nil
        }
    }

    private let details: ExchangeRateDetails
    private let rate: RateDetails

    public init(details: ExchangeRateDetails,
                rate: RateDetails) {
        self.details = details
        self.rate = rate
    }

}
