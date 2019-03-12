//
//  MockURLSession.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
@testable import NetworkKit

fileprivate class MockURLSessionDataTask: URLSessionDataTask {
    
    override func resume() { }
}

class MockURLSession: URLSession {
    
    // MARK: - Properties
    
    private let data: Data?
    private let response: URLResponse?
    private let error: Error?
    
    // MARK: - Initializer
    
    init(returning data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    // MARK: - URLSession
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return MockURLSessionDataTask()
    }
}

struct MockError: Error { }
