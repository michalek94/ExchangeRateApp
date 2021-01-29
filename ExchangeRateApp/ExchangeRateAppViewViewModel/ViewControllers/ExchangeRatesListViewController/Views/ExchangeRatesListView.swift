//
//  ExchangeRatesListView.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppCommon
import TinyConstraints

public protocol ExchangeRatesListViewDelegate: class {
    func onSegmentedControlSelected(inView view: ExchangeRatesListView, sender: SegmentedControl)
}

public class ExchangeRatesListView: BaseView {
    
    public weak var delegate: ExchangeRatesListViewDelegate?
    
    private lazy var topBar: NavigationTopBarView = { NavigationTopBarView() }()
    private lazy var segmentedControl: SegmentedControl = { SegmentedControl() }()
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
        tableView.register(ExchangeRateCell.self, forCellReuseIdentifier: ExchangeRateCell.identifier)
        tableView.backgroundColor = .white
        tableView.contentInset.bottom = UIDevice.current.bottomSafeAreaInset
        return tableView
    }()

    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            topBar,
            segmentedControl,
            tableView
        )
    }
    
    public override func setupLayout() {
        super.setupLayout()
        topBar.edgesToSuperview(excluding: .bottom)
        
        segmentedControl.topToBottom(of: topBar)
        segmentedControl.horizontalToSuperview()
        
        tableView.topToBottom(of: segmentedControl)
        tableView.edgesToSuperview(excluding: .top)
    }
    
    public override func configureViews() {
        super.configureViews()
        segmentedControl.addTarget(self, action: #selector(ExchangeRatesListView.onSegmentedControlSelected(_:)), for: .valueChanged)
    }

    public override func styleViews() {
        super.styleViews()
        backgroundColor = .white
    }

    public func setupView(with viewModel: ExchangeRatesListViewModel) {
        topBar.setTitle(viewModel.viewTitle)
        topBar.showHideBackButtonIfNeeded(false)
        segmentedControl.insertSegments(viewModel.segmentTitles)
    }
    
    @objc private func onSegmentedControlSelected(_ sender: SegmentedControl) {
        delegate?.onSegmentedControlSelected(inView: self, sender: sender)
    }

}
