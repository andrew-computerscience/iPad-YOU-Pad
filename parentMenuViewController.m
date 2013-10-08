//
//  parentMenuViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 3/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "parentMenuViewController.h"
//#import "ParentsSurveysViewController.h"

int surveyNum;

@interface parentMenuViewController ()

@end

@implementation parentMenuViewController

@synthesize Survey1;
@synthesize Survey2;
@synthesize Survey3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for(int i = 0; i < 8; i++)
    {
        firstStartup[i] = TRUE;
    }
    //fm = [NSFileManager defaultManager];
    /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    
    if ([fm fileExistsAtPath:filePath]) {
        //create file handle
        NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        
        if(myHandle == nil){
            //failed to open file
        }
        NSString *content = @"Q1 - YES!\n";
        NSData *theData = [content dataUsingEncoding:NSUTF8StringEncoding];
        [myHandle seekToEndOfFile];
        [myHandle writeData:theData];
        [myHandle closeFile];
        
        [textView setText:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]];
    }
    else {
        //The file doesn't exist
        [textView setText:@"File doesn't exist!"];
        [fm createFileAtPath:filePath contents:nil attributes:nil];
*/
	// Do any additional setup after loading the view.
    //checkBox[0] = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Survey1Action:(id)sender {
    surveyNum = 1;
}

- (IBAction)Survey2Action:(id)sender {
    surveyNum = 2;
}

- (IBAction)Survey3Action:(id)sender {
    surveyNum = 3;
}

- (IBAction)nextButtonAction:(id)sender {
    if(surveyNum == 1) {
        [self performSegueWithIdentifier:@"1" sender:self];
    } else if(surveyNum == 2) {
        [self performSegueWithIdentifier:@"2" sender:self];
    } else {
        [self performSegueWithIdentifier:@"3" sender:self];
    }

}

@end
