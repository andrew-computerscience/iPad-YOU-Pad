//
//  KidsSurveysViewController.h
//  iPad-YOU-Pad
//
//  Created by Andrew Edwards on 23/09/13.
//  Copyright (c) 2013 Computer Science Student @ UWA. All rights reserved.
//

#import <UIKit/UIKit.h>
//josh
#import <AVFoundation/AVFoundation.h>

//josh
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

@interface KidsSurveysViewController : UIViewController
{
    __weak IBOutlet UINavigationItem *firstQuestionNavBar;
    __weak IBOutlet UINavigationItem *endOfSurvey;
    IBOutlet UITextField *kidsID;
    IBOutlet UITextField *kidsName;
    IBOutlet UITextField *researcherName;
}
//josh
- (IBAction)playSound:(id)sender;
//josh
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


@end
