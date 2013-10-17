//
//  EducatorPt42ViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 16/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "EducatorPt42ViewController.h"
#import "EducatorMenuViewController.h"

bool optionQuestions;
int questions;
int numOptions;

@interface EducatorPt42ViewController ()

@end

@implementation EducatorPt42ViewController
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
    numOptions = 4;
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
    if(checkBox[start] > 1)
    {
        printf("show checkboxes");
        for(int i = 200; i < 400; i+=100) {
            for(int j = 1; j < 5; j++) {
                UIButton *temp = (UIButton*)[self.view viewWithTag:(i+j)];
                temp.enabled = YES;
                temp.alpha = 1.0;
            }
            
        }
        optionQuestions = true;
        
    } else if(checkBox[start] == 1){
        optionQuestions = false;
        printf("hide checkboxes");
        for(int i = 200; i < 400; i+=100) {
            for(int j = 1; j < 5; j++) {
                UIButton *temp = (UIButton*)[self.view viewWithTag:(i+j)];
                [temp setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Unchecked-checkbox-icon.png"] forState:UIControlStateSelected];
                [temp setSelected:NO];
                temp.enabled = NO;
                temp.alpha = 0.3;
            }
            for(int i = start+1; i<=end; i++)
            {
                checkBox[i] = 0;
            }
        }
    } else {
        
        printf("hide checkboxes");
        for(int i = 200; i < 400; i+=100) {
            for(int j = 1; j < 5; j++) {
                UIButton *temp = (UIButton*)[self.view viewWithTag:(i+j)];
                [temp setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Unchecked-checkbox-icon.png"] forState:UIControlStateSelected];
                [temp setSelected:NO];
                temp.enabled = NO;
                temp.alpha = 0.3;
            }
        }
        optionQuestions = false;
        for(int i = start; i <= end; i++)
        {
            checkBox[i] = 0;
        }
    }
}

- (void)checkNextButton {
    
    BOOL flag = YES;
    if(checkBox[start] > 1){ //answer was "yes"
        for(int i = start; i <= end; i+=1)
        {
            if(checkBox[i] <=0)
            {
                flag = NO;
            }
            
        }
    } else {
        if(checkBox[start] == 0)
            flag = NO;
    }
    
    if(flag) {
        nextButton.enabled = YES;
        nextButton.alpha = 1;
    } else {
        nextButton.enabled = NO;
        nextButton.alpha = 0.3;
    }
    
    //NSLog(@"%f", 2.0);
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
        printf(" checkboxStart%d %d",checkBoxRow, checkBox[checkBoxRow]);
        int round = ((button.tag / 100) * 100) + 1;
        for(int i = round; i < (round + numOptions); i++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:i];
            [temp setSelected:NO];
        }
        if(checkBoxRow == start){
            [self checkOptionQuestion];
        }
        [button setSelected:YES];
        [button setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
    }
    [self checkNextButton];
}

@end

