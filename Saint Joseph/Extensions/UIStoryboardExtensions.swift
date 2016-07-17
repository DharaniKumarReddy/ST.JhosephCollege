//
//  UIStoryboard.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation
import UIKit

class EmptyClassInCurrentBundle { }

extension UIStoryboard {

    convenience init(_ name: String) {
        let currentBundle = NSBundle(forClass: EmptyClassInCurrentBundle.self)
        self.init(name: name, bundle:currentBundle)
    }

    func instantiateNavigationController(identifier: String) -> UINavigationController {
        return instantiateViewControllerWithIdentifier(identifier) as! UINavigationController
    }

}
