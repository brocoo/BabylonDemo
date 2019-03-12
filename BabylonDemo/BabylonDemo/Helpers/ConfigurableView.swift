//
//  ConfigurableView.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

protocol ConfigurableView {
    
    associatedtype Model
    func configure(with model: Model)
}
