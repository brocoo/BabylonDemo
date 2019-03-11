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
    
    var posts: [[AuthoredPost]] = []
    var comments: [[Comment]] = []
    var emitsError: Bool = false
}

// MARK: -

extension MockDataProvider: PostsDataServiceProtocol {
    
    // MARK: - PostsDataServiceProtocol
    
    func fetchAuthoredPosts() -> Single<[AuthoredPost]> {
        if emitsError {
            return Single.error(MockError())
        } else {
            guard posts.count > 0 else { return Single.just([]) }
            return Single.just(posts.remove(at: 0))
        }
    }
}

// MARK: -

extension MockDataProvider: PostDetailDataServiceProtocol {
    
    // MARK: - PostDetailDataServiceProtocol
    
    func fetchComments(forPostId postId: UInt) -> Single<[Comment]> {
        if emitsError {
            return Single.error(MockError())
        } else {
            guard comments.count > 0 else { return Single.just([]) }
            return Single.just(comments.remove(at: 0))
        }
    }
}
