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

class AluminiTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet private weak var aluminiButton: UIButton!
    @IBOutlet private weak var aluminiTextField: UITextField!
    @IBOutlet private weak var aluminiButtonBottomConstarint: NSLayoutConstraint!
    
    @IBAction private func animateSelectionToTextField(sender: UIButton) {
        animateButton(12, bottom: 25, color: UIColor.redColor())
    }
    
    private func animateButton(fontSize: CGFloat, bottom: CGFloat, color: UIColor) {
        UIView.animateWithDuration(0.3, animations: {
            self.aluminiButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
            self.aluminiButtonBottomConstarint.constant = bottom
            self.layoutSubviews()
            }, completion: { finished in
                self.aluminiButton.setTitleColor(color, forState: .Normal)
                if bottom != 0 {
                    self.aluminiTextField.becomeFirstResponder()
                }
        })
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.text == "" {
            animateButton(15, bottom: 0, color: UIColor.darkGrayColor())
        }
        return true
    }
}