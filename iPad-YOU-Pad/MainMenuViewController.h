//
//  ViewController.h
//  iPad-YOU-Pad
//
//  Created by Andrew Edwards on 2/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

extern int pin;

@interface MainMenuViewController : UIViewController{
    
    IBOutlet UITextField *pinField;
}

-(IBAction)goToKidsSurveys;
-(IBAction)goToParentsSurveys;
-(IBAction)goToEducatorsSurveys;
-(IBAction)goToCompletedSurveys;
-(IBAction)goToSettings;
- (IBAction)checkPin:(id)sender;

@end
