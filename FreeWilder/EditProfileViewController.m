//
//  EditProfileViewController.m
//  FreeWilder
//
//  Created by Rahul Singha Roy on 01/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Footer.h"
#import "Side_menu.h"
#import <FacebookSDK/FacebookSDK.h>
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "AppDelegate.h"
#import "ServiceView.h"
#import "accountsubview.h"
#import "LanguageViewController.h"
#import "notificationsettingsViewController.h"
#import "ChangePassword.h"
#import "UserService.h"
#import "MyBooking & Request.h"
#import "userBookingandRequestViewController.h"
#import "myfavouriteViewController.h"
#import "SettingsViewController.h"

#import "PaymentMethodViewController.h"
#import "PrivacyViewController.h"
#import "Business Information ViewController.h"
#import "WishlistViewController.h"
#import "profile.h"
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "ViewController.h"
#import "BusinessProfileViewController.h"
#import "sideMenu.h"


@interface EditProfileViewController ()<footerdelegate,UIActionSheetDelegate,accountsubviewdelegate,UIImagePickerControllerDelegate,Serviceview_delegate,Profile_delegate,UIGestureRecognizerDelegate,sideMenu>
{
    
    sideMenu *leftMenu;
    
    AppDelegate *appDelegate;
    ServiceView *service;
    BOOL tapchk,tapchk1,tapchk2;
    accountsubview *subview;
    __weak IBOutlet UIImageView *topbar;
    __weak IBOutlet UIButton *btckbtn;
    __weak IBOutlet UILabel *hdrlbl;
    
    profile *profileview;
    
    UIView *popview ,*blackview;
    
    NSMutableArray *jsonArray,*imagelinkArray ,*country_idArray;
    NSString *userid,*phoneno;
    UITextField *phoneText;
    NSString *country_id;
    
    NSMutableArray *stateArray,*stateid_Array;
    NSString *stateName,*state_id;
    
    int done;
    
}

@end

