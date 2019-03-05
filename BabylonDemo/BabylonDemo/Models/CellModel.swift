//
//  Cell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

enum CellModel {
    
    // MARK: - Cases
    
    case authoredPost(AuthoredPost)
    case comment(Comment)
    case postDetail(AuthoredPost)
    
    // MARK: - Computed properties
    
    var collectionViewCellType: CellView.Type {
        switch self {
        case .authoredPost: return PostCollectionViewCell.self
        case .comment: return CommentCollectionViewCell.self
        case .postDetail: return PostDetailCollectionViewCell.self
        }
    }
}

// MARK: -

struct Cell {
    
    // MARK: - Properties
    
    let model: CellModel
    let cachedSize: CGSize
}
