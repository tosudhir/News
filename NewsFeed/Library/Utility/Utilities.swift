//
//  Utilities.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    class func logOutUser() {
        // AppToast.showToastWithMessage(message)
        UserDefaults.saveUserModelToUserDefaults(obj: User(), key: Constant.AppText.user)
   
       let loginController = UIStoryboard.navigateToLogin()
       let navigationController = UINavigationController.init(rootViewController: loginController)
        navigationController.isNavigationBarHidden = true
        kAppDelegate?.window?.rootViewController = navigationController
    }
    
    class func makeUserLogin(_ token:String = "") {
        UserDefaults.save(value: token, forKey: Constant.AppText.appToken)
    }
    
    /**
     Global function to check if the input object is initialized or not.
     
     - parameter value: value to verify for initialization
     
     - returns: true if initialized
     */
    class func isObjectInitialized(_ value: AnyObject?) -> Bool {
        guard let _ = value else {
            return false
        }
        return true
    }
}
