//
//  Parents45ViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "Parents45ViewController.h"
#import "parentMenuViewController.h"

bool optionQuestions;
int questions;
int numOptions;

@interface Parents45ViewController ()

@end

@implementation Parents45ViewController

@synthesize finishButton;

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
    start = 28;
    end = 32;
    questions = 5;
    numOptions = 4;
    finishButton.enabled = NO;
    finishButton.alpha = 0.3;
    
    if(!optionQuestions){
        [self disableQustions];
    } else {
    
    for(int i = 0; i < 10000; i+=100){
        for(int j = 1; j < numOptions+1; j++){
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
            int counter = i-start;
            int temp = checkBox[i]+((counter+1)*100); //get correct checkbox tag
            UIButton *tempButton = (UIButton *)[self.view viewWithTag:(temp)];
            [tempButton setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [tempButton setSelected:YES];
            
        }
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

-(void)disableQustions {
    for(int i = 100; i < 600; i+=100) {
        for(int j = 1; j < 5; j++) {
            UIButton *temp = (UIButton*)[self.view viewWithTag:(i+j)];
            [temp setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Unchecked-checkbox-icon.png"] forState:UIControlStateSelected];
            [temp setSelected:NO];
            temp.enabled = NO;
            temp.alpha = 0.3;
        }
    }
    [self zeroCheckbox];
}

-(void)zeroCheckbox {
    for(int i = start; i<= end; i++) {
        checkBox[i] = 0;
    }
}

- (void)checkNextButton {
    
    BOOL flag = YES;
    if(optionQuestions){
        printf("checking");
        for(int i = start; i <=end; i++)
        {
            if(checkBox[i] <=0)
            {
                flag = NO;
            }
            
        }

    }
        if(flag) {
        finishButton.enabled = YES;
        finishButton.alpha = 1;
        }
    
    //NSLog(@"%f", 2.0);
}

/*-(IBAction)finishButton:(id)sender {
    //write to file
    NSMutableString *answerString = [NSMutableString string];
    [answerString appendString:[NSString stringWithFormat:@"%@, %@, %@, ", researcherName, parentName, parentId]];
    [answerString appendString:[NSString stringWithFormat:@"%@, %@, ", childName,date]];
    for(int i = 0; i <= end; i++){
        if(i == 0)
        {
            [answerString appendString:[NSString stringWithFormat:@"%d ", checkBox[i]]];
        } else {
            [answerString appendString:[NSString stringWithFormat:@",%d ", checkBox[i]]];
        }
    }
    NSString *temp = commentTextField.text;
    if([temp length] != 0){
        [answerString appendString:[NSString stringWithFormat:@"%@ ", temp]];
    }
    
    
    //write to user accessible file
    if ([fm fileExistsAtPath:filePath]) {
        //create file handle
        NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        
        if(myHandle == nil){
            exit(0);
            //failed to open file
        }
        
        NSData *theData = [answerString dataUsingEncoding:NSUTF8StringEncoding];
        [myHandle seekToEndOfFile];
        [myHandle writeData:theData];
        [myHandle closeFile];
        
    }
    
    //write to hidden file
    if([fm fileExistsAtPath:hiddenFilePath]){
        NSFileHandle *myHiddenHandle =  [NSFileHandle fileHandleForWritingAtPath:hiddenFilePath];
        
        if(myHiddenHandle == nil){
            exit(0);
            //failed to open file
        }
        
        NSData *theData = [answerString dataUsingEncoding:NSUTF8StringEncoding];
        [myHiddenHandle seekToEndOfFile];
        [myHiddenHandle writeData:theData];
        [myHiddenHandle closeFile];
    }

    for(int i = 0; i <= end; i++)
    {
        checkBox[i] = 0;
    }
    parentId = @"";
    researcherName = @"";
    parentName = @"";
}*/


- (void)buttonClicked:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    
    if([button isSelected]==YES) {
        [button setSelected:YES];
    } else {
        int checkBoxRow = (button.tag/100 - 1)+start;
        checkBox[checkBoxRow] = button.tag%100;
        printf("checkbox%d %d ",checkBoxRow, checkBox[checkBoxRow] );
        int round = ((button.tag / 100) * 100) + 1;
        for(int i = round; i < (round + numOptions); i++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:i];
            [temp setSelected:NO];
        }
        [button setSelected:YES];
        
    }
    [self checkNextButton];
}





@end
