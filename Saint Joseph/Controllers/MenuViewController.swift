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
        case 1, 2, 4:
            segueToViewControllerInStoryboard(Constants.StoryBoard.Main, navigationControllerIdentifier: Constants.NavigationController.HtmlLoaderNavigationController, tag: menuButton.tag)
        case 3:
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
    
    func segueToViewControllerInStoryboard(storyboardName: String, navigationControllerIdentifier: String, tag: Int) {
        let htmlNavigationController = UIStoryboard(storyboardName).instantiateNavigationController(navigationControllerIdentifier)
        (htmlNavigationController.viewControllers[0] as! HtmlLoaderViewController).controllerType = tag == 1 ? .RectorMessage : tag == 2 ? .PrincipalMessage : .About
        let ecSlidingSegue = ECSlidingSegue(identifier: nil, source: self, destination: htmlNavigationController)
        ecSlidingSegue.perform()
    }

}
