//
//  DecodableResponse.swift
//  NetworkKit
//
//  Created by Julien Ducret on 2/28/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation

public class DecodableResponse<T: Decodable>: ResponseProtocol {
    
    // MARK: - ResponseProtocol properties
    
    public let request: RequestProtocol
    public let data: Result<Data>
    
    // MARK: - Properties
    
    public lazy private(set) var decodedData: Result<T> = data.flatMap { Result<T>(jsonEncoded: $0) }
    
    // MARK: - Initializer
    
    required public init(request: RequestProtocol, data: Result<Data>) {
        self.request = request
        self.data = data
    }
}