@implementation EditProfileViewController
@synthesize txtEmail,txtUserName,txtPhone,lblUserName,ProfileImg,mainscroll,lblPagetitle,btnSave;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here

    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        _footer_base.frame = CGRectMake(0, 520, 320, 48);
        
        mainscroll.frame = CGRectMake(0, 81, 320, 438);
        
    }
    else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        topbar.frame = CGRectMake(0, 0, 375, 60);
         mainscroll.frame = CGRectMake(0, 60, 375, 550);
        btckbtn.frame=CGRectMake(0, 0, 96, 60);
        hdrlbl.frame=CGRectMake(118, 32, 136, 22);
    }
    
    else if (screenBounds.size.height ==736  && screenBounds.size.width == 414)
    {
        _footer_base.frame = CGRectMake(0, 674, 414, 62);
        topbar.frame = CGRectMake(0, 0, 414, 106);
        btckbtn.frame=CGRectMake(0, 13, 76, 90);
        hdrlbl.frame=CGRectMake(135, 35, 136, 46);
        mainscroll.frame = CGRectMake(0, 106, 414, 568);
    }

    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    /// initializing app footer view
    
    mainscroll.contentSize=CGSizeMake(0,1400+50);
    
    pview.hidden=YES;
    pview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
    shortdescriptiontextview.autocorrectionType = UITextAutocorrectionTypeNo;
    /*  if (self.view.frame.size.width==320)
     {
     mainscroll.contentSize=CGSizeMake(0,441);
     }
     else
     {
     mainscroll.contentSize=CGSizeMake(0,500);
     }
     */
    
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
    footer.Delegate=self;
    [_footer_base addSubview:footer];
    
    stateArray = [[NSMutableArray alloc]init];
    stateid_Array =[[NSMutableArray alloc]init];
    
    countryArry=[[NSMutableArray alloc]init];
    country_idArray =[[NSMutableArray alloc]init];
    
    /// Getting side from Xib & creating a black overlay
    
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    overlay.hidden=YES;
//    overlay.userInteractionEnabled=YES;
//    [self.view addSubview:overlay];
//    
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
//    tapGesture.numberOfTapsRequired=1;
//    [overlay addGestureRecognizer:tapGesture];
    
    
    
    sidemenu=[[Side_menu alloc]init];
    
   // CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        
        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
        
        sidemenu.ProfileImage.frame = CGRectMake(46, 26, 77, 77);
        
        [sidemenu.lblUserName setFont:[UIFont fontWithName:@"Lato" size:16]];
        
        sidemenu.btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.5];
        
        sidemenu.btn5.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn6.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn7.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn8.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.0];
        
        sidemenu.btn9.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        
        
        
        
        
        
    }
    
    else{
        
        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
        
    }
    

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"lang code=%@, curr_id=%@",[prefs valueForKey:@"lang_code"],[prefs valueForKey:@"curr_id"]);
    
    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
    
    NSLog(@"Email-----------> %@",[prefs valueForKey:@"email"]);
    
     NSLog(@"Image-----------> %@",[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]);
    
    emaillbl.text=[prefs valueForKey:@"email"];
    
    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    //   sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
    sidemenu.hidden=YES;
    sidemenu.SlideDelegate=self;
    [self.view addSubview:sidemenu];
    
    globalobj=[[FW_JsonClass alloc]init];
    urlobj=[[UrlconnectionObject alloc]init];
    UserId=[prefs valueForKey:@"UserId"];
    //  NSLog(@"userid=%@",UserId);
    
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    lblPagetitle.text=@"Edit Profile";
    
    //done button on numeric keyboard
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar.barStyle=UIBarStyleDefault;
    //    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //    // Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resetView)];
    //    // Add buttons to the toolbar
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    // Set the toolbar as accessory view of an UITextField object
    txtPhone.inputAccessoryView = toolbar;
    
    if (countrylbl.text.length==0)
        
    {
        
        [countrybtn setTitle:@"Country" forState:normal];
        
    }
    
    else
        
    {
        
        [countrybtn setTitle:@"" forState:normal];
        
    }
    
    
   

    

    
    [self ProfileDetailUrl];
    
}
-(void)resetView
{
    [txtPhone resignFirstResponder];
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
}
-(void)ProfileDetailUrl
{
    NSString *urlstring=[NSString stringWithFormat:@"%@app_edit_profile?userid=%@",App_Domain_Url,[UserId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    BOOL net=[globalobj connectedToNetwork];
    if (net==YES)
    {
        [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            
            if([[result valueForKey:@"response"] isEqualToString:@"success"])
                
            {
               

                
                
                
                NSDictionary * detail = [result valueForKey:@"inforarray"];
                NSString *school = [detail valueForKey:@"school"];
                
                NSArray *schoolname = [school componentsSeparatedByString:@","];
                
                
                NSString *language = [detail valueForKey:@"language"];
                
                emaillbl.text = [detail valueForKey:@"email"];
                txtUserName.text = [detail valueForKey:@"name"];
                countrylbl.text = [detail valueForKey:@"country"];
                
                
                
                
                if (countrylbl.text.length>0)
                {
                    [countrybtn setTitle:@"" forState:UIControlStateNormal];
                    
                    countrylbl.textColor = [UIColor blackColor];
                }
                
                statelbl.text = [detail valueForKey:@"state"];
                
                
                if (statelbl.text.length>0)
                {
                     [stateBtn setTitle:@"" forState:UIControlStateNormal];
                   
                    statelbl.textColor=[UIColor blackColor];
                    
                }
                citytxt.text = [detail valueForKey:@"city"];
                phonenotxt.text = [detail valueForKey:@"phone_no"];
                worktxt.text=[detail valueForKey:@"work"];
                
                
                
                                
                if (schoolname.count>0)
                {
                    if (schoolname.count==1)
                    {
                        schoolname1txt.text = [schoolname objectAtIndex:0];
                    }
                    
                    else if (schoolname.count==2)
                    {
                        schoolname1txt.text = [schoolname objectAtIndex:0];
                         schoolname2txt.text =[schoolname objectAtIndex:1];
                    }
                    
                    else if (schoolname.count==3)
                    {
                        schoolname1txt.text = [schoolname objectAtIndex:0];
                        schoolname2txt.text =[schoolname objectAtIndex:1];
                        schoolname3txt.text =[schoolname objectAtIndex:2];
                    }
                    
                    else if (schoolname.count==4)
                    {
                        schoolname1txt.text = [schoolname objectAtIndex:0];
                        schoolname2txt.text =[schoolname objectAtIndex:1];
                        schoolname3txt.text =[schoolname objectAtIndex:2];
                        schoolname4txt.text =[schoolname objectAtIndex:3];
                    }
                    
                    else if (schoolname.count==5)
                    {
                        schoolname1txt.text = [schoolname objectAtIndex:0];
                        schoolname2txt.text =[schoolname objectAtIndex:1];
                        schoolname3txt.text =[schoolname objectAtIndex:2];
                        schoolname4txt.text =[schoolname objectAtIndex:3];
                        schoolname5txt.text =[schoolname objectAtIndex:4];
                    }

                    
                }
                
                
                 NSArray *languageArray = [language componentsSeparatedByString:@","];
                
               
                if (languageArray.count>0)
                {
                    if (languageArray.count==1)
                    {
                        language1txt.text = [languageArray objectAtIndex:0];
                    }
                    
                    else if (languageArray.count==2)
                    {
                        language1txt.text = [languageArray objectAtIndex:0];
                        language2txt.text =[languageArray objectAtIndex:1];
                    }
                    
                    else if (languageArray.count==3)
                    {
                        language1txt.text = [languageArray objectAtIndex:0];
                        language2txt.text =[languageArray objectAtIndex:1];
                        language3txt.text =[languageArray objectAtIndex:2];
                    }
                    
                    else if (languageArray.count==4)
                    {
                        language1txt.text = [languageArray objectAtIndex:0];
                        language2txt.text =[languageArray objectAtIndex:1];
                        language3txt.text =[languageArray objectAtIndex:2];
                        language4txt.text =[languageArray objectAtIndex:3];
                    }
                    
                    
                    
                }

                
                
               
                
                
                
                dateofbirthlbl.text = [detail valueForKey:@"date_of_birth"];
                shortdescriptiontextview.text = [detail valueForKey:@"short_desc"];
                
                if (shortdescriptiontextview.text.length>0)
                {
                    shortdeclbl.hidden=YES;
                }
                
                
                
                
                
                
                country_id =  [detail valueForKey:@"country_id"];
                state_id =  [detail valueForKey:@"state_id"];

                
                
                
                
                
                
            }
            else
            {
                
                UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[result valueForKey:@"message" ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [loginAlert show];
                
            }
            
            
           
            
            
            NSString *url = [NSString stringWithFormat:@"%@app_photo_video?userid=%@",App_Domain_Url,UserId];
            
            NSLog(@"url----%@",url);
            
            [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 
                 if ([[result valueForKey:@"response"] isEqualToString:@"success"])
                 {
                     imagelinkArray = [[NSMutableArray alloc]init];
                     
                     imagelinkArray = [result valueForKey:@"infoarray"];
                     NSLog(@"image link====%@",imagelinkArray);
                     
                     
                     
                     if (imagelinkArray.count>0)
                     {
                         
                         
                         [ProfileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"demo_image"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];

                         
                         
                         
                         //[ProfileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagelinkArray [0] valueForKey:@"link"]]]];
                     
                     
                         ProfileImg.contentMode=UIViewContentModeScaleAspectFill;
                         ProfileImg.clipsToBounds = YES;
                         ProfileImg.layer.cornerRadius = ProfileImg.frame.size.width/2;
                     
                     
                     }
                     
                     
                 }
                 
                 NSLog(@"Image Array===%@",imagelinkArray);
                 
            
             
             
             
                 if (stateArray.count==0)
                 {
                     
                     
                     
                     NSString *curl =[NSString stringWithFormat:@"%@app_user_service/app_state?country_id=%@",App_Domain_Url,country_id];
                     
                     
                     // countrylbl.text=@"Loading Country.....";
                     [globalobj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
                      {
                          if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                          {
                              NSMutableArray *temp = [[result valueForKey:@"infoarray"] mutableCopy];
                              
                              if (temp.count>0)
                              {
                                  state_id = [[temp objectAtIndex:0]valueForKey:@"state_id"];
                                  stateName = [[temp objectAtIndex:0]valueForKey:@"state_name"];
                              }
                              
                              
                              
                              for (int i= 0; i<temp.count; i++)
                              {
                                  NSString *stateid  = [[temp objectAtIndex:i]valueForKey:@"state_id"];
                                  NSString *statename = [[temp objectAtIndex:i]valueForKey:@"state_name"];
                                  
                                  
                                  [stateid_Array insertObject:stateid atIndex:i];
                                  [stateArray insertObject:statename atIndex:i];
                              }
                              
                              
                              
                              
                          }
                          
                      }];
                     
                     
                     
                 }
             
             
             
             
             
             
             
             
             
             }];
            
            
            
            
            
            
            
            
        }];
        
        
        
        
        
    }
    else{
        
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        lblUserName.text=[prefs valueForKey:@"UserName"];
        txtUserName.text=[prefs valueForKey:@"UserName"];
        ProfileImg.userInteractionEnabled=YES;
        
        [ProfileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"demo_image"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        
        ProfileImg.contentMode=UIViewContentModeScaleAspectFill;
        ProfileImg.clipsToBounds = YES;
        ProfileImg.layer.cornerRadius = ProfileImg.frame.size.width/2;
    }
}


//------Side menu methods Starts here

-(void)side
{
    [self.view addSubview:overlay];
    [self.view addSubview:leftMenu];
    
}


-(void)sideMenuAction:(int)tag
{
    
    NSLog(@"You have tapped menu %d",tag);
    
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    
    if(tag==0)
    {
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==1)
    {
        // Do Rate App related work here
        
    }
    if(tag==2)
    {
        
        userid=[prefs valueForKey:@"UserId"];
        
        BusinessProfileViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"busniessprofile"];
        
        obj.BusnessUserId = userid;
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==3)
    {
        EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==4)
    {
        Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==5)
    {
        
        blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [blackview addGestureRecognizer:tapGestureRecognize];
        
        
        
        
        popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
        
        
        UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview.bounds.origin.y+10, popview.frame.size.width-20, 40)];
        
        phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, header.frame.size.height+20, popview.frame.size.width-20, 45)];
        phoneText.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
        
        phoneText.delegate=self;
        phoneText.placeholder=@"Enter Phone Number";
        
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        phoneText.leftView = paddingView;
        phoneText.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+100, header.frame.size.height+phoneText.frame.size.height+40, phoneText.frame.size.width-180, 30)];
        
        submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:79/255.0 alpha:1];
        
        submit.layer.cornerRadius = 5;
        
        [submit setTitle:@"Save" forState:UIControlStateNormal];
        // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        phoneText.layer.cornerRadius=5;
        
        header.text = @"Phone Verification";
        
        //  header.backgroundColor = [UIColor redColor];
        
        [header setFont:[UIFont fontWithName:@"Lato" size:16]];
        [phoneText setFont:[UIFont fontWithName:@"Lato" size:14]];
        
        // header.textColor=[UIColor redColor];
        
        header.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:blackview];
        [popview addSubview:header];
        [popview addSubview:submit];
        [popview addSubview:phoneText];
        popview.backgroundColor=[UIColor whiteColor];
        popview.layer.cornerRadius =5;
        
        [self.view addSubview:popview];
        
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            phoneText.text=[prefs valueForKey:@"phone_no"];
            
            
        }];
        
    }
    if(tag==6)
    {
        Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==7)
    {
        
        rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==8)
    {
        Business_Information_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Business"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==9)
    {
        UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==10)
    {
        //Add product---//---service
    }
    if(tag==11)
    {
        
        userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==12)
    {
        MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==13)
    {
        WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==14)
    {
        myfavouriteViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    if(tag==15)
    {
        // Account....
        
    }
    
    if(tag==16)
    {
        LanguageViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"language"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==17)
    {
        // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [self deleteAllEntities:@"ProductList"];
        [self deleteAllEntities:@"WishList"];
        [self deleteAllEntities:@"CategoryFeatureList"];
        [self deleteAllEntities:@"CategoryList"];
        // [self deleteAllEntities:@"ContactList"];
        [self deleteAllEntities:@"ServiceList"];
        
        
        [[FBSession activeSession] closeAndClearTokenInformation];
        
        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        
        [userData removeObjectForKey:@"status"];
        
        [userData removeObjectForKey:@"logInCheck"];
        
        ViewController   *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    
    // accountSubArray=@[@"Notification",@"Payment Method",@"payout Preferences",@"Tansaction History",@"Privacy",@"Security",@"Settings"];
    
    if(tag==50)
    {
        
        notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==51)
    {
        PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==52)
    {
        PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==53)
    {
        NSLog(@"i am from transaction history");
        
        
    }
    if(tag==54)
    {
        PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    if(tag==55)
    {
        ChangePassword *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"changepass"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==56)
    {
        SettingsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    
    
}

-(void)Slide_menu_off
{
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            
                            
                            
                            leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                            
                        }
     
     
     
                     completion:^(BOOL finished)
     
     {
         
         [leftMenu removeFromSuperview];
         [overlay removeFromSuperview];
         
         
         
     }];
    
}

//------Side menu methods end here



//
//-(void)side
//{
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    //    overlay.hidden=YES;
//    //    overlay.userInteractionEnabled=YES;
//    [self.view addSubview:overlay];
//    
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
//    tapGesture.numberOfTapsRequired=1;
//    [overlay addGestureRecognizer:tapGesture];
//    
//    
//    sidemenu=[[Side_menu alloc]init];
//    
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
//        
//    {
//        
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
//        
//        sidemenu.ProfileImage.frame = CGRectMake(46, 26, 77, 77);
//        
//        [sidemenu.lblUserName setFont:[UIFont fontWithName:@"Lato" size:16]];
//        
//        sidemenu.btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.5];
//        
//        sidemenu.btn5.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn6.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn7.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn8.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.0];
//        
//        sidemenu.btn9.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        
//        
//        
//        
//        
//        
//    }
//    
//    else{
//        
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//        
//    }
//    
//    
//    
//    
//    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
//    // sidemenu.hidden=YES;
//    
//    
//    userid=[prefs valueForKey:@"UserId"];
//    
//    NSString *url= [NSString stringWithFormat:@"%@/app_phone_verification?userid=%@",App_Domain_Url,userid];
//    
//    
//    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
//        
//        if ([[result valueForKey:@"response" ]isEqualToString:@"success"])
//        {
//            jsonArray = [result valueForKey:@"infoarray"];
//            
//            phoneno = [jsonArray [0]valueForKey:@"phone_no"];
//            
//        }
//        
//        
//        NSLog(@"phone----%@",phoneno);
//        
//        
//    }];
//
//    
//    
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
//}
//-(void)Slide_menu_off
//{
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    
//    [UIView animateWithDuration:.4 animations:^{
//        
//        
//        
//        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
//        
//        profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//        
//        
//        if(screenBounds.size.width == 320)
//        {
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
//            
//        }
//        else if(screenBounds.size.width == 375)
//        {
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
//        }
//        else
//        {
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
//        }
//        
//        
//        
//        
//    }
//     
//     
//                     completion:^(BOOL finished)
//     {
//         
//         [subview removeFromSuperview];
//         
//         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
//                             options:1 animations:^{
//                                 
//                                 
//                                 
//                                 
//                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//                                 
//                             }
//          
//          
//          
//                          completion:^(BOOL finished)
//          
//          {
//              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//              [service removeFromSuperview];
//              sidemenu.hidden=YES;
//              overlay.hidden=YES;
//              overlay.userInteractionEnabled=NO;
//              
//              
//          }];
//         
//         
//         
//         
//         
//         
//         
//     }];
//    
//    
//}


-(void)btn_action:(UIButton *)sender
{
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    [UIView animateWithDuration:.4 animations:^{
        
        
        
        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
        
        if(screenBounds.size.width == 320)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
            
        }
        else if(screenBounds.size.width == 375)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
        }
        else
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
        }
        
        
        
        
    }
     
     
                     completion:^(BOOL finished)
     {
         
         [subview removeFromSuperview];
         
         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                             options:1 animations:^{
                                 
                                 
                                 
                                 
                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                 
                             }
          
          
          
                          completion:^(BOOL finished)
          
          {
              
              [overlay removeFromSuperview];
              [sidemenu removeFromSuperview];
              
              
              if (sender.tag==0)
              {
                  NSLog(@"0");
                  
                  
                  UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              
              else if (sender.tag==1)
              {
                  NSLog(@"1");
              }
              else if (sender.tag==2)
              {
                  NSLog(@"2");
                  
                  
                  userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              
              else if (sender.tag==3)
              {
                  NSLog(@"3");
                  
                  
                  MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
                  
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
                  
                  
                  
                  
                  
                  
              }
              
              
              
              else if (sender.tag==4)
              {
                  NSLog(@"4");
                  
                  WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              else if (sender.tag==5)
              {
                  NSLog(@"5");
                  
                  
                  myfavouriteViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
                  [self.navigationController pushViewController:obj animated:NO];
                  // [self Slide_menu_off];
                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
              }
              
              
              
              
              
              
              
              
              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
              [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
              
              [service removeFromSuperview];
              [sidemenu removeFromSuperview];
              [overlay removeFromSuperview];
              
              // overlay.userInteractionEnabled=NO;
              
              
          }];
         
         
         
         
         
         
         
     }];
    
    
    
    
    
    
    
    
}


-(void)pushmethod:(UIButton *)sender
{
    
    NSLog(@"Test_mode....%ld",(long)sender.tag);
    tapchk=false;
    tapchk1=false;
    tapchk2=false;
    
    
    
    
    
    if (sender.tag==5)
    {
        [self side];
        
        NSLog(@"Creating side menu.....");
        
        
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                            options:1 animations:^{
                                
                                
                                
                                
                                //                                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                                //                                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                                //                                {
                                //                                    sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
                                //
                                //                                }
                                //                                else
                                //                                {
                                //
                                //                                    sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                //
                                //
                                //                                }
                                
                                leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-leftMenu.frame.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                
                                
                                
                            }
         
                         completion:^(BOOL finished)
         {
             
             // overlay.userInteractionEnabled=YES;
             
             // [service removeFromSuperview];
             
             
             
             
         }];
        
        
        
        
        
        
        
        
        
        
    }
    else if (sender.tag==4)
    {
        
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==3)
    {
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msg_page"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==2)
    {
        
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchProductViewControllersid"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
        else if (sender.tag==1)
        {
            
            DashboardViewController *dashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
            [self PushViewController:dashVC WithAnimation:kCAMediaTimingFunctionEaseIn];
            
        }
    
    
}



-(void)subviewclick:(UIButton *)sender
{
    NSLog(@"tag%ld",(long)sender.tag);
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    [UIView animateWithDuration:.4 animations:^{
        
        
        
        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
        
        if(screenBounds.size.width == 320)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
            
        }
        else if(screenBounds.size.width == 375)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
        }
        else
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
        }
        
        
        
        
    }
     
     
                     completion:^(BOOL finished)
     {
         
         [subview removeFromSuperview];
         
         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                             options:1 animations:^{
                                 
                                 
                                 
                                 
                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                 
                             }
          
          
          
                          completion:^(BOOL finished)
          
          {
              
              if (sender.tag==100) {
                  NSLog(@"i am notification");
                  
                  
                  notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==101)
              {
                  NSLog(@"i am  payment method");
                  
                  
                  
                  
                  PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==102)
              {
                  NSLog(@"i am payout preferences");
                  
                  
                  
                  PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
                  
                  
                  
              }
              else if (sender.tag==103)
              {
                  NSLog(@"i am from transaction history");
              }
              else if (sender.tag==104)
              {
                  NSLog(@"i am from privacy");
                  
                  
                  
                  PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              else if (sender.tag==105)
              {
                  NSLog(@"i am from security");
                  
                  ChangePassword *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"changepass"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
                  
                  
              }
              else if (sender.tag==106)
              {
                  
                  
                  SettingsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              
              
              
              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
              [service removeFromSuperview];
              [sidemenu removeFromSuperview];
              [overlay removeFromSuperview];
              
              //  overlay.userInteractionEnabled=NO;
              
              
          }];
         
         
         
         
         
         
         
     }];
    
    
    
    
    
    
}


-(void)action_method:(UIButton *)sender
{
    NSLog(@"##### test mode...%ld",(long)sender.tag);
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    //[service removeFromSuperview];
    
    if (sender.tag==6)
    {
        
        
        
        if (tapchk==false)
        {
            subview=[[accountsubview alloc] init];
            subview.accountsubviewdelegate=self;
            
            
            
            if(screenBounds.size.width == 320)
            {
                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 210,subview.frame.size.width, subview.frame.size.height)];
            }
            else if(screenBounds.size.width == 375)
            {
                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 300,subview.frame.size.width, subview.frame.size.height)];
            }
            else
            {
                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 320,subview.frame.size.width, subview.frame.size.height)];
            }
            
            
            [overlay addSubview:subview];
            
            
            
            
            [UIView animateWithDuration:.4 animations:^{
                
                service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
                
                
                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
                
                
                [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn6 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
                
                
                if(screenBounds.size.width == 320)
                {
                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 210,subview.frame.size.width, subview.frame.size.height)];
                }
                else if(screenBounds.size.width == 375)
                {
                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 300,subview.frame.size.width, subview.frame.size.height)];
                    
                }
                else
                {
                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 320,subview.frame.size.width, subview.frame.size.height)];
                }
                
                
                
                
                
                
                
            }
             
             
             
                             completion:^(BOOL finished)
             {
                 
                 //  overlay.userInteractionEnabled=YES;
                 // [service removeFromSuperview];
                 
             }];
            
            tapchk=true;
            tapchk1=false;
            tapchk2=false;
        }
        
        
        
        
    }
    
    
    
    else if (sender.tag==5)
    {
        
        //             DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"ServiceListingViewControllersid"];
        //
        //             [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        if (tapchk1==false)
        {
            
            
            
            service = [[ServiceView alloc]init];
            CGRect screenBounds=[[UIScreen mainScreen] bounds];
            if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            {
                service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,240,service.frame.size.width,service.frame.size.height);
            }
            else
            {
                service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,240,service.frame.size.width,service.frame.size.height);
            }
            service.Serviceview_delegate=self;
            //[footer TapCheck:1];
            [overlay addSubview:service];
            
            
            
            [UIView animateWithDuration:.55f animations:^{
                
                
                [sidemenu.btn5 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
                [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
                
                
                
                
                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
                
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                
                if(screenBounds.size.width == 320)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
                    
                }
                else if(screenBounds.size.width == 375)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
                }
                else
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
                }
                
                tapchk=false;
                
                
                
                tapchk1=true;
                
                tapchk2=false;
                
                
                
                
                // CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-155,240,155,service.frame.size.height);
                }
                else
                {
                    service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-service.frame.size.width,240,service.frame.size.width,service.frame.size.height);
                }
                
                // service.Delegate=self;
                //[footer TapCheck:1];
                //[overlay addSubview:service];
                
                
                
                
            }
             
                             completion:^(BOOL finished)
             {
                 
                 //  overlay.userInteractionEnabled=YES;
                 
             }];
            
            
            
            
            
            
        }
        
        //[service removeFromSuperview];
        
        
        
        
        
        
        
        
        
    }
    
    else if (sender.tag==3)
    {
        //        [subview removeFromSuperview];
        //        [service removeFromSuperview];
        //
        //        EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
        //
        //        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
        if (tapchk2==false)
        {
            
            //[profileview removeFromSuperview];
            
            profileview = [[profile alloc]init];
            profileview.Profile_delegate=self;
            
            profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
            
            [overlay addSubview:profileview];
            
            
            
            
            [UIView animateWithDuration:.55f animations:^{
                
                
                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-profileview.frame.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
                
                
                [sidemenu.btn3 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
                [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
                
                
                tapchk=false;
                tapchk1=false;
                
                tapchk2=true;
                
                
                
                service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
                
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                
                if(screenBounds.size.width == 320)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
                    
                }
                else if(screenBounds.size.width == 375)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
                }
                else
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
                }
                
                
            }
                             completion:^(BOOL finished)
             {
                 
                 
                 
                 
             }];
            
            
            
            
            
        }
    }
    
    
    
    else
    {
        [subview removeFromSuperview];
        [service removeFromSuperview];
        [profileview removeFromSuperview];
        
        
        [UIView transitionWithView:sidemenu
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            
                            // overlay.hidden=YES;
                            sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                            
                        }
         
                        completion:^(BOOL finished)
         {
             
             [sidemenu removeFromSuperview];
             
             
             [overlay removeFromSuperview];
             
             
             [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
             [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
             
             
             if (sender.tag==1)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 
                 DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                 
                 
             }
             
             else if (sender.tag==8)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
                 [self deleteAllEntities:@"ProductList"];
                 [self deleteAllEntities:@"WishList"];
                 [self deleteAllEntities:@"CategoryFeatureList"];
                 [self deleteAllEntities:@"CategoryList"];
                // [self deleteAllEntities:@"ContactList"];
                 [self deleteAllEntities:@"ServiceList"];
                 
                 
                 
                 
                 [[FBSession activeSession] closeAndClearTokenInformation];
                 
                 NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
                 
                 [userData removeObjectForKey:@"status"];
                 
                 [userData removeObjectForKey:@"logInCheck"];
                 
                 ViewController   *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
                 
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
             }
             
             else if (sender.tag==4)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 
                 Business_Information_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Business"];
                 
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
             }
             
             
             
             
             
             else if (sender.tag == 9)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 LanguageViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"language"];
                 
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
             }
             
             
         }];
    }
}


