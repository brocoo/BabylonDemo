//
//  AnyCollectionViewCellRepresentable.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

class AnyCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView, ConfigurableView {
    
    typealias Model = Any
    func configure(with model: Any) { }
}

struct AnyCellRepresentable: CellViewRepresentable {
    
    typealias CellType = AnyCollectionViewCell
    let model: Any
    let cachedSize: CGSize
    
    private let base: AnyCellRepresentableBoxBase
    
    public init<Base: CellViewRepresentable>(_ base: Base) {
        self.base = AnyRenderableBox(base)
        self.model = base.model
        self.cachedSize = base.cachedSize
    }
}

class AnyRenderableBox<Base: CellViewRepresentable>: AnyCellRepresentableBoxBase {
    
    let base: Base
    
    init(_ base: Base) {
        self.base = base
        super.init()
    }
    
    override var model: Any {
        return base.model
    }
    
    override var cachedSize: CGSize {
        return base.cachedSize
    }
}

class AnyCellRepresentableBoxBase {
    
    init() {}
    
    var model: Any { fatalError() }
    var cachedSize: CGSize { fatalError() }
}
