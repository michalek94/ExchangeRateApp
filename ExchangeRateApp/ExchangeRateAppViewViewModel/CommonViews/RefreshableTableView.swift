//
//  RefreshableTableView.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public protocol RefreshableTableViewDelegate: class {
    func refresh(completion: @escaping ()->())
}

public class RefreshableTableView: UITableView {

    public weak var refreshDelegate: RefreshableTableViewDelegate?

    private var loadingView = UIView()
    private var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private var refreshLoader = UIRefreshControl()

    private let loadingViewHeight: CGFloat = 80

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        createViewsHierarchy()
        setupLayout()
        configureViews()
        styleViews()
    }

    required init?(coder aDecoder: NSCoder) { nil }

    public override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.startAnimating()
    }

    private func createViewsHierarchy() {
        loadingView.add(
            activityIndicatorView
        )
    }

    private func setupLayout() {
        loadingView.frame = CGRect(x: .zero, y: .zero, width: frame.width, height: loadingViewHeight)
        
        activityIndicatorView.centerInSuperview()
    }

    private func configureViews() {
        refreshLoader.addTarget(self, action: #selector(RefreshableTableView.refresh(_:)), for: .valueChanged)
        refreshControl = refreshLoader
    }

    private func styleViews() {
        activityIndicatorView.color = .darkGray
        activityIndicatorView.tintColor = .darkGray
        refreshLoader.tintColor = .darkGray
    }

    private func reset(completion: @escaping () -> ()) {
        refreshDelegate?.refresh(completion: completion)
    }

    @objc private func refresh(_ sender: UIRefreshControl) {
        reset() { [weak sender] in
            sender?.endRefreshing()
        }
    }

    public func showLoadingFooterIfNeeded(_ isNeeded: Bool) {
        isNeeded ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tableFooterView = isNeeded ? loadingView : nil
    }

}
