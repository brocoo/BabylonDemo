//
//  String+BoundingRect.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/3/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

extension String {
    
    public func boundingRect(forWidth width: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox
    }
    
    public func width(forFont font: UIFont) -> CGFloat {
        return boundingRect(forWidth: .greatestFiniteMagnitude, font: font).width
    }
    
    public func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        return boundingRect(forWidth: width, font: font).height
    }
}
