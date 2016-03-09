//
//  NotificationViewController.m
//  FreeWilder
//
//  Created by Soumen on 01/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "NotificationViewController.h"
#import "Notificationcell.h"
#import "Footer.h"
#import "Side_menu.h"
#import <FacebookSDK/FacebookSDK.h>
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "ServiceView.h"
#import "accountsubview.h"
#import "LanguageViewController.h"
#import "notificationsettingsViewController.h"
#import "ChangePassword.h"
#import "userBookingandRequestViewController.h"
#import "MyBooking & Request.h"
#import "myfavouriteViewController.h"
#import "UserService.h"
#import "Business Information ViewController.h"
#import "PrivacyViewController.h"
#import "SettingsViewController.h"
#import "PaymentMethodViewController.h"
#import "WishlistViewController.h"
#import "profile.h"
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "ViewController.h"
#import "MsgSideMenu.h"
#import "BusinessProfileViewController.h"
#import "sideMenu.h"

//#import "ASIHTTPRequest.h"

@interface NotificationViewController ()<footerdelegate,Slide_menu_delegate,accountsubviewdelegate,Serviceview_delegate,Profile_delegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate,UIWebViewDelegate,NSURLConnectionDownloadDelegate,sideMenu,UIActionSheetDelegate>
{
    IBOutlet UISearchBar *inbox_searchBar;
     sideMenu *leftMenu;
    
    AppDelegate *appDelegate;
    ServiceView *service;
    BOOL tapchk,tapchk1,tapchk2;
    accountsubview *subview;
    profile *profileview;
    
    NSMutableArray *jsonArray;
    
    UIView *blackview ,*popview;
    UIView *backView ,*fullview;
    UITextField *phoneText;
    
    NSString *userid,*phoneno;
    FW_JsonClass *globalobj;
    
    MsgSideMenu *Msgview;
    IBOutlet UIView *sideMsgview;
    BOOL MsgMenuBool,srchTapbool;
    UIView *backGround;
    CGRect Tobbarfrm, sideMsgviewFrm ;
    UISearchBar *srchbox;
    UILabel *NoDatalbl;
    UIWebView *webView;
    
    Notificationcell *ncell;
    
    NSMutableArray *MainArray,*searchResult,*backupArray,*filterArray,*mainFilter;
    
    NSMutableArray *all_messages;
    NSMutableArray  *archive_messages;
    NSMutableArray *star_messages;
    NSMutableArray *unread_messages;
    NSMutableArray *read_messages;
    
    NSMutableArray *tapdata;
    
    int reload;
    BOOL chk;
    
    int user_id;
    
    float final;
    int timebool;
    
    NSMutableArray *checkBoxArray;
    NSMutableDictionary *checkBoxDic;

}




@end

@implementation NotificationViewController
@synthesize btnMessage,btnnotification;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // ncell = [[Notificationcell alloc]init];
    
    // For Side menu
    
    [inbox_searchBar setImage:[UIImage imageNamed:@"magnifierglass"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    inbox_searchBar.delegate=self;

    
    MsgTable.frame=CGRectMake(MsgTable.frame.origin.x, inbox_searchBar.frame.origin.y+inbox_searchBar.frame.size.height, MsgTable.bounds.size.width, _footer_base.frame.origin.y-(inbox_searchBar.frame.origin.y+inbox_searchBar.frame.size.height));
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here
    
    MainArray=Nil;
    all_messages=Nil;
    archive_messages=Nil;
    star_messages=Nil;
    unread_messages=Nil;
    read_messages=Nil;
    searchResult=Nil;
    filterArray=Nil;
    mainFilter=Nil;
    tapdata=Nil;
    
    checkBoxArray=[[NSMutableArray alloc]init];
    checkBoxDic=[[NSMutableDictionary alloc]init];
    
    backupArray=[[NSMutableArray alloc]init];
    globalobj=[[FW_JsonClass alloc]init];
    MainArray =[[NSMutableArray alloc]init];
    
    all_messages = [[NSMutableArray alloc]init];
    
    archive_messages=[[NSMutableArray alloc]init];
    
    star_messages=[[NSMutableArray alloc]init];
   
    unread_messages=[[NSMutableArray alloc]init];
    
    read_messages=[[NSMutableArray alloc]init];
    searchResult=[[NSMutableArray alloc]init];
    filterArray = [[NSMutableArray alloc]init];
    mainFilter=[[NSMutableArray alloc]init];
    tapdata=[[NSMutableArray alloc] init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    userid=[prefs valueForKey:@"UserId"];
    
    user_id = [userid intValue];
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
    footer.Delegate=self;
    [footer TapCheck:3];
    [_footer_base addSubview:footer];
    
    //MsgTable.frame=CGRectMake(0, header.frame.size.height+header.frame.origin.y, self.view.frame.size.width, );
    
    
   // //( @"table frm ====%f",MsgTable.frame.origin.y);
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connection:) name:@"no_internet" object:nil];
    
    
    Tobbarfrm=TopbarLbl.frame;
    sideMsgviewFrm=sideMsgview.frame;
    
    
    Msgview = [[MsgSideMenu alloc]init];
    Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
    
    
    Msgview.layer.masksToBounds = NO;
    Msgview.layer.shadowOffset = CGSizeMake(3, 10);
    Msgview.layer.shadowRadius = 5;
    Msgview.layer.shadowOpacity = 0.5;
    
    Msgview.hidden=YES;
    
    [Msgview.AllmsgTap addTarget:self action:@selector(allmessageTap) forControlEvents:UIControlEventTouchUpInside];
    [Msgview.ArchiveTap addTarget:self action:@selector(archiveTap) forControlEvents:UIControlEventTouchUpInside];
    [Msgview.starBtnTap addTarget:self action:@selector(starTap) forControlEvents:UIControlEventTouchUpInside];
    [Msgview.ReadTap addTarget:self action:@selector(readTap) forControlEvents:UIControlEventTouchUpInside];
    [Msgview.unreadTap addTarget:self action:@selector(unreadTap) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    backGround = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap1)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [backGround addGestureRecognizer:tapGestureRecognize];
    
    backGround.backgroundColor = [UIColor clearColor];
   
    [self.view addSubview:backGround];
    
    
    backGround.hidden=YES;
    
    
    [self.view addSubview:Msgview];
    
   // sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
    
    MsgMenuBool=YES;
    srchTapbool=YES;
    [self.view addSubview:sideMsgview];
    
    
     TopbarLbl.text = @"All Messages";
   
    
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@app_user_inbox?userid=%@&srch_msg=",App_Domain_Url,[prefs valueForKey:@"UserId"]];
    
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        
        
        NSMutableDictionary *results= [result valueForKey:@"infoarray"];
        
        
        
        all_messages=[results valueForKey:@"all_messages"];
       archive_messages =[results valueForKey:@"archive_messages"];
        star_messages=[results valueForKey:@"star_messages"];
        read_messages=[results valueForKey:@"read_messages"];
        unread_messages=[results valueForKey:@"unread_messages"];
        
        
        [self deleteAllEntities:@"Message"];
        
        
        
        
        
        
        
        NSManagedObjectContext *context=[appDelegate managedObjectContext];
        
        NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:all_messages];
        
        [newUser setValue:data forKey:@"allmessage"];
        
        
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:archive_messages];
        
        [newUser setValue:data1 forKey:@"archive"];
        
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:star_messages];
        
        [newUser setValue:data2 forKey:@"star"];
        
        
        NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:read_messages];
        
        [newUser setValue:data3 forKey:@"read"];
        
        NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:unread_messages];
        
        [newUser setValue:data4 forKey:@"unread"];
        
        
        
        [appDelegate saveContext];
       
        
        
        MainArray = [all_messages mutableCopy];
        
        backupArray=[MainArray mutableCopy];
        
      
        
       
        
        Msgview.allmsglbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[all_messages count]];
        Msgview.archivelbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[archive_messages count]];
        Msgview.starlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[star_messages count]];
        Msgview.readlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[read_messages count]];
        Msgview.unreadlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[unread_messages count]];
        
        
        
        [MsgTable reloadData];
        
        
        
        
       
        
        
        
    }];
    
    
   
    
    
    
    
    
    
    /// Getting side from Xiv & creating a black overlay
    
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
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        
        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
        
        sidemenu.ProfileImage.frame = CGRectMake(46, 26, 77, 77);
        
        [sidemenu.lblUserName setFont:[UIFont fontWithName:@"Lato" size:16]];
        
        sidemenu.btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn5.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn6.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn7.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        sidemenu.btn8.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.0];
        
        sidemenu.btn9.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        
        
        
        
        
        
    }
    
    else{
        
        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
        
    }
    

    
    //  //(@"user name=%@",[prefs valueForKey:@"UserName"]);
    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
    
    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
  //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
    sidemenu.hidden=YES;
    sidemenu.SlideDelegate=self;
    [self.view addSubview:sidemenu];
    
    
    
    
    [btnMessage setTitle:@"Messages" forState:UIControlStateNormal];
    [btnnotification setTitle:@"Notifications" forState:UIControlStateNormal];
}

