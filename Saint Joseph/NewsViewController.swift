//
//  NewsViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let 🍔 = navigationController!.topViewController!.navigationItem.leftBarButtonItem {
            🍔.target = self
            🍔.action = #selector(NewsViewController.hamburgerPressed(_:))
        }

        getNews()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- API Caller Method
    
    private func getNews() {
        APICaller.getInstance().fetchNews(
            onSuccess: { newsFeed in
            print(newsFeed)
            }, onError: { _ in
                
        })
    }
    
    // MARK: IBAction Methods
    
    @objc private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }

}
