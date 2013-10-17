//
//  EducatorMenuViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 15/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "EducatorMenuViewController.h"

int surveyNum;
NSString *researcherName;
NSString *educatorName;
NSString *educatorId;
int checkBox[35];
bool checker;
NSString *survey;
NSString *childName;
NSString *date;
NSString *gender;
NSInteger pickerRow;
NSString *EducatorType;

@interface EducatorMenuViewController ()

@end

@implementation EducatorMenuViewController

@synthesize Survey1;
@synthesize Survey2;
@synthesize Survey3;
@synthesize researcherNameTextField;
@synthesize educatorNameTextField;
@synthesize educatorIdTextField;
@synthesize nextButton;
@synthesize childNameTextField;
@synthesize nextButton2;
@synthesize genderOption;
@synthesize EducatorTypeOption;
@synthesize educatorTypeText;




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
    educatorTypeText.enabled = FALSE;
    educatorTypeText.alpha = 0.3;
    
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
    survey = @"SingleSidedEducator3-4";
}

- (IBAction)Survey2Action:(id)sender {
    surveyNum = 2;
    survey = @"DoubleSidedEducator3-4";
}

- (IBAction)Survey3Action:(id)sender {
    surveyNum = 3;
    survey = @"FollowUpEducator3-4";
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


-(IBAction)backToMainMenu:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)nextButtonAction:(id)sender {
    researcherName = researcherNameTextField.text;
    educatorName = educatorNameTextField.text;
    educatorId = educatorIdTextField.text;
    
    
    /*if(surveyNum < 4){
     [self performSegueWithIdentifier:@"2" sender:self]; //full
     } else {
     [self performSegueWithIdentifier:@"1" sender:self]; //follow up
     }*/
}

- (IBAction)nextButtonAction2:(id)sender {
    childName = childNameTextField.text;
    
    if(genderOption.selectedSegmentIndex == 0)
    {
        gender = @"Male";
    }
    else
    {
        gender = @"Female";
    }
    
    if(EducatorTypeOption.selectedSegmentIndex == 0) {
        EducatorType = @"Playground leader";
    }
    else if (EducatorTypeOption.selectedSegmentIndex == 1)
    {
       EducatorType = @"Nursery teacher";
    }
    else
    {
        EducatorType = educatorTypeText.text;
    }
    
    
    NSDate *dob = [self.timePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy, MM, dd"];
    NSString *dobString = [dateFormat stringFromDate:dob];
    
    date = dobString;
    //[NSString stringWithFormat:@"%@, %@, %@, ", day.text, month.text, year.text];
    
}

- (IBAction)educatorTypeAction:(id)sender {
    
    if(EducatorTypeOption.selectedSegmentIndex == 2)
     {
     educatorTypeText.enabled = TRUE;
     educatorTypeText.alpha = 1.0;
     }
    else
    {
        educatorTypeText.text = @"";
        educatorTypeText.enabled = FALSE;
        educatorTypeText.alpha = 0.3;
    }

}

@end
