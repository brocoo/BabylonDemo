//
//  Result.swift
//  NetworkKit
//
//  Created by Julien Ducret on 13/09/2016.
//  Copyright © 2016 Julien Ducret. All rights reserved.
//

import Foundation

public enum Result<T> {
    
    // MARK: - Cases
    
    case success(T)
    case failure(Error)
    
    // MARK: - Initializer
    
    public init(_ value: T) {
        self = .success(value)
    }
    
    public init(_ error: Error) {
        self = .failure(error)
    }
    
    // MARK: - Computed properties
    
    public var value: T? {
        switch self {
        case .success(let value): return value
        case .failure(_): return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success(_): return nil
        case .failure(let error): return error
        }
    }
    
    public var isSuccessful: Bool {
        switch self {
        case .success(_): return true
        case .failure(_): return false
        }
    }
    
    public var isFailed: Bool { return !isSuccessful }
}

// MARK: -

extension Result {
    
    // MARK: - Map
    
    public func map<U>(_ f: (T) -> U) -> Result<U> {
        switch self {
        case .success(let value): return Result<U>.success(f(value))
        case .failure(let error): return Result<U>.failure(error)
        }
    }
    
    public func map<U>(_ f: (T) throws -> U) -> Result<U> {
        switch self {
        case .success(let value):
            do {
                let newValue = try f(value)
                return Result<U>.success(newValue)
            } catch {
                return Result<U>.failure(error)
            }
        case .failure(let error): return Result<U>.failure(error)
        }
    }
}

// MARK: -

extension Result {
    
    // MARK: - Flatten & flatMap
    
    public static func flatten<T>(_ result: Result<Result<T>>) -> Result<T> {
        switch result {
        case .success(let innerResult): return innerResult
        case .failure(let error): return Result<T>.failure(error)
        }
    }
    
    public func flatMap<U>(_ f: (T) -> Result<U>) -> Result<U> {
        return Result.flatten(self.map(f))
    }
}

// MARK: -

extension Result: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    public var description: String {
        switch self {
        case .success(let value):
            guard let descriptable = value as? CustomStringConvertible else { return "\(value)" }
            return descriptable.description
        case .failure(let error): return error.localizedDescription
        }
    }
}

// MARK: -

extension Result where T: Decodable {
    
    // MARK: - Initializer for decodable
    
    public init(jsonEncoded data: Data) {
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            self = .success(value)
        } catch {
            self = .failure(error)
        }
    }
}
