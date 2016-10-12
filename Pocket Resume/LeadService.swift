//
//  LeadService.swift
//  Pocket-Resume
//
//  Created by Joshua Alvarado on 10/12/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import Foundation
import CoreData

struct LeadService {
    let moc: NSManagedObjectContext
    
    init(managedObjectContext moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func createNewLead() -> Lead? {
        if let newLead = NSEntityDescription.insertNewObjectForEntityForName(Lead.entityName, inManagedObjectContext: moc) as? Lead {
            newLead.creationDate = NSDate()
            newLead.status = 0
            return newLead
        }
        return nil
    }
}
