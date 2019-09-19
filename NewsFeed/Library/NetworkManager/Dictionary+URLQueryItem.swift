//
//  Dictionary+Query.swift
//
//  Created by Arvind Singh on 07/07/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import Foundation

// MARK: Dictionary Extension

extension Dictionary {
    func queryItems() -> [URLQueryItem]? {
        if keys.isEmpty == false {
            var items = [URLQueryItem]()
            for key in keys {
                if key is String && self[key] is String {
                    items.append(URLQueryItem(name: key as! String, value: self[key] as? String))
                } else {
                    assertionFailure("Key and Value should be string type")
                }
            }
            return items
        }
        return nil
    }
}
