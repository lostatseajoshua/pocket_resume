//
//  AvailabiltyTableViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/2/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "AvailabiltyTableViewController.h"

@interface AvailabiltyTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dayOfTheWeekLabel;
@property (strong, nonatomic)NSString *selectedDayOfTheWeek;

@property (weak, nonatomic) IBOutlet UITextField *earlyTimeHourTextfield;
@property (weak, nonatomic) IBOutlet UITextField *earlyTimeMinuteTextField;
@property (weak, nonatomic) IBOutlet UITextField *earlyAMPMTextField;
@property (weak, nonatomic) IBOutlet UITextField *lateTimeHourTextField;
@property (weak, nonatomic) IBOutlet UITextField *lateTimeMinuteTextField;
@property (weak, nonatomic) IBOutlet UITextField *lateAMPMTextField;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (strong, nonatomic)NSManagedObject *availabiltyObject;
@property (strong, nonatomic) NSMutableArray *fetchedObjects;

@end

@implementation AvailabiltyTableViewController

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
    
    self.earlyTimeHourTextfield.delegate = self;
    self.earlyTimeMinuteTextField.delegate = self;
    self.earlyAMPMTextField.delegate = self;
    self.lateAMPMTextField.delegate = self;
    self.lateTimeHourTextField.delegate = self;
    self.lateTimeMinuteTextField.delegate = self;
    
    self.selectedDayOfTheWeek = @"Monday";
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Availability" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    self.fetchedObjects = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (self.fetchedObjects.count > 0) {
        Availability *availability = [self.fetchedObjects lastObject];
        self.availabiltyObject = availability;
        [self.earlyTimeHourTextfield setText:availability.mondayEarlyHour];
        [self.earlyTimeMinuteTextField setText:availability.mondayEarlyMin];
        [self.earlyAMPMTextField setText:availability.mondayEarlyAm];
        [self.lateTimeHourTextField setText:availability.mondayLateHour];
        [self.lateTimeMinuteTextField setText:availability.mondayLateMin];
        [self.lateAMPMTextField setText:availability.mondayLateAm];
    }
    [self unactivateAllTextFields];
    [self grayTextFields];
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

-(IBAction)incrementDayOfWeek:(UIStepper *)sender
{
    int num = (int)sender.value;
    switch (num) {
        case 1:
            [self.dayOfTheWeekLabel setText:[NSString stringWithFormat:@"Monday"]];
            self.selectedDayOfTheWeek = @"Monday";
            [self unactivateAllTextFields];
            [self changeEditButtonTitle];
            break;
        case 2:
            [self.dayOfTheWeekLabel setText:[NSString stringWithFormat:@"Tuesday"]];
            self.selectedDayOfTheWeek = @"Tuesday";
            [self unactivateAllTextFields];
            [self changeEditButtonTitle];
            break;
        case 3:
            [self.dayOfTheWeekLabel setText:[NSString stringWithFormat:@"Wednesday"]];
            self.selectedDayOfTheWeek = @"Wednesday";
            [self unactivateAllTextFields];
            [self changeEditButtonTitle];
            break;
        case 4:
            [self.dayOfTheWeekLabel setText:[NSString stringWithFormat:@"Thursday"]];
            self.selectedDayOfTheWeek = @"Thursday";
            [self unactivateAllTextFields];
            [self changeEditButtonTitle];
            break;
        case 5:
            [self.dayOfTheWeekLabel setText:@"Friday"];
            self.selectedDayOfTheWeek = @"Friday";
            [self unactivateAllTextFields];
            [self changeEditButtonTitle];
            break;
        case 6:
            [self.dayOfTheWeekLabel setText:@"Saturday"];
            self.selectedDayOfTheWeek = @"Saturday";
            [self unactivateAllTextFields];
            [self changeEditButtonTitle];
            break;
        case 7:
            [self.dayOfTheWeekLabel setText:@"Sunday"];
            self.selectedDayOfTheWeek = @"Sunday";
            [self unactivateAllTextFields];
            [self changeEditButtonTitle];
            break;
        default:
            [self.dayOfTheWeekLabel setText:[NSString stringWithFormat:@"Select a day of the week"]];
    break;
    }
}

- (IBAction)saveTime:(UIBarButtonItem *)sender {
    
    NSLog(@"%@", sender.title);
    
    if ([sender.title isEqualToString:@"Edit"]) {
        [sender setTitle:@"Save"];
        [self activateAllTextFields];
        [self whiteTextFields];
    }else if([sender.title isEqualToString:@"Save"]){
        [sender setTitle:@"Edit"];
        
        [self unactivateAllTextFields];
        [self grayTextFields];
        NSLog(@"About To save");
        
        [self saveTimeForDay:self.selectedDayOfTheWeek];
        NSLog(@"%@",self.selectedDayOfTheWeek);
        
    }
}

