//
//  Job+CoreDataProperties.swift
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

extension Job {

    @NSManaged var position: String?
    @NSManaged var city: String?
    @NSManaged var state: Int16
    @NSManaged var positionType: Int16
    @NSManaged var company: Company?

}
