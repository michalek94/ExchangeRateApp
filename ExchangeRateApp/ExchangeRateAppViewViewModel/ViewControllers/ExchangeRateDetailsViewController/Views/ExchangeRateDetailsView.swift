//
//  ExchangeRateDetailsView.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 28/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class ExchangeRateDetailsView: BaseView {

    private(set) public lazy var topBar: NavigationTopBarView = { NavigationTopBarView() }()
    private(set) public lazy var selectableView: SelectableView = { SelectableView() }()
    private var dateFromView: DatePickerView?
    private var dateToView: DatePickerView?
    private(set) public lazy var tableView: RefreshableTableView = {
        let tableView = RefreshableTableView()
        var frame: CGRect = .zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView(frame: frame)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(ExchangeRateDetailsCell.self, forCellReuseIdentifier: ExchangeRateDetailsCell.identifier)
        tableView.backgroundColor = .white
        tableView.contentInset.bottom = UIDevice.current.bottomSafeAreaInset
        return tableView
    }()

    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            topBar,
            selectableView,
            tableView
        )
    }

    public override func setupLayout() {
        super.setupLayout()
        topBar.edgesToSuperview(excluding: .bottom)
        
        selectableView.topToBottom(of: topBar)
        selectableView.horizontalToSuperview()
        
        tableView.topToBottom(of: selectableView)
        tableView.edgesToSuperview(excluding: .top)
    }
    
    public override func configureViews() {
        super.configureViews()
    }

    public override func styleViews() {
        super.styleViews()
        backgroundColor = .white
    }

    public func setupView(with viewModel: ExchangeRateDetailsViewModel) {
        topBar.setTitle(viewModel.viewTitle)
        topBar.showHideBackButtonIfNeeded()
        selectableView.setupView(with: viewModel)
    }

    public func configureDateFromPickerView(with viewModel: ExchangeRateDetailsViewModel) {
        let pickerViewModel = viewModel.getDateFromPickerViewModel()
        dateFromView = DatePickerView(viewModel: pickerViewModel)
        dateFromView?.delegate = self
        showDateFromPickerView()
    }

    public func configureDateToPickerView(with viewModel: ExchangeRateDetailsViewModel) {
        let pickerViewModel = viewModel.getDateToPickerViewModel()
        dateToView = DatePickerView(viewModel: pickerViewModel)
        dateToView?.delegate = self
        showDateToPickerView()
    }

    private func showDateFromPickerView() {
        add(dateFromView!)
        dateFromView?.edgesToSuperview()
        dateFromView?.fadeIn()
    }

    private func hideDateFromPickerView() {
        dismissPickers()
    }

    private func showDateToPickerView() {
        add(dateToView!)
        dateToView?.edgesToSuperview()
        dateToView?.fadeIn()
    }

    private func hideDateToPickerView() {
        dismissPickers()
    }
    
    public func updateSelectableSubviews(with dateFrom: String?, dateTo: String?) {
        if let dateFrom = dateFrom { selectableView.dateFromText = dateFrom }
        if let dateTo = dateTo { selectableView.dateToText = dateTo }
    }
    
    public func clearForm() {
        selectableView.dateFromText = nil
        selectableView.dateToText = nil
    }
    
    public func setAvailabilityToButtons(_ available: Bool) {
        selectableView.setAvailabilityToButtons(available)
    }

}

extension ExchangeRateDetailsView: DatePickerViewDelegate {
    private func dismissPickers() {
        self.dateFromView?.fadeOut(completionHandler: { [weak self] in
            self?.dateFromView?.removeFromSuperview()
            self?.dateFromView = nil
        })
        self.dateToView?.fadeOut(completionHandler: { [weak self] in
            self?.dateToView?.removeFromSuperview()
            self?.dateToView = nil
        })
    }

    public func onSaveTapped() {
        dismissPickers()
    }

    public func onDismissTapped() {
        dismissPickers()
    }

}
