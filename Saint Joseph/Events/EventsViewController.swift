//
//  EventsViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/16/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnnouncementDownloadDelegate {
    
    var events: [NewsData]!
    
    var announcements: [NewsData]!
    
    var controllerType: ControllerType!
    
    enum ControllerType {
        case Events, Announcements
    }
    
    // MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = controllerType == .Events ? Constants.Title.Events : Constants.Title.Announcements
        // Do any additional setup after loading the view.
    }
    
    // MARK:- UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerType == .Events ? events.count : announcements.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if controllerType == .Events {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifier.EventsCell)! as! EventsCell
            cell.event = events[indexPath.row]
            cell.fillEventsData()
            cell.tag = indexPath.row
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifier.AnnouncementsCell)! as! AnnouncementsCell
            cell.announcement = announcements[indexPath.row]
            cell.fillData()
            cell.delegate = self
            cell.tag = indexPath.row
            return cell
        }
    }
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }

    // MARK:- AnnouncementDownloadDelegate
    
    func showPDF(url: String) {
        let pdfViewController = UIStoryboard(Constants.StoryBoard.Events).instantiateViewControllerWithIdentifier(Constants.ViewControllerIdentifier.PDFViewController) as! PDFViewController
        pdfViewController.pdfURL = url
        presentViewController(pdfViewController, animated: true, completion: nil)
    }
}
