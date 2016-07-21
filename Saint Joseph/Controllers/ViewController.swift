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
        case "NewsSegue":
            let newsViewController = segue.destinationViewController as! NewsViewController
            newsViewController.news = news
        case "EventsSegue", "AnnouncementsSegue":
            let eventsController = segue.destinationViewController as! EventsViewController
            eventsController.controllerType = segue.identifier == "EventsSegue" ? .Events : .Announcements
        default:
            print("Do nothing for other cases")
        }
    }
}

