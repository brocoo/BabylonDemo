//
//  Service.swift
//  NetworkKit
//
//  Created by Julien Ducret on 2/28/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
import Network

// MARK: -

public final class Service {
    
    // MARK: - Properties
    
    let session: URLSession
    let configuration: ServiceConfiguration
    private let networkMonitor: NetworkMonitor
    private var debug: Bool
    
    // MARK: - Initializer
    
    public init(session: URLSession, configuration: ServiceConfiguration, debug: Bool = false) {
        self.session = session
        self.configuration = configuration
        self.debug = debug
        self.networkMonitor = NetworkMonitor()
    }
    
    // MARK: - Public methods
    
    public func perform<T: ResponseProtocol>(request: RequestProtocol, onCompletion completion: @escaping (T) -> Void) throws {
        let urlRequest = try makeURLRequest(for: request)
        let task = session.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
            guard let `self` = self else { return }
            let serviceResponse: T = {
                if error != nil, !self.networkMonitor.isConnected, let cachedResponse = self.cachedURLResponse(for: urlRequest) {
                    return self.makeResponse(from: request, data: cachedResponse.data, urlResponse: cachedResponse.response, error: error)
                } else {
                    return self.makeResponse(from: request, data: data, urlResponse: urlResponse, error: error)
                }
            }()
            if self.debug { print(serviceResponse) }
            completion(serviceResponse)
        }
        task.resume()
    }
    
    // MARK: - Private helper methods
    
    private func cachedURLResponse(for request: URLRequest) -> CachedURLResponse? {
        return session.configuration.urlCache?.cachedResponse(for: request)
    }
    
    private func makeResponse<T: ResponseProtocol>(from request: RequestProtocol, data: Data?, urlResponse: URLResponse?, error: Error?) -> T {
        let dataResult: Result<Data> = {
            if let data = data {
                return Result(data)
            } else {
                let serviceError: Error = {
                    guard networkMonitor.isConnected else { return ServiceError.noNetwork }
                    return error ?? ServiceError.unknown(request: request, response: urlResponse)
                }()
                return Result(serviceError)
            }
        }()
        return T(request: request, data: dataResult)
    }
    
    private func makeURLRequest(`for` request: RequestProtocol) throws -> URLRequest {
        let components = makeComponents(for: request)
        guard let url = components.url else { throw ServiceError.urlFailedBuilding(components: components) }
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = configuration.cachePolicy
        urlRequest.timeoutInterval = configuration.timeOutInterval
        urlRequest.allHTTPHeaderFields = configuration.defaultHTTPHeaders.merging(request.headers, uniquingKeysWith: { $1 })
        return urlRequest
    }
    
    private func makeComponents(`for` request: RequestProtocol) -> URLComponents {
        var components = URLComponents()
        components.host = configuration.urlHost
        components.scheme = configuration.urlScheme
        components.path = request.path
        components.queryItems = (configuration.defaultURLParameters + request.parameters).map { URLQueryItem(name: $0.key, value: $0.value) }
        return components
    }
}

// MARK: - Service error

enum ServiceError: Error {
    
    case noNetwork
    case unknown(request: RequestProtocol, response: URLResponse?)
    case urlFailedBuilding(components: URLComponents)
}

// MARK: - Extension

extension Error {
    
    var isServiceRelated: Bool { return (self as? ServiceError) != nil }
}
