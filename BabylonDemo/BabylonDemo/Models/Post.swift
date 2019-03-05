//
//  Post.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/2/19.
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

struct Post {
    
    // MARK: - Properties
    
    let userId: UInt
    let id: UInt
    let title: String
    let body: String
}

extension Post: Decodable {
    
}

extension Post: Equatable {
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
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
