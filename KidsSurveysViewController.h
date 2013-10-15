//
//  KidsSurveysViewController.h
//  iPad-YOU-Pad
//
//  Created by Andrew Edwards on 23/09/13.
//  Copyright (c) 2013 Computer Science Student @ UWA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

extern BOOL runOnce;
extern BOOL s1117ImpactSupplement;
extern BOOL s1117FollowUp;
extern BOOL s1117YR1a;
extern int answers[75];
extern int selected[75];
extern NSFileManager *fm;
extern NSArray *paths;
extern NSString *docDir;
extern NSString *filePath;
extern NSString *hiddenFilePath;
extern NSString *kidsID;
extern NSString *kidsName;
extern NSString *researcherName;
extern NSString *commentsString;

@interface KidsSurveysViewController : UIViewController
{
    __weak IBOutlet UINavigationItem *firstQuestionNavBar;
    __weak IBOutlet UINavigationItem *endOfSurvey;
    IBOutlet UITextField *kidsID;
    IBOutlet UITextField *kidsName;
    IBOutlet UITextField *researcherName;
    IBOutlet UITextView *comments;
}
@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;

- (IBAction)playButton:(id)sender;
- (IBAction)playq1:(id)sender;
- (IBAction)playq2:(id)sender;
- (IBAction)playq3:(id)sender;
- (IBAction)playq4:(id)sender;
- (IBAction)playq5:(id)sender;
- (IBAction)playq6:(id)sender;
- (IBAction)playq7:(id)sender;
- (IBAction)playq8:(id)sender;
- (IBAction)playq9:(id)sender;
- (IBAction)playq10:(id)sender;
- (IBAction)playq11:(id)sender;

- (IBAction)answer:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)childDifficultiesNext:(id)sender;
- (IBAction)s1117ImpactSuppButtonPress:(id)sender;
- (IBAction)forkNext:(id)sender;
- (IBAction)s1117FollowUpButtonPress:(id)sender;
- (IBAction)goToMainMenu;
- (IBAction)createFile:(id)sender;
- (IBAction)saveInfo:(id)sender;
- (IBAction)infoEntered:(id)sender;
- (IBAction)saveComments:(id)sender;


@end
