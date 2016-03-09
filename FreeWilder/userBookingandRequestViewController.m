//
//  userBookingandRequestViewController.m
//  FreeWilder
//
//  Created by subhajit ray on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "userBookingandRequestViewController.h"
#import "userBookingandRequestTableViewCell.h"
#import "FW_JsonClass.h"
#import "ViewOrderDetailsViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

#pragma mark - Footer related imports

#import "Side_menu.h"
#import "Footer.h"
#import "ServiceView.h"
#import "profile.h"
#import "ProductDetailsViewController.h"
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "notificationsettingsViewController.h"
#import "ChangePassword.h"
#import "LanguageViewController.h"
#import "UserService.h"
#import "MyBooking & Request.h"
#import "userBookingandRequestViewController.h"
#import "myfavouriteViewController.h"
#import "Business Information ViewController.h"
#import "SettingsViewController.h"
#import "PaymentMethodViewController.h"
#import "PrivacyViewController.h"
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "BusinessProfileViewController.h"
//#import "Product_Details_ViewController.h"
#import "accountsubview.h"
#import "WishlistViewController.h"
#import "ViewController.h"
#import "BusinessProfileViewController.h"
#import "sideMenu.h"


@interface userBookingandRequestViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{
    sideMenu *leftMenu;
    
    FW_JsonClass *globalobj;
    NSMutableDictionary *datadic;
    NSMutableArray *dataarray;
    NSString *userid;
    NSString *status,*paymentstatus;
    NSString *curr_id;
    userBookingandRequestTableViewCell *userrqst_cell;
    
    
#pragma mark - Footer variables
    
    Side_menu *sidemenu;
    UIView *overlay;
    NSMutableArray *ArrProductList;
    bool data;
    UIView *loader_shadow_View;
    IBOutlet UIView *footer_base;
    BOOL tapchk,tapchk1,tapchk2;
    NSMutableArray *jsonArray,*temp;
    UIView *blackview ,*popview;
    NSString *phoneno;
    ServiceView *service;
    profile *profileview;
    UITextField *phoneText;
    accountsubview *subview;

    
}

@end

@implementation userBookingandRequestViewController
@synthesize booking_id;

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

    
    
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer_base addSubview:footer];
    temp= [[NSMutableArray alloc]init];
    
    
    //------>

    
    [_tableviewmain setShowsHorizontalScrollIndicator:NO];
    [_tableviewmain setShowsVerticalScrollIndicator:NO];
    _tableviewmain.separatorColor = [UIColor clearColor];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    NSLog(@"userid %@",userid);
    
    curr_id=[prefs valueForKey:@"curr_id"];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self urlfire];
    
    
}

#pragma mark - Footer related methods

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




