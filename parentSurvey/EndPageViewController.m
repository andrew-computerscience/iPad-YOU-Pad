//
//  EndPageViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 8/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "EndPageViewController.h"
#import "parentMenuViewController.h"

int end;

@interface EndPageViewController ()

@end



@implementation EndPageViewController

@synthesize comment;

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
    if(surveyNum < 4)
    {
        end = 32;
    }
    else
    {
        end = 33;
    }
    CGRect frameRect = comment.frame;
    frameRect.size.height = 200;
    comment.frame = frameRect;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)writeToFile
{
    //write to file
    NSMutableString *answerString = [NSMutableString string];
    [answerString appendString:[NSString stringWithFormat:@"%@, %@, %@, ", researcherName, parentName, parentId]];
    [answerString appendString:[NSString stringWithFormat:@"%@, %@, %@, ", childName, gender, date]];
    for(int i = 0; i <= end; i++){
        if(i == 0)
        {
            [answerString appendString:[NSString stringWithFormat:@"%d ", checkBox[i]]];
        } else {
            [answerString appendString:[NSString stringWithFormat:@",%d ", checkBox[i]]];
        }
    }
    NSString *temp = comment.text;
    if([temp length] != 0){
        [answerString appendString:[NSString stringWithFormat:@",%@ ", temp]];
    }
    
    
    //write to user accessible file
    if ([fm fileExistsAtPath:filePath]) {
        //create file handle
        NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        
        if(myHandle == nil){
            exit(0);
            //failed to open file
        }
        
        NSData *theData = [answerString dataUsingEncoding:NSUTF8StringEncoding];
        [myHandle seekToEndOfFile];
        [myHandle writeData:theData];
        [myHandle closeFile];
        
    }
    
    //write to hidden file
    if([fm fileExistsAtPath:hiddenFilePath]){
        NSFileHandle *myHiddenHandle =  [NSFileHandle fileHandleForWritingAtPath:hiddenFilePath];
        
        if(myHiddenHandle == nil){
            exit(0);
            //failed to open file
        }
        
        NSData *theData = [answerString dataUsingEncoding:NSUTF8StringEncoding];
        [myHiddenHandle seekToEndOfFile];
        [myHiddenHandle writeData:theData];
        [myHiddenHandle closeFile];
    }
    
    for(int i = 0; i <= end; i++)
    {
        checkBox[i] = 0;
    }
    parentId = @"";
    researcherName = @"";
    parentName = @"";
    childName = @"";
    survey = @"";
    surveyNum = 0;
}


-(IBAction)finishButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [self writeToFile];
}

@end
