//
//  AlertViewExtension.swift
//  Saint Joseph
//
//  Created by Dharani on 9/1/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

extension UIAlertView {
    
    class func showToast(message: String, dismissAfter delay: NSTimeInterval = 1.5) {
        let alertView = UIAlertView(title: nil, message: NSLocalizedString(message, comment: ""), delegate: nil, cancelButtonTitle: nil)
        alertView.show()
        
        dispatch_after_delay(delay) {
            alertView.dismissWithClickedButtonIndex(0, animated: true)
        }
    }
    
    convenience init(title: String? = nil, message: String? = nil, cancelButtonTitle: String? = "OK") {
        self.init(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle)
    }
    
}

func dispatch_after_delay(seconds: Double, block: dispatch_block_t) {
    let delay = dispatch_time(seconds: seconds)
    dispatch_after(delay, dispatch_get_main_queue(), block)
}

func dispatch_time(seconds seconds: Double) -> dispatch_time_t {
    return dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
}