//
//  UIStoryboard+Extension.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIStoryboard Extension
extension UIStoryboard {
    /**
     Convenience Initializers to initialize storyboard.
     
     - parameter storyboard: String of storyboard name
     - parameter bundle:     NSBundle object
     
     - returns: A Storyboard object
     */
    convenience init(storyboard: String, bundle: Bundle? = nil) {
        self.init(name: storyboard, bundle: bundle)
    }
    
    /**
     Initiate view controller with view controller name.
     
     - returns: A UIView controller object
     */
    func instantiateViewController<T: UIViewController>() -> T {
        var fullName: String = NSStringFromClass(T.self)
        
        if let range = fullName.range(of: ".", options: .backwards) {
            fullName = fullName.substring(from: range.upperBound)
        }
        
        guard let viewController = self.instantiateViewController(withIdentifier: fullName) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(fullName) ")
        }
        
        return viewController
    }
    
    // MARK: - Storyboard
    
    private class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: Constant.StoryboardIndentifier.main, bundle: nil)
    }
    
    // MARK: - AllViewControllers
    class func navigateToLogin() -> LoginViewController {
        return UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: Constant.ViewControllerIdentifier.loginController) as! LoginViewController
    }
    
    class func navigateToSignup() -> SignupViewController {
        return UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: Constant.ViewControllerIdentifier.signupController) as! SignupViewController
    }
    
    class func navigateToNewsFeed() -> NewsFeedViewController {
        return UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: Constant.ViewControllerIdentifier.newsFeedController) as! NewsFeedViewController
    }
    
    class func navigateToArticle() -> ArticleViewController {
        return UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: Constant.ViewControllerIdentifier.articleController) as! ArticleViewController
    }
    
}
