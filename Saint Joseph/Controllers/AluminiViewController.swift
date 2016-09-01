//
//  AluminiTableViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 9/1/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class AluminiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifier.AluminiTableViewCell)
        return cell!
    }
}

class AluminiTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var aluminiTextField: UITextField!
    @IBOutlet private weak var aluminiButtonBottomConstarint: NSLayoutConstraint!
    
    @IBAction private func animateSelectionToTextField(sender: UIButton) {
        UIView.animateWithDuration(0.3, animations: {
                sender.titleLabel?.font = UIFont.systemFontOfSize(12)
                self.aluminiButtonBottomConstarint.constant = 25
                self.layoutSubviews()
            }, completion: { finished in
                sender.titleLabel?.tintColor = UIColor.redColor()
            })
    }
}