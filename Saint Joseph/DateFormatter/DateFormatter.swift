//
//  File.swift
//  Saint Joseph
//
//  Created by Dharani on 7/24/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

class DateFormatter {
 
    class func defaultFormatter() -> NSDateFormatter {
        return dateFormatter("yyyy-MM-dd HH:mm:ss")
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

extension NSDateFormatter {
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    class func localizedStringFromDate(date: NSDate, dateStyle: NSDateFormatterStyle) -> String {
        return NSDateFormatter.localizedStringFromDate(date, dateStyle: dateStyle, timeStyle: .NoStyle)
    }
    
}

extension NSDate {
    var startOfDay: NSDate {
        return NSCalendar.currentCalendar().startOfDayForDate(self)
    }
    
    var endOfDay: NSDate? {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())
    }
}