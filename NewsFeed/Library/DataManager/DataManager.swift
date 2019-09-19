//
//  DataManager.swift
//  NewsFeed
//
//  Created by Sudhir on 17/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation

class DataManager {
    let httpClient: HTTPRequestManager
    let isOnline: Bool = true

    // MARK: - Singleton Instance

    class var shared: DataManager {
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }

    private init() {
        httpClient = HTTPRequestManager.shared
    }
}

extension DataManager {
    /**
     Method used to handle api response and based on the status it calls completion handler

     - parameter response:   api response
     - parameter completion: completion handler
     */
    func handleResponse(_ response: Response, completion: (_ success: Bool, _ error: Error?) -> Void) {
        Logger.debug("response = \(response)")

        if response.success() {
            completion(true, nil)
        } else {
            if let x = response.resultJSON?["statusCode"] as? Int {
                if x == 401 {
                    Utilities.logOutUser()
                }
            }
            completion(false, response.error)
        }
    }

    func performRequest(_ urlString: String, params: [String: String], completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        httpClient.performHTTPActionWithMethod(.POST, urlString: urlString, params: params) { (response) -> Void in

            self.handleResponse(response, completion: completion)
        }
    }
}
