//
//  ExchangeRatesListViewController.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class ExchangeRatesListViewController: BaseViewController<ExchangeRatesListViewModel> {

    private var exchangeRatesListView: ExchangeRatesListView { view as! ExchangeRatesListView }

    public override init(viewModel: ExchangeRatesListViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) { nil }
    
    public override func loadView() {
        view = ExchangeRatesListView()
        setupSubviews()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        exchangeRatesListView.setupView(with: viewModel)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    private func setupSubviews() {
        exchangeRatesListView.tableView.delegate = viewModel
        exchangeRatesListView.tableView.dataSource = viewModel
        exchangeRatesListView.tableView.refreshDelegate = viewModel
        exchangeRatesListView.delegate = viewModel
    }

}

extension ExchangeRatesListViewController: ExchangeRatesListViewModelDelegate {
    public func onDataLoadingStarted() {
        exchangeRatesListView.tableView.showLoadingFooterIfNeeded(true)
    }

    public func onDataLoadingFinished() {
        exchangeRatesListView.tableView.showLoadingFooterIfNeeded(false)
    }

    public func onDataReady() {
        exchangeRatesListView.tableView.reloadData()
    }
}
