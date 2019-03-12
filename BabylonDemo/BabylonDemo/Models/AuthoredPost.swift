//
//  AuthoredPost.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/11/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

struct AuthoredPost {
    
    // MARK: - Properties
    
    let post: Post
    let author: User
}

extension AuthoredPost: Equatable {
    
    static func == (lhs: AuthoredPost, rhs: AuthoredPost) -> Bool {
        return lhs.post == rhs.post
    }
}

extension Post {
    
    func authored(by user: User) -> AuthoredPost {
        return AuthoredPost(post: self, author: user)
    }
}

extension Array where Element == Post {
    
    func authored(by users: [User]) -> [AuthoredPost] {
        let authors = users.keyedById
        return compactMap { (post) -> AuthoredPost? in
            guard let author = authors[post.userId] else { return nil }
            return AuthoredPost(post: post, author: author)
        }
    }
}
