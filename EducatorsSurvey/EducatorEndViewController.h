//
//  EducatorEndViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 15/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EducatorEndViewController : UIViewController

-(IBAction)finishButton:(id)sender;

@property(weak, nonatomic) IBOutlet UITextField *comment;
@end
