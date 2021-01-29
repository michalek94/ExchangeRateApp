//
//  ExchangeRateDetailsViewModel.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppModel
import ExchangeRateAppService
import ExchangeRateAppCommon

public protocol ExchangeRateDetailsViewModelFlowDelegate: class {
    func onBackRequested()
}

public protocol ExchangeRateDetailsViewModelDelegate: class {
    func onDataLoadingStarted()
    func onDataLoadingFinished()
    func onDataReady()
    func onPickedDate(dateFrom: String?, dateTo: String?)
    func onSearchAvailable(_ available: Bool)
}

public class ExchangeRateDetailsViewModel: BaseViewModel {

    public weak var flowDelegate: ExchangeRateDetailsViewModelFlowDelegate?
    public weak var delegate: ExchangeRateDetailsViewModelDelegate?

    public var viewTitle: String { currencyName.capitalized }
    public var numberOfSections: Int { 1 }
    public var numberOfRowsInSection: Int { sectionData?.dataCount ?? 0 }
    public var titleForHeaderInSection: String? { sectionData?.sectionTitle }

    private var sectionData: ExchangeRateDetailsData?
    private var dateFrom: String? = nil {
        didSet {
            validateForm()
        }
    }
    private var maximumDateFrom: Date? = nil
    private var dateTo: String? = nil {
        didSet {
            validateForm()
        }
    }
    private var minimumDateTo: Date? = nil

    private let interactor: ExchangeRateDetailsInteractor
    private let table: ExchangeRateTable
    private let currencyCode: String
    private let currencyName: String

    public init(interactor: ExchangeRateDetailsInteractor,
                table: ExchangeRateTable,
                currencyCode: String,
                currencyName: String) {
        self.interactor = interactor
        self.table = table
        self.currencyCode = currencyCode
        self.currencyName = currencyName
    }

    private func fetchDetails(with table: ExchangeRateTable,
                              code: String,
                              from fromDate: String? = nil,
                              to toDate: String? = nil,
                              silent: Bool = false,
                              completion: (() -> ())? = nil) {
        if interactor.manager.isInternetReachable {
            notifyLoadingStartedIfNeeded(silent: silent)
            interactor.fetchExchangeRateDetails(with: table,
                                                code: code,
                                                from: fromDate,
                                                to: toDate) { [weak self] response in
                self?.notifyLoadingFinishedIfNeeded(silent: silent)
                switch response.result {
                case .success(let details):
                    if !details.rates.isEmpty {
                        self?.handleFetchSuccess(details: details)
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

    private func handleFetchSuccess(details: ExchangeRateDetails) {
        sectionData = ExchangeRateDetailsData(details: details,
                                              data: details.rates.map { ExchangeRateDetailsCellViewModel(details: details, rate: $0) })
        delegate?.onDataReady()
    }

    private func handleEmptyFetch(silent: Bool, completion: (() -> ())?) {
        sectionData = nil
        notifyLoadingFinishedIfNeeded(silent: silent)
        completion?()
        delegate?.onDataReady()
    }

    public func loadData() {
        fetchDetails(with: table, code: currencyCode, from: dateFrom, to: dateTo, silent: false, completion: nil)
    }

    public func reloadData(completion: @escaping () -> ()) {
        fetchDetails(with: table, code: currencyCode, from: dateFrom, to: dateTo, silent: true, completion: completion)
    }

    public func getCellViewModel(atIndexPath indexPath: IndexPath) -> ExchangeRateDetailsCellViewModel? {
        return sectionData?.getCellViewModel(atIndex: indexPath.row)
    }

    public func getTitleForHeaderInSection(inSection section: Int) -> String? {
        return sectionData?.sectionTitle
    }

    public func onBackRequested() {
        flowDelegate?.onBackRequested()
    }

    public func getDateFromPickerViewModel() -> DatePickerViewModel {
        var selectedDate = Date()
        if let dateFrom = self.dateFrom, let date = AppDateFormatter.shared.date(from: dateFrom) {
            selectedDate = date
        }
        
        let maximumDate = self.maximumDateFrom == nil ? Date() : self.maximumDateFrom
        return DatePickerViewModel(date: selectedDate,
                                   maximumDate: maximumDate) { [weak self] date in
            guard let date = date else { return }
            self?.dateFrom = AppDateFormatter.shared.string(from: date)
            self?.minimumDateTo = date
            self?.delegate?.onPickedDate(dateFrom: self?.dateFrom, dateTo: nil)
        }
    }

    public func getDateToPickerViewModel() -> DatePickerViewModel {
        var selectedDate = Date()
        if let dateTo = self.dateTo, let date = AppDateFormatter.shared.date(from: dateTo) {
            selectedDate = date
        }
        
        let minimumDate = self.minimumDateTo == nil ? nil : self.minimumDateTo
        return DatePickerViewModel(date: selectedDate,
                                   minimumDate: minimumDate,
                                   maximumDate: Date()) { [weak self] date in
            guard let date = date else { return }
            self?.dateTo = AppDateFormatter.shared.string(from: date)
            self?.maximumDateFrom = date
            self?.delegate?.onPickedDate(dateFrom: nil, dateTo: self?.dateTo)
        }
    }

    public func clearDates() {
        self.dateFrom = nil
        self.maximumDateFrom = nil
        self.dateTo = nil
        self.minimumDateTo = nil
    }

    private func validateForm() {
        delegate?.onSearchAvailable(dateFrom != nil && dateTo != nil)
    }

}
