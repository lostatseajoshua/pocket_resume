//
//  Employment.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/19/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EmplomerInformation, PositionInformation;

@interface Employment : NSManagedObject

@property (nonatomic, retain) NSString * employer;
@property (nonatomic, retain) NSString * positionTitle;
@property (nonatomic, retain) EmplomerInformation *employerdetails;
@property (nonatomic, retain) PositionInformation *positiondetails;

@end
