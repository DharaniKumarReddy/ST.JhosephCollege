//
//  GalleryPageViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 9/2/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class GalleryPageViewController: UIViewController {
    
    var image: UIImage!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        // Do any additional setup after loading the view.
    }

}
