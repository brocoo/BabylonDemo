//
//  CollectionViewDataSourceItem.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

struct CollectionViewDataSourceItem {
    
    // MARK - Private properties
    
    let onSelectionClosure: () -> Void
    let configuredCellClosure: (UICollectionView, IndexPath) -> UICollectionViewCell
    let registerCellClosure: (UICollectionView) -> Void
    fileprivate let cellIdentifier: String
    
    // MARK: - Initializer
    
    init<T: CellViewRepresentable>(_ base: T, cachedSize: CGSize, onSelection: @escaping (T.CellType.Model) -> Void = { _ in }) {
        registerCellClosure = { base.registerCollectionViewCell(for: $0) }
        configuredCellClosure = { base.asConfiguredCollectionViewCell(dequeuedFrom: $0, atIndexPath: $1) }
        cellIdentifier = base.cellType.defaultReuseIdentifier
        onSelectionClosure = { onSelection(base.model) }
        self.cachedSize = cachedSize
    }
    
    init<T: CellViewRepresentable>(_ base: T, width: CGFloat, onSelection: @escaping (T.CellType.Model) -> Void = { _ in }) where T.CellType: SizeConfigurableView {
        let size = base.cellType.size(with: base.model, forWidth: width)
        self.init(base, cachedSize: size, onSelection: onSelection)
    }
    
    // MARK: - Helper methods and properties
    
    func dequeueConfiguredCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return configuredCellClosure(collectionView, indexPath)
    }
    
    func registerCell(on collectionView: UICollectionView) {
        registerCellClosure(collectionView)
    }
    
    func didGetSelected() {
        onSelectionClosure()
    }
    
    var cachedSize: CGSize
}

extension Array where Element == CollectionViewDataSourceItem {
    
    func registerCells(on collectionView: UICollectionView) {
        var unique = Set<String>()
        filter { (element) -> Bool in
            guard !unique.contains(element.cellIdentifier) else { return false }
            unique.insert(element.cellIdentifier)
            return true
        }.forEach { $0.registerCell(on: collectionView) }
    }
}
