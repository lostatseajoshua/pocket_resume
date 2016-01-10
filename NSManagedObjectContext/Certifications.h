//
//  Certifications.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/4/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CertificationInformation;

@interface Certifications : NSManagedObject

@property (nonatomic, retain) NSString *certificationID;
@property (nonatomic, retain) NSString *certificationName;
@property (nonatomic, retain) CertificationInformation *details;

@end
