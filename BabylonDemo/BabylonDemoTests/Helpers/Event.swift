//
//  Event.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/11/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

enum Event<T> {
    
    // MARK: - Cases
    
    case next(T)
    case error(MockError)
    
    // MARK: - Initializer
    
    public init(_ value: T) {
        self = .next(value)
    }
    
    public init(_ error: MockError) {
        self = .error(error)
    }
}
