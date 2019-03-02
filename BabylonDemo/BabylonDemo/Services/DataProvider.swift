//
//  DataProvider.swift
//  BabylonHealthDemo
//
//  Created by Julien Ducret on 3/2/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift

final class DataProvider: NSObject {
    
    // MARK: - Properties
    
    fileprivate let apiService: APIService
    
    // MARK: - Initializer
    
    override init() {
        self.apiService = APIService()
        super.init()
    }
    
    // MARK: -
}

// MARK: -

extension DataProvider: ApplicationConfiguratorProtocol {
    
    // MARK: -
    
    func configure(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        
    }
}


// MARK: -

extension DataProvider: PostsDataProviderProtocol {
    
    // MARK: - PostsDataProviderProtocol
    
    func fetchPosts() -> Single<[Post]> {
        return apiService.performCall(to: .posts)
    }
}
