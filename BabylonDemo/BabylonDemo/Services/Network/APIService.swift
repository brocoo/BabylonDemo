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
    }
    
    // MARK: - Properties
    
    private lazy var networkService: NetworkKit.Service = self.makeNetworkService()
    
    // MARK: -
    
    private func makeNetworkService() -> NetworkKit.Service {
        let session = URLSession.shared
        let serviceConfiguration = ServiceConfiguration(urlScheme: Constants.urlScheme, urlHost: Constants.urlHost)
        return Service(session: session, configuration: serviceConfiguration)
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
