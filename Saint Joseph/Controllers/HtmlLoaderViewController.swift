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
            title = Constants.Title.RectorMessage
            htmlStringName = RECTOR_MSG
        } else if controllerType == .PrincipalMessage {
            title = Constants.Title.PrincipalMessage
            htmlStringName = PRINCIPAL_MSG
        } else if controllerType == .About {
            title = Constants.Title.KnowYourInstitute
            htmlStringName = COLLEGE_WEBSITE
        } else if controllerType == .ERP {
            title = Constants.Title.ERP
            htmlStringName = ERP_URL
        } else {
            title = Constants.Title.Academic
            htmlStringName = ACADEMICS_URL
        }
        webView.loadRequest(NSURLRequest(URL: (NSURL(string: htmlStringName)!)))
    }
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }

}
