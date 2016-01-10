//
//  ReferenceInformationViewController.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/3/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferenceInformation.h"
#import "References.h"

@interface ReferenceInformationViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSManagedObject *passedReference;

@end
