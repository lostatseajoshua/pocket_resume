//
//  PositionInformation.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/19/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employment;

@interface PositionInformation : NSManagedObject

@property (nonatomic, retain) NSString * endDate;
@property (nonatomic, retain) NSString * endPay;
@property (nonatomic, retain) NSString * startDate;
@property (nonatomic, retain) NSString * startPay;
@property (nonatomic, retain) NSString * duties;
@property (nonatomic, retain) Employment *position;

@end
