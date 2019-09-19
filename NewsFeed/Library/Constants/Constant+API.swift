//
//  Constant+API.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation

// MARK: - API Services
let BASE_URL = "https://gospark.app/api/v1"

struct APIServices {
    static let loginAPI = APIServices.apiURL("login")
    static let sigupAPI = APIServices.apiURL("register")
    static let newsFeedAPI = APIServices.apiURL("kstream")
    
    static func apiURL(_ methodName: String) -> String {
        return BASE_URL + "/" + methodName
    }
}
