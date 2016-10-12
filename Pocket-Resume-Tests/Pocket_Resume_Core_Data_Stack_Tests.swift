//
//  Pocket_Resume_Core_Data_Stack_Tests.swift
//  Pocket-Resume
//
//  Created by Joshua Alvarado on 10/11/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import XCTest
import CoreData
@testable import Pocket_Resume

class Pocket_Resume_Core_Data_Stack_Tests: XCTestCase {

    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataStack = CoreDataStack(persistentStoreType: NSInMemoryStoreType)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        coreDataStack = nil
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLeadManagedObject() {
        if let lead = NSEntityDescription.insertNewObjectForEntityForName(Lead.entityName, inManagedObjectContext: coreDataStack.mainContext) as? Lead {
            lead.name = "Joshua"
            XCTAssertEqual(lead.name, "Joshua")
        } else {
            XCTFail("Failed to insert new object for entity name Lead")
        }
    }

}
