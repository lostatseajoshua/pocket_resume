//
//  ReferenceInformation.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/3/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ReferenceInformation : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * employer;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * relationship;
@property (nonatomic, retain) NSString * yearsKnows;
@property (nonatomic, retain) NSManagedObject *referenceName;

@end
