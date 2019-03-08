//
//  PostCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

extension Array where Element == AuthoredPost {
    
    func asDataSource(collectionViewWidth width: CGFloat) -> [CollectionViewDataSourceItem] {
        return map { CollectionViewDataSourceItem(AuthoredPostCell(model: $0), width: width) }
    }
}

fileprivate struct AuthoredPostCell: CellViewRepresentable {
    
    let model: AuthoredPost
    var cellType: PostCollectionViewCell.Type { return PostCollectionViewCell.self }
}
