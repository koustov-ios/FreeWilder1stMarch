//
//  rvwViewController.m
//  FreeWilder
//
//  Created by koustov basu on 07/01/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import "rvwViewController.h"
#import "FW_JsonClass.h"
#import "AppDelegate.h"

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
#import "sideMenu.h"


@interface rvwViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu>

{
    sideMenu *leftMenu;
    
    
    FW_JsonClass *globalobj;
    NSMutableDictionary *tempdic;
    NSMutableArray *reviews_about,*reviews_by;
    BOOL tap;
    UIView *DetailView;
    UIView *subview_ratings;
    NSString *userid;
    
    IBOutlet UIButton *rvwByU;
    IBOutlet UIButton *rvwAbtU;
    
    
#pragma mark - Footer variables
    
    Side_menu *sidemenu;
    UIView *overlay;
    NSMutableArray *ArrProductList;
    AppDelegate *appDelegate;
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

@implementation rvwViewController

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

    
    
    
    NSLog(@"In review -------");
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer_base addSubview:footer];
    temp= [[NSMutableArray alloc]init];
    

//------>
    
    _maintableview.delegate=self;
    _maintableview.dataSource=self;
    tap=false;
    [_maintableview setShowsHorizontalScrollIndicator:NO];
    [_maintableview setShowsVerticalScrollIndicator:NO];
    _maintableview.separatorColor = [UIColor clearColor];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    NSLog(@"userid %@",userid);
    
    
    [self urlfire];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets=NO ;
    
}

-(void)urlfire
{
    globalobj=[[FW_JsonClass alloc]init];
    tempdic=[[NSMutableDictionary alloc] init];
    reviews_about=[[NSMutableArray alloc] init];
    reviews_by=[[NSMutableArray alloc] init];
    NSString *urlstring=[NSString stringWithFormat:@"%@app_reviews_info?userid=%@",App_Domain_Url,userid];
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        tempdic=[result mutableCopy];
        NSLog(@"tempdata %@",tempdic);
        NSString *datachk=[tempdic valueForKey:@"response"];
        if ([datachk isEqualToString:@"success"])
        {
            reviews_about=[tempdic valueForKey:@"reviews_about"];
            reviews_by=[tempdic valueForKey:@"reviews_by"];
            NSLog(@"reviews_about%@",reviews_about);
            NSLog(@"reviews_by%@",reviews_by);
            [_maintableview reloadData];
            
        }
    }];
    
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
//      UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
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


