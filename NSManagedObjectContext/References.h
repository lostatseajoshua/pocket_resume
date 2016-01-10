//
//  References.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/3/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ReferenceInformation;

@interface References : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) ReferenceInformation *details;

@end
