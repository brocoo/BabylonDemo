//
//  CollectionViewAdapter.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class CollectionViewAdapter<T: CellViewRepresentable>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private let collectionView: UICollectionView
    private let onSelectedRelay: PublishRelay<T>
    private(set) lazy var onSelected: Signal<T> = self.onSelectedRelay.asSignal()
    
    fileprivate var dataSource: [T] {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Initializer
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.onSelectedRelay = PublishRelay()
        self.dataSource = []
        super.init()
        setup()
    }
    
    // MARK: - Set up
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        T.registerCollectionViewCell(for: collectionView)
    }
    
    // MARK: - UICollectionViewDataSource protocol methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource[indexPath.row].asConfiguredCollectionViewCell(dequeuedFrom: collectionView, atIndexPath: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout protocol methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource[indexPath.row].cachedSize
    }
    
    // MARK: - UICollectionViewDelegate protocol methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectedRelay.accept(dataSource[indexPath.row])
    }
}

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    
    // MARK: - Driver helper methods
    
    func drive<T: CellViewRepresentable>(_ collectionViewAdapter: CollectionViewAdapter<T>) -> Disposable where E == [T] {
        return drive(onNext: { [weak collectionViewAdapter] (dataSource) in
            collectionViewAdapter?.dataSource = dataSource
        })
    }
}


