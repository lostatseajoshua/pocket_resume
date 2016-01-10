//
//  CollegeInformation.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/4/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EducationCollege;

@interface CollegeInformation : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * cityAndState;
@property (nonatomic, retain) NSString * contact;
@property (nonatomic, retain) NSNumber * graduated;
@property (nonatomic, retain) NSString * major;
@property (nonatomic, retain) NSString * minor;
@property (nonatomic, retain) NSNumber * yearsAttended;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) EducationCollege *college;

@end
