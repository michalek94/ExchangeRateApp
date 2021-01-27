//
//  AppEnvironment.swift
//  ExchangeRateAppModel
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public enum AppEnvironmentConfiguration: String {
    case development, staging, production
}

public class AppEnvironment {
    
    public let configuration: AppEnvironmentConfiguration
    
    public init() {
        let bundleEnvironment = (Bundle.main.object(forInfoDictionaryKey: "Environment") as? String) ?? AppEnvironmentConfiguration.development.rawValue
        self.configuration = AppEnvironmentConfiguration(rawValue: bundleEnvironment)!
    }
    
    public lazy var serverBaseUrl: String = {
        switch configuration {
        case .development, .staging, .production: return "http://api.nbp.pl/api/"
        }
    }()

}
