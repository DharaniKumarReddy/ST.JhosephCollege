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
        switch indexPath.row {
        case 0:
            break
        default:
            break
        }
    }

}
