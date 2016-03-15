//
//  DashboardViewController.m
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Reachability.h"
#import "AddServiceViewController.h"
#import "DashboardViewController.h"
#import "Footer.h"
#import "Side_menu.h"
#import "LanguageViewController.h"
#import "NSString+Language.h"
#import "NSString+Language_viet_.h"
#import "ForgotpasswordViewController.h"
#import "ServiceView.h"
#import "accountsubview.h"
#import "myfavouriteViewController.h"
#import "userBookingandRequestViewController.h"
#import "MyBooking & Request.h"
#import "UserService.h"
#import "ChangePassword.h"
#import "notificationsettingsViewController.h"
#import "SettingsViewController.h"
#import "Business Information ViewController.h"
#import "PrivacyViewController.h"
#import "PaymentMethodViewController.h"
#import "WishlistViewController.h"
#import "EditProfileViewController.h"
#import "ViewController.h"
#import "profile.h"
#import "Photos & Videos ViewController.h"
#import "Trust And Verification ViewController.h"
#import "rvwViewController.h"
#import "PayoutPreferenceViewController.h"
#import "NotificationViewController.h"
#import "SearchProductViewController.h"
#import "AddServiceViewController.h"
#import "FW_InviteFriendViewController.h"
#import "BusinessProfileViewController.h"
#import "FWServiceOrProductAddingViewController.h"

//New side menu file

#import "sideMenu.h"


@interface DashboardViewController ()<footerdelegate,Slide_menu_delegate,accountsubviewdelegate,Serviceview_delegate,Profile_delegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIScrollViewDelegate,sideMenu>

{
    
    // New Side menu
    
    
      sideMenu *leftMenu;
    
    //---->
    
    BOOL internetConnected;
    
    
    NSMutableArray *buttonCollection;
    
    IBOutlet UIButton *btn1;
    
    int langId;
    
    IBOutlet UIButton *btn2;
    
    IBOutlet UIButton *btn3;
    
    IBOutlet UIButton *btn4;
    
    IBOutlet UIButton *moreBtn;
    
    UIButton *temp1;
    
    UIButton *temp2;
    
    NSInteger resultCount;
    
    BOOL smallBtn;
    
    BOOL alreadyTapped;
    
    //frame variables
    
    CGRect leftframe;
    
    CGRect rightframe;
    
    //title var
    
    ServiceView *service;
    profile *profileview;
    
    UITextField *phoneText;
    
    int titleCount;
    BOOL tapchk,tapchk1,tapchk2;
    accountsubview *subview;
    
    
    UIView *popview ,*blackview;
    
    NSMutableArray *jsonArray;
    NSString *userid,*phoneno;
    
    NSMutableArray *tempNmae;
    
    NSUserDefaults *prefs;
    
    CGFloat moreBtnOrigin_y;
    
    UIButton *selectedBtn;
    

}

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@property (strong, nonatomic)NSMutableArray *jsonResult;

@property (strong, nonatomic) IBOutlet UIImageView *arrow;

@end

@implementation DashboardViewController

@synthesize scroll,jsonResult,lbl2nddummyText,lblDummyText,lblfindinterest,lblhaveBusiness,lblOr,btnGetStarted,fromLangChangePage;

