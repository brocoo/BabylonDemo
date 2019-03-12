//
//  UIViewController+ErrorAlert.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(for error: Error, retry: @escaping () -> Void) {
        let alert = UIAlertController(title: "ERROR_MESSAGE_TITLE".localized, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ERROR_ALERT_RETRY".localized, style: .default, handler: { (action) in
            retry()
        }))
        alert.addAction(UIAlertAction(title: "ERROR_ALERT_CANCEL".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