-(void)doneWithNumberPad{
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        [phoneText resignFirstResponder];
        
    }];
    
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
    
    
    if (textField==phoneText)
    {
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        phoneText.inputAccessoryView = numberToolbar;
        
        
        phoneText.keyboardType =UIKeyboardTypePhonePad;
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .12, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            
        }];
        
        
    }
    
    
    
    return YES;
}
-(void)Profile_BtnTap:(UIButton *)sender
{
    [UIView animateWithDuration:.4 animations:^{
        
        
        
        
        
        profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
        
        
        
        
    }
                     completion:^(BOOL finished)
     {
         
         
         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                             options:1 animations:^{
                                 
                                 [profileview removeFromSuperview];
                                 
                                 
                                 
                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                 
                             }
          
          
          
                          completion:^(BOOL finished)
          
          {
              [sidemenu removeFromSuperview];
              [overlay removeFromSuperview];
              
              if (sender.tag==0)
              {
                  NSLog(@"I am viewProfile");
              }
              else if (sender.tag==1)
              {
                  NSLog(@"I am EditProfile");
                  
                  
                  EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
              }
              else if (sender.tag==2)
              {
                  NSLog(@"I am Photo & Video");
                  
                  
                  
                  Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
              }
              else if (sender.tag==3)
              {
                  NSLog(@"I am Trust & verification");
                  
                  
                  Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
              }
              else if (sender.tag==4)
              {
                  NSLog(@"I am review");
                  
                  
                  
                  
                  rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
                  
              }
              
              
              else if (sender.tag==5)
              {
                  NSLog(@"I am phone Verification");
                  
                  
                  
                  
                  blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                  
                  blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
                  
                  
                  
                  UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
                  tapGestureRecognize.delegate = self;
                  tapGestureRecognize.numberOfTapsRequired = 1;
                  
                  [blackview addGestureRecognizer:tapGestureRecognize];
                  
                  
                  
                  
                  popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
                  
                  
                  UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview.bounds.origin.y+10, popview.frame.size.width-20, 40)];
                  
                  phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, header.frame.size.height+20, popview.frame.size.width-20, 45)];
                  phoneText.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
                  
                  phoneText.delegate=self;
                  phoneText.placeholder=@"Enter Phone Number";
                  
                  
                  UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                  phoneText.leftView = paddingView;
                  phoneText.leftViewMode = UITextFieldViewModeAlways;
                  
                  UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+100, header.frame.size.height+phoneText.frame.size.height+40, phoneText.frame.size.width-180, 30)];
                  
                  submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:79/255.0 alpha:1];
                  
                  submit.layer.cornerRadius = 5;
                  
                  [submit setTitle:@"Save" forState:UIControlStateNormal];
                  // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
                  [submit addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
                  
                  
                  
                  phoneText.layer.cornerRadius=5;
                  
                  header.text = @"Phone Verification";
                  
                  //  header.backgroundColor = [UIColor redColor];
                  
                  [header setFont:[UIFont fontWithName:@"Lato" size:16]];
                  [phoneText setFont:[UIFont fontWithName:@"Lato" size:14]];
                  
                  // header.textColor=[UIColor redColor];
                  
                  header.textAlignment = NSTextAlignmentCenter;
                  
                  [self.view addSubview:blackview];
                  [popview addSubview:header];
                  [popview addSubview:submit];
                  [popview addSubview:phoneText];
                  popview.backgroundColor=[UIColor whiteColor];
                  popview.layer.cornerRadius =5;
                  
                  [self.view addSubview:popview];
                  
                  
                  
                  
                  [UIView animateWithDuration:.3 animations:^{
                      
                      
                      
                      popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
                      
                      phoneText.text=phoneno;
                      
                      
                  }];
                  
                  
                  
              }
              
              
          }];
         
         
     }];
    
    
    
    
    
    
    
    
    
}

