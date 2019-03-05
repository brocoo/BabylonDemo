//
//  CommentCollectionViewCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

final class CommentCollectionViewCell: CellView {

    // MARK: - UIConstants
    
    fileprivate enum UIConstants {
        static var bodyFont: UIFont { return UIFont.preferredFont(forTextStyle: .body) }
        static var emailFont: UIFont { return UIFont.preferredFont(forTextStyle: .footnote) }
        static let verticalSpacing: CGFloat = 15.0
        static let horizontalSpacing: CGFloat = 15.0
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
        bodyLabel.font = UIConstants.bodyFont
        emailLabel.font = UIConstants.emailFont
    }
    
    func configure(body: String, email: String) {
        bodyLabel.text = body
        emailLabel.text = email
    }
}

extension CommentCollectionViewCell {
    
    // MARK: - Sizing
    
    static func height(forBody body: String, email: String, forWidth width: CGFloat) -> CGFloat {
        let contentWidth = width - (UIConstants.horizontalSpacing * 2)
        var height: CGFloat = 0
        height += UIConstants.verticalSpacing
        height += body.height(forWidth: contentWidth, font: UIConstants.bodyFont)
        height += UIConstants.verticalSpacing
        height += email.height(forWidth: contentWidth, font: UIConstants.emailFont)
        height += UIConstants.verticalSpacing
        return height
    }
}
