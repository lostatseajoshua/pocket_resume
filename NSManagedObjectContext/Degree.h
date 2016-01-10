//
//  Degree.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/4/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Degree : NSManagedObject

@property (nonatomic, retain) NSString * degreeType;
@property (nonatomic, retain) NSDate * yearCompleted;
@property (nonatomic, retain) NSManagedObject *college;

@end
