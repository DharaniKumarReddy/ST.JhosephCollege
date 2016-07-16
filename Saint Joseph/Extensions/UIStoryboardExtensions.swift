//
//  UIStoryboard.swift
//  AlwaysOn
//
//  Created by Jawwad Ahmad on 8/2/14.
//  Copyright (c) 2014 Onlife Health. All rights reserved.
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
