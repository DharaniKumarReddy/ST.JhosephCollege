//
//  PDFViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 9/1/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController, UIWebViewDelegate {

    var pdfURL: String!
    
    @IBOutlet private weak var webView: UIWebView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        view.bringSubviewToFront(activityIndicator)
        showPDF()
        // Do any additional setup after loading the view.
    }
    
    private func showPDF() {
        webView.loadRequest(NSURLRequest(URL: NSURL(string: pdfURL)!))
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.hidden = true
    }
    
    @IBAction private func doneButton_Tapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
