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
    
    var result: [NewsData]!
    
    private var newsEventsData = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewsFeed()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK:- Save Core Data
    
    private func saveData(news: NSArray) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("News", inManagedObjectContext: managedContext)
        var newsDataObjects = [NewsData]()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
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
            print(newsData)
            newsDataObjects.append(newsData)
        }
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
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
        let taskGroup = dispatch_group_create()
        dispatch_group_enter(taskGroup)
        APICaller.getInstance().fetchNews(
            onSuccessNews: { newsFeed in
                dispatch_group_leave(taskGroup)
                self.saveData(newsFeed.sjec_news)
                self.performSegueWithIdentifier("SlidingViewControllerSegue", sender: self)
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
        ((slidingViewController.topViewController as! UINavigationController).viewControllers[0] as! ViewController).news = result
    }

}