//------Side menu methods Starts here

-(void)side
{
    [self.view addSubview:overlay];
    [self.view addSubview:leftMenu];
    
}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets=NO ;

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
//    //  //(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
//    // sidemenu.hidden=YES;
//    
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
//      //  //(@"phone----%@",phoneno);
//        
//        
//    }];
//    
//    
//    
//    
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
//}
//
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
                                

                                
                                leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-leftMenu.frame.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                
                                
                                
                            }
         
                         completion:^(BOOL finished)
         {
             
             
             
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
                // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
                 [self deleteAllEntities:@"ProductList"];
                 [self deleteAllEntities:@"WishList"];
                 [self deleteAllEntities:@"CategoryFeatureList"];
                 [self deleteAllEntities:@"CategoryList"];
               //  [self deleteAllEntities:@"ContactList"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84.00f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MainArray.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   ncell=(Notificationcell *)[MsgTable dequeueReusableCellWithIdentifier:@"notificationcell"];
    
    if(ncell==nil)
    {
    
        ncell=(Notificationcell *)[[Notificationcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"notificationcell"];
    
    }
    
    
    
    
    
    ncell.subjectlbl.text = [NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row] valueForKey:@"subject"]];
   
    ncell.msgBodylbl.text = [NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
    
  
    
    
    
   
    
    
   // NSInteger datetime = [[MainArray objectAtIndex:indexPath.row] valueForKey:@"sent_date"];
    
   
    [self timeBerfore:[[MainArray objectAtIndex:indexPath.row] valueForKey:@"sent_date"]];
    
    NSString *timeFinal = [NSString stringWithFormat:@"%f",final];
   
    NSArray *time= [timeFinal componentsSeparatedByString:@"."];
    
    
    // //(@"index path ---%d",(int)indexPath.row);
    
   // //(@"timeArray=====%@",time);
   
    NSString *lbltext;
    
    
    
    if (timebool==0)
    {
        if (time.count>=2)
        {

        
           // ncell.timelbl.text=[NSString stringWithFormat:@"Today %@ hours Ago",[[time objectAtIndex:1]substringToIndex:1]];
            
            
            ncell.timelbl.text=@"Today";
            
        }
    }
    
    
    if (timebool==1)
    {
        if (time.count>=2)
        {
            
            NSString  *newStr=[[time objectAtIndex:1] substringToIndex:1];
            
            
            lbltext = [NSString stringWithFormat:@"%@ day %@ hours Ago",[time objectAtIndex:0],newStr];
            
            
            ncell.timelbl.text =lbltext;
        }
        
        
        
    }
    
    
    
    
    
    if(timebool==2)
    {
        
       ncell.timelbl.text =[NSString stringWithFormat:@"%@ day Ago",[time objectAtIndex:0]];
        
        
    }
    
    
    
    
    
    [ncell.starimageTap addTarget:self action:@selector(startap:) forControlEvents:UIControlEventTouchUpInside];
    
     ncell.starimageTap.tag =indexPath.row;
    
//    if (checkBoxDic.count>0) {
//        
//        if ([checkBoxDic valueForKey:[NSString stringWithFormat:@"%lu", ncell.starimageTap.tag]])
//        {
//            
//            if ([[checkBoxDic valueForKey:[NSString stringWithFormat:@"%lu", ncell.starimageTap.tag]] isEqualToString:@"Y"]) {
//                
//
//                
//                [ ncell.starimageTap setImage:[UIImage imageNamed:@"Unchecked Checkbox-50"] forState:UIControlStateNormal];
//            }
//            
//            else
//            {
//                
//                
//                [ ncell.starimageTap setImage:[UIImage imageNamed:@"checked_box"] forState:UIControlStateNormal];
//                
//                
//            }
//            
//        }
//        
//    }
    
    
    int reciver_id=[[NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row]valueForKey:@"receiver_id"]] intValue];
    
      int sender_id=[[NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row]valueForKey:@"sender_id"]] intValue];
    
    
    
    NSString *file = [NSString stringWithFormat:@"%@",[MainArray[indexPath.row]valueForKey:@"file_name"]];
    
    
    if ([file isEqualToString:@"<null>"])
    {
     
        ncell.attachmentImage.hidden=YES;
        
    }
    else
    {
         ncell.attachmentImage.hidden=NO;
    }
    
    
    
     if (user_id==sender_id)
        
    {
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"read_status"] isEqualToString:@"N"])
            
            
        {
            
            
           // ncell.cellview.backgroundColor = [UIColor clearColor];
            
            
            ncell.backgroundColor =[UIColor colorWithRed:250.0f/256 green:250.0f/256 blue:250.0f/256 alpha:1];// [[UIColor lightGrayColor]colorWithAlphaComponent:.3f];
            
            
            
        }
        
        
        else if([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"read_status"] isEqualToString:@"Y"])
            
        {
            
           // ncell.cellview.backgroundColor = [UIColor whiteColor];
            
            // ncell.cellview.backgroundColor = [UIColor clearColor];
            
            ncell.backgroundColor = [UIColor whiteColor];
        }
        
        
        ///For star....
        
        
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"star_status"] isEqualToString:@"N"])
            
        {
            
            
            
            [ncell.starimageTap setImage:[UIImage imageNamed:@"Star-50"] forState:UIControlStateNormal];
            
            
            
            
        }
        
        
        else  if([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"star_status"] isEqualToString:@"Y"])
            
        {
            
            [ncell.starimageTap setImage:[UIImage imageNamed:@"Star Filled-50"] forState:UIControlStateNormal];
            
            
           // //(@"index path ---%d",(int)indexPath.row);
            
        }
        
    }
    
    
    
    
    
    
    
    else if (user_id==reciver_id)
    {
        
        
        
        ///For read & Unread....
        
        
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"read_status_receiver"] isEqualToString:@"N"])
            
            
        {
            
            
         //   ncell.cellview.backgroundColor = [UIColor clearColor];
            
            
            ncell.backgroundColor =[UIColor colorWithRed:250.0f/256 green:250.0f/256 blue:250.0f/256 alpha:1];// [[UIColor lightGrayColor]colorWithAlphaComponent:.3f];
            
            
            
            
            
            
        }
        
        
        else if([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"read_status_receiver"] isEqualToString:@"Y"])
            
        {
           //  ncell.cellview.backgroundColor = [UIColor clearColor];
            
            ncell.backgroundColor = [UIColor whiteColor];
            
            
        }
        
        
        ///For star....
        
        
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"star_status_receiver"] isEqualToString:@"N"])
            
        {
            
            
            
            [ncell.starimageTap setImage:[UIImage imageNamed:@"Star-50"] forState:UIControlStateNormal];
            
            
            
            
        }
        
        
        else  if([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"star_status_receiver"] isEqualToString:@"Y"])
            
        {
            
            [ncell.starimageTap setImage:[UIImage imageNamed:@"Star Filled-50"] forState:UIControlStateNormal];
            
            
            
            
        }
        
        
        
        
    }
    
    
    

    
    
    
    
    
