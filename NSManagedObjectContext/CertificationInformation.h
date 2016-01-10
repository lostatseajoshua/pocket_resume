//
//  CertificationInformation.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/4/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CertificationInformation : NSManagedObject

@property (nonatomic, retain) NSString * expiration;
@property (nonatomic, retain) NSString * issuedBy;
@property (nonatomic, retain) NSString * stateIssued;
@property (nonatomic, retain) NSString * dateIssued;
@property (nonatomic, retain) NSManagedObject *certificationName;

@end
