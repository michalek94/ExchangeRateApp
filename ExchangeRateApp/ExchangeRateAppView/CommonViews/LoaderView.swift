//
//  LoaderView.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class LoaderView {
    
    public static let shared = LoaderView()

    private lazy var container: UIView = { UIView() }()
    private lazy var activityIndicator: UIActivityIndicatorView = { UIActivityIndicatorView() }()

    public func showActivityIndicator(inView view: UIView) {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = .blackDisabled

        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: container.frame.size.width / 2, y: container.frame.size.height / 2)

        container.addSubview(activityIndicator)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }

    public func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }

}