//    if (tapdata.count>0)
//    {
//        
//    
//    
//    for (int k=0; k<tapdata.count; k++)
//            {
//        
//                NSString *data1=[[MainArray objectAtIndex:indexPath.row] valueForKey:@"inbox_id"];
//        
//                if ([data1 isEqualToString:[tapdata objectAtIndex:k]])
//                {
//        
//                    
//                    
//                     if (user_id==sender_id)
//                    {
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"star_status"] isEqualToString:@"N"])
//                        {
//                            
//                            
//                            
//                            
//                            [UIView animateWithDuration:0.7/1.5 animations:^{
//                                
//                                
//                                
//                                [ncell.starimageTap setImage:[UIImage imageNamed:@"Star Filled-50"] forState:UIControlStateNormal];
//                                
//                                
//                            }];
//                            
//                            
//                            
//                            
//                            
//                            
//                            
//                        }
//                        
//                        
//                        
//                        else
//                        {
//                            
//                            
//                            
//                            [UIView animateWithDuration:0.7/1.5 animations:^{
//                                
//                                
//                                
//                                [ncell.starimageTap setImage:[UIImage imageNamed:@"Star-50"] forState:UIControlStateNormal];
//                                
//                                
//                                
//                                
//                                
//                                
//                            }];
//                            
//                            
//                            
//                            
//                        }
//                        
//
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                    }
//                    
//                    
//                    
//                  else  if (user_id==reciver_id)
//                    {
//                        
//                        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"star_status_receiver"] isEqualToString:@"N"])
//                        {
//                            
//                            
//                            
//                            
//                            [UIView animateWithDuration:0.7/1.5 animations:^{
//                                
//                                
//                                
//                                [ncell.starimageTap setImage:[UIImage imageNamed:@"Star Filled-50"] forState:UIControlStateNormal];
//                                
//                                
//                            }];
//                            
//                            
//                            
//                            
//                            
//                            
//                            
//                        }
//                        
//                        
//                        
//                        else
//                        {
//                            
//                            
//                            
//                            [UIView animateWithDuration:0.7/1.5 animations:^{
//                                
//                                
//                                
//                                [ncell.starimageTap setImage:[UIImage imageNamed:@"Star-50"] forState:UIControlStateNormal];
//                                
//                                
//                                
//                                
//                                
//                                
//                            }];
//                            
//                            
//                            
//                            
//                        }
//                        
//                    }
//
//                    
//                    
//                    
//                    
//                    
//                    
//                }
//                
//                
//                
//                
//                        
//            }
//
//    
//
//    
//
//    }
    
    
    
    
    [ncell.checkBox addTarget:self action:@selector(markMessage:) forControlEvents:UIControlEventTouchUpInside];
    ncell.checkBox.tag=indexPath.row;
    
    
    ncell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return ncell;
}

-(void)markMessage:(id)sender
{

  

}