-(void)changeEditButtonTitle
{
    if ([self.editButton.title isEqualToString:@"Save"]) {
        [self.editButton setTitle:@"Edit"];
    }
}


-(void)saveTimeForDay:(NSString *)dayOfWeek
{
    NSLog(@"%@",dayOfWeek);
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    if (self.fetchedObjects.count > 0) {
        Availability *availability = (Availability *)self.availabiltyObject;
        if ([dayOfWeek isEqualToString:@"Monday"]) {
            availability.mondayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.mondayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.mondayEarlyAm = self.earlyAMPMTextField.text;
            availability.mondayLateHour = self.lateTimeHourTextField.text;
            availability.mondayLateMin = self.lateTimeMinuteTextField.text;
            availability.mondayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
            NSLog(@"Saving Tuesday");
            availability.tuesdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.tuesdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.tuesdayEarlyAm = self.earlyAMPMTextField.text;
            availability.tuesdayLateHour = self.lateTimeHourTextField.text;
            availability.tuesdayLateMin = self.lateTimeMinuteTextField.text;
            availability.tuesdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
            NSLog(@"Saving Wednesday");
            availability.wednesdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.wednesdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.wednesdayEarlyAm = self.earlyAMPMTextField.text;
            availability.wednesdayLateHour = self.lateTimeHourTextField.text;
            availability.wednesdayLateMin = self.lateTimeMinuteTextField.text;
            availability.wednesdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Thursday"]) {
            NSLog(@"Saving Thursday");
            availability.thursdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.thursdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.thursdayEarlyAm = self.earlyAMPMTextField.text;
            availability.thursdayLateHour = self.lateTimeHourTextField.text;
            availability.thursdayLateMin = self.lateTimeMinuteTextField.text;
            availability.thursdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Friday"]) {
            NSLog(@"Saving Friday");
            availability.fridayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.fridayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.fridayEarlyAm = self.earlyAMPMTextField.text;
            availability.fridayLateHour = self.lateTimeHourTextField.text;
            availability.fridayLateMin = self.lateTimeMinuteTextField.text;
            availability.fridayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Saturday"]) {
            NSLog(@"Saving Saturday");
            availability.saturdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.saturdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.saturdayEarlyAm = self.earlyAMPMTextField.text;
            availability.saturdayLateHour = self.lateTimeHourTextField.text;
            availability.saturdayLateMin = self.lateTimeMinuteTextField.text;
            availability.saturdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Sunday"]) {
            NSLog(@"Saving Sunday");
            availability.sundayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.sundayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.sundayEarlyAm = self.earlyAMPMTextField.text;
            availability.sundayLateHour = self.lateTimeHourTextField.text;
            availability.sundayLateMin = self.lateTimeMinuteTextField.text;
            availability.sundayLateAm = self.lateAMPMTextField.text;
            
        }
    }else{
        Availability *availability = [NSEntityDescription insertNewObjectForEntityForName:@"Availability" inManagedObjectContext:context];
        if ([dayOfWeek isEqualToString:@"Monday"]) {
            NSLog(@"Saving Monday");
            availability.mondayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.mondayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.mondayEarlyAm = self.earlyAMPMTextField.text;
            availability.mondayLateHour = self.lateTimeHourTextField.text;
            availability.mondayLateMin = self.lateTimeMinuteTextField.text;
            availability.mondayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
            NSLog(@"Saving Tuesday");
            availability.tuesdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.tuesdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.tuesdayEarlyAm = self.earlyAMPMTextField.text;
            availability.tuesdayLateHour = self.lateTimeHourTextField.text;
            availability.tuesdayLateMin = self.lateTimeMinuteTextField.text;
            availability.tuesdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
            NSLog(@"Saving Wednesday");
            availability.wednesdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.wednesdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.wednesdayEarlyAm = self.earlyAMPMTextField.text;
            availability.wednesdayLateHour = self.lateTimeHourTextField.text;
            availability.wednesdayLateMin = self.lateTimeMinuteTextField.text;
            availability.wednesdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Thursday"]) {
            NSLog(@"Saving Thursday");
            availability.thursdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.thursdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.thursdayEarlyAm = self.earlyAMPMTextField.text;
            availability.thursdayLateHour = self.lateTimeHourTextField.text;
            availability.thursdayLateMin = self.lateTimeMinuteTextField.text;
            availability.thursdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Friday"]) {
            NSLog(@"Saving Friday");
            availability.fridayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.fridayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.fridayEarlyAm = self.earlyAMPMTextField.text;
            availability.fridayLateHour = self.lateTimeHourTextField.text;
            availability.fridayLateMin = self.lateTimeMinuteTextField.text;
            availability.fridayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Saturday"]) {
            NSLog(@"Saving Saturday");
            availability.saturdayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.saturdayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.saturdayEarlyAm = self.earlyAMPMTextField.text;
            availability.saturdayLateHour = self.lateTimeHourTextField.text;
            availability.saturdayLateMin = self.lateTimeMinuteTextField.text;
            availability.saturdayLateAm = self.lateAMPMTextField.text;
            
        }else if ([dayOfWeek isEqualToString:@"Sunday"]) {
            NSLog(@"Saving Sunday");
            availability.sundayEarlyHour = self.earlyTimeHourTextfield.text;
            availability.sundayEarlyMin = self.earlyTimeMinuteTextField.text;
            availability.sundayEarlyAm = self.earlyAMPMTextField.text;
            availability.sundayLateHour = self.lateTimeHourTextField.text;
            availability.sundayLateMin = self.lateTimeMinuteTextField.text;
            availability.sundayLateAm = self.lateAMPMTextField.text;
        }
    }
}

