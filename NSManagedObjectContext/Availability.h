//
//  Availability.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/20/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Availability : NSManagedObject

@property (nonatomic, retain) NSString * fridayEarlyHour;
@property (nonatomic, retain) NSString * fridayLateHour;
@property (nonatomic, retain) NSString * mondayEarlyHour;
@property (nonatomic, retain) NSString * mondayLateHour;
@property (nonatomic, retain) NSString * saturdayEarlyHour;
@property (nonatomic, retain) NSString * saturdayLateHour;
@property (nonatomic, retain) NSString * sundayEarlyHour;
@property (nonatomic, retain) NSString * sundayLateHour;
@property (nonatomic, retain) NSString * thursdayEarlyHour;
@property (nonatomic, retain) NSString * thursdayLateHour;
@property (nonatomic, retain) NSString * tuesdayEarlyHour;
@property (nonatomic, retain) NSString * tuesdayLateHour;
@property (nonatomic, retain) NSString * wednesdayEarlyHour;
@property (nonatomic, retain) NSString * wednesdayLateHour;
@property (nonatomic, retain) NSString * mondayEarlyAm;
@property (nonatomic, retain) NSString * mondayLateAm;
@property (nonatomic, retain) NSString * tuesdayEarlyAm;
@property (nonatomic, retain) NSString * tuesdayLateAm;
@property (nonatomic, retain) NSString * wednesdayEarlyAm;
@property (nonatomic, retain) NSString * wednesdayLateAm;
@property (nonatomic, retain) NSString * thursdayEarlyAm;
@property (nonatomic, retain) NSString * thursdayLateAm;
@property (nonatomic, retain) NSString * fridayEarlyAm;
@property (nonatomic, retain) NSString * fridayLateAm;
@property (nonatomic, retain) NSString * saturdayEarlyAm;
@property (nonatomic, retain) NSString * saturdayLateAm;
@property (nonatomic, retain) NSString * sundayEarlyAm;
@property (nonatomic, retain) NSString * sundayLateAm;
@property (nonatomic, retain) NSString * mondayEarlyMin;
@property (nonatomic, retain) NSString * mondayLateMin;
@property (nonatomic, retain) NSString * tuesdayEarlyMin;
@property (nonatomic, retain) NSString * tuesdayLateMin;
@property (nonatomic, retain) NSString * wednesdayEarlyMin;
@property (nonatomic, retain) NSString * wednesdayLateMin;
@property (nonatomic, retain) NSString * thursdayEarlyMin;
@property (nonatomic, retain) NSString * thursdayLateMin;
@property (nonatomic, retain) NSString * fridayEarlyMin;
@property (nonatomic, retain) NSString * fridayLateMin;
@property (nonatomic, retain) NSString * saturdayEarlyMin;
@property (nonatomic, retain) NSString * saturdayLateMin;
@property (nonatomic, retain) NSString * sundayEarlyMin;
@property (nonatomic, retain) NSString * sundayLateMin;

@end
