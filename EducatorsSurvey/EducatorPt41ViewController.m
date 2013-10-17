//
//  EducatorPt41ViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 16/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "EducatorPt41ViewController.h"
#import "EducatorMenuViewController.h"

@interface EducatorPt41ViewController ()

@end

@implementation EducatorPt41ViewController

bool optionalQuestions;
int questions;
int numOptions;


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
    start = 25;
    end = 27;
    questions = 3;
    numOptions = 5;
    nextButton.enabled = NO;
    nextButton.alpha = 0.3;
    
    for(int i = 0; i < 10000; i+=100){
        for(int j = 1; j < numOptions+1; j++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:(i+j)];
            [temp setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [temp addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [self checkOptionQuestion];
    //check if already answered checkBox
    //this will be bad when going back to this page
    for(int i = start; i <=end; i++)
    {
        if(checkBox[i] != 0)
        {
            int counter = i-start;
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

-(void)checkOptionQuestion {
    if(checkBox[end] > 1)
    {
        optionalQuestions = true;
        
    } else {
        optionalQuestions = false;
    }
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
}

-(IBAction)nextButton:(id)sender {
    //write to file
    for(int i = start; i <=end; i++)
    {
        NSLog(@"%d",checkBox[i]);
    }
    
}


- (void)buttonClicked:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    
    if([button isSelected]==YES ) {
        [button setSelected:YES];
        [self checkOptionQuestion];
        
    } else {
        int checkBoxRow = (button.tag/100 - 1)+start ;
        checkBox[checkBoxRow] = button.tag%100;
        //printf(" checkboxStart%d %d",checkBoxRow, checkBox[checkBoxRow]);
        int round = ((button.tag / 100) * 100) + 1;
        for(int i = round; i < (round + numOptions); i++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:i];
            [temp setSelected:NO];
        }
        if(checkBoxRow == end){
            [self checkOptionQuestion];
        }
        [button setSelected:YES];
        [button setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
    }
    [self checkNextButton];
}


@end