-(void)unactivateAllTextFields
{
    self.earlyTimeHourTextfield.enabled = NO;
    self.earlyTimeMinuteTextField.enabled = NO;
    self.earlyAMPMTextField.enabled = NO;
    self.lateAMPMTextField.enabled = NO;
    self.lateTimeHourTextField.enabled = NO;
    self.lateTimeMinuteTextField.enabled = NO;
}

-(void)activateAllTextFields
{
    self.earlyTimeHourTextfield.enabled = YES;
    self.earlyTimeMinuteTextField.enabled = YES;
    self.earlyAMPMTextField.enabled = YES;
    self.lateAMPMTextField.enabled = YES;
    self.lateTimeHourTextField.enabled = YES;
    self.lateTimeMinuteTextField.enabled = YES;
}

-(void)grayTextFields{
    [self.earlyAMPMTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.earlyTimeHourTextfield setBackgroundColor:[UIColor lightGrayColor]];
    [self.earlyTimeMinuteTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.lateAMPMTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.lateTimeHourTextField  setBackgroundColor:[UIColor lightGrayColor]];
    [self.lateTimeMinuteTextField setBackgroundColor:[UIColor lightGrayColor]];
}

-(void)whiteTextFields{
    [self.earlyAMPMTextField setBackgroundColor:[UIColor whiteColor]];
    [self.earlyTimeHourTextfield setBackgroundColor:[UIColor whiteColor]];
    [self.earlyTimeMinuteTextField setBackgroundColor:[UIColor whiteColor]];
    [self.lateAMPMTextField setBackgroundColor:[UIColor whiteColor]];
    [self.lateTimeHourTextField  setBackgroundColor:[UIColor whiteColor]];
    [self.lateTimeMinuteTextField setBackgroundColor:[UIColor whiteColor]];
}


// Called when a button is clicked. The view will be automatically dismissed
// after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:
(NSInteger)buttonIndex
{
    if (actionSheet.tag == 0) {
        NSLog(@"Index is %li", (long)buttonIndex);
        switch(buttonIndex){
            case 0:
                self.earlyAMPMTextField.text = NSLocalizedString(@"AM",@"");
                break;
            case 1:
                self.earlyAMPMTextField.text = NSLocalizedString(@"PM",@"");
                break;
            default:
                break;
        }
    }else if (actionSheet.tag == 1){
        NSLog(@"Index is %li", (long)buttonIndex);
        switch(buttonIndex){
            case 0:
                self.lateAMPMTextField.text = NSLocalizedString(@"AM",@"");
                break;
            case 1:
                self.lateAMPMTextField.text = NSLocalizedString(@"PM",@"");
                break;
            default:
                break;
        }
    }

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
	if (textField == self.earlyAMPMTextField)
	{
        [textField resignFirstResponder];
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:
                                      NSLocalizedString(@"Time Period", @"")
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"AM",@""),NSLocalizedString(@"PM",@""),nil];
        actionSheet.tag = 0;
		[actionSheet showInView:self.view];
	}else if (textField == self.lateAMPMTextField)
    {
        [textField resignFirstResponder];
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:
                                      NSLocalizedString(@"Time Period", @"")
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"AM",@""),NSLocalizedString(@"PM", @""), nil];
        actionSheet.tag = 1;
		[actionSheet showInView:self.view];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
