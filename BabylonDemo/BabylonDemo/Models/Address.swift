//
//  Address.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

struct Address {
    
    // MARK: - Properties
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

extension Address: Decodable { }
