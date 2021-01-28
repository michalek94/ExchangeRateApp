//
//  BaseView.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class BaseView: UIView {
    
    public init() {
        super.init(frame: .zero)
        createViewsHierarchy()
        setupLayout()
        configureViews()
        styleViews()
    }
    
    public required init?(coder: NSCoder) { nil }
    
    public func createViewsHierarchy() {}

    public func setupLayout() {}

    public func configureViews() {}

    public func styleViews() {}
    
}
