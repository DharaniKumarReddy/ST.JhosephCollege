//
//  MenuViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/4/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class MenuViewController: ECSlidingViewController {
    
    override var topViewController: UIViewController! {
        didSet {
            topViewController.view.addGestureRecognizer(panGesture)
            topViewAnchoredGesture = [.Panning, .Tapping]
            
            if let navigationController = topViewController as? UINavigationController {
                if let 🍔 = navigationController.topViewController!.navigationItem.leftBarButtonItem {
                    assert(🍔.tintColor == Colors.hamburgerTintColor(), "Storyboard hamburger tintColor should be set to \(Colors.hamburgerTintColor()) not \(🍔.tintColor)")
                    🍔.target = self
                    🍔.action = "hamburgerPressed:"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IdleTimerManager.sharedInstance.scheduleNewIdleTimer()
    }
    
    @objc private func hamburgerPressed(sender: UIBarButtonItem) {
        if currentTopViewPosition == .Centered {
            anchorTopViewToRightAnimated(true)
        } else {
            resetTopViewAnimated(true)
        }
    }


}
