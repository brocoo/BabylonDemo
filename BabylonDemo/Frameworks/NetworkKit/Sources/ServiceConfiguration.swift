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
    var defaultHTTPHeaders: [String: String]
    var defaultURLParameters: [URLParameter]
    
    // MARK: - Initializer
    
    public init(urlScheme: String, urlHost: String) {
        self.urlScheme = urlScheme
        self.urlHost = urlHost
        self.defaultHTTPHeaders = [:]
        self.defaultURLParameters = []
    }
    
    // MARK: - Helper methods
    
    func withDefaultHTTPHeaders(_ headers: [String: String]) -> ServiceConfiguration {
        var serviceConfiguration = self
        serviceConfiguration.defaultHTTPHeaders = headers
        return serviceConfiguration
    }
    
    func withDefaultURLParameters(_ parameters: [URLParameter]) -> ServiceConfiguration {
        var serviceConfiguration = self
        serviceConfiguration.defaultURLParameters = parameters
        return serviceConfiguration
    }
}
