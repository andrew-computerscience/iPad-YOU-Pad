//
//  EndPageViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 8/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "EndPageViewController.h"

@interface EndPageViewController ()

@end

@implementation EndPageViewController

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

-(IBAction)finishButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