-(void)cancelByTap
{
    [UIView animateWithDuration:.3 animations:^{
        
        
        
        popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        [phoneText resignFirstResponder];
        
    }
                     completion:^(BOOL finished)
     {
         
         
         
         [blackview removeFromSuperview];
         
     }];
    
}


-(void)save
{
    
    if (phoneText.text.length==0)
    {
        phoneText.placeholder = @"Please Enter Phone Number";
    }
    else
    {
        NSLog(@"url");
        
        NSString *url = [NSString stringWithFormat:@"%@/app_phone_verify_add?userid=%@&phone_no=%@",App_Domain_Url,userid,[phoneText text]];
        
        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            
            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
            {
                phoneno=phoneText.text;
                
                
                [UIView animateWithDuration:.3 animations:^{
                    
                    
                    
                    popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
                    [phoneText resignFirstResponder];
                    
                }
                                 completion:^(BOOL finished)
                 {
                     
                     
                     
                     [blackview removeFromSuperview];
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     
                 }];
                
            }
            
            
        }];
        
        
    }
    
}




- (void)deleteAllEntities:(NSString *)nameEntity
{
    NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [theContext deleteObject:object];
    }
    
    error = nil;
    [theContext save:&error];
}



-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.2f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //  self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+20, self.view.frame.size.width, self.view.frame.size.width);
    pview.hidden=YES;
     [myview removeFromSuperview];
    
    [textField becomeFirstResponder];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         if(textField==citytxt)
                         {
                             
                             
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 180.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 150.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 120.0f+50) animated:YES];
                             }
                             
                             
                             
                         }
                         if (textField==phonenotxt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 220.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 180.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 180.0f+50) animated:YES];
                             }
                         }
                         if (textField==schoolname1txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 260.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 220.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 190.0f+50) animated:YES];
                             }
                         }
                         
                         if (textField==schoolname2txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 310.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 270.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 230.0f+50) animated:YES];
                             }
                         }
                         
                         if (textField==schoolname3txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 370.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 310.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 280.0f+50) animated:YES];
                             }
                         }
                         if (textField==schoolname4txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 420.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 370.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 320.0f+50) animated:YES];
                             }
                         }
                         if (textField==schoolname5txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 480.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 410.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 370.0f+50) animated:YES];
                             }
                         }
                         if (textField==worktxt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 520.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 490.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 410.0f+50) animated:YES];
                                 
                             }
                         }
                         if (textField==language1txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 580.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 560.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 470.0f+50) animated:YES];
                             }
                         }
                         if (textField==language2txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 640.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 610.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 510.0f+50) animated:YES];
                             }
                         }
                         if (textField==language3txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 700.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 660.0f+50) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 540.0f+50) animated:YES];
                             }
                         }
                         if (textField==language4txt)
                         {
                             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 750.0f+50) animated:YES];
                             }
                             else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 710.0f+80) animated:YES];
                             }
                             
                             else
                             {
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 560.0f+80) animated:YES];
                             }
                         }
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)back_button:(id)sender
{
    [self POPViewController];
}
-(void)POPViewController
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}
-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}
- (BOOL)validateEmail:(NSString *)emailStr{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if(![emailTest evaluateWithObject:txtEmail.text])
    {
        ////NSLog(@"Invalid email address found");
        //        UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:@"Mail alert" message:@"Please enter valid Emailid." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
        //        [objAlert show];
        
        txtEmail.text=@"";
        txtEmail.placeholder=@"Please enter valid email id";
        
        return FALSE;
    }
    return TRUE;
}