// ------- FOOTER METHOD ENDS HERE --------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tap==false)
    {
        return [reviews_by count];
    }
    else if (tap==true)
    {
        return [reviews_about count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewCell *cell=(ReviewCell *)[tableView dequeueReusableCellWithIdentifier:@"reviewcellid"];
    
    
    if (tap==false)
    {
        cell.posted_bylabel.hidden=YES;
        cell.review_user_name.hidden=YES;
        cell.service_name.text=[[reviews_by objectAtIndex:indexPath.row]valueForKey:@"service_name"] ;
        cell.typedata.text=[[reviews_by objectAtIndex:indexPath.row]valueForKey:@"type"] ;
        
        [cell.service_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[reviews_by objectAtIndex:indexPath.row]valueForKey:@"service_image"] ]] placeholderImage:[UIImage imageNamed:@"ducati3"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        
    }
    else if (tap==true)
    {
        cell.posted_bylabel.hidden=NO;
        cell.review_user_name.hidden=NO;
        cell.service_name.text=[[reviews_about objectAtIndex:indexPath.row] valueForKey:@"service_name"] ;
        cell.typedata.text=[[reviews_about objectAtIndex:indexPath.row]valueForKey:@"type"] ;
        cell.review_user_name.text=[[reviews_about objectAtIndex:indexPath.row] valueForKey:@"review_user_name"] ;
        [cell.service_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[reviews_about objectAtIndex:indexPath.row]valueForKey:@"service_image"] ]] placeholderImage:[UIImage imageNamed:@"ducati3"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
    }
    
    
    cell.selectionStyle=NO;
    
    
    cell.reviewBtn.layer.cornerRadius=10;
    cell.reviewBtn.clipsToBounds=YES;
    cell.reviewBtn.tag=indexPath.row;
    [cell.reviewBtn addTarget:self action:@selector(viewReview:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.cellContainerView.layer.cornerRadius=6;
    cell.cellContainerView.clipsToBounds=YES;
    
    
     cell.cellContainerView.layer.shadowOffset=CGSizeMake(0, 1);
     cell.cellContainerView.layer.shadowRadius=3.5;
     cell.cellContainerView.layer.shadowColor=[UIColor blackColor].CGColor;
     cell.cellContainerView.layer.shadowOpacity=0.17;
     cell.cellContainerView.clipsToBounds=NO;

    
    return cell;
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        
//        //add code here for when you hit delete
//    }
//    
//}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}


-(void)viewReview:(UIButton *)sender
{
    NSLog(@"action2");
    
    
    DetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    DetailView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    
    [self.view addSubview:DetailView];
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelReviewByTap)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [DetailView addGestureRecognizer:tapGestureRecognize];
    
    
    subview_ratings=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
    
    subview_ratings.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:1];
    
    subview_ratings.layer.cornerRadius=10;
    
    
    [DetailView addSubview:subview_ratings];
    
    
    
    
    
    
    UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
    [titlelabel setFont:[UIFont systemFontOfSize:14]];
    
    
    titlelabel.text=[[reviews_about objectAtIndex:sender.tag] valueForKey:@"service_name"] ;
    
    
    
    UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 40, subview.frame.size.width, 1)];
    lineview.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:.5];
    
    UILabel *overall=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 20)];
    [overall setFont:[UIFont systemFontOfSize:14]];
    overall.text=@"Overall";
    
    
    UILabel *quality=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 20)];
    [quality setFont:[UIFont systemFontOfSize:14]];
    quality.text=@"Quality";
    
    
    
    UILabel *service=[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 100, 20)];
    [service setFont:[UIFont systemFontOfSize:14]];
    service.text=@"Service";
    
    
    
    
    UILabel *reviews=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 20)];
    [reviews setFont:[UIFont systemFontOfSize:14]];
    reviews.text=@"Reviews:";
    
    
    
    UILabel *reviewsdata=[[UILabel alloc] initWithFrame:CGRectMake(20, 135, 200, 20)];
    [reviewsdata setFont:[UIFont systemFontOfSize:14]];
    reviewsdata.text=[[reviews_about objectAtIndex:sender.tag]valueForKey:@"review_desc"] ;
    
    
    
    
    
    
    NSInteger ovealldata=[[[reviews_about objectAtIndex:sender.tag]valueForKey:@"overall_rating"]  integerValue];
    
    int x=70;
    
    for (int i=0; i<5; i++)
    {
        
        UIImageView *retingimage1=[[UIImageView alloc] initWithFrame:CGRectMake(x, 49, 20, 20)];
        if (i<ovealldata)
        {
            retingimage1.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        else
        {
            retingimage1.image=[UIImage imageNamed:@"Star-50"];
        }
        
        x=x+20;
        [subview_ratings addSubview:retingimage1];
    }
    
    NSInteger Qualitydata=[[[reviews_about objectAtIndex:sender.tag]valueForKey:@"quality_rating"]  integerValue];
    
    int p=70;
    
    for (int k=0; k<5; k++)
    {
        
        UIImageView *retingimage2=[[UIImageView alloc] initWithFrame:CGRectMake(p, 69, 20, 20)];
        
        if (k<Qualitydata)
        {
            retingimage2.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        else
        {
            retingimage2.image=[UIImage imageNamed:@"Star-50"];
        }
        
        p=p+20;
        [subview_ratings addSubview:retingimage2];
    }
    
    
    NSInteger Servicedata=[[[reviews_about objectAtIndex:sender.tag]valueForKey:@"service_rating"]  integerValue];
    
    int d=70;
    
    for (int s=0; s<5; s++)
    {
        
        UIImageView *retingimage3=[[UIImageView alloc] initWithFrame:CGRectMake(d, 89, 20, 20)];
        
        
        if (s<Servicedata)
        {
            retingimage3.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        else
        {
            retingimage3.image=[UIImage imageNamed:@"Star-50"];
        }
        
        d=d+20;
        [subview_ratings addSubview:retingimage3];
    }
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        
        subview_ratings.frame=   CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        
        
    }];
    
    
    
    [subview_ratings addSubview:overall];
    [subview_ratings addSubview:lineview];
    [subview_ratings addSubview:quality];
    
    [subview_ratings addSubview:service];
    
    [subview_ratings addSubview:reviews];
    [subview_ratings addSubview:reviewsdata];
    [subview_ratings addSubview:titlelabel];
    
    
    
}


