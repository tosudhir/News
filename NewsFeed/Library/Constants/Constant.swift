//
//  Constant.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation
import UIKit
// -----Global Objects
let kAppDelegate = UIApplication.shared.delegate as? AppDelegate

struct Constant {
    struct AlertMessage {
        static let invalidEmail = "Please input valid email."
        static let invalidPassword = "Please input valid password. Should be minimum 8 character."
        static let allFieldMandatory = "All fields are mandatory."
    }
    
    struct AppText {
        static let appToken = "api_token"
        static let user = "USER_DATA"
    }
    
    struct ViewControllerIdentifier {
        static let baseController = "BaseViewController"
        static let loginController = "LoginViewController"
        static let signupController = "SignupViewController"
        static let newsFeedController = "NewsFeedViewController"
        static let articleController = "ArticleViewController"
    }
    
    struct StoryboardIndentifier {
        static let main = "Main"
    }
}
