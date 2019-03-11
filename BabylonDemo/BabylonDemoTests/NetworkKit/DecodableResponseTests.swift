//
//  DecodableResponseTests.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import XCTest
@testable import NetworkKit
@testable import BabylonDemo

final class DecodableResponseTests: XCTestCase {
    
    // MARK: -
    
    func testItDecodesData() {
        let request = MockRequest(path: "/valid/path")
        let data = Result(jsonData(forRessource: "GETPosts"))
        let response: DecodableResponse<[Post]> = DecodableResponse(request: request, data: data)
        switch response.decodedData {
        case .success(let posts):
            XCTAssert(posts.count == 5)
        case .failure:
            XCTFail()
        }
    }
    
    func testItFailsDecodingMalformedData() {
        let request = MockRequest(path: "/valid/path")
        let data = Result(jsonData(forRessource: "GETPosts_malformed"))
        let response: DecodableResponse<[Post]> = DecodableResponse(request: request, data: data)
        switch response.decodedData {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssert(error is Swift.DecodingError)
        }
    }
}
