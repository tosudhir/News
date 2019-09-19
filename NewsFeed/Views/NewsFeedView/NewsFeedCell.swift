//
//  NewsFeedCell.swift
//  NewsFeed
//
//  Created by Sudhir on 19/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit
import SDWebImage

class NewsFeedCell: UITableViewCell {

    //IBOutlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userImageView:UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var sharedTimeLabel: UILabel!
    @IBOutlet weak var sponsoredView: UIView!
    @IBOutlet weak var sponsoredNameLabel: UILabel!
    @IBOutlet weak var sponsorImageView: UIImageView!
    @IBOutlet weak var sponsorDescriptionLabel: UILabel!
    @IBOutlet weak var sharedView: UIView!
    @IBOutlet weak var sharedImageView: UIImageView!
    @IBOutlet weak var shareActionView: UIView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeView: UIView!
    
    // private iVar
    var feed = Feed()
    
    // Class iVar
    class var identifier:String {
        return String(describing: self)
    }
    
    class var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Custom Method
    func configureFeedCell(feed:Feed?) {
        guard let feed = feed else {
            return
        }
        self.feed = feed
        self.setupCell()
    }
    
    // MARK: - IBActions
    @IBAction func likeClicked() {
        print("Like Clicked.")
    }
    
    @IBAction func commentClicked() {
        print("Comment Clicked.")
    }
    
    @IBAction func shareClicked() {
        print("Share Clicked.")
    }
}

extension NewsFeedCell {
    func setupCell(){
        if feed.is_sponsored ?? 1 == 1 {
            sponsoredView.isHidden = false
            headerView.isHidden = true
            setupSponsoredView()
        } else {
            headerView.isHidden = false
            sponsoredView.isHidden = true
            setupHeaderView()
        }
        setupDescriptionView()
        setupFooterView()
    }
    
    func setupSponsoredView() {
        sponsoredNameLabel.text = feed.title
        sponsorImageView.sd_setImage(with: URL(string: feed.title_image ?? ""), placeholderImage: UIImage(named: ""))
    }
    
    func setupHeaderView() {
        userImageView.sd_setImage(with: URL(string: feed.title ?? ""), placeholderImage: UIImage(named: ""))
        userNameLabel.text = feed.title
        sharedTimeLabel.text = feed.published_date
    }
    
    func setupDescriptionView() {
        sharedImageView.sd_setImage(with: URL(string: feed.description_image_url ?? ""), placeholderImage: UIImage(named: ""))
    }
    
    func setupFooterView(){
        var likeText = ""
        if feed.likes ?? 0 > 0 {
            likeText = "\(feed.likes!) Like" + (feed.likes ?? 0 > 1 ? "s" : "")
        }
        if feed.shares ?? 0 > 0 {
            if likeText.count > 2 {
                likeText = likeText + " "
            }
            likeText = likeText + "\(feed.shares!) Share" + (feed.shares ?? 0 > 1 ? "s" : "")
        }
        if feed.comments ?? 0 > 0 {
            if likeText.count > 2 {
                likeText = likeText + " "
            }
            likeText = likeText + "\(feed.comments!) Comments" + (feed.comments ?? 0 > 1 ? "s" : "")
        }
        likeView.isHidden = likeText.count == 0 ? true : false
    }
}