//-(void)markMessage:(id)sender
//{
//
//    UIButton *tappedBtn=(UIButton *)sender;
//    
//    NSMutableDictionary *checkDic=[[NSMutableDictionary alloc]init];
//    
//    if (checkBoxDic.count>0) {
//        
//        if ([checkBoxDic valueForKey:[NSString stringWithFormat:@"%lu",tappedBtn.tag]])
//        {
//            
//            if ([[checkBoxDic valueForKey:[NSString stringWithFormat:@"%lu",tappedBtn.tag]] isEqualToString:@"Y"]) {
//                
//                [checkDic setValue:@"N" forKey:[NSString stringWithFormat:@"%lu",tappedBtn.tag]];
//                
//                [checkBoxArray addObject:checkDic];
//                
//                [tappedBtn setImage:[UIImage imageNamed:@"Unchecked Checkbox-50"] forState:UIControlStateNormal];
//            }
//            
//            else
//            {
//            
//                [checkDic setValue:@"Y" forKey:[NSString stringWithFormat:@"%lu",tappedBtn.tag]];
//                
//                [checkBoxArray addObject:checkDic];
//                
//                [tappedBtn setImage:[UIImage imageNamed:@"checked_box"] forState:UIControlStateNormal];
//
//            
//            }
//            
//        }
//        
//    }
//    else
//    {
//    
//        [checkDic setValue:@"Y" forKey:[NSString stringWithFormat:@"%lu",tappedBtn.tag]];
//        
//        [checkBoxArray addObject:checkDic];
//        
//        [tappedBtn setImage:[UIImage imageNamed:@"checked_box"] forState:UIControlStateNormal];
//    
//    }
//    
//
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    int reciver_id=[[NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row]valueForKey:@"receiver_id"]] intValue];
    
    int sender_id=[[NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row]valueForKey:@"sender_id"]] intValue];
    
    if (user_id==sender_id)
        
    {
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"read_status"] isEqualToString:@"N"])
            
            
        {
          
            NSString *inboxid = [[MainArray objectAtIndex:indexPath.row] valueForKey:@"inbox_id"];
            
            NSString *url =[NSString stringWithFormat:@"%@app_inbox_read?userid=%@&inbox_id=%@",App_Domain_Url,userid,inboxid];
            
            
            
            [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
                
                
                if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                {
                    
                    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    
                    NSString *url = [NSString stringWithFormat:@"%@app_user_inbox?userid=%@&srch_msg=",App_Domain_Url,userid];
                    
                    
                    
                    
                    
                    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
                     
                     {
                         
                         
                         
                         
                         
                         NSMutableDictionary *results= [result valueForKey:@"infoarray"];
                         
                         
                         
                         
                         
                         
                         
                         if ([TopbarLbl.text isEqualToString:@"All Messages"])
                             
                         {
                             
                             
                             
                             all_messages=Nil;
                             
                             all_messages= [[NSMutableArray alloc]init];
                             
                             
                             
                             all_messages=[results valueForKey:@"all_messages"];
                             
                             
                             
                             [MainArray removeAllObjects];
                             
                             
                             
                             MainArray = [all_messages mutableCopy];
                             
                             
                             
                             
                             
                         }
                         
                         
                         
                         else if ([TopbarLbl.text isEqualToString:@"Archive Messages"])
                             
                         {
                             
                             
                             
                             archive_messages =Nil;
                             
                             archive_messages = [[NSMutableArray alloc]init];
                             
                             archive_messages =[results valueForKey:@"archive_messages"];
                             
                             [MainArray removeAllObjects];
                             
                             
                             
                             MainArray = [archive_messages mutableCopy];
                             
                             
                             
                             
                             
                         }
                         
                         else if ([TopbarLbl.text isEqualToString:@"Star Messages"])
                             
                         {
                             
                             
                             
                             star_messages=Nil;
                             
                             
                             
                             star_messages = [[NSMutableArray alloc]init];
                             
                             star_messages=[results valueForKey:@"star_messages"];
                             
                             
                             
                             [MainArray removeAllObjects];
                             
                             
                             
                             MainArray = [star_messages mutableCopy];
                             
                             
                             
                             
                             
                         }
                         
                         
                         
                         else if ([TopbarLbl.text isEqualToString:@"Read Messages"])
                             
                         {
                             
                             
                             
                             read_messages=Nil;
                             
                             read_messages = [[NSMutableArray alloc]init];
                             
                             read_messages=[results valueForKey:@"read_messages"];
                             
                             
                             
                             [MainArray removeAllObjects];
                             
                             
                             
                             MainArray = [read_messages mutableCopy];
                             
                             
                             
                             
                             
                         }
                         
                         else if ([TopbarLbl.text isEqualToString:@"Unread Messages"])
                             
                         {
                             
                             unread_messages=Nil;
                             
                             unread_messages = [[NSMutableArray alloc]init];
                             
                             unread_messages=[results valueForKey:@"unread_messages"];
                             
                             
                             
                             [MainArray removeAllObjects];
                             
                             
                             
                             MainArray = [unread_messages mutableCopy];
                             
                         }
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         [MsgTable reloadData];
                         
                         
                         
                         
                         
                         
                         
                     }];
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
                
            }];

            
        }
    }
    
    else if (user_id==reciver_id)
    {
                
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"read_status_receiver"] isEqualToString:@"N"])
                    
                    
                {
                    
                    
                    
                    
                    NSString *inboxid = [[MainArray objectAtIndex:indexPath.row] valueForKey:@"inbox_id"];
                    
                    NSString *url =[NSString stringWithFormat:@"%@app_inbox_read?userid=%@&inbox_id=%@",App_Domain_Url,userid,inboxid];
                    
                    
                    
                    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
                        
                        
                        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                        {
                            
                            [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor whiteColor]];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            NSString *url = [NSString stringWithFormat:@"%@app_user_inbox?userid=%@&srch_msg=",App_Domain_Url,userid];
                            
                            
                            
                            
                            
                            [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
                             
                             {
                                 
                                 
                                 
                                 
                                 
                                 NSMutableDictionary *results= [result valueForKey:@"infoarray"];
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 if ([TopbarLbl.text isEqualToString:@"All Messages"])
                                     
                                 {
                                     
                                     
                                     
                                     all_messages=Nil;
                                     
                                     all_messages= [[NSMutableArray alloc]init];
                                     
                                     
                                     
                                     all_messages=[results valueForKey:@"all_messages"];
                                     
                                     
                                     
                                     [MainArray removeAllObjects];
                                     
                                     
                                     
                                     MainArray = [all_messages mutableCopy];
                                     
                                     
                                     
                                     
                                     
                                 }
                                 
                                 
                                 
                                 else if ([TopbarLbl.text isEqualToString:@"Archive Messages"])
                                     
                                 {
                                     
                                     
                                     
                                     archive_messages =Nil;
                                     
                                     archive_messages = [[NSMutableArray alloc]init];
                                     
                                     archive_messages =[results valueForKey:@"archive_messages"];
                                     
                                     [MainArray removeAllObjects];
                                     
                                     
                                     
                                     MainArray = [archive_messages mutableCopy];
                                     
                                     
                                     
                                     
                                     
                                 }
                                 
                                 else if ([TopbarLbl.text isEqualToString:@"Star Messages"])
                                     
                                 {
                                     
                                     
                                     
                                     star_messages=Nil;
                                     
                                     
                                     
                                     star_messages = [[NSMutableArray alloc]init];
                                     
                                     star_messages=[results valueForKey:@"star_messages"];
                                     
                                     
                                     
                                     [MainArray removeAllObjects];
                                     
                                     
                                     
                                     MainArray = [star_messages mutableCopy];
                                     
                                     
                                     
                                     
                                     
                                 }
                                 
                                 
                                 
                                 else if ([TopbarLbl.text isEqualToString:@"Read Messages"])
                                     
                                 {
                                     
                                     
                                     
                                     read_messages=Nil;
                                     
                                     read_messages = [[NSMutableArray alloc]init];
                                     
                                     read_messages=[results valueForKey:@"read_messages"];
                                     
                                     
                                     
                                     [MainArray removeAllObjects];
                                     
                                     
                                     
                                     MainArray = [read_messages mutableCopy];
                                     
                                     
                                     
                                     
                                     
                                 }
                                 
                                 else if ([TopbarLbl.text isEqualToString:@"Unread Messages"])
                                     
                                 {
                                     
                                     unread_messages=Nil;
                                     
                                     unread_messages = [[NSMutableArray alloc]init];
                                     
                                     unread_messages=[results valueForKey:@"unread_messages"];
                                     
                                     
                                     
                                     [MainArray removeAllObjects];
                                     
                                     
                                     
                                     MainArray = [unread_messages mutableCopy];
                                     
                                 }
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 [MsgTable reloadData];
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                             }];
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }];

                    
                    
                    
                }
    }
    
    
    
    
            

            

    
    
    
    
    
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
    if (currentSelectedIndexPath != nil)
    {
        [[tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:[UIColor whiteColor]];
    }
    
    return indexPath;
}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.isSelected == YES)
    {
       // [ncell setBackgroundColor:[UIColor whiteColor]];
        
        ncell.backgroundColor = [UIColor whiteColor];
    }
//    else
//    {
//        [ncell setBackgroundColor:[UIColor whiteColor]];
//
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)DownloadTap: (UIButton *)sender
{
    
    fullview = [[UIView alloc]initWithFrame:MsgTable.frame];
    [self.view addSubview:fullview];
    
    NSString *link = [NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:sender.tag] valueForKey:@"file_download_path"]];
    
    
    //(@"link===%@",link);
  
    
    
    NSString *encode = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:encode]];
    
     backView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5f];
    
     webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,topImage.frame.origin.y+topImage.frame.size.height , self.view.frame.size.width, self.view.frame.size.height-topImage.frame.size.height)];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-45, webView.frame.origin.y-45, 40, 40)];
    
    
    
    [btn setImage:[UIImage  imageNamed:@"Cancel"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(CloseTap) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:btn];
    
    [self.view addSubview:backView];
    
    
    [backView addSubview:webView];
    
    webView.scalesPageToFit=YES;
    
    //webView.alpha=.5f;
    
    [webView setUserInteractionEnabled:YES];
    [webView setDelegate:self];
    [webView loadRequest:requestObj];
    
   
     //(@"file path====%@",requestObj);
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        
        backView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
    }];
    
    
    
   // [self.downloadManager addDownloadWithFilename:downloadFilename URL:url];
    
    // Create the download with the request and start loading the data.
    
   


}




-(void)CloseTap
{
    [fullview removeFromSuperview];
    
    [UIView animateWithDuration:.2f animations:^{
    
        
    backView.alpha=.5f;
        webView.alpha=.5f;
        
    backView.frame =CGRectMake(0, self.view.frame.size.height*.8, self.view.frame.size.width, self.view.frame.size.height);
    
    }
     completion:^(BOOL finished) {
        
         [UIView animateWithDuration:.4f animations:^{
             
             webView=Nil;
             [webView removeFromSuperview];
             
             backView.alpha=0;
              backView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
             
         }
          
          completion:^(BOOL finished) {
              
              
              [backView removeFromSuperview];
              
          }];
         
         
         
     }];
    
}









