//
//  ParentFollowup5ViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 9/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentFollowup5ViewController : UIViewController
{
int start;
int end;
}
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
-(IBAction)nextButton:(id)sender;
@property(weak, nonatomic) IBOutlet UITextField *commentTextField;

-(IBAction)backButton:(id)sender;
@end

