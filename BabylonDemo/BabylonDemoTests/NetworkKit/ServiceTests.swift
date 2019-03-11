//
//  ServiceTests.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import XCTest
@testable import NetworkKit
@testable import BabylonDemo

class ServiceTests: XCTestCase {
    
    func testItReturnsValidResponse() {
        let session = MockURLSession(returning: jsonData(forRessource: "GETPosts"), response: HTTPURLResponse(valid: true), error: nil)
        let request = MockRequest(path: "/valid/path")
        let service = Service(session: session, configuration: ServiceConfiguration(urlScheme: "https", urlHost: "mock.com"))
        let completion: (DecodableResponse<[Post]>) -> Void = { response in
            switch response.decodedData {
            case .success(let data): XCTAssert(data.count == 5)
            case .failure: XCTFail()
            }
        }
        XCTAssertNoThrow(try service.perform(request: request, onCompletion: completion), "")
    }
    
    func testItReturnsInvalidResponse() {
        let session = MockURLSession(returning: nil, response: HTTPURLResponse(valid: false), error: MockError())
        let request = MockRequest(path: "/valid/path")
        let service = Service(session: session, configuration: ServiceConfiguration(urlScheme: "https", urlHost: "mock.com"))
        let completion: (DecodableResponse<[Post]>) -> Void = { response in
            XCTAssertNil(response.data.value)
            XCTAssertNotNil(response.data.error)
        }
        XCTAssertNoThrow(try service.perform(request: request, onCompletion: completion))
    }
    
    func testItFailsBuildingURLRequest() {
        let session = MockURLSession(returning: jsonData(forRessource: "GETPosts"), response: HTTPURLResponse(valid: true), error: nil)
        let invalidRequest = MockRequest(path: "invalid")
        let service = Service(session: session, configuration: ServiceConfiguration(urlScheme: "https", urlHost: "mock.com"))
        let completion: (DecodableResponse<[Post]>) -> Void = { response in
            XCTAssertNil(response.data.value)
            XCTAssertNotNil(response.data.error)
        }
        XCTAssertThrowsError(try service.perform(request: invalidRequest, onCompletion: completion))
    }
}


extension HTTPURLResponse {
    
    fileprivate convenience init(valid: Bool) {
        if valid {
            let url = URL(string: "https://mock.com/valid/path")!
            self.init(url: url, statusCode: 200, httpVersion: nil, headerFields: [:])!
        } else {
            let url = URL(string: "https://mock.com/invalid/path")!
            self.init(url: url, statusCode: 404, httpVersion: nil, headerFields: [:])!
        }
    }
}
