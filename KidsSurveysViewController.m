//
//  KidsSurveysViewController.m
//
//
//  Created by Andrew Edwards on 23/09/13.
//  Copyright (c) 2013 Computer Science Student @ UWA. All rights reserved.
//

#import "KidsSurveysViewController.h"
#import "AppDelegate.h"

BOOL runOnce = true;
BOOL s1117ImpactSupplement = false;
BOOL s1117FollowUp = false;
BOOL s1117YR1a = false;
int answers[75];
int selected[75];
NSFileManager *fm;
NSArray *paths;
NSString *docDir;
NSString *filePath;
NSString *hiddenFilePath;
NSString *kidsIDString;
NSString *kidsNameString;
NSString *researcherNameString;
NSString *commentsString;

@implementation KidsSurveysViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark - View lifecycle

// code that runs on every new view that is loaded
- (void)viewDidLoad
{
    //make the next button unclickable until an answer is selected
    UIButton * next = (UIButton *)[self.view viewWithTag:998];
    next.enabled = NO;
    
    //run this section of code only once, when a survey is first started
    if(runOnce){
        
        //initialize answers and selected array
        for(int i = 0; i < 75; i++){
            answers[i] = -1;
            selected[i] = -1;
        }
        
        
        runOnce = false;
    }
    
    //for every possible answer button, set the background to be changed to green when state is changed to selected
    for(int i = 0; i < 10000; i+=100){
        for(int j = 1; j < 6; j++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:(i+j)];
            [temp setBackgroundImage:[UIImage imageNamed:@"button (1).png"] forState:UIControlStateSelected];
            [temp addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    

    
    //recover state of previously selected answers when a user goes back to a previous question, then forward again to already answered questions
    for(int i = 0; i < 75; i++){
        if(selected[i] != -1){
            UIButton *temp = (UIButton *)[self.view viewWithTag:selected[i]];
            [temp setSelected:YES];
            if([temp isSelected]==YES)
                next.enabled = YES;
        }
    }
    
    //when the impact supplement or follow up survey is chosen, change the title of the submit button for the last common question page to a next button
    if(s1117ImpactSupplement || s1117FollowUp || s1117YR1a){
        UIButton *temp = (UIButton *)[self.view viewWithTag:998];
        [temp setTitle:@"Next" forState:UIControlStateNormal];
    }
    
    //hide the back button when the survey has first commenced and after the survey has been submitted for encapsulation purposes
    [firstQuestionNavBar setHidesBackButton:YES];
    [endOfSurvey setHidesBackButton:YES];
    
    //set the background
    UIColor * circleColorPattern = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg.jpg"]];
    [self.view setBackgroundColor:circleColorPattern];
    
    [super viewDidLoad];
}

//event handler for recording answer when an answer button is selected.
-(IBAction)answer:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    
    if([buttonTitle isEqualToString:@"Somewhat True"]){
        NSLog(@"Somewhat True!");
        answers[button.tag / 100] = 1;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Not True"]){
        NSLog(@"Not True!");
        answers[button.tag / 100] = 0;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Certaintly True"]){
        NSLog(@"Certaintly True!");
        answers[button.tag / 100] = 2;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"No - No difficulties"]){
        NSLog(@"No - No difficulties!");
        answers[button.tag / 100] = 10;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Yes - Minor difficulties"]){
        NSLog(@"Yes - Minor difficulties!");
        answers[button.tag / 100] = 11;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Yes - Definite difficulties"]){
        NSLog(@"Yes - Definite difficulties");
        answers[button.tag / 100] = 12;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Yes - Severe difficulties"]){
        NSLog(@"Yes - Severe difficulties!");
        answers[button.tag / 100] = 13;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Less than a month"]){
        NSLog(@"Less than a month!");
        answers[button.tag / 100] = 14;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"1-5 months"]){
        NSLog(@"1-5 months!");
        answers[button.tag / 100] = 15;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"6-12 months"]){
        NSLog(@"6-12 months!");
        answers[button.tag / 100] = 16;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Over a year"]){
        NSLog(@"Over a year!");
        answers[button.tag / 100] = 17;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Not at all"]){
        NSLog(@"Not at all!");
        answers[button.tag / 100] = 20;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Only a little"]){
        NSLog(@"Only a little!");
        answers[button.tag / 100] = 21;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"Quite a lot"]){
        NSLog(@"Quite a lot!");
        answers[button.tag / 100] = 22;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"A great deal"]){
        NSLog(@"A great deal!");
        answers[button.tag / 100] = 23;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"Much worse"]){
        NSLog(@"Much worse");
        answers[button.tag / 100] = 30;
        selected[button.tag / 100] = button.tag;
    } else if([buttonTitle isEqualToString:@"A bit worse"]){
        NSLog(@"A bit worse!");
        answers[button.tag / 100] = 31;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"About the same"]){
        NSLog(@"About the same!");
        answers[button.tag / 100] = 32;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"A bit better"]){
        NSLog(@"A bit better!");
        answers[button.tag / 100] = 33;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"Much better"]){
        NSLog(@"Much better!");
        answers[button.tag / 100] = 34;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"No"]){
        NSLog(@"No!");
        answers[button.tag / 100] = 40;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"A little"]){
        NSLog(@"A little!");
        answers[button.tag / 100] = 41;
        selected[button.tag / 100] = button.tag;
    }  else if([buttonTitle isEqualToString:@"A lot"]){
        NSLog(@"A lot!");
        answers[button.tag / 100] = 42;
        selected[button.tag / 100] = button.tag;
    }
}

