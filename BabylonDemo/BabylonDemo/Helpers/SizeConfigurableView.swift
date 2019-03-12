//
//  SizeConfigurableView.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

protocol SizeConfigurableView: ConfigurableView {
    
    static func height(with model: Model, forWidth width: CGFloat) -> CGFloat
}

extension SizeConfigurableView {
    
    static func size(with model: Model, forWidth width: CGFloat) -> CGSize {
        return CGSize(width: width, height: height(with: model, forWidth: width))
    }
}
