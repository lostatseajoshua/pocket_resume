//
//  PersonalEditTableViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 7/26/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "PersonalEditTableViewController.h"

@interface PersonalEditTableViewController ()

@property (strong, nonatomic) NSManagedObjectContext *context;

@property (strong, nonatomic) NSMutableArray *fetchedObjects;

//textFields
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *address1TextField;
@property (weak, nonatomic) IBOutlet UITextField *address2TextField;
@property (weak, nonatomic) IBOutlet UITextField *cityAndStateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phone1TextField;
@property (weak, nonatomic) IBOutlet UITextField *phone2TextField;
@property (weak, nonatomic) IBOutlet UITextField *email1TextField;
@property (weak, nonatomic) IBOutlet UITextField *email2TextField;


@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *cityAndState;
@property (strong, nonatomic) NSString *zipcode;
@property (strong, nonatomic) NSString *phone1;
@property (strong, nonatomic) NSString *phone2;
@property (strong, nonatomic) NSString *email1;
@property (strong, nonatomic) NSString *email2;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (strong, nonatomic) NSMutableDictionary *personalInformation;

@end

@implementation PersonalEditTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //set textfield delegate
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.address1TextField.delegate = self;
    self.address2TextField.delegate = self;
    self.cityAndStateTextField.delegate = self;
    self.zipcodeTextField.delegate = self;
    self.phone1TextField.delegate = self;
    self.phone2TextField.delegate = self;
    self.email1TextField.delegate = self;
    self.email2TextField.delegate = self;
    
    [self.editButton setTitle:@"Edit"];
    [self grayTextFields];
    
    self.context = [self managedObjectContext];
    
    NSLog(@"%@",self.context);
    
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Personal" inManagedObjectContext:self.context];
        [fetchRequest setEntity:entity];
        NSError *error;
    
       self.fetchedObjects = [[self.context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
        for (NSManagedObject *info in self.fetchedObjects) {
            NSLog(@"Name: %@", [info valueForKey:@"firstName"]);
            [self.firstNameTextField setText:[info valueForKey:@"firstName"]];
            self.firstName = (NSString *)[info valueForKey:@"firstName"];
            
            [self.lastNameTextField setText:[info valueForKey:@"lastName"]];
            self.lastName = (NSString *)[info valueForKey:@"lastName"];
            
            [self.address1TextField setText:[info valueForKey:@"address1"]];
            self.address1 = (NSString *)[info valueForKey:@"address1"];
            
            [self.address2TextField setText:[info valueForKey:@"address2"]];
            self.address2 = (NSString *)[info valueForKey:@"address2"];
            
            [self.cityAndStateTextField setText:[info valueForKey:@"cityAndState"]];
            self.cityAndState = (NSString *)[info valueForKey:@"cityAndState"];
            
            [self.zipcodeTextField setText:[info valueForKey:@"zip"]];
            self.zipcode = (NSString *)[info valueForKey:@"zip"];
            
            [self.phone1TextField setText:[info valueForKey:@"phone1"]];
            self.phone1 = (NSString *)[info valueForKey:@"phone1"];
            
            [self.phone2TextField setText:[info valueForKey:@"phone2"]];
            self.phone2 = (NSString *)[info valueForKey:@"phone2"];
            
            [self.email1TextField setText:[info valueForKey:@"email1"]];
            self.email1 = (NSString *)[info valueForKey:@"email1"];
            
            [self.email2TextField setText:[info valueForKey:@"email2"]];
            self.email2 = (NSString *)[info valueForKey:@"email2"];
        
        }
    NSLog(@"%@",self.fetchedObjects);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
    {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
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
    return 8;
}


- (IBAction)editInformation:(UIBarButtonItem *)sender {
    
    if ([sender.title isEqualToString:@"Edit"]) {
        [sender setTitle:@"Save"];
        
        self.firstNameTextField.enabled = YES;
        self.lastNameTextField.enabled = YES;
        self.address1TextField.enabled = YES;
        self.address2TextField.enabled = YES;
        self.cityAndStateTextField.enabled = YES;
        self.zipcodeTextField.enabled = YES;
        self.phone1TextField.enabled = YES;
        self.phone2TextField.enabled = YES;
        self.email1TextField.enabled = YES;
        self.email2TextField.enabled = YES;
        
        [self whiteTextFields];
    }else if([sender.title isEqualToString:@"Save"]){
        [sender setTitle:@"Edit"];
        NSLog(@"Save");
        [self grayTextFields];
        [self saveInformation];

    }
}

-(void)grayTextFields{
    [self.firstNameTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.lastNameTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.address1TextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.address2TextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.cityAndStateTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.zipcodeTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.phone1TextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.phone2TextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.email1TextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.email2TextField setBackgroundColor:[UIColor lightGrayColor]];
}
-(void)whiteTextFields{
    [self.firstNameTextField setBackgroundColor:[UIColor whiteColor]];
    [self.lastNameTextField setBackgroundColor:[UIColor whiteColor]];
    [self.address1TextField setBackgroundColor:[UIColor whiteColor]];
    [self.address2TextField setBackgroundColor:[UIColor whiteColor]];
    [self.cityAndStateTextField setBackgroundColor:[UIColor whiteColor]];
    [self.zipcodeTextField setBackgroundColor:[UIColor whiteColor]];
    [self.phone1TextField setBackgroundColor:[UIColor whiteColor]];
    [self.phone2TextField setBackgroundColor:[UIColor whiteColor]];
    [self.email1TextField setBackgroundColor:[UIColor whiteColor]];
    [self.email2TextField setBackgroundColor:[UIColor whiteColor]];
}


-(void)saveInformation
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.fetchedObjects.count > 0) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Personal" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error;
        NSMutableArray *peronArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
        
        Personal *person = [peronArray lastObject];
        
        NSLog(@"%@", person);
        
        person.firstName = self.firstNameTextField.text;
        person.lastName = self.lastNameTextField.text;
        person.address1 = self.address1TextField.text;
        person.cityAndState = self.cityAndStateTextField.text;
        person.zip = self.zipcodeTextField.text;
        person.phone1 = self.phone1TextField.text;
        person.phone2 = self.phone2TextField.text;
        person.email1 = self.email1TextField.text;
        person.email2 = self.email2TextField.text;
        
    } else {
        
        Personal *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Personal" inManagedObjectContext:context];
        
        newPerson.firstName = self.firstNameTextField.text;
        newPerson.lastName = self.lastNameTextField.text;
        newPerson.address1 = self.address1TextField.text;
        newPerson.cityAndState = self.cityAndStateTextField.text;
        newPerson.zip = self.zipcodeTextField.text;
        newPerson.phone1 = self.phone1TextField.text;
        newPerson.phone2 = self.phone2TextField.text;
        newPerson.email1 = self.email1TextField.text;
        newPerson.email2 = self.email2TextField.text;
    }
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.address1TextField resignFirstResponder];
    [self.address2TextField resignFirstResponder];
    [self.cityAndStateTextField resignFirstResponder];
    [self.zipcodeTextField resignFirstResponder];
    [self.phone1TextField resignFirstResponder];
    [self.phone2TextField resignFirstResponder];
    [self.email1TextField resignFirstResponder];
    [self.email2TextField resignFirstResponder];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