//event handler for when submit button is selected to write results to file.
-(IBAction)submit:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    
    if([buttonTitle isEqualToString:@"Submit"]){
        
        //concatenate answers into one single string, answerString
        NSMutableString *answerString = [NSMutableString string];
        int i = 0;
        while(i < 75){
            if(answers[i] != -1){
                [answerString appendString:[NSString stringWithFormat:@"%d, ", answers[i]]];
            }
            answers[i] = -1;
            selected[i] = -1;
            i++;
        }
        
        //add comments to end of answers string
        [answerString appendString:commentsString];
        
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
        s1117YR1a = false;
        s1117ImpactSupplement = false;
        s1117FollowUp = false;
    }
}

//Handler to continue with impact supplement questions if yes is answered to question re: difficulties
- (IBAction)childDifficultiesNext:(id)sender {
    UIButton *yesMinor = (UIButton *)[self.view viewWithTag:2502];
    UIButton *yesDefinite = (UIButton *)[self.view viewWithTag:2503];
    UIButton *yesSevere = (UIButton *)[self.view viewWithTag:2504];
    UIButton *noDifficulties = (UIButton *)[self.view viewWithTag:2501];
    
    if(([yesMinor isSelected]==YES || [yesDefinite isSelected]==YES || [yesSevere isSelected]==YES)){
        [self performSegueWithIdentifier:@"noDurationDifficulties" sender:self];
    } else if (([yesMinor isSelected]==YES || [yesDefinite isSelected]==YES || [yesSevere isSelected]==YES)){
        [self performSegueWithIdentifier:@"yesDifficulties" sender:self];
    } else if([noDifficulties isSelected]==YES){
        [self performSegueWithIdentifier:@"noDifficulties" sender:self];
    }
}

//Handler to make sure the impact supp module is loaded when impact supp survey selected
- (IBAction)s1117ImpactSuppButtonPress:(id)sender {
    s1117ImpactSupplement = true;
}

//handler to make additional impact supplement or follow up survey questions visible
- (IBAction)forkNext:(id)sender {
    
    if(s1117ImpactSupplement){
        [self performSegueWithIdentifier:@"yesImpactSupp" sender:self];
    } else if(s1117FollowUp){
        [self performSegueWithIdentifier:@"yesFollowUp" sender:self];
    } else if (s1117YR1a){
        [self performSegueWithIdentifier:@"yesYR1a" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"noImpactSuppOrFollowUp" sender:self];
    }
}

//handler to make sure the follow up module is loaded when follow up survey selected
- (IBAction)s1117FollowUpButtonPress:(id)sender{
    s1117FollowUp = true;
}

- (IBAction)s1117YR1aButtonPress:(id)sender{
    s1117YR1a = true;
}

//Handler to continue with additional follow up survey questions if yes is answered to question re: difficulties
- (IBAction)childDifficultiesNextFollowUp:(id)sender {
    UIButton *yesMinor = (UIButton *)[self.view viewWithTag:3502];
    UIButton *yesDefinite = (UIButton *)[self.view viewWithTag:3503];
    UIButton *yesSevere = (UIButton *)[self.view viewWithTag:3504];
    UIButton *noDifficulties = (UIButton *)[self.view viewWithTag:3501];
    
    if(([yesMinor isSelected]==YES || [yesDefinite isSelected]==YES || [yesSevere isSelected]==YES)){
        [self performSegueWithIdentifier:@"yesDifficultiesFollowUp" sender:self];
    } else if([noDifficulties isSelected]==YES){
        [self performSegueWithIdentifier:@"noDifficultiesFollowUp" sender:self];
    }
}

