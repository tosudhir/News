//
//  User.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation

struct User: Codable {
    var id:Int?
    var api_token:String?
    var created_at:String?
    var email:String?
    var name:String?
    var user_type:String?
}
