//
//  PostDetailCollectionViewManager.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostDetailCollectionViewManager: NSObject {
    
    // MARK: -
    
    fileprivate struct Row {
        
        enum Model {
            
            case postDetail(AuthoredPost, commentsCount: Int)
            case comment(Comment)
        }
        
        let model: Model
        let cachedSize: CGSize
    }

    // MARK: - Properties
    
    private let collectionView: UICollectionView
    fileprivate var dataSource: [Row] = [] {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Initializer
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setup()
    }
    
    private func setup() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.registerReusableCell(PostDetailCollectionViewCell.self)
        collectionView.registerReusableCell(CommentCollectionViewCell.self)
    }
    
    fileprivate func updateDataSource(withComments comments: [Comment], width: CGFloat) {
//        let commentsRow = comments.asRows(forWidth: width)
//        let detailRow: Row = {
//            let height = PostDetailCollectionViewCell.height(forTitle: au, body: <#T##String#>, author: <#T##String#>, commentsCount: <#T##String#>, forWidth: <#T##CGFloat#>)
//            let cachedSize =
//            Row(model: .postDetail(authoredPost, commentsCount: comments.count), cachedSize: <#T##CGSize#>)
//        }()
    }
}

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy, E == ([Comment], CGFloat) {
    
    // MARK: - Driver helper methods
    
    func drive(_ collectionViewManager: PostDetailCollectionViewManager) -> Disposable {
        return drive(onNext: { [weak collectionViewManager] (tuple) in
            let comments = tuple.0
            let width = tuple.1
            collectionViewManager?.updateDataSource(withComments: comments, width: width)
        })
    }
}

// MARK: -

extension Array where Element == Comment {
    
    // MARK: - Array helper method
    
    fileprivate func asRows(forWidth width: CGFloat) -> [PostDetailCollectionViewManager.Row] {
        return map { (model) -> PostDetailCollectionViewManager.Row in
            let height = CommentCollectionViewCell.height(forBody: model.body, email: model.email, forWidth: width)
            let cachedSize = CGSize(width: width, height: height)
            return PostDetailCollectionViewManager.Row(model: .comment(model), cachedSize: cachedSize)
        }
    }
}
