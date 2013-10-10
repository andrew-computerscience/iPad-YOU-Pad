//
//  SettingsViewController.h
//  iPad-YOU-Pad
//
//  Created by Andrew Edwards on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

-(IBAction)goToMainMenu;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *website;


@end
