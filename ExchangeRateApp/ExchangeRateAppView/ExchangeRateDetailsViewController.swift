//
//  ExchangeRateDetailsViewController.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel

public class ExchangeRateDetailsViewController: BaseViewController<ExchangeRateDetailsViewModel> {

    public override init(viewModel: ExchangeRateDetailsViewModel) {
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { nil }

}
