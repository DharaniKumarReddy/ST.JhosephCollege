//
//  MenuViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/13/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func menuButtons_Tapped(menuButton: UIButton) {
        switch menuButton.tag {
        case 1:
            segueToInitialViewControllerInStoryboard(Constants.StoryBoard.Main)
        default:
            return
        }
    }
    
    func segueToInitialViewControllerInStoryboard(storyboardName: String) {
        let initialViewController = UIStoryboard(storyboardName).instantiateInitialViewController() as UIViewController!
        let ecSlidingSegue = ECSlidingSegue(identifier: nil, source: self, destination: initialViewController)
        ecSlidingSegue.perform()
    }

}
