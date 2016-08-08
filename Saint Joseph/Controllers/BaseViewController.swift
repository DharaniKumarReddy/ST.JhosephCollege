//
//  BaseViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/13/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import CoreData
//import SwiftSpinner

class BaseViewController: UIViewController {
    
    var result: [NewsData]!
    
    var lastUpdatedDate = NSDate(timeIntervalSince1970: 0)
    
    private var newsEventsData = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let updatedDate = defaults.valueForKey(Constants.UserDefaults.NewsUpdated)
        if updatedDate != nil {
            lastUpdatedDate = DateFormatter.defaultFormatter().dateFromString(updatedDate as! String)!
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegueWithIdentifier(Constants.SegueIdentifier.SlidingViewControllerSegue, sender: self)
    }
    
    // MARK: Navigation Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.SegueIdentifier.SlidingViewControllerSegue:
            let slidingViewController = segue.destinationViewController as! SlidingViewController
            setupSlidingViewController(slidingViewController)
        default:
            return
            //Nothing to do here
        }
    }
    
    private func setupSlidingViewController(slidingViewController: SlidingViewController) {
        slidingViewController.topViewController = UIStoryboard(Constants.StoryBoard.Main).instantiateNavigationController(Constants.NavigationController.DashboardNavigationController)
    }

}
