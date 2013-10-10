//
//  Parents45ViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Parents45ViewController : UIViewController {
    int start;
    int end;
}
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
-(IBAction)finishButton:(id)sender;
@property(weak, nonatomic) IBOutlet UITextField *commentTextField;
@end
