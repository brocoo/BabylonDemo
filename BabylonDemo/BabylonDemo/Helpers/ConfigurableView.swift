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

struct AnyConfigurableView: ConfigurableView {
    
    private let _configure: (Any) -> Void
    
    init<T: ConfigurableView>(_ row: T) {
        _configure = { object in
            guard let model = object as? T.Model else { return }
            row.configure(with: model)
        }
    }

    func configure(with model: Any) {
        _configure(model)
    }
}