-(void)startap:(UIButton *)sender
{
 //   //(@"sender ====%ld",(long)sender.tag);
   
    reload =(int)sender.tag;
  
    
    UIView *clearview = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-_footer_base.frame.size.height*2)];
    
    clearview.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:clearview];
    
    
    chk=true;
    
    
    
    
    
    
    NSString *inbox_id=[[MainArray objectAtIndex:sender.tag] valueForKey:@"inbox_id"];
    
   // //(@"user id %@ %@",userid,data1);
    
    NSString *url = [NSString stringWithFormat:@"%@app_inbox_star?userid=%@&inbox_id=%@",App_Domain_Url,userid,inbox_id];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        
        
        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            
           
            
            NSString *url = [NSString stringWithFormat:@"%@app_user_inbox?userid=%@&srch_msg=",App_Domain_Url,userid];
            
            
            
            
            
            [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
             
             {
                 
                 
                 
                 
                 
                 NSMutableDictionary *results= [result valueForKey:@"infoarray"];
                 
                 
                 
                 
                 
                 
                 
                 if ([TopbarLbl.text isEqualToString:@"All Messages"])
                     
                 {
                     
                     
                     
                     all_messages=Nil;
                     
                     
                     
                     all_messages= [[NSMutableArray alloc]init];
                     
                     
                     
                     all_messages=[results valueForKey:@"all_messages"];
                     
                     
                     //(@"all++++++++++++++++%@",all_messages);
                     
                     
                     Msgview.allmsglbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[all_messages count]];
                     
                     [MainArray removeAllObjects];
                     
                     
                     
                     MainArray = [all_messages mutableCopy];
                     
                     
                     
                     
                     
                 }
                 
                 
                 
                 else if ([TopbarLbl.text isEqualToString:@"Archive Messages"])
                     
                 {
                     
                     
                     
                     archive_messages =Nil;
                     
                     archive_messages = [[NSMutableArray alloc]init];
                     
                     archive_messages =[results valueForKey:@"archive_messages"];
                     
                       Msgview.archivelbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[archive_messages count]];
                     
                     [MainArray removeAllObjects];
                     
                     
                     
                     MainArray = [archive_messages mutableCopy];
                     
                     
                     
                     
                     
                 }
                 
                 else if ([TopbarLbl.text isEqualToString:@"Star Messages"])
                     
                 {
                     
                     
                     
                     star_messages=Nil;
                     
                     
                     
                     // [star_messages removeAllObjects];
                     
                     star_messages = [[NSMutableArray alloc]init];
                     
                     
                     star_messages=[results valueForKey:@"star_messages"];
                     
                      Msgview.starlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[star_messages count]];
                     //(@"star**********************%@",star_messages);
                     
                     [MainArray removeAllObjects];
                     
                     
                     
                     MainArray = [star_messages mutableCopy];
                     
                     
                     
                     
                     
                 }
                 
                 
                 
                 else if ([TopbarLbl.text isEqualToString:@"Read Messages"])
                     
                 {
                     
                     
                     
                     read_messages=Nil;
                     
                     read_messages = [[NSMutableArray alloc]init];
                     
                     read_messages=[results valueForKey:@"read_messages"];
                     
                      Msgview.readlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[read_messages count]];
                     
                     [MainArray removeAllObjects];
                     
                     
                     
                     MainArray = [read_messages mutableCopy];
                     
                     
                     
                     
                     
                 }
                 
                 else if ([TopbarLbl.text isEqualToString:@"Unread Messages"])
                     
                 {
                     
                     unread_messages=Nil;
                     
                     unread_messages = [[NSMutableArray alloc]init];
                     
                     unread_messages=[results valueForKey:@"unread_messages"];
                     
                     Msgview.unreadlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[unread_messages count]];
                     
                     [MainArray removeAllObjects];
                     
                     
                     
                     MainArray = [unread_messages mutableCopy];
                     
                 }
                 
                 
                 
                 
                 
                 [MsgTable reloadData];
                 
                 
                 
               
                
                
                 
                 
                 
                 [clearview removeFromSuperview];
                 
             }];

            

        }
        
        
    }];
    
  
    
}


- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:reload inSection:0];
   // NSIndexPath* indexPath2 = [NSIndexPath indexPathForRow:4 inSection:3];
    // Add them in an index path array
    NSArray* indexArray = [NSArray arrayWithObjects:indexPath1, nil];
    // Launch reload for the two index path
    [MsgTable reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)MsgMenuTap:(id)sender
{
    
    
    
    if (MsgMenuBool==YES)
    {
        Msgview.hidden=NO;
        
        backGround.hidden=NO;
        
        
        
        
        
        [UIView animateWithDuration:.2f animations:^{
            
            Msgview.frame =CGRectMake(self.view.frame.origin.x, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
            
            
            sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
            
        }];
       
        
        
        MsgMenuBool=NO;
    }
    
    else
    {
        [UIView animateWithDuration:.2f animations:^{
            
            
            Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
            
            sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
            
        }
        
        completion:^(BOOL finished) {
            
            Msgview.hidden=YES;
            backGround.hidden=YES;
            
            
        }];
        
        
        
        MsgMenuBool=YES;
        
    }
    
   
    
}

- (IBAction)searchTap:(id)sender
{
    
    MsgTable.hidden=NO;
    [NoDatalbl removeFromSuperview];
    
    if (srchTapbool==YES)
    {
        srchBtn.userInteractionEnabled=NO;
        
        srchbox = [[UISearchBar alloc]init];
        
        
        srchbox.frame =CGRectMake(self.view.frame.size.width,TopbarLbl.frame.origin.y,TopbarLbl.frame.size.width,TopbarLbl.frame.size.height);
        
        srchbox.delegate=self;
        
        [self.view addSubview:srchbox];
        
        
        backupArray = [MainArray mutableCopy];
        
        
        [UIView animateWithDuration:.3f animations:^{
            
            NSLog(@"here first....");
            
            srchbox.frame=TopbarLbl.frame;
            
            TopbarLbl.frame= CGRectMake(self.view.frame.origin.x-TopbarLbl.frame.size.width, TopbarLbl.frame.origin.y, TopbarLbl.frame.size.width,TopbarLbl.frame.size.height);
            
            sideMsgview.frame = CGRectMake(self.view.frame.origin.x-sideMsgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
            
            srchTapbool=NO;
            
            
        }
         completion:^(BOOL finished) {
            
             srchImage.image = [UIImage imageNamed:@"Delete"];
             
             
             srchBtn.userInteractionEnabled=YES;
         }];
        
 
        
    }
    
    
    else
    {
        srchBtn.userInteractionEnabled=NO;
        
        [MainArray removeAllObjects];
        
        MainArray = [backupArray mutableCopy];
        [MsgTable reloadData];
        
        [backupArray removeAllObjects];
        
        
        [UIView animateWithDuration:.3f animations:^{
        
        
        srchbox.frame =CGRectMake(self.view.frame.size.width,TopbarLbl.frame.origin.y,TopbarLbl.frame.size.width,TopbarLbl.frame.size.height);
            
            TopbarLbl.frame=Tobbarfrm;
            sideMsgview.frame=sideMsgviewFrm;
            
            srchTapbool=YES;
            
            
        
        }
         completion:^(BOOL finished) {
             
             srchImage.image = [UIImage imageNamed:@"magnifierglass"];
             
             [srchbox removeFromSuperview];
             
             srchBtn.userInteractionEnabled=YES;
             
         }];
        
       
        
    }
    
    
    
}


-(void)cancelByTap1
{
    [UIView animateWithDuration:.2f animations:^{
        
        
        Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
        
        sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         Msgview.hidden=YES;
                         backGround.hidden=YES;
                         
                         
                     }];
    
    
    
    MsgMenuBool=YES;
    


}
-(void)allmessageTap
{
    
    
     TopbarLbl.text = @"All Messages";
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
        
        sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         Msgview.hidden=YES;
                         backGround.hidden=YES;
                         
                         
                     }];
    
    
    
    MsgMenuBool=YES;
    
    
    
    
    
    if (all_messages.count>0)
    {
        
        
        [MainArray removeAllObjects];
        
        MainArray = [all_messages mutableCopy];
        
        [backupArray removeAllObjects];
        backupArray=[MainArray mutableCopy];
        
        [MsgTable reloadData];
        
    }
    
   [self data];
    

    
    
}
-(void)archiveTap
{
    
    
    
    TopbarLbl.text = @"Archive Messages";
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
        
        sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         Msgview.hidden=YES;
                         backGround.hidden=YES;
                         
                         
                     }];
    
    
    
    MsgMenuBool=YES;
    

    
    
    
    if (archive_messages.count>0)
    {
        
        
        [MainArray removeAllObjects];
        [backupArray removeAllObjects];
        
        MainArray = [archive_messages mutableCopy];
        backupArray=[MainArray mutableCopy];
        [MsgTable reloadData];
        
    }
    
    [self data];
    
    
}
-(void)starTap
{
    
    
     TopbarLbl.text = @"Star Messages";
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
        
        sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         Msgview.hidden=YES;
                         backGround.hidden=YES;
                         
                         
                     }];
    
    
    
    MsgMenuBool=YES;
    
    
    
    
    
    if (star_messages.count>0)
    {
        
        
        [MainArray removeAllObjects];
        
        MainArray = [star_messages mutableCopy];
        
        [backupArray removeAllObjects];
        backupArray=[MainArray mutableCopy];
        
        [MsgTable reloadData];
        
    }
    
    [self data];

    
}
-(void)readTap
{
    
     TopbarLbl.text = @"Read Messages";
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
        
        sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         Msgview.hidden=YES;
                         backGround.hidden=YES;
                         
                         
                     }];
    
    
    
    MsgMenuBool=YES;
    
    
    
    
    
    if (read_messages.count>0)
    {
        
        
        [MainArray removeAllObjects];
        
        MainArray = [read_messages mutableCopy];
        
        [backupArray removeAllObjects];
        backupArray=[MainArray mutableCopy];
        
        [MsgTable reloadData];
        
    }
    
    [self data];

    
}
-(void)unreadTap
{
    
     TopbarLbl.text = @"Unread Messages";
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        Msgview.frame =CGRectMake(self.view.frame.origin.x-Msgview.frame.size.width, sideMsgview.frame.origin.y, Msgview.frame.size.width, Msgview.frame.size.height);
        
        sideMsgview.frame=CGRectMake(Msgview.frame.origin.x+Msgview.frame.size.width, sideMsgview.frame.origin.y, sideMsgview.frame.size.width, sideMsgview.frame.size.height);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         Msgview.hidden=YES;
                         backGround.hidden=YES;
                         
                         
                     }];
    
    
    
    MsgMenuBool=YES;
    
    
    
    
    
    if (unread_messages.count>0)
    {
        
        
        [MainArray removeAllObjects];
        
        MainArray = [unread_messages mutableCopy];
        
        [backupArray removeAllObjects];
        backupArray=[MainArray mutableCopy];
        
        [MsgTable reloadData];
        
    }
    
    [self data];

    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
  
    NSLog(@"BCK UP ARR------> %@",backupArray);
    
   // [srchbox setShowsCancelButton:YES];
    
   // //(@"backupArray---%@",backupArray);
    
    if (searchBar.text.length ==0)
    //if (inbox_searchBar.text.length ==0)
    {
        [NoDatalbl removeFromSuperview];
        MsgTable.hidden=NO;
        [MainArray removeAllObjects];
        MainArray =[backupArray mutableCopy];
        
        //(@"---search count---%d",(int)backupArray.count);
        
        [MsgTable reloadData];
        
          NSLog(@"Resigning keyboard... %@ \n ******* %ld",MainArray,backupArray.count);
        
        [searchBar performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0];
    }
    
    else {
        //(@"searchbar is");
        
        
        
       // [ArrSearchList removeAllObjects];
        // Filter the array using NSPredicate
       
        //searchResult = [[MainArray valueForKey:@"subject"] filteredArrayUsingPredicate:predicate];
       
        
       // NSArray *content = [MainArray valueForKey:@"subject"];
        
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
        
         searchResult = (NSMutableArray *)[[MainArray valueForKey:@"subject"] filteredArrayUsingPredicate:predicate];
        
        
        
        
        
        
        //(@"search result====%@",searchResult);
        
        int j=0;
        
        if (searchResult.count>0)
        {
            
            MsgTable.hidden=NO;
            [NoDatalbl removeFromSuperview];
            
            [filterArray removeAllObjects];
            
            for (int i=0; i<MainArray.count; i++)
            {
                
                
                NSString *msg = [NSString stringWithFormat:@"%@",[MainArray[i] valueForKey:@"subject"]];
                ////(@"string=======%@",msg);
                
                
                
                
                for (int a=0; a<searchResult.count; a++)
                {
                    NSString *check = [NSString stringWithFormat:@"%@",searchResult [a]];
                    
                    
                    if ([check isEqualToString:msg])
                    {
                      //  //(@"Name===%@=%@",msg,check );
                        
                        [filterArray insertObject:[MainArray objectAtIndex:i] atIndex:j];
                      
                        j++;
                        break;
                        
                        
                        
                    }
                }
                
                
                
                
                
                
                
                
            }

            
            
            [MainArray removeAllObjects];
            [MainArray addObjectsFromArray:filterArray];
            
            [MsgTable reloadData];
            
    }

        
        else
        {
            //(@"nodata======");
            
            
            
            MsgTable.hidden=YES;
            [NoDatalbl removeFromSuperview];
            
            NoDatalbl =[[UILabel alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
            
            
            NoDatalbl.text = @"No Data Found";
            NoDatalbl.textAlignment =NSTextAlignmentCenter;
            [NoDatalbl setFont:[UIFont fontWithName:@"Lato" size:16]];
            
            [self.view addSubview:NoDatalbl];
            
            
        }
       



   // //(@"Search result====%@",filterArray);
        
        
        
}
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [srchbox resignFirstResponder];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
      NSLog(@"Cancel button tapped in search bar...");
    
      [inbox_searchBar resignFirstResponder];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
        
    {
        
        
        
        //add code here for when you hit delete
        
    }
    
    
    
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    if ([userid isEqualToString:[[MainArray objectAtIndex:indexPath.row]valueForKey:@"sender_id"]])
        
    {
        
        
        
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"archive"] isEqualToString:@"N"])
            
            
            
        {
            
            
            
            
            
            return UITableViewCellEditingStyleDelete;
            
            
            
            
            
        }
        
        else
            
        {
            
            
            
            
            
            return nil;
            
        }
        
    }
    
    
   else if ([userid isEqualToString:[[MainArray objectAtIndex:indexPath.row]valueForKey:@"receiver_id"]])
        
    {
        
        
        
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"archive_receiver"] isEqualToString:@"N"])
            
            
            
        {
            
            
            
            
            
            return UITableViewCellEditingStyleDelete;
            
            
            
            
            
        }
        
        else
            
        {
            
            
            
            
            
            return nil;
            
        }
        
    }
    
    
    
    else
        
    {
        
        
        
        
        
        return nil;
        
    }
    
    
    
    
    
    
    
    
    
    
    
}







- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    UITableViewRowAction *button;
    
    
    
    
    if ([userid isEqualToString:[[MainArray objectAtIndex:indexPath.row]valueForKey:@"sender_id"]])
        
        
    {
        
        
        
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"archive"] isEqualToString:@"N"])
            
            
            
        {
            
            button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Archive" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                      
                      {
                          
                          
                          
                          
                          
                          
                          
                          //(@"tap");
                          
                          
                          
                          NSString *url =[NSString stringWithFormat:@"%@app_inbox_archive?userid=%@&inbox_id=%@",App_Domain_Url,userid,[NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row] valueForKey:@"inbox_id"]]];
                          
                          
                          
                          [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                                  
                              {
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  NSString *url = [NSString stringWithFormat:@"%@app_user_inbox?userid=%@&srch_msg=",App_Domain_Url,userid];
                                  
                                  
                                  
                                  
                                  
                                  [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
                                   
                                   {
                                       
                                       
                                       
                                       
                                       
                                       NSMutableDictionary *results= [result valueForKey:@"infoarray"];
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       if ([TopbarLbl.text isEqualToString:@"All Messages"])
                                           
                                       {
                                           
                                           
                                           
                                           all_messages=Nil;
                                           
                                           all_messages= [[NSMutableArray alloc]init];
                                           
                                           
                                           
                                           all_messages=[results valueForKey:@"all_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [all_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Archive Messages"])
                                           
                                       {
                                           
                                           
                                           
                                          archive_messages =Nil;
                                           
                                           archive_messages = [[NSMutableArray alloc]init];
                                           
                                           archive_messages =[results valueForKey:@"archive_messages"];
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [archive_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Star Messages"])
                                           
                                       {
                                           
                                           
                                           
                                           star_messages=Nil;
                                           
                                           
                                           
                                           star_messages = [[NSMutableArray alloc]init];
                                           
                                           star_messages=[results valueForKey:@"star_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [star_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Read Messages"])
                                           
                                       {
                                           
                                           
                                           
                                           read_messages=Nil;
                                           
                                           read_messages = [[NSMutableArray alloc]init];
                                           
                                           read_messages=[results valueForKey:@"read_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [read_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Unread Messages"])
                                           
                                       {
                                           
                                           unread_messages=Nil;
                                           
                                           unread_messages = [[NSMutableArray alloc]init];
                                           
                                           unread_messages=[results valueForKey:@"unread_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [unread_messages mutableCopy];
                                           
                                       }
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       [MsgTable reloadData];
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                   }];
                                  
                                  
                                  
                                  
                                  
                              }
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                          }];
                          
                          
                          
                          
                          
                          
                          
                          
                          
                      }];
            
            
            
            button.backgroundColor = [UIColor colorWithRed:247/255.0f green:191/255.0f blue:87/255.0f alpha:1];
            
            
            
            return @[button];
            
            
            
        }
        
        
        
        
        
        
        
        else
            
        {
            
            return nil;
            
        }
        
        
        
    }
    
    
    
    
    else if ([userid isEqualToString:[[MainArray objectAtIndex:indexPath.row]valueForKey:@"receiver_id"]])
        
    {
        
        
        
        if ([[[MainArray objectAtIndex:indexPath.row] valueForKey:@"archive_receiver"] isEqualToString:@"N"])
            
            
            
        {
            
            button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Archive" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                      
                      {
                          
                          
                          
                          
                          
                          
                          
                          //(@"tap");
                          
                          
                          
                          NSString *url =[NSString stringWithFormat:@"%@app_inbox_archive?userid=%@&inbox_id=%@",App_Domain_Url,userid,[NSString stringWithFormat:@"%@",[[MainArray objectAtIndex:indexPath.row] valueForKey:@"inbox_id"]]];
                          
                          
                          
                          [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                                  
                              {
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  NSString *url = [NSString stringWithFormat:@"%@app_user_inbox?userid=%@&srch_msg=",App_Domain_Url,userid];
                                  
                                  
                                  
                                  
                                  
                                  [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
                                   
                                   {
                                       
                                       
                                       
                                       
                                       
                                       NSMutableDictionary *results= [result valueForKey:@"infoarray"];
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       if ([TopbarLbl.text isEqualToString:@"All Messages"])
                                           
                                       {
                                           
                                           
                                           
                                           all_messages=Nil;
                                           
                                           all_messages= [[NSMutableArray alloc]init];
                                           
                                           
                                           
                                           all_messages=[results valueForKey:@"all_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [all_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Archive Messages"])
                                           
                                       {
                                           
                                           
                                           
                                           archive_messages =Nil;
                                           
                                           archive_messages = [[NSMutableArray alloc]init];
                                           
                                           archive_messages =[results valueForKey:@"archive_messages"];
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [archive_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Star Messages"])
                                           
                                       {
                                           
                                           
                                           
                                           star_messages=Nil;
                                         
                                           
                                           
                                           star_messages = [[NSMutableArray alloc]init];
                                           
                                           star_messages=[results valueForKey:@"star_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [star_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Read Messages"])
                                           
                                       {
                                           
                                           
                                           
                                           read_messages=Nil;
                                           
                                           read_messages = [[NSMutableArray alloc]init];
                                           
                                           read_messages=[results valueForKey:@"read_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [read_messages mutableCopy];
                                           
                                           
                                           
                                           
                                           
                                       }
                                       
                                       else if ([TopbarLbl.text isEqualToString:@"Unread Messages"])
                                           
                                       {
                                           
                                           unread_messages=Nil;
                                           
                                           unread_messages = [[NSMutableArray alloc]init];
                                           
                                           unread_messages=[results valueForKey:@"unread_messages"];
                                           
                                           
                                           
                                           [MainArray removeAllObjects];
                                           
                                           
                                           
                                           MainArray = [unread_messages mutableCopy];
                                           
                                       }
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       [MsgTable reloadData];
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                   }];
                                  
                                  
                                  
                                  
                                  
                              }
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                          }];
                          
                          
                          
                          
                          
                          
                          
                          
                          
                      }];
            
            
            
            button.backgroundColor = [UIColor colorWithRed:247/255.0f green:191/255.0f blue:87/255.0f alpha:1];             
            
            
            
            return @[button];
            
            
            
        }
        
        
        
        
        
        
        
        else
            
        {
            
            return nil;
            
        }
        
        
        
    }
    
    
    
    
    
    else
        
    {
        
        return nil;
        
    }
    
    
    
    
    
}

-(void)data
{
    NSString *url = [NSString stringWithFormat:@"%@app_user_inbox?userid=%@&srch_msg=",App_Domain_Url,userid];
    
    
    
    
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
         
         
         
         
         
         NSMutableDictionary *results= [result valueForKey:@"infoarray"];
         
         
         
         
         
        

         
         if ([TopbarLbl.text isEqualToString:@"All Messages"])
             
         {
             
             
             
             all_messages=Nil;
             
             
             
             all_messages= [[NSMutableArray alloc]init];
             
             
             
             all_messages=[results valueForKey:@"all_messages"];
             
             
              //(@"all++++++++++++++++%@",all_messages);
             
            

             
             
             [MainArray removeAllObjects];
             
             
             
             MainArray = [all_messages mutableCopy];
             
             
             
             
             
         }
         
         
         
         else if ([TopbarLbl.text isEqualToString:@"Archive Messages"])
             
         {
             
             
             
            archive_messages =Nil;
             
             archive_messages = [[NSMutableArray alloc]init];
             
             archive_messages =[results valueForKey:@"archive_messages"];
             
            
             
             [MainArray removeAllObjects];
             
             
             
             MainArray = [archive_messages mutableCopy];
             
             
             
             
             
         }
         
         else if ([TopbarLbl.text isEqualToString:@"Star Messages"])
             
         {
             
             
             
             star_messages=Nil;
             
             
             
            // [star_messages removeAllObjects];
             
             star_messages = [[NSMutableArray alloc]init];
             
             
             star_messages=[results valueForKey:@"star_messages"];
             
            
             
             
             //(@"star**********************%@",star_messages);
             
             [MainArray removeAllObjects];
             
             
             
             MainArray = [star_messages mutableCopy];
             
             
             
             
             
         }
         
         
         
         else if ([TopbarLbl.text isEqualToString:@"Read Messages"])
             
         {
             
             
             
             read_messages=Nil;
             
             read_messages = [[NSMutableArray alloc]init];
             
             read_messages=[results valueForKey:@"read_messages"];
             
            
             
             
             
             [MainArray removeAllObjects];
             
             
             
             MainArray = [read_messages mutableCopy];
             
             
             
             
             
         }
         
         else if ([TopbarLbl.text isEqualToString:@"Unread Messages"])
             
         {
             
             unread_messages=Nil;
             
             unread_messages = [[NSMutableArray alloc]init];
             
             unread_messages=[results valueForKey:@"unread_messages"];
             
             
            
             
             
             
             [MainArray removeAllObjects];
             
             
             
             MainArray = [unread_messages mutableCopy];
             
         }
         
         
         
         
         
         
         
        
         
        
         
         
        
         
        
         
         
     

         
         
         
         
         
         
         [MsgTable reloadData];
         
         
         
         Msgview.allmsglbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[all_messages count]];
         Msgview.archivelbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[archive_messages count]];
         Msgview.starlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[star_messages count]];
         Msgview.readlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[read_messages count]];
         Msgview.unreadlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[unread_messages count]];
         
         
         
     }];

}


