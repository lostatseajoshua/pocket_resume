//
//  ReferenceInformationViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/3/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "ReferenceInformationViewController.h"


@interface ReferenceInformationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *employerTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearsKnownTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeOfReferenceTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation ReferenceInformationViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.passedReference) {
        self.fullNameTextField.text = [self.passedReference valueForKey:@"fullName"];
        self.title = [self.passedReference valueForKey:@"fullName"];
        
        ReferenceInformation *referenceDetails = [self.passedReference valueForKey:@"details"];
        
        [self.addressTextField setText:[NSString stringWithFormat:@"%@",referenceDetails.address]];
        [self.phoneTextField setText:[NSString stringWithFormat:@"%@", referenceDetails.phone]];
        [self.employerTextField setText:[NSString stringWithFormat:@"%@", referenceDetails.employer]];
        [self.typeOfReferenceTextField setText:[NSString stringWithFormat:@"%@", referenceDetails.relationship]];
        [self.yearsKnownTextField setText:[NSString stringWithFormat:@"%@", referenceDetails.yearsKnows]];
    }else{
        self.title = @"New Reference";
    }
    
    self.fullNameTextField.delegate = self;
    self.addressTextField.delegate  = self;
    self.employerTextField.delegate = self;
    self.yearsKnownTextField.delegate = self;
    self.typeOfReferenceTextField.delegate = self;
    self.phoneTextField.delegate = self;
    
    [self grayTextFields];
    [self unactivateAllTextFields];
}

-(IBAction)editInformation:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"Edit"]) {
        [sender setTitle:@"Save"];
        [self activateAllTextFields];
        [self whiteTextFields];
    }else if([sender.title isEqualToString:@"Save"]){
        [sender setTitle:@"Edit"];
        [self saveInformation];
        [self grayTextFields];
    }
}

-(void)unactivateAllTextFields
{
    self.fullNameTextField.enabled = NO;
    self.addressTextField.enabled = NO;
    self.employerTextField.enabled = NO;
    self.yearsKnownTextField.enabled = NO;
    self.typeOfReferenceTextField.enabled = NO;
    self.phoneTextField.enabled = NO;
}

-(void)activateAllTextFields
{
    self.fullNameTextField.enabled = YES;
    self.addressTextField.enabled = YES;
    self.employerTextField.enabled = YES;
    self.yearsKnownTextField.enabled = YES;
    self.typeOfReferenceTextField.enabled = YES;
    self.phoneTextField.enabled = YES;
}

-(void)grayTextFields{
    [self.fullNameTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.addressTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.employerTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.yearsKnownTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.typeOfReferenceTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.phoneTextField setBackgroundColor:[UIColor lightGrayColor]];
}

-(void)whiteTextFields{
    [self.fullNameTextField setBackgroundColor:[UIColor whiteColor]];
    [self.addressTextField setBackgroundColor:[UIColor whiteColor]];
    [self.employerTextField setBackgroundColor:[UIColor whiteColor]];
    [self.yearsKnownTextField setBackgroundColor:[UIColor whiteColor]];
    [self.typeOfReferenceTextField setBackgroundColor:[UIColor whiteColor]];
    [self.phoneTextField setBackgroundColor:[UIColor whiteColor]];
}

-(void)saveInformation
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.passedReference) {
        
        [self.passedReference setValue:self.fullNameTextField.text forKey:@"fullName"];
        
        ReferenceInformation *referenceDetails = [self.passedReference valueForKey:@"details"];
        
        referenceDetails.address = self.addressTextField.text;
        referenceDetails.employer = self.employerTextField.text;
        referenceDetails.phone = self.phoneTextField.text;
        referenceDetails.yearsKnows = self.yearsKnownTextField.text;
        referenceDetails.relationship = self.typeOfReferenceTextField.text;
        
        
    } else {
    
        References *reference = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"References"
                                      inManagedObjectContext:context];
    
        reference.fullName = self.fullNameTextField.text;
    
        ReferenceInformation *referenceInformation = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"ReferenceInformation"
                                            inManagedObjectContext:context];
    
        referenceInformation.address = self.addressTextField.text;
        referenceInformation.employer = self.employerTextField.text;
        referenceInformation.phone = self.phoneTextField.text;
        referenceInformation.yearsKnows = self.yearsKnownTextField.text;
        referenceInformation.relationship = self.typeOfReferenceTextField.text;
    
        reference.details = referenceInformation;
    }
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.fullNameTextField resignFirstResponder];
    [self.yearsKnownTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (textField == self.typeOfReferenceTextField)
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:
                                      NSLocalizedString(@"Gender", @"")
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"Friend",@""),
                                      NSLocalizedString(@"Employer",@""),
                                      NSLocalizedString(@"Professional", @""),nil];
		[actionSheet showInView:self.view];
	}
}

// Called when a button is clicked. The view will be automatically dismissed
// after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:
(NSInteger)buttonIndex
{
	NSLog(@"Index is %li", (long)buttonIndex);
	switch(buttonIndex){
		case 0:
			self.typeOfReferenceTextField.text = NSLocalizedString(@"Friend",@"");
			break;
		case 1:
			self.typeOfReferenceTextField.text = NSLocalizedString(@"Employer",@"");
			break;
		case 2:
			self.typeOfReferenceTextField.text = NSLocalizedString(@"Professional", @"");
			break;
		default:
			break;
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

-(IBAction)backButton:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
