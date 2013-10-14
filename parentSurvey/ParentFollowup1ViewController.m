//
//  ParentFollowup1ViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson on 9/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "ParentFollowup1ViewController.h"
#import "parentMenuViewController.h"
#import "AppDelegate.h"

@interface ParentFollowup1ViewController ()

@end

@implementation ParentFollowup1ViewController


int checkBox[35];
bool firstStartup;
int questions;


@synthesize nextButton;

// Core Data
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
    start = 0;
    end = 7;
    questions = 8;
    nextButton.enabled = NO;
    nextButton.alpha = 0.3;
    if(firstStartup)
    {
        firstStartup = FALSE;
        fm = [NSFileManager defaultManager];
        
        //create the filepath
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docDir = [paths objectAtIndex:0];
        //NSMutableString *fn;
        //[fn appendString:[NSString stringWithFormat:@"%@%@%@%@.txt ", survey, researcherName, parentName, parentId]];
        //NSString *filename = fn;
        filePath = [docDir stringByAppendingPathComponent: [NSString stringWithFormat:@"%@-%@-%@-%@", survey, researcherName, parentName, parentId]];
        //filePath = [docDir stringByAppendingPathComponent:@"2.txt"];//@"%@-%@-%@-%@.txt",survey, researcherName, parentName, parentId]];//dont know if it works
        //create the answer file
        [fm createFileAtPath:filePath contents:nil attributes:nil];
        
        paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        docDir = [paths objectAtIndex:0];
        hiddenFilePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@-%@-%@", survey, researcherName, parentName, parentId]];
        NSLog(@"filepath %@", filePath);
        NSLog(@"filepath hidden %@", hiddenFilePath);
        
        
        //create the answer file
        [fm createFileAtPath:filePath contents:nil attributes:nil];
        [fm createFileAtPath:hiddenFilePath contents:nil attributes:nil];
        
        //Survey List change
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *parentSurvey = [NSEntityDescription insertNewObjectForEntityForName:@"Survey" inManagedObjectContext:context];
        [parentSurvey setValue:researcherName forKey:@"researcher_name"];
        [parentSurvey setValue:parentName forKey:@"kid_name"];
        [parentSurvey setValue:parentId forKey:@"kid_id"];
        [parentSurvey setValue:false forKey:@"uploaded"];
        [parentSurvey setValue:[NSString stringWithFormat:@"%@-%@-%@-%@", survey, researcherName, parentName, parentId] forKey:@"file_name"];
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"Kids list updated successfully!");
        }
        
        optionalQuestions = true;
    }
    
    for(int i = 0; i < 10000; i+=100){
        for(int j = 1; j < 4; j++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:(i+j)];
            [temp setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [temp addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //check if already answered checkBox
    for(int i = start; i <= end; i++)
    {
        if(checkBox[i] != 0)
        {
            int temp = checkBox[i]+((i+1)*100); //get correct checkbox tag
            UIButton *tempButton = (UIButton *)[self.view viewWithTag:(temp)];
            [tempButton setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [tempButton setSelected:YES];
            
        }
    }
    [self checkNextButton];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//check if all checkboxes were answered
- (void)checkNextButton {
    
    BOOL flag = YES;
    for(int i = start; i <= end; i+=1)
    {
        if(checkBox[i] <=0)
        {
            flag = NO;
        }
        
    }
    if(flag) {
        nextButton.enabled = YES;
        nextButton.alpha = 1;
    }
    
    //NSLog(@"%f", 2.0);
}

-(IBAction)nextButton:(id)sender {
    //write to file
    NSLog(@"nextbutton");
    for(int i = start; i <= end; i++)
    {
        NSLog(@"%d",checkBox[i]);
    }
    NSLog(@"end of nextbutton");
    
}


- (void)buttonClicked:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    
    if([button isSelected]==YES) {
        [button setSelected:YES];
    } else {
        int checkBoxRow = button.tag/100 - 1;
        checkBox[checkBoxRow] = button.tag%100;
        int round = ((button.tag / 100) * 100) + 1;
        for(int i = round; i < (round + 3); i++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:i];
            [temp setSelected:NO];
        }
        [button setSelected:YES];
        
    }
    [self checkNextButton];
}

@end

