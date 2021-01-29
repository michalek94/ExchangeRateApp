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
    func onDataReady(isReloading: Bool)
}

public class ExchangeRatesListViewModel: BaseViewModel {

    public weak var flowDelegate: ExchangeRatesListViewModelFlowDelegate?
    public weak var delegate: ExchangeRatesListViewModelDelegate?

    public var viewTitle: String { R.string.localizable.exchangeRatesListViewControllerViewTitle() }
    public var segmentTitles: [String] { ExchangeRateTable.allCases.map { $0.rawValue } }
    public var numberOfSections: Int { sectionData.count }
    
    private var sectionData: [ExchangeRatesListData] = []
    private var table: ExchangeRateTable {
        didSet {
            guard oldValue != table else { return }
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
                        self?.handleEmptyFetch(silent: silent, isReloading: isReloading, completion: completion)
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
        sectionData = tables.map {
            let table = $0
            let cellViewModels = table.rates.map { ExchangeRateCellViewModel(table: table, rate: $0) }
            return ExchangeRatesListData(table: table,
                                         data: cellViewModels)
        }
        delegate?.onDataReady(isReloading: isReloading)
    }

    private func handleEmptyFetch(silent: Bool, isReloading: Bool, completion: (() -> ())?) {
        sectionData = []
        notifyLoadingFinishedIfNeeded(silent: silent)
        completion?()
        delegate?.onDataReady(isReloading: isReloading)
    }

    public func loadData() {
        fetchRates(with: table, silent: false, isReloading: false, completion: nil)
    }

    public func reloadData(completion: @escaping () -> ()) {
        fetchRates(with: table, silent: true, isReloading: true, completion: completion)
    }
    
    public func getNumberOfRowsInSection(inSection section: Int) -> Int {
        return sectionData[section].dataCount
    }
    
    public func getCellViewModel(atIndexPath indexPath: IndexPath) -> ExchangeRateCellViewModel? {
        return sectionData[indexPath.section].getCellViewModel(atIndex: indexPath.row)
    }
    
    public func getTitleForHeaderInSection(inSection section: Int) -> String? {
        return sectionData[section].sectionTitle
    }
    
    public func setTable(withIndex index: Int) {
        table = ExchangeRateTable.allCases[index]
    }

    public func didSelectRowAt(_ indexPath: IndexPath) {
        let selectedViewModel = getCellViewModel(atIndexPath: indexPath)
        guard let currencyCode = selectedViewModel?.code, let currencyName = selectedViewModel?.currency else { return }
        flowDelegate?.onExchangeRateDetailsNeeded(in: table, with: currencyCode, currencyName)
    }

}
