//
//  ContactUsViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 8/8/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

let CONTACTUSCELLS = ["WebsiteCell", "EmailCell", "PhoneCell", "LocationCell", "AddressCell"]

class ContactUsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }
    
    // MARK:- UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CONTACTUSCELLS[indexPath.row])!
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.sjpuc.in")!)
        case 3:
            UIApplication.sharedApplication().openURL(NSURL(string: "https://www.google.co.in/maps/place/SJPUC/@12.9711237,77.6020432,17z/data=!3m1!4b1!4m5!3m4!1s0x3bae1680a56a367b:0xd5e28804a197d3d0!8m2!3d12.9711185!4d77.6042319?hl=en")!)
        default:
            break
        }
    }
}
