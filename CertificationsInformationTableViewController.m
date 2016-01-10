//
//  CertificationsInformationTableViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/20/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "CertificationsInformationTableViewController.h"

@interface CertificationsInformationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *certificationIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *certificationTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *expirationDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateIssuedTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateIssuedTextField;
@property (weak, nonatomic) IBOutlet UITextField *issuedByTextField;

@end

@implementation CertificationsInformationTableViewController

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
    
    if (self.passedCertification) {
        Certifications *certification = (Certifications *)self.passedCertification;
        CertificationInformation *certificationInformation = certification.details;
        
        self.title = certification.certificationName;
        
        [self.certificationIDTextField setText:certification.certificationID];
        [self.certificationTitleTextField setText:certification.certificationName];
        [self.expirationDateTextField setText:certificationInformation.expiration];
        [self.stateIssuedTextField setText:certificationInformation.stateIssued];
        [self.dateIssuedTextField setText:certificationInformation.dateIssued];
        [self.issuedByTextField setText:certificationInformation.issuedBy];

    }else{
        self.title = @"New Certification";
    }
 
    self.certificationIDTextField.delegate = self;
    self.certificationTitleTextField.delegate  = self;
    self.expirationDateTextField.delegate = self;
    self.stateIssuedTextField.delegate = self;
    self.dateIssuedTextField.delegate = self;
    self.issuedByTextField.delegate = self;
    
    [self grayTextFields];
    [self unactivateAllTextFields];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
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
    self.certificationIDTextField.enabled = NO;
    self.certificationTitleTextField.enabled  = NO;
    self.expirationDateTextField.enabled = NO;
    self.stateIssuedTextField.enabled = NO;
    self.dateIssuedTextField.enabled = NO;
    self.issuedByTextField.enabled = NO;
}

-(void)activateAllTextFields
{
    self.certificationIDTextField.enabled = YES;
    self.certificationTitleTextField.enabled = YES;
    self.expirationDateTextField.enabled = YES;
    self.stateIssuedTextField.enabled = YES;
    self.dateIssuedTextField.enabled = YES;
    self.issuedByTextField.enabled = YES;
}

-(void)grayTextFields{
    [self.certificationTitleTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.certificationIDTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.expirationDateTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.stateIssuedTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.dateIssuedTextField  setBackgroundColor:[UIColor lightGrayColor]];
    [self.issuedByTextField setBackgroundColor:[UIColor lightGrayColor]];
}

-(void)whiteTextFields{
    [self.certificationTitleTextField setBackgroundColor:[UIColor whiteColor]];
    [self.certificationIDTextField setBackgroundColor:[UIColor whiteColor]];
    [self.expirationDateTextField setBackgroundColor:[UIColor whiteColor]];
    [self.stateIssuedTextField setBackgroundColor:[UIColor whiteColor]];
    [self.dateIssuedTextField  setBackgroundColor:[UIColor whiteColor]];
    [self.issuedByTextField setBackgroundColor:[UIColor whiteColor]];
}

-(void)saveInformation
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.passedCertification) {
        
        Certifications *certification = (Certifications *)self.passedCertification;
        CertificationInformation *certificationInformation = certification.details;
        
        certification.certificationName = self.certificationTitleTextField.text;
        certification.certificationID = self.certificationIDTextField.text;
        
        certificationInformation.expiration = self.expirationDateTextField.text;
        certificationInformation.issuedBy = self.issuedByTextField.text;
        certificationInformation.stateIssued = self.stateIssuedTextField.text;
        certificationInformation.dateIssued = self.dateIssuedTextField.text;
        
    } else {
        
        Certifications *newCertification = [NSEntityDescription insertNewObjectForEntityForName:@"Certifications" inManagedObjectContext:context];
        
        newCertification.certificationName = self.certificationTitleTextField.text;
        newCertification.certificationID = self.certificationIDTextField.text;
        
        CertificationInformation *newCertificationInformation = [NSEntityDescription
                                                      insertNewObjectForEntityForName:@"CertificationInformation"
                                                      inManagedObjectContext:context];
        
        newCertificationInformation.expiration = self.expirationDateTextField.text;
        newCertificationInformation.issuedBy = self.issuedByTextField.text;
        newCertificationInformation.stateIssued = self.stateIssuedTextField.text;
        newCertificationInformation.dateIssued = self.dateIssuedTextField.text;
        
        newCertification.details = newCertificationInformation;
    }
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.certificationTitleTextField resignFirstResponder];
    [self.certificationIDTextField resignFirstResponder];
    [self.expirationDateTextField resignFirstResponder];
    [self.stateIssuedTextField resignFirstResponder];
    [self.dateIssuedTextField  resignFirstResponder];
    [self.issuedByTextField resignFirstResponder];
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
