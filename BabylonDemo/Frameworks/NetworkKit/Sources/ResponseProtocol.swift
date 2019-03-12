//
//  ResponseProtocol.swift
//  NetworkKit
//
//  Created by Julien Ducret on 2/28/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

public protocol ResponseProtocol: CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: - Properties
    
    var request: RequestProtocol { get }
    var data: Result<Data> { get }
    
    // MARK: - Initializer
    
    init(request: RequestProtocol, data: Result<Data>)
}

// MARK: -

extension ResponseProtocol {
    
    // MARK: - CustomStringConvertible
    
    public var description: String {
        switch self.data {
        case .success: return "[RESPONSE PROTOCOL] ✅ SUCCESSFUL \(request.path)"
        case .failure(let error): return "[RESPONSE PROTOCOL] ❌ FAILURE \(request.path)\n\(error)"
        }
    }
    
    public var debugDescription: String { return description }
}

