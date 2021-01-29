//
//  BaseViewController.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel

public class BaseViewController<ViewModel: BaseViewModel>: UIViewController, UIGestureRecognizerDelegate {

    public var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }

}
