//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Sudhir on 17/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // iVar
    private var feeds = [Feed]();
    private var currentPage = 0
    private var totalPage = 0
    
    // Computed Var
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Custom Methods
    func setupUI() {
        // Setup UI
        tableView.register(NewsFeedCell.nib, forCellReuseIdentifier: NewsFeedCell.identifier)
        tableView.estimatedRowHeight = 377
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setupData() {
        // Update UI with data
        fetchNewsFeed()
    }
    
    // MARK: - IBActions
    @IBAction func logoutClicked() {
        Utilities.logOutUser()
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:NewsFeedCell.identifier) as? NewsFeedCell {
            cell.configureFeedCell(feed: feeds[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleController = UIStoryboard.navigateToArticle()
        articleController.feedUrl = feeds[indexPath.row].article_url
        navigationController?.pushViewController(articleController, animated: true)
    }
}

extension NewsFeedViewController {
    // MARK: - WebServices
    func fetchNewsFeed() {
        if currentPage>totalPage {
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        view.showLoader()
        DataManager.shared.fetchNewsFeed(currentPage) { [unowned self](newsFeed, _, error) in
            self.view.hideLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                self.currentPage = newsFeed?.kstream?.current_page ?? 0
                self.totalPage = newsFeed?.kstream?.to ?? 0
                self.feeds = newsFeed?.kstream?.data ?? [Feed]()
                self.tableView.reloadData()
            } else {
                let controller = UIAlertController().alertWithOk("Failed!", message: error?.localizedDescription ?? "Unknown error!")
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
