//
//  ServiceConfiguration.swift
//  NetworkKit
//
//  Created by Julien Ducret on 2/28/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

public struct ServiceConfiguration {
    
    // MARK: - Properties
    
    let urlScheme: String
    let urlHost: String
    private(set) var defaultHTTPHeaders: [String: String]
    private(set) var defaultURLParameters: [URLParameter]
    private(set) var cachePolicy: NSURLRequest.CachePolicy
    private(set) var timeOutInterval: TimeInterval
    
    // MARK: - Initializer
    
    public init(urlScheme: String, urlHost: String) {
        self.urlScheme = urlScheme
        self.urlHost = urlHost
        self.defaultHTTPHeaders = [:]
        self.defaultURLParameters = []
        self.cachePolicy = .useProtocolCachePolicy
        self.timeOutInterval = 60
    }
    
    // MARK: - Helper methods
    
    public func withDefaultHTTPHeaders(_ headers: [String: String]) -> ServiceConfiguration {
        var serviceConfiguration = self
        serviceConfiguration.defaultHTTPHeaders = headers
        return serviceConfiguration
    }
    
    public func withDefaultURLParameters(_ parameters: [URLParameter]) -> ServiceConfiguration {
        var serviceConfiguration = self
        serviceConfiguration.defaultURLParameters = parameters
        return serviceConfiguration
    }
    
    public func withCachePolicy(_ cachePolicy: NSURLRequest.CachePolicy) -> ServiceConfiguration {
        var serviceConfiguration = self
        serviceConfiguration.cachePolicy = cachePolicy
        return serviceConfiguration
    }
    
    public func withTimeOutInterval(_ timeOutInterval: TimeInterval) -> ServiceConfiguration {
        var serviceConfiguration = self
        serviceConfiguration.timeOutInterval = timeOutInterval
        return serviceConfiguration
    }
}
