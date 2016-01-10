//
//  Pocket_ResumeAppDelegate.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 7/22/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pocket_ResumeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
