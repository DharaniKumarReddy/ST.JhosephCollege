//
//  AluminiTableViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 9/1/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

let ALUMINI = ["Name", "Designation", "Address", "Year of Passing", "Email", "Mobile No.", "College Registration No."]

class AluminiViewController: UITableViewController, AddDetailsDelegate {

    var params = [String : String]()
    
    var textFields = [UITextField]()
    
    var isReload = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ALUMINI.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifier.AluminiTableViewCell) as! AluminiTableViewCell
        cell.aluminiButton.setTitle(ALUMINI[indexPath.row], forState: .Normal)
        cell.tag = indexPath.row
        if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 {
            cell.aluminiTextField.keyboardType = indexPath.row == 3 ? .NumberPad : indexPath.row == 5 ? .PhonePad : .EmailAddress
        }
        if indexPath.row == ALUMINI.count - 1 {
            cell.aluminiTextField.returnKeyType = .Done
        }
        cell.delegate = self
        if !textFields.contains(cell.aluminiTextField) {
            textFields.append(cell.aluminiTextField)
        }
        if isReload {
            cell.animateToOriginal()
        }
        return cell
    }
    
    
    @IBAction private func submitButton_Tapped(sender: UIButton) {
        submitUserDetails()
    }
    
    // MARK:- AddDetailsDelegate Method
    
    func addUserDetail(text: String, key: String) {
        params[key] = text == "" ? nil : text
    }
    
    func editNextCell(tag: Int) {
        if tag != textFields.count - 1 {
            textFields[tag + 1].becomeFirstResponder()
        }
    }
    
    func submitUserDetails() {
        if params.count < ALUMINI.count {
            UIAlertView.showToast("Please fill all details")
            return
        } else {
            APICaller.getInstance().sendUserDetails(params: makeParam() ,onSuccess: {_ in
                UIAlertView.showToast("Details submitted")
                self.params = [:]
                self.isReload = true
                self.tableView.reloadData()
                let _ = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(AluminiViewController.stopAnimateToOriginal), userInfo: nil, repeats: false)
                }, onError: {_ in
            })
        }
    }
    
    private func makeParam() -> String {
        let parameter = "name=\(params["Name"]),designation=\(params["Designation"]),address=\(params["Address"]),yop=\(params["Year of Passing"]),Email=\(params["Email"]),mobile=\(params["Mobile No."]),cregno=\(params["College Registration No."])"
        return parameter
    }
    
    func stopAnimateToOriginal() {
        isReload = false
    }
}

class AluminiTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet private weak var aluminiButton: UIButton!
    @IBOutlet private weak var aluminiTextField: UITextField!
    @IBOutlet private weak var aluminiButtonBottomConstarint: NSLayoutConstraint!
    
    weak var delegate: AddDetailsDelegate?
    
    var animationStarted = false
    
    @IBAction private func animateSelectionToTextField(sender: UIButton) {
        animateButton(12, bottom: 30, color: UIColor.redColor(), alreadyStarted: false)
    }
    
    func animateToOriginal() {
        aluminiTextField.text = ""
        animateButton(15, bottom: 0, color: UIColor.darkGrayColor(), alreadyStarted: false)
    }
    
    private func animateButton(fontSize: CGFloat, bottom: CGFloat, color: UIColor, alreadyStarted: Bool) {
        animationStarted = !animationStarted
        if bottom != 0 && !alreadyStarted {
            aluminiTextField.becomeFirstResponder()
        }
        self.aluminiButton.setTitleColor(color, forState: .Normal)
        UIView.animateWithDuration(0.6, animations: {
            self.aluminiButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
            self.aluminiButtonBottomConstarint.constant = bottom
            self.layoutIfNeeded()
            //self.layoutSubviews()
            }, completion: { finished in
        })
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        animateButton(12, bottom: 30, color: UIColor.redColor(), alreadyStarted: true)
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.text == "" {
            animateButton(15, bottom: 0, color: UIColor.darkGrayColor(), alreadyStarted: false)
        } else {
            animateButton(12, bottom: 30, color: UIColor.redColor(), alreadyStarted: false)
        }
        delegate?.addUserDetail(textField.text!, key: self.aluminiButton.titleForState(.Normal)!)
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.editNextCell(self.tag)
        return true
    }
}

protocol AddDetailsDelegate: class {
    func addUserDetail(text: String, key: String)
    func editNextCell(tag: Int)
    func submitUserDetails()
}