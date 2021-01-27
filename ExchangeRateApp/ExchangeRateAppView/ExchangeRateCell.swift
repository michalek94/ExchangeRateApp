//
//  ExchangeRateCell.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel
import ExchangeRateAppCommon

public class ExchangeRateCell: UITableViewCell {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sharedInit()
    }
    
    private func sharedInit() {
        createViewsHierarchy()
        configureViews()
        setupLayout()
        styleViews()
    }
    
    private func createViewsHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    private func configureViews() {
        
    }
    
    private func styleViews() {
        
    }
    
    public func setupCell(with viewModel: ExchangeRateCellViewModel?) {
        
    }
    
}