//Handler to continue with additional YR1a survey questions if yes is answered to question re: difficulties
- (IBAction)childDifficultiesNextYR1a:(id)sender {
    UIButton *yesMinor = (UIButton *)[self.view viewWithTag:4602];
    UIButton *yesDefinite = (UIButton *)[self.view viewWithTag:4603];
    UIButton *yesSevere = (UIButton *)[self.view viewWithTag:4604];
    UIButton *noDifficulties = (UIButton *)[self.view viewWithTag:4601];
    
    if(([yesMinor isSelected]==YES || [yesDefinite isSelected]==YES || [yesSevere isSelected]==YES)){
        [self performSegueWithIdentifier:@"yesDifficultiesYR1a" sender:self];
    } else if([noDifficulties isSelected]==YES){
        [self performSegueWithIdentifier:@"noDifficultiesYR1a" sender:self];
    }
}

//event handler for when answer button is pressed only highlights the latest selected answer button.
- (void)buttonClicked:(UIButton *)sender {
    
    //enable the next button since an answer has been selected
    UIButton * next = (UIButton *)[self.view viewWithTag:998];
    next.enabled = YES;
    
    UIButton *button = (UIButton *)sender;
    
    //logic to allow for mutually exclusive answer buttons within a question
    if([button isSelected]==YES) {
        [button setSelected:YES];
    } else {
        int round = ((button.tag / 100) * 100) + 1;
        for(int i = round; i < (round + 6); i++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:i];
            [temp setSelected:NO];
        }
        [button setSelected:YES];
    }
    
    //call the answer action at the same time as an answer is selected
    [self answer:sender];
}

//handler to bring view back to the main menu
- (void)goToMainMenu{
    [self dismissModalViewControllerAnimated:YES];
}

// handler to create the answer file as a .txt file. File name is in format of 'survey name'-'researchers name'-'child's unique ID'
- (IBAction)createFile:(id)sender {
    
    //get the name of the survey selected
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    
    //create a file manager
    fm = [NSFileManager defaultManager];
    
    //create the filepath for both files
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *hiddenPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    NSString *hiddenDirectory = [hiddenPaths objectAtIndex:0];
    filePath = [docDir stringByAppendingPathComponent: [NSString stringWithFormat:@"%@-%@-%@", buttonTitle, researcherNameString, kidsIDString]];
    hiddenFilePath = [hiddenDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@-%@-%@", buttonTitle, researcherNameString, kidsIDString]];
    
    //create the answer file
    [fm createFileAtPath:filePath contents:nil attributes:nil];
    [fm createFileAtPath:hiddenFilePath contents:nil attributes:nil];
    NSLog(@"file created at: %@",docDir);
    NSLog(@"hidden file created at: %@",hiddenDirectory);
    
    //Survey List change
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *survey = [NSEntityDescription insertNewObjectForEntityForName:@"Survey" inManagedObjectContext:context];
    [survey setValue:researcherNameString forKey:@"researcher_name"];
    [survey setValue:kidsNameString forKey:@"kid_name"];
    [survey setValue:kidsID forKey:@"kid_id"];
    [survey setValue:false forKey:@"uploaded"];
    [survey setValue:[NSString stringWithFormat:@"%@-%@-%@", buttonTitle, researcherNameString, kidsIDString] forKey:@"file_name"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"Kids list updated successfully!");
    }

    
}

// handler to save identifying info entered by staff at start of new survey
- (IBAction)saveInfo:(id)sender {
    researcherNameString = researcherName.text;
    kidsIDString = kidsID.text;
    kidsNameString = kidsName.text;
}

//handler to ensure all text fields are nonempty before allowing user to move on
- (IBAction)infoEntered:(id)sender {
    UIButton * next = (UIButton *)[self.view viewWithTag:998];
    if(![researcherName.text isEqual: @""] && ![kidsName.text isEqual: @""] && ![kidsID.text isEqual: @""]){
        next.enabled = YES;
    } else {
        next.enabled = NO;
    }
}

//handler to save contents of comments textfield after view is changed
- (IBAction)saveComments:(id)sender {
    commentsString = comments.text;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
@end
