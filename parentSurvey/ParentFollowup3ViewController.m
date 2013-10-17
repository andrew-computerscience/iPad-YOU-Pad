//
//  ParentFollowup3ViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 9/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "ParentFollowup3ViewController.h"
#import "parentMenuViewController.h"

@interface ParentFollowup3ViewController ()

@end

@implementation ParentFollowup3ViewController



int checkBox3[9];
int page;
int questions;

@synthesize nextButton;

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
    start= 16;
    end = 24;
    questions = 9;
    nextButton.enabled = NO;
    nextButton.alpha = 0.3;
    
    for(int i = 0; i < 10000; i+=100){
        for(int j = 1; j < 4; j++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:(i+j)];
            [temp setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [temp addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //check if already answered checkBox
    for(int i = start; i <=end; i++)
    {
        if(checkBox[i] != 0)
        {
            int counter = i -start;
            int temp = checkBox[i]+((counter+1)*100); //get correct checkbox tag
            UIButton *tempButton = (UIButton *)[self.view viewWithTag:(temp)];
            [tempButton setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [tempButton setSelected:YES];
            
        }
    }
    [self checkNextButton];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkNextButton {
    
    BOOL flag = YES;
    for(int i = start; i <=end; i+=1)
    {
        if(checkBox[i] <=0)
        {
            flag = NO;
        }
        
    }
    if(flag) {
        nextButton.enabled = YES;
        nextButton.alpha = 1;
    }
    
    //NSLog(@"%f", 2.0);
}

-(IBAction)nextButton:(id)sender {
    //write to file
    for(int i = start; i <= end; i++)
    {
        NSLog(@"%d",checkBox[i]);
    }
    
}


- (void)buttonClicked:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    
    if([button isSelected]==YES) {
        [button setSelected:YES];
    } else {
        int checkBoxRow = (button.tag/100 - 1)+start;
        checkBox[checkBoxRow] = button.tag%100;
        int round = ((button.tag / 100) * 100) + 1;
        for(int i = round; i < (round + 3); i++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:i];
            [temp setSelected:NO];
        }
        [button setSelected:YES];
        
    }
    [self checkNextButton];
}

@end
