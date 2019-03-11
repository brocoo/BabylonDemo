//
//  MockDataService.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxTest
@testable import BabylonDemo

final class MockDataProvider {
    
    var postsEvents: [Event<[AuthoredPost]>] = []
    var commentsEvents: [Event<[Comment]>] = []
}

// MARK: -

extension MockDataProvider: PostsDataServiceProtocol {
    
    // MARK: - PostsDataServiceProtocol
    
    func fetchAuthoredPosts() -> Single<[AuthoredPost]> {
        switch postsEvents.remove(at: 0) {
        case .next(let posts): return Single.just(posts)
        case .error(let error): return Single.error(error)
        }
    }
}

// MARK: -

extension MockDataProvider: PostDetailDataServiceProtocol {
    
    // MARK: - PostDetailDataServiceProtocol
    
    func fetchComments(forPostId postId: UInt) -> Single<[Comment]> {
        switch commentsEvents.remove(at: 0) {
        case .next(let comments): return Single.just(comments)
        case .error(let error): return Single.error(error)
        }
    }
}
