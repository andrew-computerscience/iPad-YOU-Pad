//
//  PictureSurveyViewController.h
//  iPad-YOU-Pad
//
//  Created by Samuel Hall on 8/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>
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



- (IBAction)createFile:(id)sender;

@end
