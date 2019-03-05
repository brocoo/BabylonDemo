//
//  PostCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

struct AuthoredPostCell {
    
    let model: AuthoredPost
    let cachedSize: CGSize
    
    init(model: AuthoredPost, cachedSize: CGSize) {
        self.model = model
        self.cachedSize = cachedSize
    }
}

extension AuthoredPostCell: CellViewRepresentable {
    
    typealias CellType = PostCollectionViewCell
}

extension Array where Element == AuthoredPost {
    
    func asCells(collectionViewWidth width: CGFloat) -> [AuthoredPostCell] {
        return map { (model) -> AuthoredPostCell in
            let cachedSize = PostCollectionViewCell.size(with: model, forWidth: width)
            return AuthoredPostCell(model: model, cachedSize: cachedSize)
        }
    }
}
