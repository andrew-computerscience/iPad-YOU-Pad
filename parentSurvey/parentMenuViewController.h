//
//  parentMenuViewController.h
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

extern int surveyNum;
extern int checkBox1[8];
extern int checkBox2[8];
extern int checkBox3[9];
extern int checkBox4[3];
extern int checkBox5[5];
extern int checkBox[35];
extern NSString *researcherName;
extern NSString *parentName;
extern NSString *parentId;
extern NSFileManager *fm;
extern NSArray *paths;
extern NSString *docDir;
extern NSString *filePath;
extern NSString *hiddenFilePath;


extern bool firstStartup;

@interface parentMenuViewController : UIViewController {
    //NSFileManager *fm;
}

@property (weak, nonatomic) IBOutlet UIButton *Survey1;
- (IBAction)Survey1Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Survey2;
- (IBAction)Survey2Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Survey3;
- (IBAction)Survey3Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextButtonAction:(id)sender;

@property(weak,nonatomic) IBOutlet UITextField *researcherNameTextField;
@property(weak,nonatomic) IBOutlet UITextField *parentNameTextField;
@property(weak,nonatomic) IBOutlet UITextField *parentIdTextField;
@end
