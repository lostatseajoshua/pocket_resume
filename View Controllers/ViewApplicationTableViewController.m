//
//  ViewApplicationTableViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/1/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "ViewApplicationTableViewController.h"

@interface ViewApplicationTableViewController ()

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSMutableArray *fetchedObjects;


//Personal Information Labels
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *address1Label;
@property (weak, nonatomic) IBOutlet UILabel *address2Label;
@property (weak, nonatomic) IBOutlet UILabel *cityAndStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone1Label;
@property (weak, nonatomic) IBOutlet UILabel *phone2Label;
@property (weak, nonatomic) IBOutlet UILabel *email1Label;
@property (weak, nonatomic) IBOutlet UILabel *email2Label;

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

@end

@implementation ViewApplicationTableViewController

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
    
    self.context = [self managedObjectContext];
    [self loadPersonalInformation];
}

-(void)loadPersonalInformation
{
    NSLog(@"%@",self.context);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Personal" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    self.fetchedObjects = [[self.context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    for (NSManagedObject *info in self.fetchedObjects) {
        
        self.firstName = [info valueForKey:@"firstName"];
        self.lastName = [info valueForKey:@"lastName"];
        self.address1 = [info valueForKey:@"address1"];
        self.address2 = [info valueForKey:@"address2"];
        self.cityAndState = [info valueForKey:@"cityAndState"];
        self.zipcode = [info valueForKey:@"zip"];
        self.phone1 = [info valueForKey:@"phone1"];
        self.phone2 = [info valueForKey:@"phone2"];
        self.email1 = [info valueForKey:@"email1"];
        self.email2 = [info valueForKey:@"email2"];
        
        [self.fullNameLabel setText:[NSString stringWithFormat:@"%@ %@",[info valueForKey:@"firstName"], [info valueForKey:@"lastName"]]];
        
        [self.address1Label setText:self.address1];
        [self.address2Label setText:self.address2];
        [self.cityAndStateLabel setText:self.cityAndState];
        [self.zipcodeLabel setText:self.zipcode];
        [self.phone1Label setText:self.phone1];
        [self.phone2Label setText:self.phone2];
        [self.email1Label setText:self.email1];
        [self.email2Label setText:self.email2];
        
    }
    NSLog(@"%@",self.fetchedObjects);
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personal" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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
