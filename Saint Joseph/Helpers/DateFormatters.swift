//
//  DateFormatters.swift
//  AlwaysOn
//
//  Created by Jawwad Ahmad on 10/20/14.
//  Copyright (c) 2014 Onlife Health. All rights reserved.
//

import Foundation

class DateFormatters {

    class func dateFormatter() -> NSDateFormatter {
        return dateFormatter("")
    }

}

var dateFormattersMap: [String : NSDateFormatter] = [:]

func dateFormatter(format: String) -> NSDateFormatter {
    if let dateFormatter = dateFormattersMap[format] {
        return dateFormatter
    } else {
        let dateFormatter = NSDateFormatter(dateFormat: format)
        dateFormattersMap[format] = dateFormatter
        return dateFormatter
    }
}
