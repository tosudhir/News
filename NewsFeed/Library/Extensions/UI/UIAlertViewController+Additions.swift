//
//  UIAlertController+Addiotios.swift
//  NewsFeed
//
//  Created by Sudhir on 17/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIAlertController Extension

extension UIAlertController {
    /**
     Present alert with ok  buttton only.

     - parameter title:     String which show as title
     - parameter message :  String which show as message
     - parameter handler:   Callback action to handle action

     - returns:  Completion handler returns callback to function
     */
    func alertWithOk(_ title: String, message: String, handler: ((UIAlertAction?) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertAction.Style.default, handler: handler))
        return alert
    }

    /**
     Present alert with ok and cancel butttons.

     - parameter title:     String which show as title
     - parameter message :  String which show as message
     - parameter handler:   Callback action to handle action

     - returns : Completion handler returns callback to function
     */
    class func alertWithOkAndCancel(_ title: String, message: String, handler: ((UIAlertAction?) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertAction.Style.default, handler: handler))
        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "CANCEL"), style: UIAlertAction.Style.cancel, handler: handler))
        return alert
    }

    /**
     Present alert with multiple buttons which we want to pass in button title.

     - parameter title:     String which show as title
     - parameter message :  String which show as message
     - parameter handler:   Callback action to handle action

     - returns: Completion handler returns callback to function
     */
    func confirmAlertWithMultipleButtons(_ title: String, message: String, arrayButtons: NSArray, handler: ((UIAlertAction?) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for buttonTitle in arrayButtons {
            alert.addAction(UIAlertAction(title: buttonTitle as? String, style: UIAlertAction.Style.default, handler: handler))
        }
        return alert
    }
}
