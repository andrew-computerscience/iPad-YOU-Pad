//
//  ParentFollowup1ViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 9/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

extern bool optionalQuestions;

@interface ParentFollowup1ViewController : UIViewController {
    int start;
    int end;
}
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
-(IBAction)nextButton:(id)sender;
@end

