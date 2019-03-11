//
//  MockRequest.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
@testable import NetworkKit

struct MockRequest: RequestProtocol {
    
    let path: String
    let method: RequestMethod = .get
    let body: RequestBody? = nil
    let headers: [String: String] = [:]
    let parameters: [String: String] = [:]
    
    init(path: String) {
        self.path = path
    }
}
