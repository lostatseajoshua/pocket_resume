//
//  CoreDataStack.swift
//  Pocket-Resume
//
//  Created by Joshua Alvarado on 10/11/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let modelName = "Pocket_Resume"
    private let persistentStoreType: String
    
    /// Create a Core Data stack
    /// - Parameter persistentStoreType: Specifies the persistent store type of the stack
    init(persistentStoreType: String) {
        self.persistentStoreType = persistentStoreType
    }
    
    /// The `CoreDataStack`'s main `NSManagedObjectContext` on the main queue
    lazy var mainContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(
            concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.psc
        return managedObjectContext
    }()
    
    /// Creates a `NSManagedObjectContext` that is a child of the current `CoreDataStack`'s `mainContext` on a private background queue
    /// - Returns: a `NSManagedObjectContext` on a private queue
    func privateQueueContext() -> NSManagedObjectContext {
        let privateContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateContext.parentContext = mainContext
        return privateContext
    }
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.jaapps.Flappy_Typing_Test" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    private lazy var psc: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(modelName)
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption : true]
            try coordinator.addPersistentStoreWithType(self.persistentStoreType, configuration: nil, URL: url, options: options)
        } catch {
            print("Error adding persistent store.")
        }
        return coordinator
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    func saveMainContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                abort()
            }
        }
    }
}
