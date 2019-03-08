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

final class CollectionViewAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    fileprivate let collectionView: UICollectionView
    private var dataSource: [CollectionViewDataSourceItem] = []
    private let _onRowSelected: PublishRelay<Int> = PublishRelay()
    private var _cellsRegistered: Bool = false
    private(set) lazy var onRowSelected: Signal<Int> = self._onRowSelected.asSignal()
    
    // MARK: - Initializer
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setup()
    }
    
    // MARK: - Set up
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    fileprivate func reload(with dataSource: [CollectionViewDataSourceItem]) {
        dataSource.registerCells(on: collectionView)
        collectionView.performBatchUpdates({
            self.dataSource = dataSource
            collectionView.reloadSections([0])
        }, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource protocol methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource[indexPath.row].dequeueConfiguredCell(from: collectionView, at: indexPath)
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
        _onRowSelected.accept(indexPath.row)
    }
}

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy, E == [CollectionViewDataSourceItem] {
    
    // MARK: - Driver helper methods
    
    func drive(_ collectionViewAdapter: CollectionViewAdapter) -> Disposable {
        return drive(onNext: { [weak collectionViewAdapter] (dataSource) in
            collectionViewAdapter?.reload(with: dataSource)
        })
    }
}
