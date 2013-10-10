//
//  SurveyUploadViewController.h
//  iPad-YOU-Pad
//
//  Created by Pangpang.i.Lily on 13-10-6.
//  Copyright (c) 2013年 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Survey.h"

@interface SurveyUploadViewController : UIViewController
    


@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (nonatomic, strong) Survey *survey;
@property (weak, nonatomic) IBOutlet UILabel *kidName;
@property (weak, nonatomic) IBOutlet UILabel *researcherName;
@property (weak, nonatomic) IBOutlet UILabel *message;
- (IBAction)upload:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@end
