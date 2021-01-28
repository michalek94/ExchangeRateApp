//
//  ExchangeRatesListViewModel.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppService
import ExchangeRateAppCommon

public protocol ExchangeRatesListViewModelFlowDelegate: class {
    func onExchangeRateDetailsNeeded(in table: ExchangeRateTable, with currencyName: String, _ currencyCode: String)
}

public protocol ExchangeRatesListViewModelDelegate: class {
    func onDataLoadingStarted()
    func onDataLoadingFinished()
    func onDataReady()
}

public class ExchangeRatesListViewModel: BaseViewModel {

    public weak var flowDelegate: ExchangeRatesListViewModelFlowDelegate?
    public weak var delegate: ExchangeRatesListViewModelDelegate?

    public var viewTitle: String { R.string.localizable.exchangeRatesListViewControllerViewTitle() }
    public var segmentTitles: [String] { ExchangeRateTable.allCases.map { $0.rawValue } }
    
    private var sectionData: [ExchangeRatesTableSectionData] = []
    private var table: ExchangeRateTable {
        didSet {
            guard oldValue != table else { return }
            resetData()
            fetchRates(with: table)
        }
    }

    private let interactor: ExchangeRatesListInteractor

    public init(interactor: ExchangeRatesListInteractor) {
        self.interactor = interactor
        self.table = .tableA
        super.init()
    }

    private func fetchRates(with table: ExchangeRateTable,
                            silent: Bool = false,
                            isReloading: Bool = false,
                            completion: (() -> ())? = nil) {
        if interactor.manager.isInternetReachable {
            notifyLoadingStartedIfNeeded(silent: silent)
            interactor.fetchExchangeRatesList(with: table) { [weak self] response in
                self?.notifyLoadingFinishedIfNeeded(silent: silent)
                switch response.result {
                case .success(let tables):
                    if !tables.isEmpty {
                        self?.handleFetchSuccess(tables: tables, isReloading: isReloading)
                    } else {
                        self?.handleEmptyFetch(silent: silent, completion: completion)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion?()
            }
        } else {
            print("There is no internet connection!")
        }
    }

    private func notifyLoadingStartedIfNeeded(silent: Bool) {
        if !silent { delegate?.onDataLoadingStarted() }
    }

    private func notifyLoadingFinishedIfNeeded(silent: Bool) {
        if !silent { delegate?.onDataLoadingFinished() }
    }

    private func handleFetchSuccess(tables: [ExchangeRatesTable], isReloading: Bool) {
        if isReloading {
            sectionData = tables.map {
                let table = $0
                let cellViewModels = table.rates.map { ExchangeRateCellViewModel(table: table, rate: $0) }
                return ExchangeRatesTableSectionData(table: table,
                                                     data: cellViewModels)
            }
        } else {
            sectionData.append(contentsOf:
                                tables.map {
                                    let table = $0
                                    let cellViewModels = table.rates.map { ExchangeRateCellViewModel(table: table, rate: $0) }
                                    return ExchangeRatesTableSectionData(table: table,
                                                                         data: cellViewModels)
            })
        }
        delegate?.onDataReady()
    }

    private func handleEmptyFetch(silent: Bool, completion: (() -> ())?) {
        sectionData = []
        notifyLoadingFinishedIfNeeded(silent: silent)
        completion?()
        delegate?.onDataReady()
    }

    public func loadData() {
        fetchRates(with: table, silent: false, isReloading: false, completion: nil)
    }

    private func reloadData(completion: @escaping () -> ()) {
        fetchRates(with: table, silent: true, isReloading: true, completion: completion)
    }
    
    private func resetData() {
        sectionData = []
        delegate?.onDataReady()
    }
    
    private func getCellViewModel(atIndexPath indexPath: IndexPath) -> ExchangeRateCellViewModel? {
        return sectionData[indexPath.section].getCellViewModel(atIndex: indexPath.row)
    }

    private func didSelectRowAt(_ indexPath: IndexPath) {
        let selectedViewModel = getCellViewModel(atIndexPath: indexPath)
        guard let currencyCode = selectedViewModel?.code, let currencyName = selectedViewModel?.currency else { return }
        flowDelegate?.onExchangeRateDetailsNeeded(in: table, with: currencyCode, currencyName)
    }

}

extension ExchangeRatesListViewModel: ExchangeRatesListViewDelegate {
    public func onSegmentedControlSelected(inView view: ExchangeRatesListView, sender: SegmentedControl) {
        table = ExchangeRateTable.allCases[sender.selectedSegmentIndex]
    }
}

extension ExchangeRatesListViewModel: RefreshableTableViewDelegate {
    public func refresh(completion: @escaping () -> ()) { reloadData(completion: completion) }
}

extension ExchangeRatesListViewModel: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { didSelectRowAt(indexPath) }
}

extension ExchangeRatesListViewModel: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int { sectionData.count }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sectionData[section].dataCount }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExchangeRateCell = tableView.dequeueReusableCell(for: indexPath)
        cell.changeCellBackgroundColorIfNeeded(indexPath.row % 2 == 0)
        cell.setupCell(with: getCellViewModel(atIndexPath: indexPath))
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { sectionData[section].sectionTitle }
}
