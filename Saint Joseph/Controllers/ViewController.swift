//
//  ViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/4/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var news: [NewsData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(news)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.SegueIdentifier.NewsSegue:
            let newsViewController = segue.destinationViewController as! NewsViewController
            newsViewController.news = news
        case Constants.SegueIdentifier.EventsSegue, Constants.SegueIdentifier.AnnouncementsSegue:
            let eventsController = segue.destinationViewController as! EventsViewController
            let events = news.filter {
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

