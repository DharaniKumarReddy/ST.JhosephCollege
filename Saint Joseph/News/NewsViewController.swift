//
//  NewsViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import CoreData

class NewsViewController: UIViewController {

    var news: [NewsData]!
    
    @IBOutlet private weak var label: UILabel!
    
    // MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = news.last?.title as? String
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Private Methods
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }

}
