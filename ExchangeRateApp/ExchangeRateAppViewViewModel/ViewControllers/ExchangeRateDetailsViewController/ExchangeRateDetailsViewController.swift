//
//  ExchangeRateDetailsViewController.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class ExchangeRateDetailsViewController: BaseViewController<ExchangeRateDetailsViewModel> {
    
    private var exchangeRateDetailsView: ExchangeRateDetailsView { view as! ExchangeRateDetailsView }

    public override init(viewModel: ExchangeRateDetailsViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) { nil }
    
    public override func loadView() {
        view = ExchangeRateDetailsView()
        setupSubviews()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        exchangeRateDetailsView.setupView(with: viewModel)
    }
    
    private func setupSubviews() {
       
    }

}

extension ExchangeRateDetailsViewController: ExchangeRateDetailsViewModelDelegate {
    public func onDataLoadingStarted() {
        exchangeRateDetailsView.tableView.showLoadingFooterIfNeeded(true)
    }

    public func onDataLoadingFinished() {
        exchangeRateDetailsView.tableView.showLoadingFooterIfNeeded(false)
    }

    public func onDataReady() {
        exchangeRateDetailsView.tableView.reloadData()
    }
}
