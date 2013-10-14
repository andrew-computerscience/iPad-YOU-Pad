//
//  parentMenuViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "parentMenuViewController.h"

int surveyNum;
NSString *researcherName;
NSString *parentName;
NSString *parentId;
int checkBox[35];
bool checker;
NSString *survey;
NSString *childName;
NSString *date;

@interface parentMenuViewController ()

@end

@implementation parentMenuViewController

@synthesize Survey1;
@synthesize Survey2;
@synthesize Survey3;
@synthesize researcherNameTextField;
@synthesize parentNameTextField;
@synthesize parentIdTextField;
@synthesize nextButton;
@synthesize childNameTextField;
@synthesize day;
@synthesize month;
@synthesize year;
@synthesize nextButton2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    /*nextButton.enabled = false;
    nextButton.alpha = 0.3;
    [self checker];
    checker = false;*/
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    firstStartup= TRUE;
    for(int i = 0; i < 35; i++)
    {
        checkBox[i] = 0;
    }
	// Do any additional setup after loading the view.
    //checkBox[0] = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Survey1Action:(id)sender {
    surveyNum = 1;
    survey = @"Parent3-4Full";
}

- (IBAction)Survey2Action:(id)sender {
    surveyNum = 2;
    survey = @"Parent4-10Full";
}

- (IBAction)Survey3Action:(id)sender {
    surveyNum = 3;
    survey = @"Parent11-17Full";
}

- (IBAction)Survey4Action:(id)sender {
    surveyNum = 4;
    survey = @"Parent3-4FollowUp";
}

- (IBAction)Survey5Action:(id)sender {
    surveyNum = 5;
    survey = @"Parent4-10FollowUp";
}

- (IBAction)Survey6Action:(id)sender {
    surveyNum = 6;
    survey = @"Parent11-17FollowUp";
}

/*-(void)checker {
    bool flag = TRUE;
    if((researcherNameTextField.text = @""))
    {
        flag = FALSE;
    }
    if((parentNameTextField.text = @""))
    {
        flag = FALSE;
    }
    if((parentNameTextField.text = @""))
    {
        flag = FALSE;
    }
    if(flag) {
        nextButton.enabled = TRUE;
        nextButton.alpha = 1.0;
    } else {
        nextButton.enabled = FALSE;
        nextButton.alpha = 0.3;
    }
}*/

- (IBAction)nextButtonAction:(id)sender {
    researcherName = researcherNameTextField.text;
    parentName = parentNameTextField.text;
    parentId = parentIdTextField.text;
    
    
    /*if(surveyNum < 4){
        [self performSegueWithIdentifier:@"2" sender:self]; //full
    } else {
        [self performSegueWithIdentifier:@"1" sender:self]; //follow up
    }*/
}
    
- (IBAction)nextButtonAction2:(id)sender {
    childName = childNameTextField.text;
    
    NSDate *dob = [self.timePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy, MM, dd"]; 
    NSString *dobString = [dateFormat stringFromDate:dob];
    
    date = dobString;
    //[NSString stringWithFormat:@"%@, %@, %@, ", day.text, month.text, year.text];
    if(surveyNum < 4){
        [self performSegueWithIdentifier:@"2" sender:self]; //full
    } else {
        [self performSegueWithIdentifier:@"1" sender:self]; //follow up
    }

}

@end
