//
//  DataService.swift
//  BabylonHealthDemo
//
//  Created by Julien Ducret on 3/2/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DataService: NSObject {
    
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

extension DataService: ApplicationConfiguratorProtocol {
    
    // MARK: -
    
    func configure(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        
    }
    
    // MARK: - Private helpers
    
    fileprivate func fetchPosts() -> Single<[Post]> {
        return apiService.performCall(to: .posts)
    }
    
    fileprivate func fetchUsers() -> Single<[User]> {
        return apiService.performCall(to: .users)
    }
}

// MARK: -

extension DataService: PostsDataProviderProtocol {
    
    // MARK: - PostsDataProviderProtocol
    
    func fetchAuthoredPosts() -> Single<[AuthoredPost]> {
        return Single
            .zip(fetchPosts(), fetchUsers())
            .map { (tuple) -> [AuthoredPost] in
                let posts = tuple.0
                let users = tuple.1
                return posts.authored(by: users)
            }
    }
}

// MARK: -

extension DataService: PostDetailDataServiceProtocol {
    
    // MARK: - PostDetailViewModelProtocol
    
    func fetchComments(forPostId postId: UInt) -> Single<[Comment]> {
        return apiService.performCall(to: .comments(postId: postId))
    }
}
