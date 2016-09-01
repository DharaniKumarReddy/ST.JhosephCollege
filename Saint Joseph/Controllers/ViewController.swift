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
    
    var managedObjectContext: NSManagedObjectContext!
    
    private var newsEventsData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
        let defaults = NSUserDefaults.standardUserDefaults()
        let updatedDate = defaults.valueForKey(Constants.UserDefaults.NewsUpdated)
        if updatedDate != nil {
            lastUpdatedDate = DateFormatter.defaultFormatter().dateFromString(updatedDate as! String)!
        }
        fetchNewsFeed()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchRequest()
    }
    
    // MARK:- Save Core Data
    
    private func saveData(news: NSArray) {
        var newsDataObjects = [NewsData]()
        
        if news.count > 0 {
            for i in 0...news.count-1 {
                let newsData = NSEntityDescription.insertNewObjectForEntityForName("News", inManagedObjectContext: managedObjectContext) as! NewsData

                let newsEvents = news[i] as! NSDictionary
                //  newsData.date =  formatter.dateFromString((newsEvents["date"] ?? "") as! String)
                newsData.id = newsEvents["id"] as? String
                newsData.newsID = newsEvents["id"] as? String
                newsData.descript = newsEvents["description"] as? String
                newsData.largeImageURL = newsEvents["limg"] as? String
                newsData.smallImageURL = newsEvents["simg"] as? String
                newsData.title = newsEvents["title"] as? String
                newsData.type = newsEvents["type"] as? String
                newsData.updatedAt = newsEvents["updated_at"] as? String
                let newDate = DateFormatter.defaultFormatter().dateFromString(newsData.updatedAt!)
                if newDate?.isGreaterThanDate(lastUpdatedDate) == true {
                    lastUpdatedDate = newDate!
                }
                newsDataObjects.append(newsData)
            }
            do {
                try self.managedObjectContext.save()
                let date = DateFormatter.defaultFormatter().stringFromDate(lastUpdatedDate)
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(date, forKey: Constants.UserDefaults.NewsUpdated)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        fetchRequest()
    }
    
    private func fetchRequest() {
        let fetchRequest = NSFetchRequest(entityName: "News")
        do {
            result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [NewsData]
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
                self.saveData(newsFeed.sjpu_news)
            }, onError: { _ in
                dispatch_group_leave(taskGroup)
                self.saveData(NSArray())
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.SegueIdentifier.NewsSegue:
            let newsViewController = segue.destinationViewController as! NewsViewController
            let news = result.filter {
                $0.type == "1"
            }
            newsViewController.news = news
        case Constants.SegueIdentifier.EventsSegue, Constants.SegueIdentifier.AnnouncementsSegue:
            let eventsController = segue.destinationViewController as! EventsViewController
            let events = result.filter {
                $0.type == "2"
            }
            eventsController.events = events
            eventsController.controllerType = segue.identifier == Constants.SegueIdentifier.EventsSegue ? .Events : .Announcements
        case Constants.SegueIdentifier.GallerySegue, Constants.SegueIdentifier.VideosSegue:
            let galleryViewController = segue.destinationViewController as! GalleryViewController
            let news = result.filter {
                $0.type == "1"
            }
            galleryViewController.news = news
            galleryViewController.controllerType = segue.identifier == Constants.SegueIdentifier.GallerySegue ? .Gallery : .Videos
        case Constants.SegueIdentifier.AcademicSegue, Constants.SegueIdentifier.ERPSegue:
            let htmlViewController = segue.destinationViewController as! HtmlLoaderViewController
            htmlViewController.controllerType = Constants.SegueIdentifier.AcademicSegue == segue.identifier ? .Academic : .ERP
        default:
            print("Do nothing for other cases")
        }
    }
}

