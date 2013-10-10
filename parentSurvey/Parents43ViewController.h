//
//  Parents43ViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Parents43ViewController : UIViewController{
    int start;
    int end;
}
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
-(IBAction)nextButton:(id)sender;
@end
