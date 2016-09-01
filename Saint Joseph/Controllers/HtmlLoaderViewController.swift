//
//  HtmlLoaderViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 8/31/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class HtmlLoaderViewController: UIViewController {

    enum ControllerType {
        case RectorMessage, PrincipalMessage, About, ERP, Academic
    }
    
    var controllerType: ControllerType!
    
    @IBOutlet private weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        // Do any additional setup after loading the view.
    }
    
    private func setTitle() {
        var htmlStringName = ""
        if controllerType == .RectorMessage {
            title = "Rector Message"
            htmlStringName = RECTOR_MSG
        } else if controllerType == .PrincipalMessage {
            title = "Principal Message"
            htmlStringName = PRINCIPAL_MSG
        } else if controllerType == .About {
            title = "Know Your Institute"
            htmlStringName = COLLEGE_WEBSITE
        } else if controllerType == .ERP {
            htmlStringName = ERP_URL
        } else {
            htmlStringName = ACADEMICS_URL
        }
        webView.loadRequest(NSURLRequest(URL: (NSURL(string: htmlStringName)!)))
    }
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }

}
