//
//  ViewController.m
//  FreeWilder
//
//  Created by Koustov Basu on 01/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import "ViewController.h"

#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "DashboardViewController.h"
#import "LocalizeHelper.h"

@interface ViewController ()<UITextFieldDelegate,UIAlertViewDelegate>


{
    NSMutableArray *contactList;
    AppDelegate *appDelegate;
    FW_JsonClass *globalobj;
    
    NSString *user_id;
    
    NSString *countryCode,*tzName;
    
}


@property (strong, nonatomic) IBOutlet UITextField *email;


@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic)NSMutableArray *jsonResult;

@property(nonatomic,strong)UISegmentedControl *segControl;

@end

@implementation ViewController

@synthesize email,password,lbldontHaveAccount,lblFacebook,lblLogin,btnSignUp,btnForgetPassword,btnlogin;

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//
//}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
    
    NSString *currentLang=[userData objectForKey:@"language"];
    
    NSLog(@"Current lang----> %@",currentLang);
    
    if(![currentLang isKindOfClass:[NSString class]])
    {
        LocalizationSetLanguage(@"en");
        
    }
    else
    {
        LocalizationSetLanguage(currentLang);
        
    }
    
    
    NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"LanguageTable"];
    fetchRequest.predicate=[NSPredicate predicateWithFormat:@"langId== %@",currentLang];
    
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSArray *fetchedObjects1 = [theContext executeFetchRequest:fetchRequest error:nil];
    
    
    for(NSManagedObject *obj in fetchedObjects1)
    {
        
        NSLog(@"Lang table... %@", [NSKeyedUnarchiver unarchiveObjectWithData:[obj valueForKey:@"langDic"] ]);
        
        appDelegate.currentLangDic=(NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:[obj valueForKey:@"langDic"] ];
        
    }
    
    
    
    NSLocale *locale = [NSLocale currentLocale];
    countryCode = [locale objectForKey: NSLocaleCountryCode];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    tzName = [timeZone name];
    
    
    
    
    email.keyboardAppearance = UIKeyboardAppearanceAlert;
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    
    password.keyboardAppearance = UIKeyboardAppearanceAlert;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
    globalobj=[[FW_JsonClass alloc]init];
    _jsonResult = [[NSMutableArray alloc]init];
    forgotArray = [[NSMutableArray alloc]init];
    
    email.placeholder=@"Email";
    password.placeholder=@"Password";
    lblLogin.text=[appDelegate.currentLangDic valueForKey:@"Log_in_with_your"];//LocalizedString(@"Log_in_with_your");
    lblLogin.adjustsFontSizeToFitWidth=YES;
    lblFacebook.text=@"Facebook";
    lbldontHaveAccount.text=[appDelegate.currentLangDic valueForKey:@"Dnt_hv_acnt"];//LocalizedString(@"Dnt_hv_acnt");
    
    //    [btnSignUp setTitle:LocalizedString(@"sign_up") forState:UIControlStateNormal];
    //    [btnForgetPassword setTitle:LocalizedString(@"Frgt_pass") forState:UIControlStateNormal];
    //    [btnlogin setTitle:LocalizedString(@"LOG_IN") forState:UIControlStateNormal];
    
    
    [btnSignUp setTitle:[appDelegate.currentLangDic valueForKey:@"sign_up"] forState:UIControlStateNormal];
    [btnForgetPassword setTitle:[appDelegate.currentLangDic valueForKey:@"Frgt_pass"] forState:UIControlStateNormal];
    [btnlogin setTitle:[appDelegate.currentLangDic valueForKey:@"LOG_IN"] forState:UIControlStateNormal];
    
    
    
}


