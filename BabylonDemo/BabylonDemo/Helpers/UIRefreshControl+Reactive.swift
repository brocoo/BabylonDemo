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

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy, E == Bool {
    
    // MARK: - Driver helper methods
    
    func drive(refreshingOf refreshControl: UIRefreshControl) -> Disposable {
        return drive(onNext: { [weak refreshControl] (isRefreshing) in
            if isRefreshing {
                refreshControl?.beginRefreshing()
            } else {
                refreshControl?.endRefreshing()
            }
        })
    }
}
