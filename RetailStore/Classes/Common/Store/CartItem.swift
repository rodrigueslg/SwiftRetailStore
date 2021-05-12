//
//  CartItem.swift
//  RetailStore
//
//  Created by Saravanan on 19/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import CoreData

class CartItem: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: CoreDataStore.sharedInstance.managedObjectContext)
    }
    
}
