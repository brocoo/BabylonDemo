//
//  Cache.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/6/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

protocol CacheProtocol {
    
    func cachedResponse(for request: RequestProtocol)
}
