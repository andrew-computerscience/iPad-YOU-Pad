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

@interface parentMenuViewController ()

@end

@implementation parentMenuViewController

@synthesize Survey1;
@synthesize Survey2;
@synthesize Survey3;
@synthesize researcherNameTextField;
@synthesize parentNameTextField;
@synthesize parentIdTextField;

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
}

- (IBAction)Survey2Action:(id)sender {
    surveyNum = 2;
}

- (IBAction)Survey3Action:(id)sender {
    surveyNum = 3;
}

- (IBAction)nextButtonAction:(id)sender {
    researcherName = researcherNameTextField.text;
    parentName = parentNameTextField.text;
    parentId = parentIdTextField.text;
    if(surveyNum == 1) {
        
        [self performSegueWithIdentifier:@"1" sender:self];
    } else if(surveyNum == 2) {
        [self performSegueWithIdentifier:@"2" sender:self];
    } else {
        [self performSegueWithIdentifier:@"3" sender:self];
    }

}

@end
