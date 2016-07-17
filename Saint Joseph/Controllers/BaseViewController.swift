//
//  BaseViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/13/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import CoreData

class BaseViewController: UIViewController {
    
    private var newsEventsData = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewsFeed()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK:- Save Core Data
    
    private func saveData(news: [OLNews]) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
      //  let entity = NSEntityDescription.entityForName("News", inManagedObjectContext: managedContext)
        
        for newsObject in news {
            let newsValues =  NewsData.newWithContext(managedContext, entityName: "News")
            
        }
      //  let newsValues =  NewsData.newWithContext(managedContext, entityName: "News") //NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
    }
    
    // MARK:- API Caller Method
    
    private func fetchNewsFeed() {
        let taskGroup = dispatch_group_create()
        dispatch_group_enter(taskGroup)
        APICaller.getInstance().fetchNews(
            onSuccessNews: { newsFeed in
                dispatch_group_leave(taskGroup)
                self.saveData(newsFeed.news)
                self.performSegueWithIdentifier("SlidingViewControllerSegue", sender: self)
                print(newsFeed)
            }, onError: { _ in
                dispatch_group_leave(taskGroup)
                self.performSegueWithIdentifier("SlidingViewControllerSegue", sender: self)
        })
    }
    
    // MARK: Navigation Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "SlidingViewControllerSegue":
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
