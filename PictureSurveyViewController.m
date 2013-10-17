//
//  PictureSurveyViewController.m
//  iPad-YOU-Pad
//
//  Created by Samuel Hall on 8/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "PictureSurveyViewController.h"
#import "ArraySingleton.h"

bool runOncePS = true;
int answers[50];
ArraySingleton *answersStringsOne;
NSArray *paths;
NSString *docDir;
NSString *filePath;
NSString *kidsIDString;
NSString *kidsNameString;
NSString *researcherNameString;
NSString *answerOneString;
NSString *answerTwoString;
NSString *answerThreeString;
NSFileManager *fmPS;



@interface PictureSurveyViewController ()
{
  AVAudioPlayer *avPlayer;
}
@end



@implementation PictureSurveyViewController

@synthesize answerOne;

@synthesize answerTwo;

@synthesize answerThree;

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
    //make the next button unclickable until an answer is selected
    UIButton * next = (UIButton *)[self.view viewWithTag:998];
    next.enabled = YES;
    
    //run this section of code only once, when a survey is first started
    if (runOncePS) {
        //initialize answers and selected array
        for(int i = 0; i < 50; i++){
            answers[i] = -1;
        }
        
    }
    runOncePS = false;
}


- (IBAction)playgeneric3:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Boy3" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}
//Boy questions play

- (IBAction)playb1:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Boy1" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}

//Girl Questions Play


- (IBAction)playg1:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Girl1" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}

// Man Q1

- (IBAction)playm1:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Man1" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}

//Question 2 set

- (IBAction)playb2:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Boy2" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}


- (IBAction)playg2:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Girl2" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}


- (IBAction)playm2:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Man2" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}

//Question 4


- (IBAction)playb4:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Boy4" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}


- (IBAction)playg4:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Girl4" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}

- (IBAction)playm4:(id)sender {
  NSError *error;
  
  NSString *stringPath =[[NSBundle mainBundle]pathForResource:@"Man4" ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:stringPath];
  avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
  [avPlayer play];
}

-(IBAction)firstNext:(id)sender
{
  answers[0] = 1234567890;
  NSLog(@"First Next Used");
  //Initialise variable sized arrays for data from the three question types.
  answersStringsOne  = [ArraySingleton getInstance];
  
}


//event handler for recording answer when an answer button is selected. - NB: Modify to also rule out existing choice (deselect).
-(IBAction)answer:(id)sender
{
    UIButton *button = (UIButton *)sender;
    answers[(button.tag/100)] = (button.tag % 100);
    NSLog(@"answer added:%i", button.tag % 100);
    NSLog(@"answer added to:%i", button.tag / 100);
}

//event handler for recording answer when next is pressed.
-(IBAction)answerPartTwo:(id)sender
{
    //NB: should not be possible if either answer is empty.
    
    //add answer one to the first array
    NSLog(@"String answer one %@", answerOne.text);
    answerOneString = answerOne.text;
    [answersStringsOne.arrGlobal addObject:answerOneString];
    
    //add answer two to the second array
    answerTwoString = answerTwo.text;
    NSLog(@"String answer two %@", answerTwoString);
    [answersStringsOne.arrGlobal addObject:answerTwoString];
  
    UIButton * next = (UIButton *)[self.view viewWithTag:998];
    next.enabled = YES;
}

//event handler for recording answer when an answer button is selected.
-(IBAction)answerPartThree:(id)sender
{
    //add answer two to the second array
    answerOneString = answerOne.text;
    [answersStringsOne.arrGlobal addObject:answerThree.text];
    NSLog(@"String answer three %@", [answersStringsOne.arrGlobal lastObject]);
    
    UIButton * next = (UIButton *)[self.view viewWithTag:998];
    next.enabled = YES;

}

-(IBAction)submit:(id)sender
{
    NSFileHandle *pictureSurveyFile = [NSFileHandle fileHandleForWritingAtPath:filePath];
    
    if (pictureSurveyFile == nil && pictureSurveyFile != nil) {
        exit(0);
    }
    
    NSMutableString *answerString = [NSMutableString string];
    int i = 0;
    int a;
    int b;
    int c;
    [answerString appendString:[NSString stringWithFormat:@"Face chosen: %d, ", answers[1]]];
  NSLog(@"i = %d, answers i = %i", i, answers[1]);
    [answerString appendString:[NSString stringWithFormat:@"Answers one %@, ", [answersStringsOne.arrGlobal objectAtIndex:i]]];
    [answerString appendString:[NSString stringWithFormat:@"Answers Two %@, ", [answersStringsOne.arrGlobal objectAtIndex:i+1]]];
    [answerString appendString:[NSString stringWithFormat:@"Answers Three %@, ", [answersStringsOne.arrGlobal objectAtIndex:i+2]]];
  
    i++;
  

    while(answers[i] < 12){
        if(answers[i] != -1){
          a = i*3;
          b = i*3+1;
          c = i*3+2;
            [answerString appendString:[NSString stringWithFormat:@"Face chosen: %d, ", answers[i+1]]];
            [answerString appendString:[NSString stringWithFormat:@"Answers one %@, ", [answersStringsOne.arrGlobal objectAtIndex:a]]];
            [answerString appendString:[NSString stringWithFormat:@"Answers Two %@, ", [answersStringsOne.arrGlobal objectAtIndex:b]]];
            [answerString appendString:[NSString stringWithFormat:@"Answers Three %@, ", [answersStringsOne.arrGlobal objectAtIndex:c]]];
        }
        i++;
    }
    NSData *theData = [answerString dataUsingEncoding:NSUTF8StringEncoding];
    [pictureSurveyFile seekToEndOfFile];
    [pictureSurveyFile writeData:theData];
    [pictureSurveyFile closeFile];
}


//event handler for when answer button is pressed only highlights the latest selected answer button.
- (IBAction)buttonClicked:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    
    //logic to allow for mutually exclusive answer buttons within a question
    if([button isSelected]==YES) {
        [button setSelected:YES];
    } else {
        int round = ((button.tag / 100) * 100);
        for(int i = round; i < (round + 6); i++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:i];
            [temp setSelected:NO];
        }
        [button setSelected:YES];
    }
    
    //call the answer action at the same time as an answer is selected
    UIButton * next = (UIButton *)[self.view viewWithTag:998];
    next.enabled = YES;
  
    [self answer:sender];
}

- (IBAction)saveInfo:(id)sender {
  researcherNameString = researcherName.text;
  kidsIDString = kidsId.text;
  kidsNameString = kidsName.text;
}
  
//handler to bring view back to the main menu
- (void)goToMainMenu{
  [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)createFile:(id)sender {
  
    //create a file manager
    fmPS = [NSFileManager defaultManager];
    
    //create unix timestamp
    NSDate *past = [NSDate date];
    NSTimeInterval oldTime = [past timeIntervalSince1970];
    NSString *unixTime = [[NSString alloc] initWithFormat:@"%0.0f", oldTime];
    
    //create the filepath
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    filePath = [docDir stringByAppendingPathComponent: [NSString stringWithFormat:@"KEDS-%@-%@", kidsIDString, unixTime]];
    
    //create the answer file
    [fmPS createFileAtPath:filePath contents:nil attributes:nil];
    NSLog(@"file created at: %@",docDir);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end