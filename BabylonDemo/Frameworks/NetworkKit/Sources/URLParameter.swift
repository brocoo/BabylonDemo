//
//  URLParameter.swift
//  NetworkKit
//
//  Created by Julien Ducret on 2/28/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

public struct URLParameter {
    
    // MARK: - Properties
    
    let key: String
    let value: String
    
    // MARK: - Initializer
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

// MARK: -

extension URLParameter: Equatable {
    
    // MARK: - Equatable
    
    public static func == (lhs: URLParameter, rhs: URLParameter) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}

// MARK: -

extension Array where Element == URLParameter {
    
    // MARK: - Array subscript
    
    public subscript(key: String) -> [String] {
        get {
            return lazy.filter { $0.key == key }.map { $0.value }
        }
    }
    
    // MARK: -
    
    public mutating func append(key: String, value: String) {
        append(URLParameter(key: key, value: value))
    }
}
