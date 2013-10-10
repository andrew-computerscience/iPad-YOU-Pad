//
//  CompletedSurveysViewController.m
//  iPad-YOU-Pad
//
//  Created by Andrew Edwards on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "CompletedSurveysViewController.h"

@interface CompletedSurveysViewController ()

@end

@implementation CompletedSurveysViewController

- (void)goToMainMenu{
    [self dismissModalViewControllerAnimated:YES];
}

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
