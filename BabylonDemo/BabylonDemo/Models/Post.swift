//
//  Post.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/2/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

struct Post {
    
    // MARK: - Properties
    
    let userId: UInt
    let id: UInt
    let title: String
    let body: String
}

extension Post: Decodable { }

extension Post: Equatable {
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
