//
//  NetworkMonitor.swift
//  NetworkKit
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
import Network

final class NetworkMonitor {
    
    // MARK: -
    
    let pathMonitor: NWPathMonitor
    private(set) var isConnected: Bool = true
    
    // MARK: - Initializer
    
    init() {
        pathMonitor = NWPathMonitor()
        pathMonitor.pathUpdateHandler = { [weak self] (path) in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        pathMonitor.start(queue: DispatchQueue(label: "com.brocoo.NetworkKit.pathMonitor"))
    }
}
