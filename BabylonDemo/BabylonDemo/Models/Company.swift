//
//  Company.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

struct Company {
    
    // MARK: - Properties

    let name: String
    let catchPhrase: String
    let bs: String
}

extension Company: Decodable { }
