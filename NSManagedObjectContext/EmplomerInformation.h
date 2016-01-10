//
//  EmplomerInformation.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/19/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employment;

@interface EmplomerInformation : NSManagedObject

@property (nonatomic, retain) NSString * address1;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * cityAndState;
@property (nonatomic, retain) NSString * companyPhone;
@property (nonatomic, retain) NSString * industry;
@property (nonatomic, retain) NSString * managerContact;
@property (nonatomic, retain) NSString * managerName;
@property (nonatomic, retain) NSString * reasonForLeaving;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) Employment *employer;

@end
