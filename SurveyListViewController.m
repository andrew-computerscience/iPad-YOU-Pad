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
#import "AppDelegate.h"
#import "Survey.h"


@interface SurveyListViewController ()
//surveys
@property (strong) NSMutableArray *surveys;

@end

@implementation SurveyListViewController

NSMutableArray *uploadingArray;
NSMutableArray *uploadedArray;
NSMutableArray *surveyArray;

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

- (void)goToMainMenu{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateTable
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                    message:@"The survey is successfully uploaded!"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles: nil];
    [alert show];
    [self reloadTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Survey"];
    self.surveys = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    /*
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
     //[uploadedArray addObject:nil];
     //[uploadingArray addObject:nil];
     surveyArray = [[NSMutableArray alloc] initWithObjects:uploadingArray,uploadedArray, nil];
     
     [self.tableView reloadData];
     */
    
    [self reloadTable];
    self.navigationItem.title=@"Kid's List";
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(goToMainMenu)];
    
    
    UIButton* backButton = [UIButton buttonWithType:101]; // left-pointing shape!
    [backButton addTarget:self action:@selector(goToMainMenu) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    
    // create button item -- possible because UIButton subclasses UIView!
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:@"surveyUploaded" object:nil];
   
}

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //return 1;
    return [surveyArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    //return self.surveys.count;
    return [[surveyArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellSurvey";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SurveyListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    
    //CoreData
    //NSManagedObject *survey = [self.surveys objectAtIndex:indexPath.row];
    NSManagedObject *survey = [[surveyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell.kidName setText:[survey valueForKey:@"kid_name"]];
    if ([survey valueForKey:@"uploaded"]) {
        [cell.kidName setAlpha:(CGFloat)0.5];
    }
    
    [cell.researcherName setText:[survey valueForKey:@"researcher_name"]];
    
    [cell.surveyKind setText:[survey valueForKey:@"file_name"]];
    return cell;
}

//設定分類開頭標題
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Unuploaded";
            break;
            
        case 1:
            return @"Uploaded";
            break;
            
        default:
            return @"";
            break;
    }
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
        Survey *survey = [[surveyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        destViewController.survey = survey;
        //NSLog([NSString stringWithFormat:@"%@",survey.kid_name]);
        
    }
}
 

@end
