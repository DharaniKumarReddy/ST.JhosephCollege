//
//  SlidingViewController.swift
//  AlwaysOn
//
//  Created by Jawwad Ahmad on 8/2/14.
//  Copyright (c) 2014 Onlife Health. All rights reserved.
//

import UIKit

/**
Extension of the third party controller that enables the "hamburger" side menu.
*/
class SlidingViewController: ECSlidingViewController {

    override var topViewController: UIViewController! {
        didSet {
            topViewController.view.addGestureRecognizer(panGesture)
            topViewAnchoredGesture = [.Panning, .Tapping]

            if let navigationController = topViewController as? UINavigationController {
                if let 🍔 = navigationController.topViewController!.navigationItem.leftBarButtonItem {
                    🍔.target = self
                    🍔.action = #selector(SlidingViewController.hamburgerPressed(_:))
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc private func hamburgerPressed(sender: UIBarButtonItem) {
        if currentTopViewPosition == .Centered {
            anchorTopViewToRightAnimated(true)
        } else {
            resetTopViewAnimated(true)
        }
    }

}
