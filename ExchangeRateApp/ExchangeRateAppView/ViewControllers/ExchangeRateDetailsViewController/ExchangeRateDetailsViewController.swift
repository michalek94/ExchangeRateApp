//
//  ExchangeRateDetailsViewController.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel

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
        viewModel.loadData()
    }

    private func setupSubviews() {
        exchangeRateDetailsView.topBar.delegate = self
        exchangeRateDetailsView.selectableView.delegate = self
        exchangeRateDetailsView.tableView.dataSource = self
        exchangeRateDetailsView.tableView.refreshDelegate = self
    }

}

extension ExchangeRateDetailsViewController: ExchangeRateDetailsViewModelDelegate {
    public func onDataLoadingStarted() {
        LoaderView.shared.showActivityIndicator(inView: view)
    }

    public func onDataLoadingFinished() {
        LoaderView.shared.hideActivityIndicator()
    }

    public func onDataReady() {
        exchangeRateDetailsView.tableView.reloadData()
    }

    public func onPickedDate(dateFrom: String?, dateTo: String?) {
        exchangeRateDetailsView.updateSelectableSubviews(with: dateFrom, dateTo: dateTo)
    }
    
    public func onSearchAvailable(_ available: Bool) {
        exchangeRateDetailsView.setAvailabilityToButtons(available)
    }
}

extension ExchangeRateDetailsViewController: NavigationTopBarViewDelegate {
    public func leftButtonTapped(inView view: NavigationTopBarView, sender: UIButton) {
        viewModel.onBackRequested()
    }
}

extension ExchangeRateDetailsViewController: SelectableViewDelegate {
    public func onDateFromSelected(inView view: SelectableView, sender: DropDownTextField) {
        exchangeRateDetailsView.configureDateFromPickerView(with: viewModel)
    }
    
    public func onDateToSelected(inView view: SelectableView, sender: DropDownTextField) {
        exchangeRateDetailsView.configureDateToPickerView(with: viewModel)
    }
    
    public func onClearTapped(inView view: SelectableView, sender: UIButton) {
        exchangeRateDetailsView.clearForm()
        viewModel.clearDates()
        viewModel.loadData()
    }
    
    public func onDownloadTapped(inView view: SelectableView, sender: UIButton) {
        viewModel.loadData()
    }
}

extension ExchangeRateDetailsViewController: RefreshableTableViewDelegate {
    public func refresh(completion: @escaping () -> ()) {
        viewModel.reloadData(completion: completion)
    }
}

extension ExchangeRateDetailsViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExchangeRateDetailsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.changeCellBackgroundColorIfNeeded(indexPath.row % 2 == 0)
        cell.setupCell(with: viewModel.getCellViewModel(atIndexPath: indexPath))
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection
    }
}
