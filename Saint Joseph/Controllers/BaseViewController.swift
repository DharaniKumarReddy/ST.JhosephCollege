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
        //fetchNewsFeed()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegueWithIdentifier(Constants.SegueIdentifier.SlidingViewControllerSegue, sender: self)
    }
    // MARK:- Save Core Data
    
    private func saveData(news: NSArray) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("News", inManagedObjectContext: managedContext)
        var newsDataObjects = [NewsData]()
        
        if news.count > 0 {
            for i in 0...news.count-1 {
                let newsData: NewsData = NewsData(entity: entity!, insertIntoManagedObjectContext: managedContext)
                let newsEvents = news[i] as! NSDictionary
                //  newsData.date =  formatter.dateFromString((newsEvents["date"] ?? "") as! String)
                newsData.descript = newsEvents["description"] as! NSString
                newsData.largeImageURL = newsEvents["limg"] as! NSString
                newsData.smallImageURL = newsEvents["simg"] as! NSString
                newsData.title = newsEvents["title"] as! NSString
                newsData.type = newsEvents["type"] as! NSString
                newsData.updatedAt = newsEvents["updated_at"] as! NSString
                let newDate = DateFormatter.defaultFormatter().dateFromString(newsData.updatedAt as String)
                if newDate?.isGreaterThanDate(lastUpdatedDate) == true {
                    lastUpdatedDate = newDate!
                }
                print(newsData)
                newsDataObjects.append(newsData)
            }
            do {
                try managedContext.save()
                let date = DateFormatter.defaultFormatter().stringFromDate(lastUpdatedDate)
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(date, forKey: Constants.UserDefaults.NewsUpdated)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        
        let fetchRequest = NSFetchRequest(entityName: "News")
        do {
            result = try managedContext.executeFetchRequest(fetchRequest) as! [NewsData]
            print(result)
        } catch let fetchError as NSError {
            print("getGalleryForItem error: \(fetchError.localizedDescription)")
        }
    }
    
    // MARK:- API Caller Method
    
    private func fetchNewsFeed() {
        APICaller.getInstance().fetchNews(
            onSuccessNews: { newsFeed in
                self.saveData(newsFeed.sjec_news)
                self.performSegueWithIdentifier(Constants.SegueIdentifier.SlidingViewControllerSegue, sender: self)
            }, onError: { _ in
                self.saveData(NSArray())
                self.performSegueWithIdentifier(Constants.SegueIdentifier.SlidingViewControllerSegue, sender: self)
        })
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
