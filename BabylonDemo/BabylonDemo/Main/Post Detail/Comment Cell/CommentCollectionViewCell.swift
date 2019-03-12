//
//  CommentCollectionViewCell.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

final class CommentCollectionViewCell: CollectionViewCell {

    // MARK: - UIConstants
    
    fileprivate enum UIConstants {
        static let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        static let emailFont = UIFont.preferredFont(forTextStyle: .subheadline)
        static let verticalSpacing: CGFloat = 15.0
        static let horizontalSpacing: CGFloat = 15.0
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - UICollectionViewCell life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .white
        bodyLabel.font = UIConstants.bodyFont
        emailLabel.font = UIConstants.emailFont
    }
}

extension CommentCollectionViewCell: SizeConfigurableView {
    
    // MARK: - ConfigurableView protocol method
    
    func configure(with model: Comment) {
        bodyLabel.text = model.body
        emailLabel.text = model.email
    }
    
    // MARK: - SizeConfigurableView protocol method
    
    static func height(with model: Comment, forWidth width: CGFloat) -> CGFloat {
        let contentWidth = width - (UIConstants.horizontalSpacing * 2)
        var height: CGFloat = 0
        height += UIConstants.verticalSpacing
        height += model.body.height(forWidth: contentWidth, font: UIConstants.bodyFont)
        height += UIConstants.verticalSpacing
        height += model.email.height(forWidth: contentWidth, font: UIConstants.emailFont)
        height += UIConstants.verticalSpacing
        return height
    }
}
