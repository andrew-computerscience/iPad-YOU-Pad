//
//  Teachers0ViewController.m
//  iPad-YOU-Pad
//
//  Created by Yuki Robson & Nicolas La Verghetta
//  Copyright (c) 2013 Andrew Edwards. All rights reserved.
//

#import "Teachers0ViewController.h"
#import "TeachersMenuViewController.h"


int checkBox[8][8];
bool firstStartup[8];
int page = 0;

@interface Teachers0ViewController ()


@end

@implementation Teachers0ViewController

@synthesize nextButton;

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
    nextButton.enabled = NO;
    nextButton.alpha = 0.3;
    NSLog(@"hi1");
    if(firstStartup[0])
    {
        firstStartup[0] = FALSE;
        for(int i = 0; i < 8; i++) {
            checkBox[i][page] = 0;
        }
        NSLog(@"hi");
        fm = [NSFileManager defaultManager];
        
        //create the filepath
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docDir = [paths objectAtIndex:0];
        filePath = [docDir stringByAppendingPathComponent:@"answers.txt"];
        //create the answer file
        [fm createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    for(int i = 0; i < 10000; i+=100){
        for(int j = 1; j < 4; j++){
            UIButton * temp = (UIButton *)[self.view viewWithTag:(i+j)];
            [temp setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [temp addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //check if already answered checkBox
    for(int i = 0; i < 8; i++)
    {
        NSLog(@"%d",checkBox[i][page]);
        if(checkBox[i][page] != 0)
        {
            int temp = checkBox[i][page]+((i+1)*100); //get correct checkbox tag
            NSLog(@"checkbox %d",temp);
            UIButton *tempButton = (UIButton *)[self.view viewWithTag:(temp)];
            [tempButton setBackgroundImage:[UIImage imageNamed:@"Very-Basic-Checked-checkbox-icon.png"] forState:UIControlStateSelected];
            [tempButton setSelected:YES];
                                            
        }
    }
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
    for(int i = 0; i < 8; i+=1)
    {
        if(checkBox[i][page] <=0)
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
    for(int i = 0; i < 8; i++)
    {
        NSLog(@"%d",checkBox[i][page]);
    }
    
}


- (void)buttonClicked:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    
    if([button isSelected]==YES) {
        [button setSelected:YES];
    } else {
        int checkBoxRow = button.tag/100 - 1;
        checkBox[checkBoxRow][page] = button.tag%100;
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
