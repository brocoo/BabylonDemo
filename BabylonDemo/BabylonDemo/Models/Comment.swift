//
//  Comment.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

struct Comment {
    
    let postId: UInt
    let id: UInt
    let name: String
    let email: String
    let body: String
}

extension Comment: Decodable { }
