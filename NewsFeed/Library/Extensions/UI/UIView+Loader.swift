//
//  UIView+Loader.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation
import MBProgressHUD

// MARK: - UIView Extension

extension UIView {
    // - MARK: - Loading Progress View
    func showLoader() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.isSquare = true
        hud.mode = .indeterminate
        // hud.color = Colors.themeColor()
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
