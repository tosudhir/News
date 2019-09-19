//
//  NewsFeed.swift
//  NewsFeed
//
//  Created by Sudhir on 19/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation

struct NewsFeed: Codable {
    var kstream:Kstrem?
}

struct Kstrem: Codable {
    var current_page: Int?
    var data:[Feed]?
    var first_page_url:String?
    var from:Int?
    var next_page_url:String?
    var path:String?
    var per_page: Int?
    var prev_page_url:String?
    var to:Int?
    
}

struct Feed: Codable {
    var accepted:Int?
    var article_type:String?
    var article_url:String?
    var author:String?
    var comments:Int?
    var created_at:String?
    var description_image_url:String?
    var filtertags:String?
    var full_description:String?
    var id: Int?
    var is_premium:Int?
    var is_sponsored:Int?
    var likes:Int?
    var meta_kstream_id:Int?
    var published_date:String?
    var rss_source_id:Int?
    var shares:Int?
    var short_description:String?
    var tag_line:String?
    var tags:String?
    var title:String?
    var title_image:String?
    var title_image_url:String?
    var updated_at:String?
}
