//
//  User+Service.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation

extension DataManager {
    /**
     Method used to handle user signin and signup api response
     
     - parameter response:   api response
     - parameter completion: completion handler
     */
    func handleSignInResponse(_ response: Response, completion: (_ result: User?, _ success: Bool, _ error: Error?) -> Void) {
        Logger.debug("response = \(response)")
        if response.success() {
            // parse the response
            if let result = response.resultJSON?["user"] as? Dictionary<String, Any> {
                if let _ = result["api_token"] {
                    do {
                        // Decode retrived data with JSONDecoder
                        let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                        let user = try JSONDecoder().decode(User.self, from: jsonData)
                        UserDefaults.saveUserModelToUserDefaults(obj: user, key: Constant.AppText.user)
                        completion(user, true, nil)
                    } catch let jsonError {
                        completion(nil, false, jsonError)
                    }
                } else {
                    completion(nil, false, nil)
                }
            } else {
                completion(nil, false, response.error)
            }
        } else {
            if let x = response.resultJSON?["statusCode"] as? Int {
                if x == 401 {
                    Utilities.logOutUser()
                }
            }
            completion(nil, false, response.error)
        }
    }
    
    func handleSignUpResponse(_ response: Response, completion: (_ message: String?, _ success: Bool, _ error: Error?) -> Void) {
        Logger.debug("response = \(response)")
        if response.success() {
            // parse the response
            if let result = response.resultJSON as? Dictionary<String, Any> {
                        completion(result["message"] as? String, true, nil)
            } else{
                completion(nil, false, response.error)
            }
        } else {
            if let x = response.resultJSON?["statusCode"] as? Int {
                if x == 401 {
                    Utilities.logOutUser()
                }
            }
            completion(nil, false, response.error)
        }
    }
    
    func handleFeedResponse(_ response: Response, completion: (_ result: NewsFeed?, _ success: Bool, _ error: Error?) -> Void) {
        Logger.debug("response = \(response)")
        if response.success() {
            // parse the response
            if let result = response.resultJSON {
                do {
                    // Decode retrived data with JSONDecoder
                    let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                    let feed = try JSONDecoder().decode(NewsFeed.self, from: jsonData)
                    completion(feed, true, nil)
                } catch let jsonError {
                    completion(nil, false, jsonError)
                }
            } else {
                completion(nil, false, response.error)
            }
        } else {
            if let x = response.resultJSON?["statusCode"] as? Int {
                if x == 401 {
                    Utilities.logOutUser()
                }
            }
            completion(nil, false, response.error)
        }
    }
    
    
    
    // MARK: User Sign Up
    
    func registerWithEmail(_ email: String, password: String, name: String, mobile:String, gender:String, completion: @escaping (_ message: String?, _ success: Bool, _ error: Error?) -> Void) {
        let params = ["name": name, "email": email, "password": password, "password_confirmation":password, "mobile":mobile, "gender":gender]
        
        httpClient.performHTTPActionWithMethod(.POST, urlString: APIServices.sigupAPI, params: params) { (response) -> Void in
            
            self.handleSignUpResponse(response, completion: completion)
        }
    }
    
    // MARK: Login using email
    
    func loginWithEmail(_ email: String, password: String, completion: @escaping (_ result: User?, _ success: Bool, _ error: Error?) -> Void) {
        let params = ["email": email, "password": password]
        httpClient.performHTTPActionWithMethod(.POST, urlString: APIServices.loginAPI, params: params) { (response) -> Void in
            
            self.handleSignInResponse(response, completion: completion)
        }
    }
    
    func fetchNewsFeed(_ page: Int = 0, completion: @escaping (_ result: NewsFeed?, _ success: Bool, _ error: Error?) -> Void) {
        var params:[String:Any]?
        if page > 0 {
            params = ["page": "\(page)"]
        }
        
        httpClient.performHTTPActionWithMethod(.GET, urlString: APIServices.newsFeedAPI, params: params) { (response) -> Void in
            self.handleFeedResponse(response, completion: completion)
        }
    }
}
