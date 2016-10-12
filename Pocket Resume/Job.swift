//
//  Job.swift
//  Pocket-Resume
//
//  Created by Joshua Alvarado on 10/11/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import Foundation
import CoreData


class Job: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    var location: String? {
        return city
    }
    
    enum CountryState: Int16 {
        case Alaska
    }
}
