//
//  PostCollectionViewCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

final class PostCollectionViewCell: CellView {
    
    // MARK: - UIConstants
    
    fileprivate enum UIConstants {
        static var titleFont: UIFont { return UIFont.preferredFont(forTextStyle: .body) }
        static var authorFont: UIFont { return UIFont.preferredFont(forTextStyle: .footnote) }
        static let verticalSpacing: CGFloat = 15.0
        static let horizontalSpacing: CGFloat = 15.0
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.groupTableViewBackground : UIColor.white
        }
    }

    // MARK: - UICollectionViewCell life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        titleLabel.font = UIConstants.titleFont
        authorLabel.font = UIConstants.authorFont
    }
}

extension PostCollectionViewCell: SizeCacheableView {
    
    // MARK: - ConfigurableView protocol method
    
    func configure(with model: AuthoredPost) {
        titleLabel.text = model.post.title
        authorLabel.text = model.author.username
    }
    
    // MARK: - HeightCacheableView protocol method
    
    static func height(with model: AuthoredPost, forWidth width: CGFloat) -> CGFloat {
        let contentWidth = width - (UIConstants.horizontalSpacing * 2)
        var height: CGFloat = 0
        height += UIConstants.verticalSpacing
        height += model.post.title.height(forWidth: contentWidth, font: UIConstants.titleFont)
        height += UIConstants.verticalSpacing
        height += model.author.username.height(forWidth: contentWidth, font: UIConstants.authorFont)
        height += UIConstants.verticalSpacing
        return height
    }
}
