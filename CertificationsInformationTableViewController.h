//
//  CertificationsInformationTableViewController.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/20/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CertificationInformation.h"
#import "Certifications.h"

@interface CertificationsInformationTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObject *passedCertification;

@end
