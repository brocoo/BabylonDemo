//
//  PostDetailCollectionViewCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

final class PostDetailCollectionViewCell: CollectionViewCell {

    // MARK: - UIConstants
    
    fileprivate enum UIConstants {
        static var titleFont: UIFont { return UIFont.preferredFont(forTextStyle: .headline) }
        static var bodyFont: UIFont { return UIFont.preferredFont(forTextStyle: .body) }
        static var authorFont: UIFont { return UIFont.preferredFont(forTextStyle: .footnote) }
        static let spacing: CGFloat = 15.0
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

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
        bodyLabel.font = UIConstants.bodyFont
        authorLabel.font = UIConstants.authorFont
    }
}

// MARK: -

extension PostDetailCollectionViewCell: SizeConfigurableView {
    
    // MARK: - ConfigurableView protocol method
    
    func configure(with model: AuthoredPost) {
        titleLabel.text = model.post.title
        bodyLabel.text = model.post.body
        authorLabel.text = model.author.username
    }
    
    // MARK: - SizeConfigurableView protocol method
    
    static func height(with model: AuthoredPost, forWidth width: CGFloat) -> CGFloat {
        let contentWidth = width - (UIConstants.spacing * 2)
        var height: CGFloat = 0
        height += UIConstants.spacing
        height += model.post.title.height(forWidth: contentWidth, font: UIConstants.titleFont)
        height += UIConstants.spacing
        height += model.post.body.height(forWidth: contentWidth, font: UIConstants.bodyFont)
        height += UIConstants.spacing
        height += model.author.username.height(forWidth: contentWidth, font: UIConstants.authorFont)
        height += UIConstants.spacing
        return height
    }
}
