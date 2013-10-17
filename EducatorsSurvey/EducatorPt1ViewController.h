//
//  EducatorPt1ViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 15/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>



extern bool optionalQuestions;

@interface EducatorPt1ViewController : UIViewController {
    int start;
    int end;
}


@property (weak, nonatomic) IBOutlet UIButton *nextButton;
-(IBAction)nextButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;


@end
