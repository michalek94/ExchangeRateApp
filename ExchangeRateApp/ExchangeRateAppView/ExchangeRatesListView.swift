//
//  ExchangeRatesListView.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel
import ExchangeRateAppCommon
import TinyConstraints

public class ExchangeRatesListView: BaseView {
    
    private lazy var topBar: NavigationTopBarView = { NavigationTopBarView() }()
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
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    public override init() {
        super.init()
    }
    
    public required init?(coder: NSCoder) { nil }
    
    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(topBar,
            tableView)
    }
    
    public override func setupLayout() {
        super.setupLayout()
        topBar.edgesToSuperview(excluding: .bottom)
        tableView.topToBottom(of: topBar)
        tableView.edgesToSuperview(excluding: .top)
    }
    
    public override func configureViews() {
        super.configureViews()
    }
    
    public override func styleViews() {
        super.styleViews()
    }
    
    public func setupView(with viewModel: ExchangeRatesListViewModel) {
        
    }
    
}
