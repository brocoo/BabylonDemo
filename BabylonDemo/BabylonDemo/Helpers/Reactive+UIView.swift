//
//  Reactive+UIView.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UIView {
    
    // MARK: - UIScrollView reactive extension
    
    public var bounds: Observable<CGRect> {
        return observe(CGRect.self, "bounds").flatMap { Observable.from(optional: $0) }
    }
}
