//
//  Personal.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/4/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Personal : NSManagedObject

@property (nonatomic, retain) NSString * address1;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * cityAndState;
@property (nonatomic, retain) NSString * email1;
@property (nonatomic, retain) NSString * email2;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * phone1;
@property (nonatomic, retain) NSString * phone2;
@property (nonatomic, retain) NSString * zip;

@end
