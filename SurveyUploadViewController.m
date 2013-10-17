//
//  SurveyUploadViewController.m
//  iPad-YOU-Pad
//
//  Created by Pangpang.i.Lily on 13-10-6.
//  Copyright (c) 2013年 Andrew Edwards. All rights reserved.
//

#import "SurveyUploadViewController.h"
#import "AppDelegate.h"


@interface SurveyUploadViewController ()

@end

@implementation SurveyUploadViewController

NSMutableData *responseData;

@synthesize survey;

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
    
    
    UIColor * circleColorPattern = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg.jpg"]];
    [self.view setBackgroundColor:circleColorPattern];
	// Do any additional setup after loading the view.
    self.fileName.text = survey.file_name;
    self.kidName.text = survey.kid_name;
    self.researcherName.text = survey.researcher_name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response  {
    responseData = [[NSMutableData alloc] init];
    NSLog(@"Responde:%@",response);
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data  {
    
    [responseData appendData:data];
    NSLog(@"%@",data);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.message setText:@"Unable to fetch data"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection  {
    
    NSError *error;
    NSDictionary *loginResult = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingMutableLeaves error:&error];
    NSNumber *status = [loginResult objectForKey:@"status"];
    NSString *msg = [loginResult objectForKey:@"message"];
    if(status.intValue == 1){
        
        survey.uploaded = [NSNumber numberWithBool:YES] ;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"surveyUploaded" object:self];
        
        //NSLog(@"Core data?");
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else{
        [self.message setText:msg];
    }
    
    
    
    [self.activity stopAnimating];
    //NSLog(@"Completed connection:%@",connection);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

- (IBAction)upload:(id)sender {
    
    [self.message setTextColor:[UIColor redColor]];
    
    //Get the user default data(email & pwd)
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSObject * email = [userDefaults objectForKey:@"email"];
    NSObject * password = [userDefaults objectForKey:@"password"];
    NSObject * website = [userDefaults objectForKey:@"website"];
    
    if(email == nil || password == nil || website == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Don't panic. Please put in your email and password in setting panel."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    
    else{
        
        
        if([[userDefaults stringForKey:@"website"] isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Don't panic. Please put in website in setting panel."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
            [alert show];
        }else{
            NSURL *myURL = [NSURL URLWithString:[userDefaults stringForKey:@"website"]];
            
            // Create the request.
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
            
            //All stuff need for setting the form
            NSString *boundary = @"----------V2ymHFg03ehbqgZCaKO6jy";
            // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
            NSString* FileParamConstant = @"file";
            NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
            [_params setObject:@"1.0" forKey:@"ver"];
            [_params setObject:@"en" forKey:@"lan"];
            [_params setObject:[userDefaults stringForKey:@"email"] forKey:@"email"];
            [_params setObject:[userDefaults stringForKey:@"password"] forKey:@"password"];
            [_params setObject:survey.file_name forKey:@"file_name" ];
            [_params setObject:survey.kid_name forKey:@"kid_name"];
            
            // This is how we set header fields
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            // post body
            NSMutableData *body = [NSMutableData data];
            
            for (NSString *param in _params) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            
            // Find the library path in app
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *libraryDirectory = [paths objectAtIndex:0];
            NSString *filePath = [libraryDirectory stringByAppendingPathComponent: survey.file_name];
            
            // add txt data
            NSData *txtData = [NSData dataWithContentsOfFile:filePath];
            //NSData *imageData = UIImageJPEGRepresentation(imageToPost, 1.0);
            if (txtData) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,survey.file_name ] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: text/plain\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:txtData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            /*
             // Convert your data and set your request's HTTPBody property
             NSString *stringData = [NSString stringWithFormat:@"email=%@&password=%@",[userDefaults stringForKey:@"email"],[userDefaults stringForKey:@"password"]];
             NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
             [request setHTTPBody:requestBodyData];
             */
            
            
            
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // setting the body of the post to the reqeust
            [request setHTTPBody:body];
            
            // set the content-length
            NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            // Specify that it will be a POST request
            [request setHTTPMethod:@"POST"];
            
            // Create url connection and fire request
            //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            
            [NSURLConnection connectionWithRequest:request delegate:self];
            
            // Network indicator
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [self.activity startAnimating];
        }
    }
    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
