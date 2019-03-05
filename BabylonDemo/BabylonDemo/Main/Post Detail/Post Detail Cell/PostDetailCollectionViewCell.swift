//
//  PostDetailCollectionViewCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

final class PostDetailCollectionViewCell: CellView {

    // MARK: - UIConstants
    
    fileprivate enum UIConstants {
        static var titleFont: UIFont { return UIFont.preferredFont(forTextStyle: .headline) }
        static var bodyFont: UIFont { return UIFont.preferredFont(forTextStyle: .body) }
        static var authorFont: UIFont { return UIFont.preferredFont(forTextStyle: .footnote) }
        static var commentsCountFont: UIFont { return UIFont.preferredFont(forTextStyle: .caption2) }
        static let verticalSpacing: CGFloat = 15.0
        static let horizontalSpacing: CGFloat = 15.0
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
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
        titleLabel.font = UIConstants.titleFont
        bodyLabel.font = UIConstants.bodyFont
        authorLabel.font = UIConstants.authorFont
        commentsCountLabel.font = UIConstants.commentsCountFont
    }
    
    func configure(title: String, body: String, author: String, commentsCount: String) {
        titleLabel.text = title
        bodyLabel.text = body
        authorLabel.text = author
        commentsCountLabel.text = commentsCount
    }
}

extension PostDetailCollectionViewCell {
    
    // MARK: - Sizing
    
    static func height(forTitle title: String, body: String, author: String, commentsCount: String, forWidth width: CGFloat) -> CGFloat {
        let contentWidth = width - (UIConstants.horizontalSpacing * 2)
        var height: CGFloat = 0
        height += UIConstants.verticalSpacing
        height += title.height(forWidth: contentWidth, font: UIConstants.titleFont)
        height += UIConstants.verticalSpacing
        height += body.height(forWidth: contentWidth, font: UIConstants.bodyFont)
        height += UIConstants.verticalSpacing
        height += author.height(forWidth: contentWidth, font: UIConstants.authorFont)
        height += UIConstants.verticalSpacing
        height += commentsCount.height(forWidth: contentWidth, font: UIConstants.commentsCountFont)
        height += UIConstants.verticalSpacing
        return height
    }
}
