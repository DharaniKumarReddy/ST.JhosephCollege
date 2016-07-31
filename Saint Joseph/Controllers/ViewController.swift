//
//  ViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/4/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

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
        fetchNewsFeed()
        
        // Do any additional setup after loading the view, typically from a nib.
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
        let taskGroup = dispatch_group_create()
        dispatch_group_enter(taskGroup)
        APICaller.getInstance().fetchNews(
            onSuccessNews: { newsFeed in
                dispatch_group_leave(taskGroup)
                self.saveData(newsFeed.sjec_news)
            }, onError: { _ in
                dispatch_group_leave(taskGroup)
                self.saveData(NSArray())
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.SegueIdentifier.NewsSegue:
            let newsViewController = segue.destinationViewController as! NewsViewController
            newsViewController.news = result
        case Constants.SegueIdentifier.EventsSegue, Constants.SegueIdentifier.AnnouncementsSegue:
            let eventsController = segue.destinationViewController as! EventsViewController
            let events = result.filter {
                $0.type == "2"
            }
            eventsController.events = events
            eventsController.controllerType = segue.identifier == Constants.SegueIdentifier.EventsSegue ? .Events : .Announcements
        case Constants.SegueIdentifier.GallerySegue, Constants.SegueIdentifier.VideosSegue:
            let galleryViewController = segue.destinationViewController as! GalleryViewController
            galleryViewController.controllerType = segue.identifier == Constants.SegueIdentifier.GallerySegue ? .Gallery : .Videos
        default:
            print("Do nothing for other cases")
        }
    }
}

