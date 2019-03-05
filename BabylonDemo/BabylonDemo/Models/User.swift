//
//  User.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

struct User {

    // MARK: - Properties
    
    let id: UInt
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

extension User: Decodable { }

extension Array where Element == User {
    
    var keyedById: [UInt: User] {
        return reduce([:]) { (dictionary, user) -> [UInt: User] in
            var dict = dictionary
            dict[user.id] = user
            return dict
        }
    }
}
