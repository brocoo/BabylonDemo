//
//  Endpoint.swift
//  NetworkKit
//
//  Created by Julien Ducret on 2/28/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
import NetworkKit

enum Endpoint {

    // MARK: - Cases

    case posts
    case users
    case comments(postId: UInt)
    
}

extension Endpoint: RequestProtocol {

    // MARK: - RequestProtocol

    var path: String {
        switch self {
        case .posts: return "/posts"
        case .users: return "/users"
        case .comments(let postId): return "/posts/\(postId)/comments"
        }
    }

    var method: RequestMethod {
        switch self {
        case .posts: return .get
        case .users: return .get
        case .comments: return .get
        }
    }
    
    var body: RequestBody? { return nil }
    
    var headers: [String: String] { return [:] }
    
    var parameters: [String: String] { return [:] }
}
