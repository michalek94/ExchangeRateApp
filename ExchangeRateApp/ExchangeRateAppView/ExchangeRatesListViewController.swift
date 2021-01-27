//
//  ExchangeRatesListViewController.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel

public class ExchangeRatesListViewController: BaseViewController<ExchangeRatesListViewModel> {
    
    // MARK: - Private stored properties
    private var exchangeRatesListView: ExchangeRatesListView { view as! ExchangeRatesListView }

    // MARK: - Internal methods
    public override init(viewModel: ExchangeRatesListViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) { nil }
    
    public override func loadView() {
        view = ExchangeRatesListView()
        setupSubviews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    // MARK: - Private methods
    private func setupSubviews() {
        exchangeRatesListView.tableView.delegate = self
        exchangeRatesListView.tableView.dataSource = self
        exchangeRatesListView.tableView.refreshDelegate = self
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

extension ExchangeRatesListViewController: RefreshableTableViewDelegate {
    public func refresh(completion: @escaping () -> ()) {
        viewModel.reloadData(completion: completion)
    }
}

extension ExchangeRatesListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath)
    }
}

extension ExchangeRatesListViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExchangeRateCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupCell(with: viewModel.getCellViewModel(atIndexPath: indexPath))
        return cell
    }
}