//- (NSArray *)tableView:(UITableView *)tableView
//editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewRowAction *button;
//    if (tap==true) {
//        button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Review" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                  {
//                      NSLog(@"action2");
//                      
//                      
//                      DetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//                      DetailView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
//                      
//                      
//                      [self.view addSubview:DetailView];
//                      
//                      UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
//                      tapGestureRecognize.delegate = self;
//                      tapGestureRecognize.numberOfTapsRequired = 1;
//                      
//                      [DetailView addGestureRecognizer:tapGestureRecognize];
//                      
//                      
//                      subview=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
//                      
//                      subview.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:1];
//                      
//                      subview.layer.cornerRadius=10;
//                      
//                      
//                      [DetailView addSubview:subview];
//                      
//                      
//                      
//                      
//                      
//                      
//                      UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
//                      [titlelabel setFont:[UIFont systemFontOfSize:14]];
//                      
//                      
//                      titlelabel.text=[[reviews_about objectAtIndex:indexPath.row] valueForKey:@"service_name"] ;
//                      
//                      
//                      
//                      UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 40, subview.frame.size.width, 1)];
//                      lineview.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:.5];
//                      
//                      UILabel *overall=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 20)];
//                      [overall setFont:[UIFont systemFontOfSize:14]];
//                      overall.text=@"Overall";
//                      
//                      
//                      UILabel *quality=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 20)];
//                      [quality setFont:[UIFont systemFontOfSize:14]];
//                      quality.text=@"Quality";
//                      
//                      
//                      
//                      UILabel *service=[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 100, 20)];
//                      [service setFont:[UIFont systemFontOfSize:14]];
//                      service.text=@"Service";
//                      
//                      
//                      
//                      
//                      UILabel *reviews=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 20)];
//                      [reviews setFont:[UIFont systemFontOfSize:14]];
//                      reviews.text=@"Reviews:";
//                      
//                      
//                      
//                      UILabel *reviewsdata=[[UILabel alloc] initWithFrame:CGRectMake(20, 135, 200, 20)];
//                      [reviewsdata setFont:[UIFont systemFontOfSize:14]];
//                      reviewsdata.text=[[reviews_about objectAtIndex:indexPath.row]valueForKey:@"review_desc"] ;
//                      
//                      
//                      
//                      
//                      
//                      
//                      NSInteger ovealldata=[[[reviews_about objectAtIndex:indexPath.row]valueForKey:@"overall_rating"]  integerValue];
//                      
//                      int x=70;
//                      
//                      for (int i=0; i<5; i++)
//                      {
//                          
//                          UIImageView *retingimage1=[[UIImageView alloc] initWithFrame:CGRectMake(x, 49, 20, 20)];
//                          if (i<ovealldata)
//                          {
//                              retingimage1.image=[UIImage imageNamed:@"Star Filled-50"];
//                          }
//                          else
//                          {
//                              retingimage1.image=[UIImage imageNamed:@"Star-50"];
//                          }
//                          
//                          x=x+20;
//                          [subview addSubview:retingimage1];
//                      }
//                      
//                      NSInteger Qualitydata=[[[reviews_about objectAtIndex:indexPath.row]valueForKey:@"quality_rating"]  integerValue];
//                      
//                      int p=70;
//                      
//                      for (int k=0; k<5; k++)
//                      {
//                          
//                          UIImageView *retingimage2=[[UIImageView alloc] initWithFrame:CGRectMake(p, 69, 20, 20)];
//                          
//                          if (k<Qualitydata)
//                          {
//                              retingimage2.image=[UIImage imageNamed:@"Star Filled-50"];
//                          }
//                          else
//                          {
//                              retingimage2.image=[UIImage imageNamed:@"Star-50"];
//                          }
//                          
//                          p=p+20;
//                          [subview addSubview:retingimage2];
//                      }
//                      
//                      
//                      NSInteger Servicedata=[[[reviews_about objectAtIndex:indexPath.row]valueForKey:@"service_rating"]  integerValue];
//                      
//                      int d=70;
//                      
//                      for (int s=0; s<5; s++)
//                      {
//                          
//                          UIImageView *retingimage3=[[UIImageView alloc] initWithFrame:CGRectMake(d, 89, 20, 20)];
//                          
//                          
//                          if (s<Servicedata)
//                          {
//                              retingimage3.image=[UIImage imageNamed:@"Star Filled-50"];
//                          }
//                          else
//                          {
//                              retingimage3.image=[UIImage imageNamed:@"Star-50"];
//                          }
//                          
//                          d=d+20;
//                          [subview addSubview:retingimage3];
//                      }
//                      
//                      
//                      [UIView animateWithDuration:.3 animations:^{
//                          
//                          
//                          subview.frame=   CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//                          
//                          
//                      }];
//                      
//                      
//                      
//                      [subview addSubview:overall];
//                      [subview addSubview:lineview];
//                      [subview addSubview:quality];
//                      
//                      [subview addSubview:service];
//                      
//                      [subview addSubview:reviews];
//                      [subview addSubview:reviewsdata];
//                      [subview addSubview:titlelabel];
//                      
//                      
//                      
//                  }];
//        button.backgroundColor = [UIColor colorWithRed:247/255.0f green:191/255.0f blue:87/255.0f alpha:1]; //arbitrary color
//        
//    }
//    else if (tap==false)
//    {
//        button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Review" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                  {
//                      NSLog(@" action1");
//                      
//                      
//                      DetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//                      DetailView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
//                      
//                      
//                      
//                      UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
//                      tapGestureRecognize.delegate = self;
//                      tapGestureRecognize.numberOfTapsRequired = 1;
//                      
//                      [DetailView addGestureRecognizer:tapGestureRecognize];
//                      
//                      
//                      
//                      subview=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height , self.view.frame.size.width-20, self.view.frame.size.height * .3)];
//                      subview.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:1];
//                      subview.layer.cornerRadius=10;
//                      
//                      
//                      UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
//                      [titlelabel setFont:[UIFont systemFontOfSize:14]];
//                      
//                      
//                      titlelabel.text=[[reviews_by objectAtIndex:indexPath.row] valueForKey:@"service_name"] ;
//                      
//                      
//                      
//                      UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 40, subview.frame.size.width, 1)];
//                      lineview.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:.5];
//                      
//                      UILabel *overall=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 20)];
//                      [overall setFont:[UIFont systemFontOfSize:14]];
//                      overall.text=@"Overall";
//                      
//                      
//                      UILabel *quality=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 20)];
//                      [quality setFont:[UIFont systemFontOfSize:14]];
//                      quality.text=@"Quality";
//                      
//                      
//                      
//                      UILabel *service=[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 100, 20)];
//                      [service setFont:[UIFont systemFontOfSize:14]];
//                      service.text=@"Service";
//                      
//                      
//                      
//                      
//                      UILabel *reviews=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 20)];
//                      [reviews setFont:[UIFont systemFontOfSize:14]];
//                      reviews.text=@"Reviews:";
//                      
//                      
//                      
//                      UILabel *reviewsdata=[[UILabel alloc] initWithFrame:CGRectMake(20, 135, 100, 20)];
//                      [reviewsdata setFont:[UIFont systemFontOfSize:14]];
//                      reviewsdata.text=[[reviews_by objectAtIndex:indexPath.row] valueForKey:@"review_desc"] ;
//                      
//                      
//                      
//                      
//                      
//                      
//                      NSInteger ovealldata=[[[reviews_by objectAtIndex:indexPath.row]valueForKey:@"overall_rating"]  integerValue];
//                      
//                      int x=70;
//                      
//                      for (int i=0; i<5; i++)
//                      {
//                          
//                          UIImageView *retingimage1=[[UIImageView alloc] initWithFrame:CGRectMake(x, 49, 20, 20)];
//                          if (i<ovealldata)
//                          {
//                              retingimage1.image=[UIImage imageNamed:@"Star Filled-50"];
//                          }
//                          else
//                          {
//                              retingimage1.image=[UIImage imageNamed:@"Star-50"];
//                          }
//                          
//                          x=x+20;
//                          [subview addSubview:retingimage1];
//                      }
//                      
//                      NSInteger Qualitydata=[[[reviews_by objectAtIndex:indexPath.row]valueForKey:@"quality_rating"]  integerValue];
//                      
//                      int p=70;
//                      
//                      for (int k=0; k<5; k++)
//                      {
//                          
//                          UIImageView *retingimage2=[[UIImageView alloc] initWithFrame:CGRectMake(p, 69, 20, 20)];
//                          
//                          if (k<Qualitydata)
//                          {
//                              retingimage2.image=[UIImage imageNamed:@"Star Filled-50"];
//                          }
//                          else
//                          {
//                              retingimage2.image=[UIImage imageNamed:@"Star-50"];
//                          }
//                          
//                          p=p+20;
//                          [subview addSubview:retingimage2];
//                      }
//                      
//                      
//                      NSInteger Servicedata=[[[reviews_by objectAtIndex:indexPath.row]valueForKey:@"service_rating"]  integerValue];
//                      
//                      int d=70;
//                      
//                      for (int s=0; s<5; s++)
//                      {
//                          
//                          UIImageView *retingimage3=[[UIImageView alloc] initWithFrame:CGRectMake(d, 89, 20, 20)];
//                          
//                          
//                          if (s<Servicedata)
//                          {
//                              retingimage3.image=[UIImage imageNamed:@"Star Filled-50"];
//                          }
//                          else
//                          {
//                              retingimage3.image=[UIImage imageNamed:@"Star-50"];
//                          }
//                          
//                          d=d+20;
//                          [subview addSubview:retingimage3];
//                      }
//                      
//                      
//                      
//                      
//                      [subview addSubview:overall];
//                      [subview addSubview:lineview];
//                      [subview addSubview:quality];
//                      
//                      [subview addSubview:service];
//                      
//                      [subview addSubview:reviews];
//                      [subview addSubview:reviewsdata];
//                      [subview addSubview:titlelabel];
//                      [DetailView addSubview:subview];
//                      [self.view addSubview:DetailView];
//                      
//                      
//                      [UIView animateWithDuration:.3 animations:^{
//                          
//                          
//                          subview.frame=   CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//                          
//                          
//                      }];
//                      
//                  }];
//        button.backgroundColor = [UIColor colorWithRed:247/255.0f green:191/255.0f blue:87/255.0f alpha:1]; //arbitrary color
//        
//    }
//    
//    
//    return @[button];
//}


-(void)cancelReviewByTap
{
    
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        DetailView.alpha=.5f;
        
        subview_ratings.frame = CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         
                         [DetailView removeFromSuperview];
                         
                         
                     }];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:subview])
    {
        return false;
    }
    return true;
}




-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
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

- (IBAction)review_by_youbtn:(id)sender
{
    [rvwByU setBackgroundColor:[UIColor colorWithRed:39.0f/256 green:170.0f/256 blue:105.0f/256 alpha:1]];
    [rvwAbtU setBackgroundColor:[UIColor colorWithRed:225.0f/256 green:225.0f/256 blue:225.0f/256 alpha:1]];
    
    tap=false;
    [_maintableview reloadData];
}
- (IBAction)reviews_about_youbtn:(id)sender
{
    [rvwAbtU setBackgroundColor:[UIColor colorWithRed:39.0f/256 green:170.0f/256 blue:105.0f/256 alpha:1]];
    [rvwByU setBackgroundColor:[UIColor colorWithRed:225.0f/256 green:225.0f/256 blue:225.0f/256 alpha:1]];
      
    tap=true;
    [_maintableview reloadData];
}

- (IBAction)BackTap:(id)sender
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}

@end