//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//
//    [locationManager stopUpdatingLocation];
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
//    CLLocation *currentLocation=[locations lastObject];//newLocation;
//
//    NSLog(@"NewLocation %f %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
//
//    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
//     {
//         if (!(error))
//         {
//             CLPlacemark *placemark = [placemarks objectAtIndex:0];
//             NSLog(@"\nCurrent Location Detected\n");
//             NSLog(@"placemark %@",placemark);
//             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//             NSString *Address = [[NSString alloc]initWithString:locatedAt];
//             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
//             NSString *Country = [[NSString alloc]initWithString:placemark.country];
//             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
//             NSLog(@"%@",CountryArea);
//
//             NSLog(@"My country is----> %@",placemark.country);
//             NSLog(@"My address is----> %@",Address);
//         }
//         else
//         {
//             NSLog(@"Geocode failed with error %@", error);
//             NSLog(@"\nCurrent Location Not Detected\n");
//
//         }
//
//    }];
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    email.keyboardAppearance = UIKeyboardAppearanceAlert;
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if([textField isEqual:email])
    {
        textField.keyboardType=UIKeyboardTypeEmailAddress;
        
        [UIView animateWithDuration:0.8 animations:^{
            
            
            // CGRect mainFrame=self.view.frame;
            
            if([[UIScreen mainScreen] bounds].size.height==568)
            {
                
                CGRect tempFrame=CGRectMake(0, -75, self.view.bounds.size.width, self.view.bounds.size.height);
                
                self.view.frame=tempFrame;
                
                
            }
            
            else  if([[UIScreen mainScreen] bounds].size.height==667)
            {
                
                CGRect tempFrame=CGRectMake(0, -55, self.view.bounds.size.width, self.view.bounds.size.height);
                
                self.view.frame=tempFrame;
            }
            
            else  if([[UIScreen mainScreen] bounds].size.height==736)
            {
                
                CGRect tempFrame=CGRectMake(0, -55, self.view.bounds.size.width, self.view.bounds.size.height);
                
                self.view.frame=tempFrame;
            }
            
            
            
            
            
            
            
        }];
    }
    
    else if ([textField isEqual:password])
    {
        
        
        [UIView animateWithDuration:0.8 animations:^{
            
            
            if([[UIScreen mainScreen] bounds].size.height==568)
            {
                
                CGRect tempFrame=CGRectMake(0, -75, self.view.bounds.size.width, self.view.bounds.size.height);
                
                self.view.frame=tempFrame;
                
                
            }
            
            else  if([[UIScreen mainScreen] bounds].size.height==667)
            {
                
                CGRect tempFrame=CGRectMake(0, -55, self.view.bounds.size.width, self.view.bounds.size.height);
                
                self.view.frame=tempFrame;
            }
            
            else  if([[UIScreen mainScreen] bounds].size.height==736)
            {
                
                CGRect tempFrame=CGRectMake(0, -55, self.view.bounds.size.width, self.view.bounds.size.height);
                
                self.view.frame=tempFrame;
            }
            
            
            
        }];
        
        
        
    }
    
    
    textField.inputAccessoryView = [self keyboardToolBar];
    
    if([textField isEqual:email])
    {
        
        [self.segControl setEnabled:NO forSegmentAtIndex:0];
        
        
    }
    
    else     if([textField isEqual:password])
    {
        
        [self.segControl setEnabled:NO forSegmentAtIndex:1];
        
        
    }
    
    
    
}


- (UIToolbar *)keyboardToolBar {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"Previous", @"Next"]];
    
    //[self.segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    self.segControl.momentary = YES;
    
    [self.segControl addTarget:self action:@selector(changeRow:) forControlEvents:(UIControlEventValueChanged)];
    
    //    [self.segControl setEnabled:NO forSegmentAtIndex:0];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithCustomView:self.segControl];
    
    NSArray *itemsArray = @[nextButton];
    
    [toolbar setItems:itemsArray];
    
    return toolbar;
}



