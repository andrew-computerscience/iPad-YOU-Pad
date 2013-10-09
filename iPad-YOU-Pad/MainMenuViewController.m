//
//  ViewController.m
//  iPad-YOU-Pad
//
//  Created by Andrew Edwards on 2/10/13.
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "MainMenuViewController.h"

int pin = 1968;

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

#pragma mark - UITextField Delegate

//handler so when user presses return on keyboard, runs checkPin action
- (BOOL)textFieldShouldReturn:(UITextField *)pinField {
    [self checkPin:self];
    return true;
}

-(void)goToSettings{
    UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *initialSettingsVC = [settingsStoryboard instantiateInitialViewController];
    initialSettingsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:initialSettingsVC animated:YES];
}

- (IBAction)checkPin:(id)sender {
    if(pin == [pinField.text intValue]){
        pinField.text = @"";
        [self performSegueWithIdentifier:@"pinCorrect" sender:self];
    }
}

- (IBAction)lock:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)goToKidsSurveys{
    UIStoryboard *kidsStoryboard = [UIStoryboard storyboardWithName:@"KidsSurveys" bundle:nil];
    UIViewController *initialKidsVC = [kidsStoryboard instantiateInitialViewController];
    initialKidsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:initialKidsVC animated:YES];
}

-(void)goToParentsSurveys{
    UIStoryboard *parentsStoryboard = [UIStoryboard storyboardWithName:@"ParentsSurveys" bundle:nil];
    UIViewController *initialParentsVC = [parentsStoryboard instantiateInitialViewController];
    initialParentsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:initialParentsVC animated:YES];
}

-(void)goToEducatorsSurveys{
    UIStoryboard *educatorsStoryboard = [UIStoryboard storyboardWithName:@"EducatorsSurveys" bundle:nil];
    UIViewController *initialEducatorsVC = [educatorsStoryboard instantiateInitialViewController];
    initialEducatorsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:initialEducatorsVC animated:YES];
}

-(void)goToCompletedSurveys{
    UIStoryboard *completedStoryboard = [UIStoryboard storyboardWithName:@"CompletedSurveys" bundle:nil];
    UIViewController *initialCompletedVC = [completedStoryboard instantiateInitialViewController];
    initialCompletedVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:initialCompletedVC animated:YES];
}


- (void)viewDidLoad
{
    pinField.keyboardType = UIKeyboardTypeNumberPad;
    UIColor * circleColorPattern = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg.jpg"]];
    [self.view setBackgroundColor:circleColorPattern];
    
    pinField.delegate = self;
    pinField.secureTextEntry = YES;
    
    [super viewDidLoad];
    
    
    
    //UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //imageView.image = [[UIImage imageNamed:@"bg.jpg"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    //[self.view addSubview:imageView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
