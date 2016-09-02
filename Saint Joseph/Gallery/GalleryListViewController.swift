//
//  GalleryListViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 8/4/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class GalleryListViewController: UIViewController {
    
    private var imageList: [UIImage]!
    
    private var index: Int!
    
    func configure(images: [UIImage], index: Int) {
        self.imageList = images
        self.index = index
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.SegueIdentifier.GalleryListPageViewController:
            let pageViewController = segue.destinationViewController as! GalleryListPageViewController
            pageViewController.configure(imageList, index: 0)
        default:
            return
        }
    }

}