//-(void)side
//{
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    // overlay.hidden=YES;
//    //overlay.userInteractionEnabled=YES;
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
//    }
//    
//    else{
//        
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//        
//    }
//    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    //  //(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//    
//    userid=[prefs valueForKey:@"UserId"];
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
//            
//        }
//        
//        
//    }];
//    
//    
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
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
//              [sidemenu removeFromSuperview];
//              [overlay removeFromSuperview];
//              // overlay.userInteractionEnabled=NO;
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
                  //(@"0");
                  
                  
                  UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              
              else if (sender.tag==1)
              {
                  //(@"1");
              }
              else if (sender.tag==2)
              {
                  //(@"2");
                  
                  
                  userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              
              else if (sender.tag==3)
              {
                  //(@"3");
                  
                  
                  MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
                  
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
                  
                  
                  
                  
                  
                  
              }
              
              
              
              else if (sender.tag==4)
              {
                  //(@"4");
                  
                  WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              else if (sender.tag==5)
              {
                  //(@"5");
                  
                  
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
    //(@"tag%ld",(long)sender.tag);
    
    
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
                  //(@"i am notification");
                  
                  
                  notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==101)
              {
                  //(@"i am  payment method");
                  
                  
                  
                  
                  PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==102)
              {
                  //(@"i am payout preferences");
                  
                  
                  
                  PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
                  
                  
                  
              }
              else if (sender.tag==103)
              {
                  //(@"i am from transaction history");
              }
              else if (sender.tag==104)
              {
                  //(@"i am from privacy");
                  
                  
                  
                  PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              else if (sender.tag==105)
              {
                  //(@"i am from security");
                  
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
    //(@"##### test mode...%ld",(long)sender.tag);
    
    
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
                 //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
                 [self deleteAllEntities:@"ProductList"];
                 [self deleteAllEntities:@"WishList"];
                 [self deleteAllEntities:@"CategoryFeatureList"];
                 [self deleteAllEntities:@"CategoryList"];
                 //   [self deleteAllEntities:@"ContactList"];
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
                  //(@"I am viewProfile");
              }
              else if (sender.tag==1)
              {
                  //(@"I am EditProfile");
                  
                  
                  EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
              }
              else if (sender.tag==2)
              {
                  //(@"I am Photo & Video");
                  
                  
                  
                  Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
              }
              else if (sender.tag==3)
              {
                  //(@"I am Trust & verification");
                  
                  
                  Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
              }
              else if (sender.tag==4)
              {
                  //(@"I am review");
                  
                  
                  
                  
                  rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
                  
              }
              
              
              else if (sender.tag==5)
              {
                  //(@"I am phone Verification");
                  
                  
                  
                  
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




-(void)save
{
    
    if (phoneText.text.length==0)
    {
        phoneText.placeholder = @"Please Enter Phone Number";
    }
    else
    {
        //(@"url");
        
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


-(void)urlfire
{
    
    
    globalobj=[[FW_JsonClass alloc]init];
    
    
    UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    
    
    
    datadic=[[NSMutableDictionary alloc] init];
    dataarray=[[NSMutableArray alloc] init];
    NSString *urlstring=[NSString stringWithFormat:@"%@app_user_booking_det?userid=%@&cur_id=%@",App_Domain_Url,userid,curr_id];
    NSLog(@"str=%@",urlstring);
    
    [spinner startAnimating];
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        datadic=[result mutableCopy];
        
        
        NSString *datachking=[datadic valueForKey:@"response"];
        if ([datachking isEqualToString:@"success"])
        {
            dataarray=[datadic valueForKey:@"infoarray"];
            NSLog(@"data %@",dataarray);
            
            
            
            
            NSManagedObjectContext *context1=[appDelegate managedObjectContext];
            NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"UserBooking"];
            NSMutableArray *fetchrequest=[[context1 executeFetchRequest:request error:nil] mutableCopy];
            NSInteger CoreDataCount=[fetchrequest count];
            
            NSLog(@"core data count=%ld",(long)CoreDataCount);
            NSLog(@"url array count=%lu",(unsigned long)[dataarray count]);
            
            if (CoreDataCount !=[dataarray count])
            {
                
                //Deleting data from core data
                NSManagedObjectContext *context2=[appDelegate managedObjectContext];
                NSFetchRequest *request2=[[NSFetchRequest alloc] initWithEntityName:@"UserBooking"];
                NSMutableArray *fetchrequest2=[[context2 executeFetchRequest:request2 error:nil] mutableCopy];
                for (NSManagedObject *obj2 in fetchrequest2)
                {
                    
                    [context2 deleteObject:obj2];
                    
                }
                
            }
            
            // Placing  url data in core data
            for ( NSDictionary *tempDict1 in  [result objectForKey:@"infoarray"])
            {
                NSManagedObjectContext *context=[appDelegate managedObjectContext];
                NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"UserBooking" inManagedObjectContext:context];
                [manageobject setValue:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"booking_id"]] forKey:@"booking_id"];
                [manageobject setValue:[tempDict1 valueForKey:@"buyer_name"] forKey:@"buyer_name"];
                [manageobject setValue:[tempDict1 valueForKey:@"buyer_user_id"] forKey:@"buyer_user_id"];
                [manageobject setValue:[tempDict1 valueForKey:@"check_in_date"] forKey:@"check_in_date"];
                [manageobject setValue:[tempDict1 valueForKey:@"order_date"] forKey:@"order_date"];
                [manageobject setValue:[tempDict1 valueForKey:@"price"] forKey:@"price"];
                [manageobject setValue:[tempDict1 valueForKey:@"quantity"] forKey:@"quantity"];
                [manageobject setValue:[tempDict1 valueForKey:@"total_amount"] forKey:@"total_amount"];
                [manageobject setValue:[tempDict1 valueForKey:@"status"] forKey:@"status"];
                [manageobject setValue:[tempDict1 valueForKey:@"payment_status"] forKey:@"payment_status"];
                [manageobject setValue:[tempDict1 valueForKey:@"service_name"] forKey:@"service_name"];
                [manageobject setValue:[tempDict1 valueForKey:@"service_id"] forKey:@"service_id"];
                [manageobject setValue:[tempDict1 valueForKey:@"seller_name"] forKey:@"seller_name"];
                [manageobject setValue:[tempDict1 valueForKey:@"seller_user_id"] forKey:@"seller_user_id"];
                
                [appDelegate saveContext];
                
            }
            
            
            //            NSManagedObjectContext *context2=[appDelegate managedObjectContext];
            //            NSFetchRequest *request2=[[NSFetchRequest alloc] initWithEntityName:@"UserBooking"];
            //            NSMutableArray *fetchrequest2=[[context2 executeFetchRequest:request2 error:nil] mutableCopy];
            //            NSInteger CoreDataCount2=[fetchrequest2 count];
            //
            //            NSLog(@"Final core data count=%ld",(long)CoreDataCount2);
            
            [_tableviewmain reloadData];
        }
        else
        {
            [_tableviewmain setHidden:YES];
        }
        
        [spinner stopAnimating];
        [polygonView removeFromSuperview];
        
    }];
    
  
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 317;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      NSLog(@"Data array ----------->>>>>>> %@",dataarray);
    return [dataarray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    userrqst_cell=(userBookingandRequestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"userbookingandrequ"];
    
    
    userrqst_cell.productnamelbl.text=[[dataarray valueForKey:@"service_name"] objectAtIndex:indexPath.row];
    userrqst_cell.buyer_namelbl.text=[[dataarray valueForKey:@"buyer_name"] objectAtIndex:indexPath.row];
    
    NSString *oderdate=[[dataarray valueForKey:@"order_date"] objectAtIndex:indexPath.row];
    NSArray *holedatetime=[oderdate componentsSeparatedByString:@" "];
    NSString *date1=[holedatetime objectAtIndex:0];
    NSString *time=[holedatetime objectAtIndex:1];
    
    NSArray *finaltime=[time componentsSeparatedByString:@":"];
    NSString *currenttime=[NSString stringWithFormat:@"%@:%@",[finaltime objectAtIndex:0],[finaltime objectAtIndex:1]];
    
    NSLog(@"the time is %@",currenttime);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSDate *date = [dateFormatter dateFromString:currenttime];
    
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *pmamDateString = [dateFormatter stringFromDate:date];
    NSLog(@"%@",pmamDateString);
    
    
    
    
    
    userrqst_cell.order_datelbl.text=[NSString stringWithFormat:@"%@ %@",date1,pmamDateString];
    userrqst_cell.pricelbl.text=[[dataarray valueForKey:@"price"] objectAtIndex:indexPath.row];
    userrqst_cell.quantity.text=[[dataarray valueForKey:@"quantity"] objectAtIndex:indexPath.row];
    userrqst_cell.total_amountlbl.text=[[dataarray valueForKey:@"total_amount"] objectAtIndex:indexPath.row];
    
    status=[[dataarray valueForKey:@"status"] objectAtIndex:indexPath.row];
    if ([status isEqualToString:@"P"]) {
        userrqst_cell.statuslbl.text=@"Pending";
    }
    else if ([status isEqualToString:@"C"])
    {
        userrqst_cell.statuslbl.text=@"Confirmed";
    }
    paymentstatus=[[dataarray valueForKey:@"payment_status"]objectAtIndex:indexPath.row];
    
    if ([paymentstatus isEqualToString:@"N"])
    {
        userrqst_cell.payment_statuslbl.text=@"Pending";
    }
    else if([paymentstatus isEqualToString:@"Y"])
    {
        userrqst_cell.payment_statuslbl.text=@"Done";
        
    }
    
    userrqst_cell.containerView.layer.cornerRadius=6;
    userrqst_cell.containerView.clipsToBounds=YES;
    userrqst_cell.containerView.backgroundColor=[UIColor whiteColor];
    
    userrqst_cell.containerView.layer.shadowOffset=CGSizeMake(0, 1);
    userrqst_cell.containerView.layer.shadowRadius=3.5;
    userrqst_cell.containerView.layer.shadowColor=[UIColor blackColor].CGColor;
    userrqst_cell.containerView.layer.shadowOpacity=0.4;
    userrqst_cell.containerView.clipsToBounds=NO;
    
    
  // userrqst_cell.bottomLbl.layer.cornerRadius=6;
   // userrqst_cell.bottomLbl.clipsToBounds=YES;
   // CGFloat borderWidth = 1.0f;
    userrqst_cell.bottomLbl.backgroundColor=[UIColor clearColor];
   // userrqst_cell.bottomLbl.layer.borderColor = [UIColor blackColor].CGColor;
    //userrqst_cell.bottomLbl.layer.borderWidth = borderWidth;
    
    
    
    userrqst_cell.leftBtn.layer.cornerRadius=6;
    userrqst_cell.leftBtn.clipsToBounds=YES;
    userrqst_cell.rightBtn.layer.cornerRadius=6;
    userrqst_cell.rightBtn.clipsToBounds=YES;
    userrqst_cell.bottomBtn.layer.cornerRadius=6;
    userrqst_cell.bottomBtn.clipsToBounds=YES;

    
     return userrqst_cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

 //   NSLog(@"!st cell-----> %@",[dataarray objectAtIndex:indexPath.row]);


    [userrqst_cell.bookindProductImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[dataarray objectAtIndex:indexPath.row] valueForKey:@"service_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder_big"]];
    
    
    if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"is_requested"] isEqualToString:@"1"])
    {
    
        if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"requested_status"] isEqualToString:@"0"])
        {
        
            userrqst_cell.leftBtn.hidden=NO;
            userrqst_cell.rightBtn.hidden=NO;
            
            [userrqst_cell.leftBtn setTitle:@"Accept" forState:UIControlStateNormal];
            userrqst_cell.leftBtn.tag=1;
            [userrqst_cell.rightBtn setTitle:@"Deny" forState:UIControlStateNormal];
            userrqst_cell.rightBtn.tag=2;
            
            [userrqst_cell.rightBtn addTarget:self action:@selector(acceptDeny:) forControlEvents:UIControlEventTouchUpInside];
            [userrqst_cell.leftBtn addTarget:self action:@selector(acceptDeny:) forControlEvents:UIControlEventTouchUpInside];
            
            userrqst_cell.bottomLbl.hidden=YES;
            userrqst_cell.bottomBtn.hidden=YES;
            userrqst_cell.statusImage.hidden=YES;
        
        
        }
        
        else if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"requested_status"] isEqualToString:@"3"])
        {
            
            
            userrqst_cell.bottomLbl.hidden=NO;
            userrqst_cell.bottomLbl.textColor=[UIColor colorWithRed:219.0f/256 green:21.0f/256 blue:41.0f/256 alpha:1];
            
           // userrqst_cell.bottomLbl.layer.borderColor = [UIColor colorWithRed:219.0f/256 green:21.0f/256 blue:41.0f/256 alpha:1].CGColor;
            userrqst_cell.bottomLbl.text=@"Order Cancelled";
            userrqst_cell.leftBtn.hidden=YES;
            userrqst_cell.rightBtn.hidden=YES;
            userrqst_cell.bottomBtn.hidden=YES;
           userrqst_cell.statusImage.hidden=NO;
            userrqst_cell.statusImage.image=[UIImage imageNamed:@"denied"];
            
        }

        
        else if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"requested_status"] isEqualToString:@"2"])
        {
            userrqst_cell.bottomLbl.hidden=NO;
            userrqst_cell.bottomLbl.textColor=[UIColor colorWithRed:219.0f/256 green:21.0f/256 blue:41.0f/256 alpha:1];

           // userrqst_cell.bottomLbl.layer.borderColor = [UIColor colorWithRed:219.0f/256 green:21.0f/256 blue:41.0f/256 alpha:1].CGColor;
            userrqst_cell.bottomLbl.text=@"Request Denied";
            userrqst_cell.leftBtn.hidden=YES;
            userrqst_cell.rightBtn.hidden=YES;
            userrqst_cell.bottomBtn.hidden=YES;
           userrqst_cell.statusImage.hidden=NO;
            userrqst_cell.statusImage.image=[UIImage imageNamed:@"denied"];
            
            
            
        }
        
        else if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"requested_status"] isEqualToString:@"1"])
        {
            
           if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"P"] && [[[dataarray objectAtIndex:indexPath.row] valueForKey:@"payment_status"] isEqualToString:@"N"])
           {
             userrqst_cell.bottomLbl.text=@"Request Confirmed";
             userrqst_cell.bottomLbl.hidden=NO;
               userrqst_cell.bottomLbl.textColor=[UIColor colorWithRed:24.0f/256 green:181.0f/256 blue:124.0f/256 alpha:1];

             //  userrqst_cell.bottomLbl.layer.borderColor = [UIColor colorWithRed:24.0f/256 green:181.0f/256 blue:124.0f/256 alpha:1].CGColor;
             userrqst_cell.leftBtn.hidden=YES;
             userrqst_cell.rightBtn.hidden=YES;
             userrqst_cell.bottomBtn.hidden=YES;
               userrqst_cell.statusImage.hidden=NO;
               userrqst_cell.statusImage.image=[UIImage imageNamed:@"confirmed"];
           }
          else  if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"P"] && [[[dataarray objectAtIndex:indexPath.row] valueForKey:@"payment_status"] isEqualToString:@"Y"])
            {
                userrqst_cell.rightBtn.hidden=YES;
                
                 userrqst_cell.bottomBtn.hidden=NO;
       
                [userrqst_cell.bottomBtn setTitle:@"Manage" forState:UIControlStateNormal];
                
                userrqst_cell.bottomBtn.tag=indexPath.row;
                
                [userrqst_cell.bottomBtn addTarget:self action:@selector(manageBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                userrqst_cell.leftBtn.hidden=YES;
                
                userrqst_cell.bottomLbl.hidden=YES;
                userrqst_cell.statusImage.hidden=YES;
                
                
            }
          else  if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"C"] && [[[dataarray objectAtIndex:indexPath.row] valueForKey:@"payment_status"] isEqualToString:@"Y"])
            {
                
               // if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"C"])
                
                NSLog(@"Row no-----> %lu",indexPath.row);
                
                userrqst_cell.bottomBtn.hidden=NO;
                
                [userrqst_cell.bottomBtn setTitle:@"Details" forState:UIControlStateNormal];
                
                
                userrqst_cell.bottomBtn.tag=indexPath.row;
                
                [userrqst_cell.bottomBtn addTarget:self action:@selector(detailsBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                
                userrqst_cell.leftBtn.hidden=YES;
                
                userrqst_cell.bottomLbl.hidden=YES;
                
                userrqst_cell.rightBtn.hidden=YES;
                userrqst_cell.statusImage.hidden=YES;
                
            }
            
                      else
          {
              
              NSLog(@"UNWANTED----------1");
              
          }

            
            
        }
        
        else
        {
            
            NSLog(@"UNWANTED----------2");
            
            NSLog(@"unwanted data----> %@",[dataarray objectAtIndex:indexPath.row]);
            
        }


        
    
    }
    
   
    
    
    else if ([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"is_requested"] isEqualToString:@"0"])
    {
    
        if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"P"] && [[[dataarray objectAtIndex:indexPath.row] valueForKey:@"payment_status"] isEqualToString:@"N"])
        {
            userrqst_cell.bottomLbl.text=@"Waiting for Payment";
            userrqst_cell.bottomLbl.hidden=NO;
            userrqst_cell.bottomBtn.hidden=YES;
            userrqst_cell.leftBtn.hidden=YES;
            userrqst_cell.rightBtn.hidden=YES;
        }
        else  if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"P"] && [[[dataarray objectAtIndex:indexPath.row] valueForKey:@"payment_status"] isEqualToString:@"Y"])
        {
            userrqst_cell.bottomBtn.hidden=NO;
            
            [userrqst_cell.bottomBtn setTitle:@"Manage" forState:UIControlStateNormal];
            
            userrqst_cell.bottomBtn.tag=indexPath.row;
            
            [userrqst_cell.bottomBtn addTarget:self action:@selector(manageBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            userrqst_cell.leftBtn.hidden=YES;
            
            userrqst_cell.bottomLbl.hidden=YES;
            
            userrqst_cell.rightBtn.hidden=YES;
            userrqst_cell.statusImage.hidden=YES;

            
            
        }
        else  if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"C"] && [[[dataarray objectAtIndex:indexPath.row] valueForKey:@"payment_status"] isEqualToString:@"Y"])
        {
            
            // if([[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"C"])
            
            userrqst_cell.bottomBtn.hidden=NO;
            
            [userrqst_cell.bottomBtn setTitle:@"Details" forState:UIControlStateNormal];
            
            userrqst_cell.bottomBtn.tag=indexPath.row;
            
            [userrqst_cell.bottomBtn addTarget:self action:@selector(detailsBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            userrqst_cell.leftBtn.hidden=YES;
            
            userrqst_cell.bottomLbl.hidden=YES;
            
            userrqst_cell.rightBtn.hidden=YES;
            
            userrqst_cell.statusImage.hidden=YES;
            
        }
        
        else
        {
            
            NSLog(@"UNWANTED----------3");
            
            NSLog(@"Combination-----> %@ || %@",[[dataarray objectAtIndex:indexPath.row] valueForKey:@"status"],[[dataarray objectAtIndex:indexPath.row] valueForKey:@"payment_status"]);
            
            userrqst_cell.bottomLbl.text=@"Value Mismatch !!!";
            userrqst_cell.bottomLbl.hidden=NO;
            userrqst_cell.bottomLbl.textColor=[UIColor colorWithRed:24.0f/256 green:181.0f/256 blue:124.0f/256 alpha:1];
           // userrqst_cell.bottomLbl.layer.borderColor = [UIColor colorWithRed:24.0f/256 green:181.0f/256 blue:124.0f/256 alpha:1].CGColor;
            userrqst_cell.leftBtn.hidden=YES;
            userrqst_cell.rightBtn.hidden=YES;
            userrqst_cell.bottomBtn.hidden=YES;
            
        }


    
    }
    
    else
    {
        
        NSLog(@"UNWANTED----------4");
        
    }


}

