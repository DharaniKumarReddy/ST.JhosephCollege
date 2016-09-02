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
        case 1, 2:
            showAlertController(indexPath.row)
        default:
            break
        }
    }
    
    private func showAlertController(index: Int) {
        let alertController = UIAlertController(title: "Select", message: "select one to perform action", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) in
            // ...
        })
        alertController.addAction(cancelAction)
        
        let firstAction = UIAlertAction(title: index == 1 ? "sjpucday@yahoo.co.in" : "080-22228844", style: .Default, handler:  { (action) in
            self.openURL(index == 1, text: index == 1 ? "sjpucday@yahoo.co.in" : "080-22228844")
        })
        alertController.addAction(firstAction)
        
        let secondAction = UIAlertAction(title: index == 1 ? "sjpucdayalumni@gmail.com" : "080-22297197", style: .Default, handler: { action in
            self.openURL(index == 1, text: index == 1 ? "sjpucdayalumni@gmail.com" : "080-22297197" )
        })
        alertController.addAction(secondAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func openURL(isMail: Bool, text: String) {
        let textURL = isMail ? "mailto:\(text)" : "tel://\(text)"
        UIApplication.sharedApplication().openURL(NSURL(string: textURL)!)
    }
}
