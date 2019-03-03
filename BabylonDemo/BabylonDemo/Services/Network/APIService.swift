//
//  APIService.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/2/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
import NetworkKit
import RxSwift
import RxCocoa

final class APIService {
    
    // MARK - Constants
    
    private enum Constants {
        static let urlScheme: String = "https"
        static let urlHost: String = "jsonplaceholder.typicode.com"
        static let timeOutInterval: TimeInterval = 15.0
    }
    
    // MARK: - Properties
    
    private lazy var networkService: NetworkKit.Service = self.makeNetworkService()
    
    // MARK: -
    
    private func makeNetworkService() -> NetworkKit.Service {
        
        let session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
            return URLSession(configuration: configuration)
        }()
        
        let serviceConfiguration = ServiceConfiguration(urlScheme: Constants.urlScheme, urlHost: Constants.urlHost)
            .withCachePolicy(.useProtocolCachePolicy)
            .withTimeOutInterval(Constants.timeOutInterval)
        
        return Service(session: session, configuration: serviceConfiguration, debug: true)
    }
    
    // MARK: -
    
    func performCall<T: Decodable>(to endpoint: Endpoint) -> Single<T> {
        return Single<T>.create { (single) -> Disposable in
            let completion: (DecodableResponse<T>) -> Void = { response in
                switch response.decodedData {
                case .success(let data): single(.success(data))
                case .failure(let error): single(.error(error))
                }
            }
            do {
                try self.networkService.perform(request: endpoint, onCompletion: completion)
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
