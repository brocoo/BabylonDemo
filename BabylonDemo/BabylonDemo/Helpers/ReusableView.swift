//
//  ReusableView.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    
    // MARK: -
    
    static var defaultReuseIdentifier: String { get }
}

// MARK: -

extension ReusableView where Self: UIView {
    
    // MARK: - ReusableView default implementation
    
    static var defaultReuseIdentifier: String { return String(describing: self) }
}