-(BOOL)prefersStatusBarHidden
{
    return YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // fromLangChangePage=NO;
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here
    
    
    
    
    moreBtnOrigin_y=btn1.frame.origin.y+8;
    moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
    
    
    NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
    
    NSString *currentLang=[userData objectForKey:@"language"];

    
    NSLog(@"languageeeeeeeeee.......... %@",currentLang);
    
    if([currentLang isEqualToString:@"en"])
    {
    
        langId=1;
    
    }
  else  if([currentLang isEqualToString:@"pl"])
    {
        
        langId=3;
        
    }

  else  if([currentLang isEqualToString:@"vi"])
    {
        
        langId=4;
        
    }
    
    
    [_arrow setFrame:CGRectMake(self.lblhaveBusiness.frame.origin.x + self.lblhaveBusiness.frame.size.width + 5, self.arrow.frame.origin.y, self.arrow.frame.size.width, self.arrow.frame.size.height)];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tempNmae =[[NSMutableArray alloc]init];
    

    
    prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    
    ProfileImageView.layer.cornerRadius=ProfileImageView.frame.size.height/2.0;
    ProfileImageView.clipsToBounds = YES;
    
    
    [ProfileImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    resultCount=0;
    
    titleCount=4;
    
    smallBtn=YES;
    
    alreadyTapped=NO;
    
    
    
    
    leftframe=CGRectMake(0, 0, 0, 0);
    
    rightframe=CGRectMake(0, 0, 0, 0);
    
    
    //
    
    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,moreBtn.frame.origin.y+moreBtn.bounds.size.height);
    
    scroll.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    
    
    
    
    
    //initializing json class object
    
    
    
    
    globalobj=[[FW_JsonClass alloc]init];
    
    
    
    
    
 //  [self CoreDataTask];
    
    /// initializing app footer view
    
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
    footer.Delegate=self;
    [footer TapCheck:1];
    [_footer_base addSubview:footer];
    
    
    /// Getting side from Xib & creating a black overlay
    lblhaveBusiness.text=[appDelegate.currentLangDic valueForKey:@"Do_u_hv_bsns"];//LocalizedString(@"Do_u_hv_bsns");//@"DO YOU HAVE A BUSINESS?";
    lblOr.text=@"OR";
    lblDummyText.text=@"Lorem Ipsum is simply dummy text";
    lbl2nddummyText.text=@"Lorem Ipsum is simply dummy text";
    lblfindinterest.text=[appDelegate.currentLangDic valueForKey:@"Find_ur_intrst"];//LocalizedString(@"Find_ur_intrst");//Find_ur_intrst
    
    [btnGetStarted setTitle:[appDelegate.currentLangDic valueForKey:@"Get_Started"] /*LocalizedString(@"Get_Started") */forState:UIControlStateNormal];//Get_Started
    
    
    [moreBtn setTitle:@"More" forState:UIControlStateNormal];
    
  
    
    if ([[prefs valueForKey:@"lang_code"] isEqualToString:@"pl"])
    {
        lblhaveBusiness.text = [NSString lang_string];
    }
    else if ([[prefs valueForKey:@"lang_code"] isEqualToString:@"vi"])
    {
        lblhaveBusiness.text = [NSString lang_str];
    }

    

}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    
    jsonResult=[[NSMutableArray alloc]init];
    
    tempNmae=[[NSMutableArray alloc]init];
    
    buttonCollection=[[NSMutableArray alloc]init];
    
    [buttonCollection addObjectsFromArray:scroll.subviews];
    
    for (UIButton *btn in buttonCollection) {
        
        if ([btn isKindOfClass:[UIButton class]])
        {
            NSLog(@"Removing button-------");
            [btn removeFromSuperview];
        }
        
    }
    
    [scroll addSubview:moreBtn];
    [scroll addSubview:btnGetStarted];
    
     resultCount=0;
    
     titleCount=4;
    
    [self CoreDataTask];

}


- (void)CoreDataTask
{
     if (![[NSThread currentThread] isMainThread]) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           [self urlFire];
            
            
        });
        
        
    }
    
    else
    {
    
        [self urlFire];
    
    }
    
    
 }

#pragma mark-For Right Menu

//------Side menu methods Starts here

-(void)side
{
    [self.view addSubview:overlay];
    [self.view addSubview:leftMenu];
    
}