- (IBAction)SaveClick:(id)sender
{
   /* if ([self TarminateWhiteSpace:txtUserName.text].length==0)
    {
        txtUserName.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter name" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        txtUserName.attributedPlaceholder=nn3;
    }
    
    else if (countrylbl.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Select Country" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if ([self TarminateWhiteSpace:citytxt.text].length==0)
    {
        citytxt.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter City" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        citytxt.attributedPlaceholder=nn3;
    }
    
    
    else if ([self TarminateWhiteSpace:phonenotxt.text].length==0)
    {
        phonenotxt.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter Phone No" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        phonenotxt.attributedPlaceholder=nn3;
    }
    else if (countrylbl.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Select Country" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    else if(shortdescriptiontextview.text.length==0)
    {
        shortdeclbl.text =@"Enter short Description";
    }
    
    */
    
        [self UpdateProfileUrl];
   
    
    
}
-(void)UpdateProfileUrl
{
    BOOL net=[urlobj connectedToNetwork];
    
    
    
    if (net==YES)
    {
        NSString *url = [NSString stringWithFormat:@"%@app_user_profile_update?userid=%@&name=%@&country=%@&state_name=%@&city=%@&phone_no=%@&work=%@&dob=%@&description=%@&lang_name1=%@&lang_name2=%@&lang_name3=%@&lang_name4=%@&fild_name1=%@&fild_name2=%@&fild_name3=%@&fild_name4=%@&fild_name5=%@",App_Domain_Url,UserId,txtUserName.text,country_id,state_id,citytxt.text,phonenotxt.text,worktxt.text,dateofbirthlbl.text,shortdescriptiontextview.text,language1txt.text,language2txt.text,language3txt.text,language4txt.text,schoolname1txt.text,schoolname2txt.text,schoolname3txt.text,schoolname4txt.text,schoolname5txt.text];
        
        NSString *encode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            
            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                
                [alrt show];
                
                
                [self ProfileDetailUrl];
                
                
              
                
            }
            else
            {
                NSLog(@"faild");
            }
            
            
        }];
       
    
    
    
    }
    else{
        
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
}
- (IBAction)ImageClick:(id)sender
{
    pview.hidden=YES;
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [actionsheet showInView:self.view];
    [myview removeFromSuperview];
    pview.hidden=YES;
    [txtUserName resignFirstResponder];
    [citytxt resignFirstResponder];
    [phonenotxt resignFirstResponder];
    
    [schoolname1txt resignFirstResponder];
    [schoolname2txt resignFirstResponder];
    [schoolname3txt resignFirstResponder];
    [schoolname4txt resignFirstResponder];
    [schoolname5txt resignFirstResponder];
    
    [worktxt resignFirstResponder];
    [language1txt resignFirstResponder];
    [language2txt resignFirstResponder];
    [language3txt resignFirstResponder];
    [language4txt resignFirstResponder];
}