- (void)changeRow:(id)sender {
    
    int idx = (int)[sender selectedSegmentIndex];
    
    if (idx==1) {
        //self.topText.text = @"Top one";
        [self.password becomeFirstResponder];
    }
    else if(idx==0){
        // self.bottomText.text =@"Bottom one";
        [self.email becomeFirstResponder];
    }
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
        
        CGRect mainFrame=self.view.frame;
        
        CGRect tempFrame=mainFrame;
        
        tempFrame.origin.y=0;
        
        self.view.frame=tempFrame;
        
        [textField resignFirstResponder];
        
        
    }];
    
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login_button:(id)sender
{
    if([email.text length]==0 && [password.text length]==0)
    {
        
        email.placeholder=@"Enter email id";
        
        password.placeholder=@"Enter valid password";
        
        
    }
    else   if([email.text length]==0 && [password.text length]>0)
    {
        
        email.placeholder=@"Enter email id";
        
        //  password.placeholder=@"Enter valid password";
        
        
    }
    
    else   if([email.text length]>0 && [password.text length]==0)
    {
        
        // email.placeholder=@"Enter email id";
        
        password.placeholder=@"Enter valid password";
        
        
    }
    
    
    
    else   if([email.text length]>0 && [password.text length]>0)
    {
        
        NSString *urlstring=[NSString stringWithFormat:@"%@verify_app_login?email=%@&password=%@&timezone=%@&country_id=%@",App_Domain_Url,[email.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[password.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],tzName,countryCode];
        BOOL net=[globalobj connectedToNetwork];
        if (net==YES)
        {
            [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
                
                
                
                
                
                NSLog(@"jsonResult... : %@",result);
                
                
                
                
                if([[result valueForKey:@"response" ] isEqualToString:@"success"])
                    
                {
                    user_id = [result valueForKey:@"site_user_id"];
                    
                    [[NSUserDefaults standardUserDefaults]setValue:[result valueForKey:@"ios_curncyid"] forKey:@"curr_id"];
                    
                    
                    NSString *url = [NSString stringWithFormat:@"%@app_edit_profile?userid=%@",App_Domain_Url,user_id];
                    
                    
                    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
                     {
                         
                         _jsonResult=[[result valueForKey:@"inforarray"] mutableCopy];
                         
                         if ([[result valueForKey:@"response" ] isEqualToString:@"success"])
                         {
                             
                             
                             
                             NSLog(@"jsonResult2... : %@",_jsonResult);
                             
                             [[NSUserDefaults standardUserDefaults] setObject:user_id  forKey:@"UserId"];
                             [[NSUserDefaults standardUserDefaults] setObject:[_jsonResult valueForKey:@"name"]  forKey:@"UserName"];
                             [[NSUserDefaults standardUserDefaults] setObject:[_jsonResult valueForKey:@"prof_image"]  forKey:@"UserImage"];
                             [[NSUserDefaults standardUserDefaults] setObject:[_jsonResult valueForKey:@"email"]  forKey:@"email"];
                             
                             
                             [[NSUserDefaults standardUserDefaults] setObject:[_jsonResult valueForKey:@"phone_no"]  forKey:@"phone_no"];
                             
                             
                             [[NSUserDefaults standardUserDefaults] setObject:@"en"  forKey:@"lang_code"];
                             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"3"]  forKey:@"curr_id"];
                             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"Logged in"] forKey:@"logInCheck"];
                             
                             
                             
                             DashboardViewController   *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
                             [self.navigationController pushViewController:obj animated:YES];
                             
                             
                         }
                         
                         
                         
                         
                     }];
                    
                    
                    
                    
                }
                else
                {
                    
                    UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[result valueForKey:@"message" ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [loginAlert show];
                    
                }
                
                
            }];
        }
        else{
            
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
        }
        
        
    }
    
    
    //    ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
    //    [self.navigationController pushViewController:obj animated:YES];
    
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//
//
//    if(buttonIndex==0)
//    {
//        email.text=@"";
//
//        password.text=@"";
//
//    }
//
//}



- (IBAction)sign_up:(id)sender
{
    ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"signup_Page"];
    [self.navigationController pushViewController:obj animated:YES];
}


- (IBAction)forgot_Password:(id)sender
{
    
    //    NSString *urlForgot=[NSString stringWithFormat:@"%@verify_app_forgot?email=%@",App_Domain_Url,forgot_Password.text];
    //     [globalobj GlobalDict:urlForgot Globalstr:@"array" Withblock:^(id result, NSError *error) {
    //    
    //         forgotArray = [result mutableCopy];
    //         NSLog(@"ForgotArray%@",forgotArray);
    //         
    //         
    //    }];
    
    
    ForgotpasswordViewController *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"forgotpwd"];
    [self.navigationController pushViewController:obj1 animated:YES];
    
    
    
    
}








- (IBAction)fbLogIn:(id)sender
{
    
    
    if ([FBSession activeSession].state != FBSessionStateOpen &&
        [FBSession activeSession].state != FBSessionStateOpenTokenExtended )
        
        
    {
        //[self UserInformation];
        
        NSLog(@"Facebook logging in....");
        
        AppDelegate *app=[[UIApplication sharedApplication]delegate];
        
        [app openActiveSessionWithPermissions:@[@"public_profile", @"email", @"user_birthday"] allowLoginUI:YES];
        
        
        
    }
    
    
    
    
}



@end
