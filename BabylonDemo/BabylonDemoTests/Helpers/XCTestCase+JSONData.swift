//
//  XCTestCase+JSONData.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func jsonData(forRessource filename: String) -> Data {
        guard let JSONPath = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json") else { fatalError() }
        return try! Data(contentsOf: JSONPath)
    }
}
