//
//  CellViewRepresentable.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

// MARK: -

protocol CellViewRepresentable {
    
    associatedtype CellType: CollectionViewCell
    var cellType: CellType.Type { get }
    var model: CellType.Model { get }
}

// MARK: -

extension CellViewRepresentable {
    
    // MARK: - Helper methods
    
    func registerCollectionViewCell(for collectionView: UICollectionView) {
        collectionView.registerReusableCell(CellType.self)
    }
    
    func asConfiguredCollectionViewCell(dequeuedFrom collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CellType {
        let cell: CellType = asCollectionViewCell(dequeuedFrom: collectionView, atIndexPath: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func asCollectionViewCell(dequeuedFrom collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CellType {
        let cell: CellType = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
}
