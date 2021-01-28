//
//  UIView+AddSubview.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

extension UIView {
    @discardableResult
    public func add(_ subviews: UIView...) -> UIView {
        return add(subviews)
    }
    
    @discardableResult
    public func add(_ subviews: [UIView]) -> UIView {
        subviews.forEach { [weak self] in
            self?.addSubview($0)
        }
        return self
    }
}
