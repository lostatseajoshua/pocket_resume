//
//  Lead+CoreDataProperties.swift
//  Pocket-Resume
//
//  Created by Joshua Alvarado on 10/11/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Lead {

    @NSManaged var creationDate: NSTimeInterval
    @NSManaged var status: Int16
    @NSManaged var name: String?
    @NSManaged var company: Company?

}
