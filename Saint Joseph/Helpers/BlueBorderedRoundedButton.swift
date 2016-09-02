//
//  BlueBorderedRoundedButton.swift
//  Saint Joseph
//
//  Created by Dharani on 9/1/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation
import UIKit

class BlueBorderedRoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 6
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 14/255, green: 63/255, blue: 169/255, alpha: 1.0).CGColor
    }
}