- (IBAction)countryBtnTap:(id)sender
{
    countryPicker.tag=0;
    
    done=1;
    
   // [stateBtn setTitle:@"Select State" forState:UIControlStateNormal];
    
    //statelbl.text=@"";
    stateName=@"";
    state_id=@"";
    
    
    if (countrylbl.text.length==0)
        
    {
        
        [countrybtn setTitle:@"Country" forState:UIControlStateNormal];
        
    }
    
    else
        
    {
        
        [countrybtn setTitle:@"" forState:UIControlStateNormal];
        
    }

    
    
    [myview removeFromSuperview];
    
    [txtUserName resignFirstResponder];
    [citytxt resignFirstResponder];
    [phonenotxt resignFirstResponder];
    
    [schoolname1txt resignFirstResponder];
    [schoolname2txt resignFirstResponder];
    [schoolname3txt resignFirstResponder];
    [schoolname4txt resignFirstResponder];
    [schoolname5txt resignFirstResponder];
    
    [worktxt resignFirstResponder];
    [language1txt resignFirstResponder];
    [language2txt resignFirstResponder];
    [language3txt resignFirstResponder];
    [language4txt resignFirstResponder];
    
  /*  NSString *curl =[NSString stringWithFormat:@"http://esolzdemos.com/lab1/countries-object-array.json"];
    
    [txtUserName resignFirstResponder];
    
    [globalobj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         [countrybtn setTitle:@"Select Country" forState:UIControlStateNormal];
         countrylbl.text=@"";
         
         countryArry = [result valueForKey:@"name"];
         
         country=countryArry[0];
         
         countryPicker.dataSource=self;
         countryPicker.delegate=self;
         
         
         
         CGRect screenBounds=[[UIScreen mainScreen] bounds];
         if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
         {
             [self.mainscroll setContentOffset:CGPointMake(0.0f,67.0f) animated:YES];
             
         }
         else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
         {
             
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 20.0f) animated:YES];
             
         }
         
         else
         {
             
             [self.mainscroll setContentOffset:CGPointMake(0.0f, 15.0f) animated:YES];
             
             //pview.frame =CGRectMake(0, 400, self.view.bounds.size.width, self.view.bounds.size.height);
         }
         
         
         
         
         
         pview.hidden=NO;
         pview.frame =CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, pview.frame.size.width, pview.frame.size.height);
         [self.view addSubview:pview];
         
         
         
         mainscroll.scrollEnabled=NO;
         
         NSLog(@"countryArry===%@",countryArry);
     }];
    */
    
    NSString *curl =[NSString stringWithFormat:@"%@/app_country",App_Domain_Url];
    
    
   // countrylbl.text=@"Loading Country.....";
    [globalobj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
        
        // [countrybtn setTitle:@"Select Country" forState:UIControlStateNormal];
        // countrylbl.text=@"";
         
         NSMutableArray  *temp ;
         temp= [[result valueForKey:@"infoarray" ] mutableCopy];
         
         
         
         country = [[temp objectAtIndex:0]valueForKey:@"country_name"];
         country_id = [[temp objectAtIndex:0]valueForKey:@"country_id"];
         
         
         for (int i=0 ; i<temp.count; i++)
         {
             
             
             NSString *tempcounry = [[temp objectAtIndex:i]valueForKey:@"country_name"];
             NSString *temp_id = [[temp objectAtIndex:i]valueForKey:@"country_id"];
             
             
             
             [countryArry insertObject:tempcounry atIndex:i];
             [country_idArray insertObject:temp_id atIndex:i];
             
             
             
             
             
             
         }
         
         
         CGRect screenBounds=[[UIScreen mainScreen] bounds];
         if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
         {
             [self.mainscroll setContentOffset:CGPointMake(0.0f,67.0f) animated:YES];
             
         }
         else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
         {
             
             [self.mainscroll setContentOffset:CGPointMake(0.0f, 20.0f) animated:YES];
             
         }
         
         else
         {
             
             [self.mainscroll setContentOffset:CGPointMake(0.0f, 15.0f) animated:YES];
             
             //pview.frame =CGRectMake(0, 400, self.view.bounds.size.width, self.view.bounds.size.height);
         }
         
         
         
         
         
         pview.hidden=NO;
         pview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
         
         [UIView animateWithDuration:.2 animations:^{
             pview.frame =CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
             [self.view addSubview:pview];
         }];
         
         
         
         pview.frame =CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
         [self.view addSubview:pview];
         
         
         
         mainscroll.scrollEnabled=NO;
         
           [countryPicker selectRow:0 inComponent:0 animated:NO];
         
         
         countryPicker.dataSource=self;
         countryPicker.delegate=self;
         
        
         
        
         
     }];
    
    
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
            
        case 0:
            
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
            
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
            break;
            
        default:
            break;
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    ProfileImg.image=info[UIImagePickerControllerEditedImage];
    ProfileImg.contentMode=UIViewContentModeScaleAspectFill;
    ProfileImg.clipsToBounds = YES;
    ProfileImg.layer.cornerRadius = ProfileImg.frame.size.width/2;
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}





- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (countryPicker.tag==0)
    {
        return countryArry[row];
    }
    else
    {
        return stateArray [row];
    }
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (countryPicker.tag==0)
    {
        return countryArry.count;
    }
    
    else
    {
        return  stateArray.count;
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    if (countryPicker.tag==0)
    {
        country=countryArry[row];
        country_id =country_idArray[row];
    }
    
    else
    {
        stateName= stateArray [row];
        state_id = stateid_Array [row];
    }
    
    
}



- (IBAction)PickerCnclBtn:(id)sender
{
    
    
    if (countrylbl.text.length>0)
    {
        [countrybtn setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
       [countrybtn setTitle:@"Select Country" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        
        pview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
       
       

    }
     completion:^(BOOL finished) {
         
         
         
         pview.hidden=YES;
     }];
    
    
       mainscroll.scrollEnabled=YES;
    
}

- (IBAction)PickerDoneBtn:(id)sender
{
    
    mainscroll.scrollEnabled=YES;
    
    
    if (done==1)
    {
       
        stateArray = [[NSMutableArray alloc]init];
        stateid_Array =[[NSMutableArray alloc]init];
        
        countrylbl.text=country;
        
        NSLog(@"county id ---%@",country_id);
        [UIView animateWithDuration:.2 animations:^{
            
            
            pview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
            
            
            
        }
                         completion:^(BOOL finished) {
                             
                             
                             
                             pview.hidden=YES;
                         }];
        
        
        [countrybtn setTitle:@"" forState:UIControlStateNormal];
        
        
        if (stateArray.count==0)
        {
            
       
        
        NSString *curl =[NSString stringWithFormat:@"%@app_user_service/app_state?country_id=%@",App_Domain_Url,country_id];
        
        
        // countrylbl.text=@"Loading Country.....";
        [globalobj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             if ([[result valueForKey:@"response"]isEqualToString:@"success"])
             {
                 NSMutableArray *temp = [[result valueForKey:@"infoarray"] mutableCopy];
                 
                 if (temp.count>0)
                 {
                     state_id = [[temp objectAtIndex:0]valueForKey:@"state_id"];
                     stateName = [[temp objectAtIndex:0]valueForKey:@"state_name"];
                 }
                 
                 
                 
                 for (int i= 0; i<temp.count; i++)
                 {
                     NSString *stateid  = [[temp objectAtIndex:i]valueForKey:@"state_id"];
                     NSString *statename = [[temp objectAtIndex:i]valueForKey:@"state_name"];
                     
                     
                     [stateid_Array insertObject:stateid atIndex:i];
                     [stateArray insertObject:statename atIndex:i];
                 }
                 
                 
                 
                 
             }
             
         }];
        
        
        
        }
        
        
        
        
        statelbl.text=@"";
        [stateBtn setTitle:@"Select State" forState:UIControlStateNormal];
        

    }
    
    
    
    else
    {
        
        
        statelbl.text = stateName;
        
        
        if (statelbl.text.length>0)
        {
            [stateBtn setTitle:@"" forState:UIControlStateNormal];
        }
        
        NSLog(@"state id---%@",state_id);
        
        [UIView animateWithDuration:.2 animations:^{
            
            
            pview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
            
            
            
        }
                         completion:^(BOOL finished) {
                             
                             
                             
                             pview.hidden=YES;
                         }];
        
        
    }



}




- (IBAction)DatePickerBtnTap:(id)sender
{
    [myview removeFromSuperview];
    pview.hidden=YES;
    [txtUserName resignFirstResponder];
    [citytxt resignFirstResponder];
    [phonenotxt resignFirstResponder];
    
    [schoolname1txt resignFirstResponder];
    [schoolname2txt resignFirstResponder];
    [schoolname3txt resignFirstResponder];
    [schoolname4txt resignFirstResponder];
    [schoolname5txt resignFirstResponder];
    
    [worktxt resignFirstResponder];
    [language1txt resignFirstResponder];
    [language2txt resignFirstResponder];
    [language3txt resignFirstResponder];
    [language4txt resignFirstResponder];
    
    
    
     [mainscroll setContentOffset:CGPointMake(0.0f, 880.0f) animated:YES];
    
     myview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, self.view.frame.size.width, pview.frame.size.height)];
    
      [myview setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,pview.frame.size.height-42,self.view.frame.size.width/2,42)];
    btn.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
    [btn setTitle: @"OK" forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [Datepicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    [myview addSubview:btn];

    
    
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(btn.frame.size.width,pview.frame.size.height-42,self.view.frame.size.width/2,42)];
    btn1.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
    [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
   [myview addSubview:btn1];
    
    
     Datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,pview.frame.size.height-btn.frame.size.height)];
    
    Datepicker.datePickerMode=UIDatePickerModeDate;
    
    
    
    
    NSDate *minYearDate = [[NSDate date] dateByAddingTimeInterval: -473040000.0];
    Datepicker.maximumDate=minYearDate;

    
    
    [myview addSubview:Datepicker];
    
    
    [self.view addSubview:myview];
    
    
    
    
    
 /*   CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    if (screenBounds.size.height == 568 && screenBounds.size.width == 320) {
        
        
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        
        
        Datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [Datepicker setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        [myview addSubview:Datepicker];
        
        
        Datepicker.datePickerMode=UIDatePickerModeDate;
        
        
        NSDate *minYearDate = [[NSDate date] dateByAddingTimeInterval: -473040000.0];
        Datepicker.maximumDate=minYearDate;
        
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-15,227,187,42)];
        btn.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [Datepicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(150,227,188,42)];
        btn1.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        CGRect rc=[mainscroll bounds];
        CGPoint pt;
        rc=[mainscroll convertRect:rc toView:mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=830+50;
        [mainscroll setContentOffset:pt animated:YES];
        
        
        
        [self.view addSubview:myview];
        
    }
    else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        // [myview setBackgroundColor:[UIColor grayColor]];
        
        
        Datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [Datepicker setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        [myview addSubview:Datepicker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        //  [Datepicker setBackgroundColor: [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1]];
        
        Datepicker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        
        
        NSDate *minYearDate = [[NSDate date] dateByAddingTimeInterval: -473040000.0];
        Datepicker.maximumDate=minYearDate;
        
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,228,185,40)];
        btn.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [Datepicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(191,228,185,40)];
        btn1.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        CGRect rc=[mainscroll bounds];
        CGPoint pt;
        rc=[mainscroll convertRect:rc toView:mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=750+50;
        [mainscroll setContentOffset:pt animated:YES];
        
        [self.view addSubview:myview];
        
    }
    
    
    else if(screenBounds.size.height == 480 && screenBounds.size.width == 320)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        
        
        Datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [Datepicker setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        [myview addSubview:Datepicker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        // [Datepicker setBackgroundColor: [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1]];
        
        Datepicker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        
        
        NSDate *minYearDate = [[NSDate date] dateByAddingTimeInterval: -473040000.0];
        Datepicker.maximumDate=minYearDate;
        
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-7,225,187,42)];
        btn.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [Datepicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(150,225,188,42)];
        btn1.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
    }
    else
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 450, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        
        
        Datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [Datepicker setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
        [myview addSubview:Datepicker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        //  [Datepicker setBackgroundColor: [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1]];
        
        Datepicker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        
        
        NSDate *minYearDate = [[NSDate date] dateByAddingTimeInterval: -473040000.0];
        Datepicker.maximumDate=minYearDate;
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(15,225,187,42)];
        btn.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [Datepicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(210,225,188,42)];
        btn1.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        CGRect rc=[mainscroll bounds];
        CGPoint pt;
        rc=[mainscroll convertRect:rc toView:mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=750+50;
        [mainscroll setContentOffset:pt animated:YES];
        
        
        [self.view addSubview:myview];
        
    }
    */
}

