//
//  ExchangeRatesListViewController.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel

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
        viewModel.loadData()
    }

    private func setupSubviews() {
        exchangeRatesListView.delegate = self
        exchangeRatesListView.tableView.delegate = self
        exchangeRatesListView.tableView.dataSource = self
        exchangeRatesListView.tableView.refreshDelegate = self
    }

}

extension ExchangeRatesListViewController: ExchangeRatesListViewModelDelegate {
    public func onDataLoadingStarted() {
        LoaderView.shared.showActivityIndicator(inView: view)
    }

    public func onDataLoadingFinished() {
        LoaderView.shared.hideActivityIndicator()
    }

    public func onDataReady(isReloading: Bool) {
        if !isReloading {  exchangeRatesListView.tableView.setContentOffset(.zero, animated: false) }
        exchangeRatesListView.tableView.reloadData()
    }
}

extension ExchangeRatesListViewController: ExchangeRatesListViewDelegate {
    public func onSegmentedControlSelected(inView view: ExchangeRatesListView, sender: SegmentedControl) {
        viewModel.setTable(withIndex: sender.selectedSegmentIndex)
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
    public func numberOfSections(in tableView: UITableView) -> Int { viewModel.numberOfSections }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection(inSection: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExchangeRateCell = tableView.dequeueReusableCell(for: indexPath)
        cell.changeCellBackgroundColorIfNeeded(indexPath.row % 2 == 0)
        cell.setupCell(with: viewModel.getCellViewModel(atIndexPath: indexPath))
        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitleForHeaderInSection(inSection: section)
    }
}
