//
//  CommentsCountCollectionViewCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/5/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

final class CommentsCountCollectionViewCell: CollectionViewCell {
    
    // MARK: - UIConstants
    
    fileprivate enum UIConstants {
        static var commentsFont: UIFont { return UIFont.preferredFont(forTextStyle: .caption2) }
        static let spacing: CGFloat = 15.0
    }
    
    // MARK: - IBOutlet properties
    
    @IBOutlet weak var commentsCountLabel: UILabel!
    
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
        commentsCountLabel.font = UIConstants.commentsFont
    }
}

// MARK: -

extension CommentsCountCollectionViewCell: SizeConfigurableView {
    
    // MARK: - ConfigurableView protocol method
    
    func configure(with model: Int) {
        commentsCountLabel.text = model.asCommentCountText
    }
    
    // MARK: - SizeConfigurableView protocol method
    
    static func height(with model: Int, forWidth width: CGFloat) -> CGFloat {
        let contentWidth = width - (UIConstants.spacing * 2)
        return model.asCommentCountText.height(forWidth: contentWidth, font: UIConstants.commentsFont) + (UIConstants.spacing * 2)
    }
}

extension Int {
    
    // MARK: -
    
    fileprivate var asCommentCountText: String {
        return "\(self) \(self > 1 ? "comments" : "comment")"
    }
}
