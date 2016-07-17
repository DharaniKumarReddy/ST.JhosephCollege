//
//  NSManagedObjectContextExtension.swift
//  Saint Joseph
//
//  Created by Dharani on 7/17/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    class func newWithContext(context: NSManagedObjectContext, entityName: String) {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context)
    }
}