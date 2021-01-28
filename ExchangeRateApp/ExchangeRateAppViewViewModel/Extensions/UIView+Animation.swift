//
//  UIView+Animation.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppCommon

extension UIView {
    func fadeIn(duration: TimeInterval = AppConstants.appDefaultAnimationDuration,
                delay: TimeInterval = 0.0,
                completionHandler: (() -> ())? = nil) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: [.curveEaseInOut, .beginFromCurrentState],
                       animations: { [weak self] in
            self?.isHidden = false
            self?.alpha = 1.0
        }) { completed in
            completionHandler?()
        }
    }
    
    func fadeOut(duration: TimeInterval = AppConstants.appDefaultAnimationDuration,
                 delay: TimeInterval = 0.0,
                 completionHandler: (() -> ())? = nil) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: [.curveEaseInOut, .beginFromCurrentState],
                       animations: { [weak self] in
            self?.alpha = 0.0
        }) { [weak self] completed in
            self?.isHidden = true
            completionHandler?()
        }
    }
}
