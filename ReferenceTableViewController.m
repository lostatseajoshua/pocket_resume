//
//  ReferenceTableViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/3/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "ReferenceTableViewController.h"

@interface ReferenceTableViewController ()

@property (strong, nonatomic) References *references;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSMutableArray *referenceArray;



@end

@implementation ReferenceTableViewController

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
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.managedObjectContext = [self managedObjectContext];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Appear");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"References" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.referenceArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    [self.tableView reloadData];
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
    return [self.referenceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for index");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    // Set up the cell...
    References *reference = [self.referenceArray objectAtIndex:indexPath.row];
    cell.textLabel.text = reference.fullName;
    
    return cell;
}


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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"UpdateReference"]) {
        NSManagedObject *selectedReference = [self.referenceArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        UINavigationController *navController = [segue destinationViewController];
        ReferenceInformationViewController *destViewController = (ReferenceInformationViewController *)navController.topViewController;
        destViewController.passedReference = selectedReference;
    }
}

-(IBAction)backButton:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
