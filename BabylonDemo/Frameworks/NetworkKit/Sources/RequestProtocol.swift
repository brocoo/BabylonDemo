//
//  RequestProtocol.swift
//  NetworkKit
//
//  Created by Julien Ducret on 2/28/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

public protocol RequestProtocol {
    
    // MARK: - Properties
    
    var path: String { get }
    var method: RequestMethod { get }
    var body: RequestBody? { get }
    var headers: [String: String] { get }
    var parameters: [URLParameter] { get }
}

// MARK: -

extension RequestProtocol {
    
    // MARK: - Default properties
    
    var body: RequestBody? {
        return nil
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var parameters: [URLParameter] {
        return []
    }
}
