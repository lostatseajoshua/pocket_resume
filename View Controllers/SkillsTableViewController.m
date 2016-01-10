//
//  SkillsTableViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/19/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "SkillsTableViewController.h"

@interface SkillsTableViewController ()

@property (strong, nonatomic) NSMutableArray *skillsArray;

@end

@implementation SkillsTableViewController

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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.skillsArray = [[NSMutableArray alloc]init];
    [self fetchTableData];
}
-(void)fetchTableData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Skills" inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"nameOfSkill" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setEntity:entity];
    
    NSError *error;

    self.skillsArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];

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
    return self.skillsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Skills *skill = self.skillsArray[indexPath.row];
    
    [cell.textLabel setText:skill.nameOfSkill];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

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
- (IBAction)addNewSkill:(UIBarButtonItem *)sender {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Add New Skill"
                              message:@"Please type in your new skill:"
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Add", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *alertTextField = [alertView textFieldAtIndex:0];
    alertTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    alertTextField.autocorrectionType = UITextAutocorrectionTypeDefault;
    
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSLog(@"In clicked button");
        NSString *newSkillText = [alertView textFieldAtIndex:0].text;
        NSManagedObjectContext *context = [self managedObjectContext];
        Skills *newSkill = [NSEntityDescription insertNewObjectForEntityForName:@"Skills" inManagedObjectContext:context];
        newSkill.nameOfSkill = newSkillText;
        [self.skillsArray addObject:newSkill];
    }
    else
    {
        //Do something else
    }
    [self.tableView reloadData];
}
- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
