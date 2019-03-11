//
//  Error+Message.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/11/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
import NetworkKit

extension Error {
    
    var message: String {
        if let networkError = self as? ServiceError, case .noNetwork = networkError {
            return "ERROR_MESSAGE_NO_NETWORK".localized
        } else {
            return "ERROR_MESSAGE_DEFAULT".localized
        }
    }
}