-(void)ok:(id)sender
{
    
    [myview removeFromSuperview];
    
    
    
    
    
    [self LabelTitle:sender];
    [self monthcheck];
    [Datepicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    
    dateofbirthlbl.textColor = [UIColor blackColor];
    dateofbirthlbl.text= [NSString stringWithFormat:@"%@/%@/%@",strmon,strday,stryear];
    
    
}


-(void)monthcheck
{
    if ([strmon isEqualToString:@"Jan"]) {
        strmon=@"1";
    }
    else if ([strmon isEqualToString:@"Feb"]) {
        strmon=@"2";
    }
    else if ([strmon isEqualToString:@"Mar"]) {
        strmon=@"3";
    }
    else if ([strmon isEqualToString:@"Apr"]) {
        strmon=@"4";
    }
    else if ([strmon isEqualToString:@"May"]) {
        strmon=@"5";
    }
    else if ([strmon isEqualToString:@"Jun"]) {
        strmon=@"6";
    }
    else if ([strmon isEqualToString:@"Jul"]) {
        strmon=@"7";
    }
    else if ([strmon isEqualToString:@"Aug"]) {
        strmon=@"8";
    }
    else if ([strmon isEqualToString:@"Sep"]) {
        strmon=@"9";
    }
    else if ([strmon isEqualToString:@"Oct"]) {
        strmon=@"10";
    }
    else if ([strmon isEqualToString:@"Nov"]) {
        strmon=@"11";
    }
    else if ([strmon isEqualToString:@"Dec"]) {
        strmon=@"12";
    }
}

-(void)cancel:(id)sender
{
    [myview removeFromSuperview];
}
-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    strday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:Datepicker.date]];
    strmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:Datepicker.date]];
    stryear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:Datepicker.date]];
    strday = [strday substringWithRange:NSMakeRange(4,2)];
    strmon = [strmon substringWithRange:NSMakeRange(0,3)];
    stryear = [stryear substringWithRange:NSMakeRange(7,4)];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
    if (text.length>0)
        
    {
        
        shortdeclbl.hidden=YES;
        
    }
    
    if ([text isEqualToString:@"\n"])
        
    {
        
        
        
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 1050.0f+50) animated:YES];
            
            mainscroll.contentSize=CGSizeMake(0,1400+50);
            
        }
        
        else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 1000.0f+50) animated:YES];
            
            mainscroll.contentSize=CGSizeMake(0,1400+50);
            
        }
        
        else
            
        {
            
            
            
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 970.0f+20) animated:YES];
            
            mainscroll.contentSize=CGSizeMake(0,1400+50);
            
            
            
        }
        
        [textView resignFirstResponder];
        
        if (textView.text.length==0)
            
        {
            
            shortdeclbl.hidden=NO;
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    return YES;
    
}



-(void)textViewDidBeginEditing:(UITextView *)textView

{
     [myview removeFromSuperview];
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
    shortdeclbl.hidden=YES;
    
    
    
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        
        [self.mainscroll setContentOffset:CGPointMake(0.0f, 1050.0f+50) animated:YES];
        
        mainscroll.contentSize=CGSizeMake(0,1580+50);
        
    }
    
    else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
        
    {
        
        [self.mainscroll setContentOffset:CGPointMake(0.0f, 1040.0f+50) animated:YES];
        
        mainscroll.contentSize=CGSizeMake(0,1580+50);
        
    }
    
    else
        
    {
        
        
        
        [self.mainscroll setContentOffset:CGPointMake(0.0f, 970.0f+50) animated:YES];
        
        mainscroll.contentSize=CGSizeMake(0,1580+50);
        
        
        
    }
    
    
    
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


- (IBAction)stateBtnTap:(id)sender
{
    countryPicker.tag=2;
    done=2;
    
    [self textFieldShouldReturn:txtUserName];
    [self textFieldShouldReturn:citytxt];
    [self textFieldShouldReturn:phonenotxt];
    [self textFieldShouldReturn:schoolname1txt];
    [self textFieldShouldReturn:schoolname2txt];
    [self textFieldShouldReturn:schoolname3txt];
    [self textFieldShouldReturn:schoolname4txt];
    [self textFieldShouldReturn:schoolname5txt];
    
    [self textFieldShouldReturn:worktxt];
    [self textFieldShouldReturn:phonenotxt];
    [self textFieldShouldReturn:language4txt];
     [self textFieldShouldReturn:language3txt];
     [self textFieldShouldReturn:language2txt];
     [self textFieldShouldReturn:language1txt];

    
    
    
    
    
    
    
    
    if (stateArray.count==0)
    {
        NSLog(@"working");
    }
    
    else if (stateArray.count>0)
    {
       
        
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,120.0f) animated:YES];
            
        }
        else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
        {
            
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 40.0f) animated:YES];
            
        }
        
        else
        {
            
            [self.mainscroll setContentOffset:CGPointMake(0.0f,30.0f) animated:YES];
            
            //pview.frame =CGRectMake(0, 400, self.view.bounds.size.width, self.view.bounds.size.height);
        }
        
        
        
        
        
        pview.hidden=NO;

        
        [UIView animateWithDuration:.2 animations:^{
          
            pview.frame =CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
            [self.view addSubview:pview];
        }];
        
        
        
        
        
        mainscroll.scrollEnabled=NO;
        
        [countryPicker selectedRowInComponent:0];
        countryPicker.dataSource=self;
        countryPicker.delegate=self;
        
        

    }
    
}
@end
