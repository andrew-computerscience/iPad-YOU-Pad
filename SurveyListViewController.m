//
//  SurveyListViewController.m
//  iPad-YOU-Pad
//
//  Created by Pangpang.i.Lily on 13-10-5.
//  Copyright (c) 2013年 Andrew Edwards. All rights reserved.
//

#import "SurveyListViewController.h"
#import "SurveyListCell.h"
#import "SurveyUploadViewController.h"

#import "Survey.h"


@interface SurveyListViewController ()
//surveys
@property (strong) NSMutableArray *surveys;

@end

@implementation SurveyListViewController


@synthesize fetchedResultsController = _fetchedResultsController;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//CoreData


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Survey" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"uploaded" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:context sectionNameKeyPath:@"sectionPath"
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)goToMainMenu{
    [self dismissViewControllerAnimated:YES completion:nil];
}


// After upload the table
- (void)updateTable
{
    
    // Save
    NSError *error;
    if ([context save:&error] == NO) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                    message:@"The survey is successfully uploaded!"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles: nil];
    [alert show];
    
    //[self reloadTable];
}

- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    self.navigationItem.title=@"Kid's List";
    
    
    UIButton* backButton = [UIButton buttonWithType:101]; // left-pointing shape!
    [backButton addTarget:self action:@selector(goToMainMenu) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    
    // create button item -- possible because UIButton subclasses UIView!
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:@"updateTable" object:nil];
    /*
     
     NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Survey"];
     self.surveys = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
     
     
     [self reloadTable];
     self.navigationItem.title=@"Kid's List";
     
     
     UIButton* backButton = [UIButton buttonWithType:101]; // left-pointing shape!
     [backButton addTarget:self action:@selector(goToMainMenu) forControlEvents:UIControlEventTouchUpInside];
     [backButton setTitle:@"Back" forState:UIControlStateNormal];
     
     // create button item -- possible because UIButton subclasses UIView!
     UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
     self.navigationItem.leftBarButtonItem = backItem;
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:@"surveyUploaded" object:nil];
     */
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

/*
 // Reload the data of table
 - (void)reloadTable
 {
 NSError *error = nil;
 [self.managedObjectContext save:&error];
 
 uploadedArray = [[NSMutableArray alloc] init];
 uploadingArray = [[NSMutableArray alloc] init];
 for (NSManagedObject *obj in self.surveys) {
 if ([obj valueForKey:@"uploaded"]){
 [uploadedArray addObject:obj];
 NSLog(@"%@",[obj valueForKey:@"kid_name"]);
 }else{
 [uploadingArray addObject:obj];
 NSLog(@"%@",[obj valueForKey:@"kid_name"]);
 }
 }
 
 surveyArray = [[NSMutableArray alloc] initWithObjects:uploadingArray,uploadedArray, nil];
 
 [self.tableView reloadData];
 }
 */


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //return [surveyArray count];
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    //return [[surveyArray objectAtIndex:section] count];
    id <NSFetchedResultsSectionInfo> sectionInfo =
    [[[self fetchedResultsController] sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(SurveyListCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Survey *survey = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.kidName setText:[survey valueForKey:@"kid_name"]];
    if ([survey valueForKey:@"uploaded"]) {
        [cell.kidName setAlpha:(CGFloat)0.5];
    }
    [cell.researcherName setText:[survey valueForKey:@"researcher_name"]];
    [cell.surveyKind setText:[survey valueForKey:@"file_name"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellSurvey";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SurveyListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    
    //CoreData
    //NSManagedObject *survey = [[surveyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

//Set the header of list
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *sections = [[self fetchedResultsController] sections]; id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo name];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(SurveyListCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libraryDirectory = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [libraryDirectory stringByAppendingPathComponent: [object valueForKey:@"file_name"]];
        [fileManager removeItemAtPath:filePath error:nil];
        
        [context deleteObject:object];
        
        // Save
        NSError *error;
        if ([context save:&error] == NO) {
            // Handle Error.
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

// Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"uploadSurvey"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        
        
        SurveyUploadViewController *destViewController = segue.destinationViewController;
        //Survey *survey = [[surveyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        Survey *survey = [self.fetchedResultsController objectAtIndexPath:indexPath];
        destViewController.survey = survey;
        //NSLog([NSString stringWithFormat:@"%@",survey.kid_name]);
        
    }
}


@end
