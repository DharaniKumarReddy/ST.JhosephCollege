//
//  NewsData.swift
//  Saint Joseph
//
//  Created by Dharani on 7/17/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewsData: NSManagedObject {
    
    @NSManaged var date: NSDate?
    @NSManaged var descript: String?
    @NSManaged var id: String?
    @NSManaged var largeImageURL: String?
    @NSManaged var newsID: String?
    @NSManaged var smallImageURL: String?
    @NSManaged var title: String?
    @NSManaged var type: String?
    @NSManaged var updatedAt: String?
}
