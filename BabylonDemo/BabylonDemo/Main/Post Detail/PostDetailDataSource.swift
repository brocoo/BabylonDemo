//
//  PostDetailDataSource.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

struct PostDetailDataSource {
    
    // MARK: - Properties
    
    private let post: AuthoredPost
    private let comments: [Comment]
    private let width: CGFloat
    
    // MARK: - Initializer
    
    init(post: AuthoredPost, comments: [Comment], forWidth width: CGFloat) {
        self.post = post
        self.comments = comments
        self.width = width
    }
    
    // MARK: -
    
    func asDataSource() -> [CollectionViewDataSourceItem] {
        var dataSource: [CollectionViewDataSourceItem] = []
        dataSource.append(CollectionViewDataSourceItem(PostDetailCell(model: post), width: width))
        if comments.count > 0 {
            dataSource.append(CollectionViewDataSourceItem(CommentCountCell(model: comments.count), width: width))
            dataSource.append(contentsOf: comments.map { CollectionViewDataSourceItem(CommentCell(model: $0), width: width) })
        }
        return dataSource
    }
}

// MARK: -

fileprivate struct PostDetailCell: CellViewRepresentable {
    
    var model: AuthoredPost
    var cellType: PostDetailCollectionViewCell.Type { return PostDetailCollectionViewCell.self }
}

// MARK: -

fileprivate struct CommentCountCell: CellViewRepresentable {
    
    var model: Int
    var cellType: CommentsCountCollectionViewCell.Type { return CommentsCountCollectionViewCell.self }
}

// MARK: -

fileprivate struct CommentCell: CellViewRepresentable {
    
    var model: Comment
    var cellType: CommentCollectionViewCell.Type { return CommentCollectionViewCell.self }
}

