//
//  PictureSurveyViewController.h
//  iPad-YOU-Pad
//
//  Created by Samuel Hall on 8/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ArraySingleton.h"

int answers[50];
extern ArraySingleton *answersStringsOne;
extern NSString *filePath;
extern NSString *kidsID;
extern NSString *kidsName;
extern NSString *researcherName;
extern NSString *answerOneString;
extern NSString *answerTwoString;
extern NSString *answerThreeString;


@interface PictureSurveyViewController : UIViewController
{
    IBOutlet UITextField *answerOne;
    IBOutlet UITextField *answerTwo;
    IBOutlet UITextField *answerThree; 
    IBOutlet UITextField *kidsName;
    IBOutlet UITextField *kidsId;
    IBOutlet UITextField *researcherName;
  
  
}

@property (nonatomic, retain) IBOutlet UITextField *answerOne;

@property (nonatomic, retain) IBOutlet UITextField *answerTwo;

@property (nonatomic, retain) IBOutlet UITextField *answerThree;

- (IBAction)infoEntered:(id)sender;
- (IBAction)infoEnteredTwo:(id)sender;
- (IBAction)infoEnteredThree:(id)sender;


- (IBAction)goToMainMenu;

- (IBAction)createFile:(id)sender;
- (IBAction)playgeneric3:(id)sender;

- (IBAction)playb1:(id)sender;
- (IBAction)playb2:(id)sender;
- (IBAction)playb4:(id)sender;

- (IBAction)playg1:(id)sender;
- (IBAction)playg2:(id)sender;
- (IBAction)playg4:(id)sender;

- (IBAction)playm1:(id)sender;
- (IBAction)playm2:(id)sender;
- (IBAction)playm4:(id)sender;
@end
