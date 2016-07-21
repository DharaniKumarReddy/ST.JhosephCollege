//
//  NewsData.swift
//  Saint Joseph
//
//  Created by Dharani on 7/17/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation
import CoreData

class NewsData: NSManagedObject {
    var date: NSDate!
    var descript: NSString!
    var largeImageURL: NSString!
    var smallImageURL: NSString!
    var title: NSString!
    var type: NSString!
    var updatedAt: NSString!

}