-(void)acceptDeny:(UIButton *)sender
{

    NSString *stat=[NSString stringWithFormat:@"%ld",sender.tag];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableviewmain];
    NSIndexPath *indexPath = [_tableviewmain indexPathForRowAtPoint:buttonPosition];
    
    NSString *serviceId=[[dataarray objectAtIndex:indexPath.row] valueForKey:@"service_id"];
    NSString *bookingId=[[dataarray objectAtIndex:indexPath.row] valueForKey:@"booking_id"];
    
    
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString  *tzName = [timeZone name];

    
    globalobj=[[FW_JsonClass alloc]init];
    
     NSString *url= [NSString stringWithFormat:@"%@/app_user_service/app_user_booking_accept_deny_status?userid=%@&service_id=%@&booking_id=%@&booking_status=%@&user_timezone=%@",App_Domain_Url,userid,serviceId,bookingId,stat,tzName];
    
    NSLog(@"You are L -----> %@",url);
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"Result is here--------> %@",result);
        
        
    }];
    
    
//    
//    {
//        message = "booking status accepted";
//        response = success;
//    }
//


}

-(void)detailsBtnTapped:(UIButton *)sender
{
    
    
    ViewOrderDetailsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"orderdetails"];
    
    
    obj.holddata=[[dataarray objectAtIndex:sender.tag] mutableCopy];
    
    obj.fromManageButtnAction=YES;

    
    [self.navigationController pushViewController:obj animated:NO];
    
    
    
}

