//
//  AppDelegate.swift
//  ExchangeRateApp
//
//  Created by Michał Pankowski on 27/01/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?

    private let dependencies = Dependencies()
    private var initialCoordinator: InitialCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp(withOptions: launchOptions)
        return true
    }

    private func configureApp(withOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window
        initialCoordinator = InitialCoordinator(window: window, dependencies: dependencies)
        initialCoordinator?.start()
    }

}
