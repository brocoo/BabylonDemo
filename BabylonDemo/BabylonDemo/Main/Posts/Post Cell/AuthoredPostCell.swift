//
//  PostCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Array where Element == AuthoredPost {
    
    func asDataSource(collectionViewWidth width: CGFloat, emitSelectionOn selection: PublishRelay<AuthoredPost>) -> [CollectionViewDataSourceItem] {
        return map { (authoredPostCell) -> CollectionViewDataSourceItem in
            let cell = AuthoredPostCell(model: authoredPostCell)
            let item = CollectionViewDataSourceItem(cell, width: width, onSelection: { (authoredPostCell) in
                selection.accept(authoredPostCell)
            })
            return item
        }
    }
}

fileprivate struct AuthoredPostCell: CellViewRepresentable {
    
    let model: AuthoredPost
    var cellType: PostCollectionViewCell.Type { return PostCollectionViewCell.self }
}