-(float)timeBerfore:(NSString *)lastlogin
{
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [df dateFromString:lastlogin];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    dateFormatter = nil;
    
    
    NSDate *date2 = [df dateFromString:currentTime];
    
    NSTimeInterval inter = 0;
    
    if ([date1 compare:date2] == NSOrderedAscending)
    {
        inter = [date2 timeIntervalSinceDate:date1];
        
        
        int hours=0;
        final=0;
//        int seconds = (int)inter % 60;
//        int minutes = ((int)inter / 60) % 60;
         hours = (int)inter / 3600;
        
        
        
    
        if (hours<24)
        {
           
            
            
            timebool=0;
            
            final=(float)hours/24;
            
            
            
        }
        
        
        
    else if (hours>24 && hours<170)
        {
            timebool=1;
            
            
           final= (float)hours/24;
            
            
            
            
        }
        
        
        
        else
        {
           timebool=2;
            
            final= (float)hours/24;
            
           
            
            
        }
        
        
        
        
    }
    
    
    
    return final;
}



-(void)connection:(NSNotification *)note
{
    
   
    
    [self nointernet];
    
    
}


-(void)nointernet
{
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Message"inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDesc];
    
    
    
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    NSArray *objects1=[context executeFetchRequest:request error:&error];
    
    NSArray *objects2=[context executeFetchRequest:request error:&error];
    
    NSArray *objects3=[context executeFetchRequest:request error:&error];
    
    NSArray *objects4=[context executeFetchRequest:request error:&error];
    
    
    if (objects.count>0)
    {
        
        
        all_messages = [[NSMutableArray alloc]init];
        archive_messages= [[NSMutableArray alloc]init];
        read_messages= [[NSMutableArray alloc]init];
        star_messages= [[NSMutableArray alloc]init];
        unread_messages= [[NSMutableArray alloc]init];
        
        objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"allmessage"]];
        
        [all_messages addObjectsFromArray:objects];
        
        NSLog(@"all---%@",all_messages);
        
        objects1=[NSKeyedUnarchiver unarchiveObjectWithData:[[objects1 objectAtIndex:0]valueForKey:@"archive"]];
        
        [archive_messages addObjectsFromArray:objects1];
        
        
        objects2=[NSKeyedUnarchiver unarchiveObjectWithData:[[objects2 objectAtIndex:0]valueForKey:@"read"]];
        
        [read_messages addObjectsFromArray:objects2];
        
        
        
        objects3=[NSKeyedUnarchiver unarchiveObjectWithData:[[objects3 objectAtIndex:0]valueForKey:@"star"]];
        
        [star_messages addObjectsFromArray:objects3];
        
        
        
        objects4=[NSKeyedUnarchiver unarchiveObjectWithData:[[objects4 objectAtIndex:0]valueForKey:@"unread"]];
        
        [unread_messages addObjectsFromArray:objects4];
        
        
        
       
        
        // NSLog(@"----%@---%@",all_messages,star_messages);
        
        
        if ([TopbarLbl.text isEqualToString:@"All Messages"])
            
        {
            [MainArray removeAllObjects];
            
            MainArray = [all_messages mutableCopy];
            
            
        }
        
        
        
        else if ([TopbarLbl.text isEqualToString:@"Archive Messages"])
            
        {
            
            [MainArray removeAllObjects];
            
            MainArray = [archive_messages mutableCopy];
            
            
            
        }
        
        else if ([TopbarLbl.text isEqualToString:@"Star Messages"])
            
        {
            
            [MainArray removeAllObjects];
            
            MainArray = [star_messages mutableCopy];
            
            
        }
        
        
        
        else if ([TopbarLbl.text isEqualToString:@"Read Messages"])
            
        {
            [MainArray removeAllObjects];
            
            MainArray = [read_messages mutableCopy];
            
        }
        
        else if ([TopbarLbl.text isEqualToString:@"Unread Messages"])
            
        {
            [MainArray removeAllObjects];
            
            MainArray = [unread_messages mutableCopy];
            
            
        }
        
        [MsgTable reloadData];
        
        
        
        Msgview.allmsglbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[all_messages count]];
        Msgview.archivelbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[archive_messages count]];
        Msgview.starlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[star_messages count]];
        Msgview.readlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[read_messages count]];
        Msgview.unreadlbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)[unread_messages count]];
        
        
        
    }
}

#pragma mark-message filter tap action

- (IBAction)messageFilterOptions:(id)sender
{
    NSString *allMsgTitle,*archMsgTitle,*starMsgTitle,*readMsgTitle,*unreadMsgTitle;
    
    allMsgTitle  = [NSString stringWithFormat:@"All Message(%lu)",(unsigned long)[all_messages count]];
    archMsgTitle = [NSString stringWithFormat:@"Archived Message(%lu)",(unsigned long)[archive_messages count]];
    starMsgTitle = [NSString stringWithFormat:@"Starred Message(%lu)",(unsigned long)[star_messages count]];
    readMsgTitle = [NSString stringWithFormat:@"Read Message(%lu)",(unsigned long)[read_messages count]];
    unreadMsgTitle = [NSString stringWithFormat:@"Unread Message(%lu)",(unsigned long)[unread_messages count]];

    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Filter Messages"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:allMsgTitle,archMsgTitle,starMsgTitle,readMsgTitle,unreadMsgTitle, nil];
    
    [actionSheet showInView:self.view];
    
    
}


- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    for (UIView *_currentView in actionSheet.subviews) {
        if ([_currentView isKindOfClass:[UILabel class]]) {
            [((UILabel *)_currentView) setFont:[UIFont fontWithName:@"lato" size:15.0f]];
        }
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"Button index--> %ld",buttonIndex);
    
    if(buttonIndex==0)
    {
        
        
        TopbarLbl.text = @"All Messages";
        
        if (all_messages.count>0)
        {
            
            
            [MainArray removeAllObjects];
            
            MainArray = [all_messages mutableCopy];
            
            [backupArray removeAllObjects];
            backupArray=[MainArray mutableCopy];
            
            [MsgTable reloadData];
            
        }
        
        [self data];
        
        
        
        
    }
    else  if(buttonIndex==1)
    {
    
         TopbarLbl.text = @"Archived Messages";
        
        if (archive_messages.count>0)
        {
            
            
            [MainArray removeAllObjects];
            [backupArray removeAllObjects];
            
            MainArray = [archive_messages mutableCopy];
            backupArray=[MainArray mutableCopy];
            [MsgTable reloadData];
            
        }
        
        [self data];
    
    }
    else  if(buttonIndex==2)
    {
        
         TopbarLbl.text = @"Starred Messages";
        
        
        if (star_messages.count>0)
        {
            
            
            [MainArray removeAllObjects];
            
            MainArray = [star_messages mutableCopy];
            
            [backupArray removeAllObjects];
            backupArray=[MainArray mutableCopy];
            
            [MsgTable reloadData];
            
        }
    
       [self data];
        
    }
    else  if(buttonIndex==3)
    {
        
        TopbarLbl.text = @"Read Messages";
        
        
        
        if (read_messages.count>0)
        {
            
            
            [MainArray removeAllObjects];
            
            MainArray = [read_messages mutableCopy];
            
            [backupArray removeAllObjects];
            backupArray=[MainArray mutableCopy];
            
            [MsgTable reloadData];
            
        }
        
        [self data];
        
        
    }
    else  if(buttonIndex==4)
    {
        
        TopbarLbl.text = @"Unread Messages";
        
        
        
        if (unread_messages.count>0)
        {
            
            
            [MainArray removeAllObjects];
            
            MainArray = [unread_messages mutableCopy];
            
            [backupArray removeAllObjects];
            backupArray=[MainArray mutableCopy];
            
            [MsgTable reloadData];
            
        }
        
        [self data];
        
        
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}

-(void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL
{
  

}


@end
