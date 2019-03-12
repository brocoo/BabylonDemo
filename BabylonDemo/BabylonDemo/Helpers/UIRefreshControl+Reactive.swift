//
//  UIRefreshControl+Reactive.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/8/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIRefreshControl {
    
    public var isRefreshing: Binder<Bool> {
        return Binder(base) { refreshControl, refresh in
            if refresh {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
