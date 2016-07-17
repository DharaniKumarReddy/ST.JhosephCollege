//
//  ViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/4/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewsFeed()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK:- API Caller Method
    
    private func fetchNewsFeed() {
        let taskGroup = dispatch_group_create()
        dispatch_group_enter(taskGroup)
        APICaller.getInstance().fetchNews(
            onSuccessNews: { newsFeed in
                dispatch_group_leave(taskGroup)
                print(newsFeed)
            }, onError: { _ in
                dispatch_group_leave(taskGroup)
        })
    }
}

