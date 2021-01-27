//
//  ExchangeRatesListViewModel.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppService
import Alamofire

public protocol ExchangeRatesListViewModelFlowDelegate: class {

}

public protocol ExchangeRatesListViewModelDelegate: class {
    func onDataLoadingStarted()
    func onDataLoadingFinished()
    func onDataReady()
}

public class ExchangeRatesListViewModel: BaseViewModel {

    public weak var flowDelegate: ExchangeRatesListViewModelFlowDelegate?
    public weak var delegate: ExchangeRatesListViewModelDelegate?

    private var cellViewModels: [ExchangeRateCellViewModel]? = []

    public var numberOfSections: Int { 1 }
    public var numberOfRowsInSection: Int { cellViewModels?.count ?? 0 }

    public var table: ExchangeRateTable {
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
                case .success(let table):
                    let rates = table.flatMap { $0.rates }
                    if !rates.isEmpty {
                        self?.handleFetchSuccess(rateModels: rates, isReloading: isReloading)
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

    private func handleFetchSuccess(rateModels: [RateModel], isReloading: Bool) {
        if isReloading {
            cellViewModels = rateModels.map { ExchangeRateCellViewModel(rateModel: $0) }
        } else {
            cellViewModels?.append(contentsOf: rateModels.map { ExchangeRateCellViewModel(rateModel: $0) })
        }
        delegate?.onDataReady()
    }

    private func handleEmptyFetch(silent: Bool, completion: (() -> ())?) {
        cellViewModels = []
        notifyLoadingFinishedIfNeeded(silent: silent)
        completion?()
        delegate?.onDataReady()
    }

    public func loadData() {
        fetchRates(with: table, silent: false, isReloading: false, completion: nil)
    }

    public func reloadData(completion: @escaping () -> ()) {
        fetchRates(with: table, silent: true, isReloading: true, completion: completion)
    }

    public func getCellViewModel(atIndexPath indexPath: IndexPath) -> ExchangeRateCellViewModel? {
        return cellViewModels?[indexPath.row]
    }
    
    public func didSelectRowAt(_ indexPath: IndexPath) {
        
    }

}
