//
//  NavigationTopBarView.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppCommon
import TinyConstraints

public protocol NavigationTopBarViewDelegate: class {
    func leftButtonTapped(inView view: NavigationTopBarView, sender: UIButton)
}

public class NavigationTopBarView: BaseView {
    
    public weak var delegate: NavigationTopBarViewDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(R.image.backArrowIcon(), for: .normal)
        button.addTarget(self, action: #selector(NavigationTopBarView.leftButtonTapped(_:)), for: .touchUpInside)
        button.touchAreaEdgeInsets = UIEdgeInsets(top: -20.0, left: -20.0, bottom: -20.0, right: -20.0)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    public override init() {
        super.init()
    }
    
    public required init?(coder: NSCoder) { nil }
    
    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            containerView.add(
                barView.add(
                    leftButton,
                    titleLabel
                )
            )
        )
    }
    
    public override func setupLayout() {
        super.setupLayout()
        containerView.edgesToSuperview()
        
        barView.topToSuperview(offset: UIApplication.shared.statusBarFrame.height)
        barView.edgesToSuperview(excluding: .top)
        barView.height(60.0)
        
        leftButton.leadingToSuperview(offset: 20.0)
        leftButton.centerYToSuperview()
        leftButton.size(CGSize(width: 20.0, height: 20.0))
        
        titleLabel.centerInSuperview()
        titleLabel.height(45.0)
    }
    
    public override func configureViews() {
        super.configureViews()
    }
    
    public override func styleViews() {
        super.styleViews()
        backgroundColor = .white
    }
    
    @objc private func leftButtonTapped(_ sender: UIButton) {
        delegate?.leftButtonTapped(inView: self, sender: sender)
    }
    
    public func showHideBackButtonIfNeeded(_ isNeeded: Bool) {
        isNeeded ? leftButton.fadeIn() : leftButton.fadeOut()
    }
    
}