-(void)manageBtnTapped:(UIButton *)sender
{


    ViewOrderDetailsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"orderdetails"];
    
    
    obj.holddata=[[dataarray objectAtIndex:sender.tag] mutableCopy];
    
    [self.navigationController pushViewController:obj animated:NO];



}



//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
    
    
  //  if (editingStyle == UITableViewCellEditingStyleDelete)
    //{
        
        //add code here for when you hit delete
    //}
    
//}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
 //   return UITableViewCellEditingStyleDelete;
//}

//- (NSArray *)tableView:(UITableView *)tableView
//editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        NSString *status1=[[dataarray valueForKey:@"status"] objectAtIndex:indexPath.row];
//    
//        NSString *paymentstatus1=;
//    
//    
//    
//    if ([[[dataarray valueForKey:@"status"] objectAtIndex:indexPath.row] isEqualToString:@"C"] &&[[[dataarray valueForKey:@"payment_status"]objectAtIndex:indexPath.row] isEqualToString:@"Y"] )
//    {
//        UITableViewRowAction *button,*button2;
//        button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Manage" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                  {
//                      NSLog(@"manage action");
//                      
//                      ViewOrderDetailsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"orderdetails"];
//                      
//                      obj.holddata=[[dataarray objectAtIndex:indexPath.row] mutableCopy];
//                      
//                      [self.navigationController pushViewController:obj animated:NO];
//                  }];
//        button.backgroundColor = [UIColor colorWithRed:252/255.0f green:76/255.0f blue:79/255.0f alpha:1]; //arbitrary color
//        
//        
//        button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Add Review" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                   {
//                       NSLog(@"add action");
//                   }];
//        button2.backgroundColor = [UIColor colorWithRed:82/255.0f green:173/255.0f blue:33/255.0f alpha:1]; //arbitrary color
//        
//        return @[button,button2];
//    }
//    else
//    {
//        
//        UITableViewRowAction *button;
//        button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Manage" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                  {
//                      NSLog(@"manage action");
//           
//                      ViewOrderDetailsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"orderdetails"];
//                      
//                      
//                      obj.holddata=[[dataarray objectAtIndex:indexPath.row] mutableCopy];
//                 
//                      [self.navigationController pushViewController:obj animated:NO];
//                      
//                      
//                      NSLog(@"hole data %@",[dataarray objectAtIndex:indexPath.row]);
//                      
//                  }];
//        button.backgroundColor = [UIColor colorWithRed:252/255.0f green:76/255.0f blue:79/255.0f alpha:1]; //arbitrary color
//        
//        
//        return @[button];
//    }
//
//}

- (IBAction)backbtntapped:(id)sender
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
