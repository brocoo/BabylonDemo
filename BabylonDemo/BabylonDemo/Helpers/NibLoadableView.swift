//
//  NibLoadableView.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    
    // MARK: -
    
    static var nibName: String { get }
}

// MARK: -

extension NibLoadableView where Self: UIView {
    
    // MARK: - NibLoadableView default implementation
    
    static var nibName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
