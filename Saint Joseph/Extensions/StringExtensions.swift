//
//  StringExtensions.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

extension String {
    
    func urlEscapedString() -> String {
        return CFURLCreateStringByAddingPercentEscapes(nil, self, nil, "!*';:&=+$,/?%#[]%", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) as String
    }
}