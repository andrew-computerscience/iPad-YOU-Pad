//
//  EducatorPt41ViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 16/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EducatorPt41ViewController : UIViewController
{
    int start;
    int end;
}
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
-(IBAction)nextButton:(id)sender;
@end