-(void)sideMenuAction:(int)tag
{
    
    NSLog(@"You have tapped menu %d",tag);
    
    prefs=[NSUserDefaults standardUserDefaults];
    
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


- (IBAction)backTapped:(id)sender
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



-(void)urlFire
{
    
   
        NSManagedObjectContext *context1=[appDelegate managedObjectContext];
        NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"CategoryList"];
    request.predicate=[NSPredicate predicateWithFormat:@"userid== %@ && langid== %@",userid,[NSString stringWithFormat:@"%d",langId]];
    
        [request setReturnsObjectsAsFaults:NO];
    
        NSArray *fetchrequest=[context1 executeFetchRequest:request error:nil];
        NSInteger CoreDataCount=[fetchrequest count];
    
    
          NSLog(@"I have got %ld data from local database....",CoreDataCount);
    
          NSLog(@"Object ----> %@",fetchrequest);
    
    
    
        if(CoreDataCount>0 && ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable))
        {
        
              //show from core data.....
            
            
            for (NSManagedObject *categoryObj in fetchrequest) {
                
                NSString *catname=[categoryObj valueForKey:@"categoryName"];
                NSString *catID=[categoryObj valueForKey:@"id"];
                
                  NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
                [tempDic setValue:catname forKey:@"categoryName"];
                [tempDic setValue:catID forKey:@"id"];
                
                [jsonResult addObject:tempDic];
            }
            
            
            
                if ([[UIScreen mainScreen] bounds].size.height == 568 && [[UIScreen mainScreen] bounds].size.width == 320)
                {
                    
                    
                    moreBtn.titleLabel.font= [UIFont systemFontOfSize:14.0f];
                    
                    if(jsonResult.count>=1)
                    {
                        [scroll addSubview:btn1];
                        
                        btn1.hidden=NO;
                        
                        moreBtnOrigin_y=btn1.frame.origin.y+btn1.frame.size.height+8;
                        moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                        
                        [btn1 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(0) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        
                        btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                        
                        
                        
                        
                        [btn1.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn1.layer.borderWidth=0.5;
                        
                        [btn1 setTitleColor:[UIColor colorWithRed:(115.0f/255.0) green:(115.0f/255.0) blue:(115.0f/255.0) alpha:3] forState:UIControlStateNormal];
                        [[btn1 layer] setBorderWidth:0.5f];
                        [[btn1 layer] setBorderColor:[UIColor colorWithRed:(171.0f/255.0) green:(171.0f/255.0) blue:(171.0f/255.0) alpha:1].CGColor];
                        [btn1 setBackgroundColor:[UIColor whiteColor]];
                        
                        
                        [btn1 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        btn1.tag=[[[jsonResult objectAtIndex:(0) ]valueForKey:@"id"] integerValue];
                        
                        
                        [btn1 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    
                    
                    if(jsonResult.count>=2)
                    {
                        //btn2
                        [scroll addSubview:btn2];
                        
                        btn2.hidden=NO;
                        
                        [btn2 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(1) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                        
                        
                        [btn2.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn2.layer.borderWidth=0.5;
                        
                        
                        
                        [btn2 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        btn2.tag=[[[jsonResult objectAtIndex:(1) ]valueForKey:@"id"] integerValue];
                        [btn2 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                    
                    if(jsonResult.count>=3)
                    {
                        
                        //btn3
                        
                        [scroll addSubview:btn3];
                        
                        btn3.hidden=NO;
                        
                        
                        moreBtnOrigin_y=btn3.frame.origin.y+btn3.frame.size.height+8;
                        moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                        
                        [btn3 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(2)]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                        
                        
                        [btn3.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn3.layer.borderWidth=0.5;
                        
                        
                        [btn3 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        
                        btn3.tag=[[[jsonResult objectAtIndex:(2) ]valueForKey:@"id"] integerValue];
                        [btn3 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                    }
                    
                    if(jsonResult.count>=4)
                    {
                        
                        //btn4
                        
                        [scroll addSubview:btn4];
                        
                        btn4.hidden=NO;
                        
                        [btn4 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(3) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                        
                        
                        
                        [btn4.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn4.layer.borderWidth=0.5;
                        
                        
                        [btn4 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        btn4.tag=[[[jsonResult objectAtIndex:(3) ]valueForKey:@"id"] integerValue];
                        [btn4 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                    
                    
                    
                }
                
                else
                {
                    
                    
                    //[btn1 setTitle:[NSString stringWithCString:[[[jsonResult objectAtIndex:(0) ]valueForKey:@"categoryname"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding  ] forState:UIControlStateNormal];
                    
                    if(jsonResult.count>=1)
                    {
                        
                        [scroll addSubview:btn1];
                        
                        btn1.hidden=NO;
                        
                        moreBtnOrigin_y=btn1.frame.origin.y+btn1.frame.size.height+8;
                        moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                        
                        [btn1 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(0) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        
                        
                        [btn1.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn1.layer.borderWidth=0.5;
                        
                        [btn1 setTitleColor:[UIColor colorWithRed:(115.0f/255.0) green:(115.0f/255.0) blue:(115.0f/255.0) alpha:3] forState:UIControlStateNormal];
                        [[btn1 layer] setBorderWidth:0.5f];
                        [[btn1 layer] setBorderColor:[UIColor colorWithRed:(171.0f/255.0) green:(171.0f/255.0) blue:(171.0f/255.0) alpha:1].CGColor];
                        [btn1 setBackgroundColor:[UIColor whiteColor]];
                        
                        
                        [btn1 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        btn1.tag=[[[jsonResult objectAtIndex:(0) ]valueForKey:@"id"] integerValue];
                        
                        
                        [btn1 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                    
                    if(jsonResult.count>=2)
                    {
                        //btn2
                        [scroll addSubview:btn2];
                        
                        btn2.hidden=NO;
                        
                        [btn2 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(1) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        
                        [btn2.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn2.layer.borderWidth=0.5;
                        
                        
                        
                        [btn2 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        btn2.tag=[[[jsonResult objectAtIndex:(1) ]valueForKey:@"id"] integerValue];
                        [btn2 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                    
                    
                    if(jsonResult.count>=3)
                    {
                        //btn3
                        
                        [scroll addSubview:btn3];
                        
                        btn3.hidden=NO;
                        
                        moreBtnOrigin_y=btn3.frame.origin.y+btn3.frame.size.height+8;
                        moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                        
                        [btn3 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(2) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        
                        [btn3.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn3.layer.borderWidth=0.5;
                        
                        
                        [btn3 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        
                        btn3.tag=[[[jsonResult objectAtIndex:(2) ]valueForKey:@"id"] integerValue];
                        [btn3 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                    }
                    
                    if(jsonResult.count>=4)
                    {
                        
                        //btn4
                        
                        [scroll addSubview:btn4];
                        
                        btn4.hidden=NO;
                        
                        [btn4 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(3) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                        
                        [btn4.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btn4.layer.borderWidth=0.5;
                        
                        
                        [btn4 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                        btn4.tag=[[[jsonResult objectAtIndex:(3) ]valueForKey:@"id"] integerValue];
                        [btn4 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                }
                
                scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, moreBtn.frame.origin.y+moreBtn.bounds.size.height+10);
                
                NSLog(@"json count----> %ld",jsonResult.count);
                
                
                
                if(jsonResult.count>4)
                {
                    resultCount=jsonResult.count;
                    resultCount-=4;
                    [self btnCreate];
                    
                    
                }
                
        
        }
    
        else
       {
    
          // When internet is connected fetching category data from online....
           
           
           NSString *urlstring=[NSString stringWithFormat:@"%@verify_app_category?categorytype=toplevel&lang_id=%d&userid=%@",App_Domain_Url,langId,userid];//verify_app_category
           
           [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
               
               
               jsonResult=[[NSMutableArray alloc]init];
               
               for ( NSDictionary *tempDict1 in  [result objectForKey:@"infoaray"])
               {
                   [jsonResult addObject:tempDict1];
                   
               }
               
               NSLog(@"Category list.... \n %@",jsonResult);
               
               
               if(jsonResult.count>0)
               {
                   
               
               
//               NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
//               [myQueue addOperationWithBlock:^{
                
                   //Deleting existing category list from core data
                   
                   for (NSManagedObject *car in fetchrequest) {
                       [context1 deleteObject:car];
                   }
                   NSError *saveError = nil;
                   [context1 save:&saveError];
                   
                   // Background work
                   
                   for ( NSDictionary *tempDict1 in  jsonResult)
                   {
                       NSLog(@"putting data in core data.");
                       
                       NSManagedObjectContext *context=[appDelegate managedObjectContext];
                       NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"CategoryList" inManagedObjectContext:context];
                       
                       [manageobject setValue:[tempDict1 valueForKey:@"id"] forKey:@"id"];
                       [manageobject setValue:[tempDict1 valueForKey:@"categoryName"] forKey:@"categoryName"];
                       //userid  //langid
                       [manageobject setValue:[NSString stringWithFormat:@"%d",langId] forKey:@"langid"];
                       [manageobject setValue:userid forKey:@"userid"];
                       
                       [appDelegate saveContext];
                   }

                   
              //     [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                       // Main thread work (UI usually)
                       
                       
                       if ([[UIScreen mainScreen] bounds].size.height == 568 && [[UIScreen mainScreen] bounds].size.width == 320)
                       {
                           
                           
                           moreBtn.titleLabel.font= [UIFont systemFontOfSize:14.0f];
                           
                           if(jsonResult.count>=1)
                           {
                               [scroll addSubview:btn1];
                               
                               btn1.hidden=NO;
                               
                               moreBtnOrigin_y=btn1.frame.origin.y+btn1.frame.size.height+8;
                               moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                               
                               [btn1 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(0) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               
                               btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                               
                               
                               
                               
                               [btn1.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn1.layer.borderWidth=0.5;
                               
                               [btn1 setTitleColor:[UIColor colorWithRed:(115.0f/255.0) green:(115.0f/255.0) blue:(115.0f/255.0) alpha:3] forState:UIControlStateNormal];
                               [[btn1 layer] setBorderWidth:0.5f];
                               [[btn1 layer] setBorderColor:[UIColor colorWithRed:(171.0f/255.0) green:(171.0f/255.0) blue:(171.0f/255.0) alpha:1].CGColor];
                               [btn1 setBackgroundColor:[UIColor whiteColor]];
                               
                               
                               [btn1 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               btn1.tag=[[[jsonResult objectAtIndex:(0) ]valueForKey:@"id"] integerValue];
                               
                               
                               [btn1 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                           }
                           
                           
                           if(jsonResult.count>=2)
                           {
                               //btn2
                               [scroll addSubview:btn2];
                               
                               btn2.hidden=NO;
                               
                               [btn2 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(1) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                               
                               
                               [btn2.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn2.layer.borderWidth=0.5;
                               
                               
                               
                               [btn2 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               btn2.tag=[[[jsonResult objectAtIndex:(1) ]valueForKey:@"id"] integerValue];
                               [btn2 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                               
                           }
                           
                           if(jsonResult.count>=3)
                           {
                               
                               //btn3
                               
                               [scroll addSubview:btn3];
                               
                               btn3.hidden=NO;
                               
                               
                               moreBtnOrigin_y=btn3.frame.origin.y+btn3.frame.size.height+8;
                               moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                               
                               [btn3 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(2)]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                               
                               
                               [btn3.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn3.layer.borderWidth=0.5;
                               
                               
                               [btn3 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               
                               btn3.tag=[[[jsonResult objectAtIndex:(2) ]valueForKey:@"id"] integerValue];
                               [btn3 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                               
                               
                           }
                           
                           if(jsonResult.count>=4)
                           {
                               
                               //btn4
                               
                               [scroll addSubview:btn4];
                               
                               btn4.hidden=NO;
                               
                               [btn4 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(3) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
                               
                               
                               
                               [btn4.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn4.layer.borderWidth=0.5;
                               
                               
                               [btn4 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               btn4.tag=[[[jsonResult objectAtIndex:(3) ]valueForKey:@"id"] integerValue];
                               [btn4 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                               
                           }
                           
                           
                           
                       }
                       
                       else
                       {
                           
                           
                           //[btn1 setTitle:[NSString stringWithCString:[[[jsonResult objectAtIndex:(0) ]valueForKey:@"categoryname"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding  ] forState:UIControlStateNormal];
                           
                           if(jsonResult.count>=1)
                           {
                               
                               [scroll addSubview:btn1];
                               
                               btn1.hidden=NO;
                               
                               moreBtnOrigin_y=btn1.frame.origin.y+btn1.frame.size.height+8;
                               moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                               
                               [btn1 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(0) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               
                               
                               [btn1.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn1.layer.borderWidth=0.5;
                               
                               [btn1 setTitleColor:[UIColor colorWithRed:(115.0f/255.0) green:(115.0f/255.0) blue:(115.0f/255.0) alpha:3] forState:UIControlStateNormal];
                               [[btn1 layer] setBorderWidth:0.5f];
                               [[btn1 layer] setBorderColor:[UIColor colorWithRed:(171.0f/255.0) green:(171.0f/255.0) blue:(171.0f/255.0) alpha:1].CGColor];
                               [btn1 setBackgroundColor:[UIColor whiteColor]];
                               
                               
                               [btn1 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               btn1.tag=[[[jsonResult objectAtIndex:(0) ]valueForKey:@"id"] integerValue];
                               
                               
                               [btn1 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                               
                           }
                           
                           if(jsonResult.count>=2)
                           {
                               //btn2
                               [scroll addSubview:btn2];
                               
                               btn2.hidden=NO;
                               
                               [btn2 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(1) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               
                               [btn2.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn2.layer.borderWidth=0.5;
                               
                               
                               
                               [btn2 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               btn2.tag=[[[jsonResult objectAtIndex:(1) ]valueForKey:@"id"] integerValue];
                               [btn2 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                               
                           }
                           
                           
                           if(jsonResult.count>=3)
                           {
                               //btn3
                               
                               [scroll addSubview:btn3];
                               
                               btn3.hidden=NO;
                               
                               moreBtnOrigin_y=btn3.frame.origin.y+btn3.frame.size.height+8;
                               moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, moreBtnOrigin_y, moreBtn.bounds.size.width, moreBtn.bounds.size.height);
                               
                               [btn3 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(2) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               
                               [btn3.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn3.layer.borderWidth=0.5;
                               
                               
                               [btn3 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               
                               btn3.tag=[[[jsonResult objectAtIndex:(2) ]valueForKey:@"id"] integerValue];
                               [btn3 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                               
                               
                           }
                           
                           if(jsonResult.count>=4)
                           {
                               
                               //btn4
                               
                               [scroll addSubview:btn4];
                               
                               btn4.hidden=NO;
                               
                               [btn4 setTitle:[NSString stringWithFormat:@"%@",[[jsonResult objectAtIndex:(3) ]valueForKey:@"categoryName"]] forState:UIControlStateNormal];
                               
                               [btn4.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                               btn4.layer.borderWidth=0.5;
                               
                               
                               [btn4 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
                               btn4.tag=[[[jsonResult objectAtIndex:(3) ]valueForKey:@"id"] integerValue];
                               [btn4 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
                               
                           }
                       }
                       
                       scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, moreBtn.frame.origin.y+moreBtn.bounds.size.height+10);
                       
                       NSLog(@"json count----> %ld",jsonResult.count);
                       
                       
                       
                       if(jsonResult.count>4)
                       {
                           resultCount=jsonResult.count;
                           resultCount-=4;
                           [self btnCreate];
                           
                           
                       }

                 //  }];
         //      }];
               
               
           }
            
            
           }];
           
            }
    
    
    
    
    NSLog(@"Result counte ------>>> %lu",resultCount);

}

-(void)btnCreate
{
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    NSLog(@"result count=%ld",(long)resultCount);
    leftframe=btn3.frame;
    rightframe=btn4.frame;
   
    NSInteger rows=resultCount/2;
    
    NSInteger oddRow = 0;
    
    if(resultCount%2)
    {
        rows+=1;
        
        oddRow=rows;
        
    }
    
    NSLog(@"Rows count: %ld",(long)rows);
    
    
    for (int i=0; i<rows; i++)
    {
        NSLog(@"creating button...");
        
        
        
        leftframe.origin.y=leftframe.origin.y+leftframe.size.height+6;
        
        
        if(smallBtn==YES)
        {
            temp1=[[UIButton alloc]initWithFrame:CGRectMake(leftframe.origin.x, leftframe.origin.y, btn4.bounds.size.width, leftframe.size.height)];
            
            smallBtn=NO;
        }
        else
        {
            temp1=[[UIButton alloc]initWithFrame:CGRectMake(leftframe.origin.x, leftframe.origin.y, btn3.bounds.size.width, leftframe.size.height)];//leftframe
            
            smallBtn=YES;
            
        }
        
        
        [temp1.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
        temp1.layer.borderWidth=0.5;
        
        
        [temp1 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
        
        //temp1.titleLabel.textColor=[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1];
        
        
        
        
        
        temp1.layer.cornerRadius=20.0f;
        

            temp1.tag=[[[jsonResult objectAtIndex:(titleCount) ]valueForKey:@"id"] integerValue];
        
        
        [temp1 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        // temp1.backgroundColor=[UIColor colorWithRed:(31.0f/255.0f) green:(173.0f/255.0f) blue:(121.0f/255.0f) alpha:1];
        
        
       
          //  [temp1 setTitle:[NSString stringWithCString:[[[jsonResult objectAtIndex:(titleCount)]valueForKey:@"categoryName"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding  ] forState:UIControlStateNormal];
            
            
     
            [temp1 setTitle:[[jsonResult objectAtIndex:(titleCount)]valueForKey:@"categoryName"] forState:UIControlStateNormal];
            
    
       
        
        
        
        
        if (screenBounds.size.height == 568 && screenBounds.size.width == 320)
        {
            
            temp1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0f];
        }
        
        
        leftframe=temp1.frame;
        
        [scroll addSubview:temp1];
        
        titleCount++;
        
        
        if(i!=oddRow-1)
        {
            NSLog(@"odd row....");
            
             NSLog(@"title count=%d",titleCount);
            
            CGRect rightTempFrame=leftframe;
            
            rightTempFrame.origin.x=leftframe.origin.x+temp1.bounds.size.width+10;
            
            temp2=[[UIButton alloc]initWithFrame:CGRectMake(rightTempFrame.origin.x, rightTempFrame.origin.y, rightframe.origin.x+rightframe.size.width-rightTempFrame.origin.x, rightframe.size.height)];
            
            if (screenBounds.size.height == 568 && screenBounds.size.width == 320)
            {
                
                temp2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            }
            
            
            
            [temp2.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
            temp2.layer.borderWidth=0.5;
            
            [temp2 setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
            
            
         
                temp2.tag=[[[jsonResult objectAtIndex:(titleCount) ]valueForKey:@"id"] integerValue];
  
                temp2.tag=[[[jsonResult objectAtIndex:(titleCount) ]valueForKey:@"id"] integerValue];
            
            
            
            
            [temp2 addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
         
              //  [temp2 setTitle:[NSString stringWithCString:[[[jsonResult objectAtIndex:(titleCount)]valueForKey:@"categoryName"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding  ] forState:UIControlStateNormal];
         
                [temp2 setTitle:[[jsonResult objectAtIndex:(titleCount)]valueForKey:@"categoryName"] forState:UIControlStateNormal];
                
 
           
            
            
            temp2.layer.cornerRadius=20.0f;
            
            rightframe=temp2.frame;
            
            [scroll addSubview:temp2];
            
            titleCount++;
            
        }
        
        
        
    }
    
    
     CGRect frameMore=moreBtn.frame;
    
    frameMore.origin.y=temp1.frame.origin.y+temp1.bounds.size.height+14;
    
    moreBtn.frame=frameMore;
    
    
    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, moreBtn.frame.origin.y+moreBtn.bounds.size.height+10);
    
}



-(void)btnTapped:(id)sender
{
    
    UIButton *tappedBtn=(UIButton *)(id)sender;
    
    
    if(tappedBtn.selected==NO)
    tappedBtn.selected=YES;
    else
        tappedBtn.selected=NO;
    
    if(tappedBtn.selected==YES)
    {
        
        NSLog(@"1st time..........");
        
        tappedBtn.backgroundColor=[UIColor colorWithRed:(31.0f/255.0f) green:(173.0f/255.0f) blue:(121.0f/255.0f) alpha:1];
        
        [tappedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        //shadow
        
        tappedBtn.layer.shadowOffset=CGSizeMake(0, 1);
        tappedBtn.layer.shadowRadius=3.5;
        tappedBtn.layer.shadowColor=[UIColor blackColor].CGColor;
        tappedBtn.layer.shadowOpacity=0.4;

        selectedBtn=tappedBtn;
        
        ProductViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Product_Page"];
        obj.CategoryId=[NSString stringWithFormat:@"%ld",(long)tappedBtn.tag];
        obj.headerTitle=tappedBtn.titleLabel.text;
        [self.navigationController pushViewController:obj animated:YES];

        
        
    }
    
    else
    {
        
        [tappedBtn.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
        tappedBtn.layer.borderWidth=0.5;
        
        [tappedBtn setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
        
        tappedBtn.backgroundColor=[UIColor whiteColor];
        
        tappedBtn.layer.shadowOpacity=0.0;
        
        
    }
    
    
}







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
    
    
//            DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
//            
//            [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
            
            NSLog(@"Here kidding man....");
            
            UIStoryboard *addServiceStoryBoard=[UIStoryboard storyboardWithName:@"FWAddService" bundle:nil];
            
            FWServiceOrProductAddingViewController *obj=[addServiceStoryBoard instantiateViewControllerWithIdentifier:@"FWServiceOrProductAdding"];
            
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
              
              
              //[subview removeFromSuperview];
              [service removeFromSuperview];
              [profileview removeFromSuperview];
              
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
                 
                 
                 
                 [service removeFromSuperview];
                 [profileview removeFromSuperview];
                 
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
                
                
                
                
                
                
            }
             
                             completion:^(BOOL finished)
             {
                 
                 
                 
                 
                 [subview removeFromSuperview];
                 [profileview removeFromSuperview];
                 
             }];
            
            
            
            
            
            
        }
        
        //[service removeFromSuperview];
        
        
        
        
        
        
        
        
        
    }
    
    else if (sender.tag==3)
    {
        //        [subview removeFromSuperview];
        //        [service removeFromSuperview];
        
        
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
                 
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 //[profileview removeFromSuperview];
                 
                 
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==phoneText)
    {
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            
        }];
        
        
    }
    
    [textField resignFirstResponder];
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
                      
                      phoneText.text=[prefs valueForKey:@"phone_no"];

                      
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
               // phoneno=phoneText.text;
                
                
                [prefs setObject:phoneText.text forKey:@"phone_no"];
                
                
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

-(void)SubmenuPushViewcontroller:(UIViewController *)viewcontroller withAnimation:(NSString *)Animation
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewcontroller animated:NO];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    
    [self Slide_menu_off];
    
    fromLangChangePage=NO;
}

-(void)viewDidDisappear:(BOOL)animated
{

    [selectedBtn.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
    selectedBtn.layer.borderWidth=0.5;
    
    [selectedBtn setTitleColor:[UIColor colorWithRed:(158.0f/255.0f) green:(158.0f/255.0f) blue:(158.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    
    selectedBtn.backgroundColor=[UIColor whiteColor];
    
    selectedBtn.layer.shadowOpacity=0.0;
    


}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




- (IBAction)more_interests:(id)sender
{
    DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Interest_page"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)get_started_button:(id)sender
{
    
    DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
    [self.navigationController pushViewController:obj animated:YES];
}
@end
