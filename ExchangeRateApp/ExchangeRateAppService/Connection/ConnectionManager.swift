//
//  ConnectionManager.swift
//  ExchangeRateAppService
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppCommon
import Alamofire

public class ConnectionManager {

    private let dataProvider: AppDataProvider
    private let environment: AppEnvironment

    private var _session: Session?
    private var session: Session {
        get {
            if let _session = self._session {
                return _session
            } else {
                let configuration: URLSessionConfiguration = .default
                configuration.timeoutIntervalForRequest = TimeInterval(30.0)
                configuration.timeoutIntervalForResource = TimeInterval(30.0)
                configuration.urlCache = nil
                configuration.httpCookieStorage = nil
                let requestInterceptor = RequestAccessToken(dataProvider: dataProvider,
                                                            environment: environment)
                self._session = Session(configuration: configuration,
                                        interceptor: requestInterceptor)
                return self._session!
            }
        }
        set {
            self._session = newValue
        }
    }

    public var baseUrl: String {
        return environment.serverBaseUrl
    }

    public var isInternetReachable: Bool {
        return NetworkReachabilityManager(host: "https://www.google.com")?.isReachable ?? false
    }

    public init(dataProvider: AppDataProvider,
                environment: AppEnvironment) {
        self.dataProvider = dataProvider
        self.environment = environment
    }

    public func request<T: Codable> (_ url: URLConvertible,
                                     method: HTTPMethod = .get,
                                     parameters: Parameters? = nil,
                                     encoding: ParameterEncoding = JSONEncoding.default,
                                     headers: HTTPHeaders? = nil,
                                     completionHandler: ((DataResponse<T, AFError>) -> Void)? = nil) {
        let request = session.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        request
            .responseDecodable(of: T.self) { response in
                completionHandler?(response)
            }
    }

    public func requestArray<T: Codable> (_ url: URLConvertible,
                                          method: HTTPMethod = .get,
                                          parameters: Parameters? = nil,
                                          encoding: ParameterEncoding = JSONEncoding.default,
                                          headers: HTTPHeaders? = nil,
                                          completionHandler: ((DataResponse<[T], AFError>) -> Void)? = nil) {
        let request = session.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        request
            .responseDecodable(of: [T].self) { response in
                completionHandler?(response)
            }
    }

}
