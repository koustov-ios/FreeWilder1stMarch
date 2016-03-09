//
//  SearchProductViewController.m
//  FreeWilder
//
//  Created by Priyanka ghosh on 14/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "SearchProductViewController.h"
#import "ForgotpasswordViewController.h"
#import "DashboardViewController.h"
#import "AppDelegate.h"
#import "NMRangeSlider.h"
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
#import "Business Information ViewController.h"
#import "PrivacyViewController.h"
#import "PaymentMethodViewController.h"
#import "WishlistViewController.h"
#import "profile.h"
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "ViewController.h"
#import "FW_JsonClass.h"
#import "searchCell.h"
#import "SearchResult.h"
#import "BusinessProfileViewController.h"
#import "sideMenu.h"
#import "FWlocationSearchViewController.h"


@interface SearchProductViewController () <Serviceview_delegate,accountsubviewdelegate,Profile_delegate,UIGestureRecognizerDelegate,UITextFieldDelegate,NSURLSessionDelegate,sideMenu,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    NSArray *serviceName,*serviceId,*filteredServiceArr;
    
    NSMutableArray *catid,*catname,*keywordName,*keywordId;
    
     IBOutlet UILabel *keywordLbl;
    
    float latitude,longitude;
    
    sideMenu *leftMenu;
    
    ServiceView *service;
    UIView *pickerview;
    UIDatePicker *datepicker;
    UIPickerView *picker;
    AppDelegate *appDelegate;
    BOOL tapchk,tapchk1,tapchk2,tabledatachk;
    accountsubview *subview;
    profile *profileview;
    
    NSMutableDictionary *data;
    
    NSMutableArray *jsonArray,*Arraytable;
    
    UIView *blackview ,*popview;
    UITextField *phoneText;
    
    NSString *userid,*phoneno;
    
    NSMutableArray *results;
    
    IBOutlet NMRangeSlider *priceRangeSlider;
    IBOutlet UILabel *categoryLbl;
    IBOutlet UIPickerView *catPicker;
    IBOutlet UIView *categoryPickerBaseView;
    
    IBOutlet UILabel *prdctSrchLbl;
    IBOutlet UITextField *bsnsOrServcTextField;
    IBOutlet UITextField *locationTextField;
    IBOutlet UILabel *endDateLbl;
    IBOutlet UIButton *searchBtn;
    IBOutlet UIButton *startDateBtn;
    IBOutlet UILabel *pricerangeLbl;
    
    
    
    NSString *productname,*location,*minPrice,*maxPrice,*startDate,*endDate,*category,*keyword;
}
@property(nonatomic,strong)CLLocationManager *locationManager;



@end

@implementation SearchProductViewController
@synthesize txtPreductName,txtLocation,LocationView,btnDate,btnTime,btnSearch,SearchTable,txtDays,txtTime,btnBack,lblProduct,lblPageTitle,lblMesg;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    productname=@"";
    location=@"";
    minPrice=@"";
    maxPrice=@"";
    startDate=@"";
    endDate=@"";
    category=@"";
    keyword=@"";
    
    //Location work
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    
    priceRangeSlider.maximumValue = 20000;
    priceRangeSlider.minimumValue = 1;
    priceRangeSlider.upperValue = 20000;
    priceRangeSlider.lowerValue = 1;
    // slider.curvatiousness = 1;
    priceRangeSlider.continuous=YES;
    [priceRangeSlider addTarget:self
               action:@selector(slideValueChanged:)
     forControlEvents:UIControlEventValueChanged];

    
    catid=[[NSMutableArray alloc]init];
    catname=[[NSMutableArray alloc]init];
    keywordName=[[NSMutableArray alloc]init];
    keywordId=[[NSMutableArray alloc]init];
    serviceName=[[NSArray alloc]init];
    serviceId=[[NSArray alloc]init];
    filteredServiceArr=[[NSArray alloc]init];
    
    
    categoryPickerBaseView.frame=CGRectMake(categoryPickerBaseView.frame.origin.x, self.view.bounds.size.height, categoryPickerBaseView.frame.size.width, categoryPickerBaseView.frame.size.height);

    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0];
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture1.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture1];
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    leftMenu.delegate=self;
    ///Side menu ends here

     appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    // Do any additional setup after loading the view.
    
        
    results = [[NSMutableArray alloc]init];
    
    
    tabledatachk=false;
    
    
    prdctSrchLbl.text=LocalizedString(@"Product Search");
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
    footer.Delegate=self;
    [footer TapCheck:2];
    [_footer_base addSubview:footer];
    
    
    TableBackView.frame=CGRectMake(TableBackView.frame.origin.x, (locationTextField.frame.origin.y+locationTextField.frame.size.height), TableBackView.frame.size.width, TableBackView.frame.size.height);
    
    
    //[self.view addSubview:TableBackView];
    TableBackView.hidden=YES;
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
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
    
    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFill;
    
    sidemenu.hidden=YES;
    sidemenu.SlideDelegate=self;
    [self.view addSubview:sidemenu];
    
    
    globalobj=[[FW_JsonClass alloc]init];
   // ArrSearchList=[[NSMutableArray alloc] init];
    
    txtPreductName.placeholder=LocalizedString(@"Business or Service");//@"Enter a Business or Service";
    txtLocation.placeholder=LocalizedString(@"Location");
    txtDays.placeholder=@"All Days";
    txtTime.placeholder=@"All Times";
    [btnSearch setTitle:LocalizedString(@"SEARCH") forState:UIControlStateNormal];
    [searchBtn setTitle:LocalizedString(@"SEARCH") forState:UIControlStateNormal];
    
    //lblPageTitle.text=@"Product Search";
    
    StartDateLbl.text=LocalizedString(@"Start Date");
    endDateLbl.text=LocalizedString(@"End Date");
    
    [self gettingAllServices];
    
    
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    
    
    [self.locationManager stopUpdatingLocation];
    
        CLLocation* eventLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
        [self getAddressFromLocation:eventLocation complationBlock:^(NSString * address) {
            if(address) {
    
                NSLog(@"Address----> %@",address);
                locationTextField.text=address;
                
              }
      }];
}


-(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock
{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@, %@ %@", placemark.name, placemark.postalCode, placemark.locality];
             completionBlock(address);
             
         }
     }];
}





-(void)viewWillAppear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"LocationNotification"
                                               object:nil];

}

-(void)receiveTestNotification:(NSNotification *)notify
{

    locationTextField.text=appDelegate.locationData;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------Side menu methods Starts here

-(void)side
{
    NSLog(@"Here....");
    
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
                            
                            
                            overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0];
                            
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
//    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
//    // sidemenu.hidden=YES;
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
                                
                                
                                
                                overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
                                
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
                // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                 //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
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



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [pickerview removeFromSuperview];
    //UITextField *yourTextField;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if(textField==txtLocation)
    {
       // [txtLocation addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }

    
}

//Filtering array from textfields text....

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField==bsnsOrServcTextField)
    {
        
        NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
        [myQueue addOperationWithBlock:^{
            
            // Background work
            
            //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",string];
            
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",str];
            
            filteredServiceArr = [serviceName filteredArrayUsingPredicate:resultPredicate];
            
            NSLog(@"Filtered array.... %@",filteredServiceArr);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // Main thread work (UI usually)
                
                if(filteredServiceArr.count>0)
                {
                   serviceSearchTable.hidden=NO;
                   [serviceSearchTable reloadData];
                }
                
              else  if(filteredServiceArr.count==0)
                {
                    serviceSearchTable.hidden=YES;
                }

                
            }];
        }];
        
        
    }
    
    return YES;

}

-(void)textFieldDidChange:(UITextField *)thetextfield
{
    
    
    if (txtLocation.text.length==0)
    {
        TableBackView.hidden=YES;
    }
    
    
    

    
    else
    {
        
        
        
        // Main thread work (UI usually)
        
        
        NSString *urlll =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?region=GB&key=AIzaSyA9CuugBNIOxYTO_GVn0fTEUaPzM03jvNo&input=%@",[txtLocation text]];
        
        
        NSString* encodedUrl = [urlll stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        
        
        NSURL *url = [NSURL URLWithString:encodedUrl];
        
        
        //--------------- GET Method-----------  //
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
        
        
        
        NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                        completionHandler:^(NSData *data1, NSURLResponse *response, NSError *error) {
                                                            if(error == nil)
                                                            {
                                                                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
                                                                
                                                                NSLog(@"RETURN DATA------> %@",dictionary);
                                                                
                                                                
                                                                if ([[dictionary valueForKey:@"status"] isEqualToString:@"OK"])
                                                                {
                                                                    
                                                                    
                                                                    
                                                                    data = [dictionary mutableCopy];
                                                                    
                                                                    
                                                                    NSLog(@"data %@",data);
                                                                    
                                                                    Arraytable=[data valueForKey:@"predictions"];
                                                                    
                                                                    Arraytable = [Arraytable valueForKey:@"description"];
                                                                   
                                                                    TableBackView.hidden=NO;
                                                                    
                                                                   
                                                                    NSLog(@"ARRA ====%@",Arraytable);
                                                                    
                                                                    
                                                                    [SearchTable reloadData];
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                                else if ([[dictionary valueForKey:@"status"] isEqualToString:@"ZERO_RESULTS"])
                                                                {
                                                                    //                                                                        obj=Nil;
                                                                    //                                                                        tablebackview.hidden=YES;
                                                                    //                                                                        blackview.hidden = YES;
                                                                    //                                                                        mytable.hidden=YES;
                                                                    //
                                                                    //                                                                        srchImage.hidden=NO;
                                                                    //                                                                        [spinnerSrch stopAnimating];
                                                                    
                                                                    //[lodertext stopAnimating];
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                                else
                                                                {
                                                                    UIAlertView *alart = [[UIAlertView alloc]initWithTitle:[data valueForKey:@"status"] message:[data valueForKey:@"error_message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                    [alart show];
                                                                    //                                                                        srchImage.hidden=NO;
                                                                    //                                                                        [spinnerSrch stopAnimating];
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }];
        
        [dataTask resume];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [pickerview removeFromSuperview];
    [textField resignFirstResponder];
    
    return YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)DayClick:(id)sender
{
    [txtPreductName resignFirstResponder];
    [txtLocation resignFirstResponder];
       [pickerview removeFromSuperview];
    [self OpenDatePicker];
    
}

-(void)createpicker
{
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 256, self.view.frame.size.width, 256)];
    
    //    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor colorWithRed:92.0f/255.0 green:92.0f/255.0f blue:92.0f/255.0f alpha:1];
    [cancelbtn setTitle:LocalizedString(@"Cancel") forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor colorWithRed:74.0f/255.0f green:182.0f/255.0f blue:125.0f/255.0f alpha:1];;
    [okbtn setTitle:LocalizedString(@"Ok") forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okaction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - 40)];
    
    [pickerview addSubview:picker];
    [self.view addSubview:pickerview];
    //    [picker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    
    picker.delegate = self;
    picker.dataSource = self;
}


-(void)OpenDatePicker
{
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 256, self.view.frame.size.width, 256)];
    
    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor colorWithRed:92.0f/255.0 green:92.0f/255.0f blue:92.0f/255.0f alpha:1];
    [cancelbtn setTitle:LocalizedString(@"Cancel") forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor colorWithRed:74.0f/255.0f green:182.0f/255.0f blue:125.0f/255.0f alpha:1];
    [okbtn setTitle:LocalizedString(@"Ok") forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okDateAction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelDateAction) forControlEvents:UIControlEventTouchUpInside];
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - 80)];
    //    [datepicker sizeToFit];
    [datepicker setDatePickerMode:UIDatePickerModeDate];
    [datepicker setMinimumDate:[NSDate date]];
    
   // [datepicker setMaximumDate:];
    
    [pickerview addSubview:datepicker];
    [self.view addSubview:pickerview];
}

-(void)okDateAction
{
    [pickerview removeFromSuperview];
    NSDateFormatter *dateFormator=[[NSDateFormatter alloc] init];
    //    [dateFormator setDateFormat:@"dd/MM/YYYY"];
    [dateFormator setDateFormat:@"MM-dd-YYYY"];
    NSString *datenew=[dateFormator stringFromDate:datepicker.date];
    StartDateLbl.textColor = [UIColor blackColor];
    
    [StartDateLbl setText:datenew];
    
    startDate=datenew;
    
}

-(void)okDateAction1
{
    [pickerview removeFromSuperview];
    
    NSDateFormatter *dateFormator=[[NSDateFormatter alloc] init];
    //    [dateFormator setDateFormat:@"dd/MM/YYYY"];
    [dateFormator setDateFormat:@"MM-dd-YYYY"];
    NSString *datenew=[dateFormator stringFromDate:datepicker.date];
    
    EndDateLbl.textColor = [UIColor blackColor];
    
    [EndDateLbl setText:datenew];
    
    endDate=datenew;
    
}

-(void) cancelDateAction
{
    [pickerview removeFromSuperview];
}

-(void)CrossClick
{
    [calenderView removeFromSuperview];
    
}


- (IBAction)TimeClick:(id)sender
{
    [txtPreductName resignFirstResponder];
    [txtLocation resignFirstResponder];
    [pickerview removeFromSuperview];
    
    [self createpicker];
}

-(void)okaction
{
    
    NSString *select = [ArrTime objectAtIndex:[picker selectedRowInComponent:0]];
    NSLog(@"picker selected:----%@",select);
    txtTime.text = select;
    [pickerview removeFromSuperview];
}

-(void)cancelaction
{
    [pickerview removeFromSuperview];
}


-(void)repeatpickerCancel
{
    [timeView removeFromSuperview];
}

-(void)pickerChange
{
    if ([time isEqualToString:@"" ] || time ==nil) {
        
        txtTime.text=[ArrTime objectAtIndex:0];
        // [btnTime setTitle:[ArrTime objectAtIndex:0] forState:UIControlStateNormal];
        
    }
    else
    {
        txtTime.text=time;
        // [btnTime setTitle:time forState:UIControlStateNormal];
    }
    
    time=@"";
    [timeView removeFromSuperview];
    
}



-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}
- (IBAction)SearchClick:(id)sender
{
    
    if (locationTextField.text.length==0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Faild" message:@"Enter Location(Mandetory)." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alrt show];
    }
    else
    {
        srchBtn.userInteractionEnabled=NO;
        
        location=locationTextField.text;
        
        [self SearchUrl];
    }
}
-(void)SearchUrl
{
    
    
    //    NSString *urlstring=[NSString stringWithFormat:@"%@app_product_details_cat?servicename=%@&serviceplae=%@&opendate=%@&timeopen=%@",App_Domain_Url,[txtPreductName text],[txtLocation text ],[txtDays text],[txtTime text]];
    //    NSLog(@"str=%@",urlstring);
 //   http://esolz.co.in/lab6/freewilder/app_product_details_cat?servicename=new&serviceplae=kolkata&opendate=09-30-2015&enddate=10-10-2015
    
   // http://esolz.co.in/lab6/freewilder/app_product_details_cat?servicename=test&serviceplae=kolkata&opendate=09-30-2015&enddate=10-10-2015&catid=2&price_low=1&price_high=20000&cur_id=3
    
    
    NSString *urlstring;
    
//    = [NSString stringWithFormat:@"%@app_product_details_cat?servicename=%@&serviceplae=%@&opendate=%@&enddate=%@&catid=&price_low=1&price_high=20000&cur_id=3",App_Domain_Url,[txtPreductName text],[txtLocation text],StartDateLbl.text,EndDateLbl.text];
//    NSLog(@"str=%@",urlstring);
    
    appDelegate=[[UIApplication sharedApplication]delegate];
    
    
    NSString *partUrl=[NSString stringWithFormat:@"%@app_product_details_cat?servicename=%@&serviceplae=%@&opendate=%@&enddate=%@&catid=%@&price_low=%@&price_high=%@&cur_id=%@&userid=%@&per_page=10&lang_id=%@&keyword_id=%@&srch_lat=%@&srch_lon=%@&sw_lat=%@&sw_lng=%@&ne_lat=%@&ne_lng=%@&&start_from=",App_Domain_Url,productname,locationTextField.text,startDate,endDate,category,minPrice,maxPrice,[[NSUserDefaults standardUserDefaults] valueForKey:@"curr_id"],[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"],[[NSUserDefaults standardUserDefaults] valueForKey:@"language"],keyword,appDelegate.location_lat,appDelegate.location_long,appDelegate.sw_lat,appDelegate.sw_long,appDelegate.ne_lat,appDelegate.ne_long];
    
    urlstring = [NSString stringWithFormat:@"%@app_product_details_cat?servicename=%@&serviceplae=%@&opendate=%@&enddate=%@&catid=%@&price_low=%@&price_high=%@&cur_id=%@&userid=%@&per_page=10&lang_id=%@&keyword_id=%@&srch_lat=%@&srch_lon=%@&sw_lat=%@&sw_lng=%@&ne_lat=%@&ne_lng=%@&start_from=0",App_Domain_Url,productname,locationTextField.text,startDate,endDate,category,minPrice,maxPrice,[[NSUserDefaults standardUserDefaults] valueForKey:@"curr_id"],[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"],[[NSUserDefaults standardUserDefaults] valueForKey:@"language"],keyword,appDelegate.location_lat,appDelegate.location_long,appDelegate.sw_lat,appDelegate.sw_long,appDelegate.ne_lat,appDelegate.ne_long];
    
    //*location_lat,*location_long,*sw_lat,*sw_long,*ne_lat,*ne_long
    
    [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"str=%@",urlstring);
    
    
    
    NSString *encode = [urlstring  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    BOOL net=[globalobj connectedToNetwork];
    
    if (net==YES)
    {
        [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
        
        {
            
            //   NSLog(@"result=%@",result);
            
            [results removeAllObjects];
            
            if([[result valueForKey:@"response"] isEqualToString:@"success"])
                
            {
                
                
                NSLog(@"result=%@",[result valueForKey:@"details"]);
                
                for ( NSDictionary *tempDict1 in  [result objectForKey:@"details"])
                {
                    [results addObject:tempDict1];
                }
                
                
                
               
                NSLog(@"+++++++++++++++++++++%@",results);
                
                SearchResult *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"result"];
                
                
                obj.ArrSearchList=[results mutableCopy];
                obj.urlString=encode;
                obj.producrname= [txtPreductName text];
                obj.location= [txtLocation text];
                obj.start_date= StartDateLbl.text;
                obj.end_date=  EndDateLbl.text;
                obj.prevStartValue=@"0";
                obj.partofUrl=partUrl;
                
                [self.navigationController pushViewController:obj animated:YES];
                
                
                
                
                
                
               
            }
            else
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Result Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alrt show];
            }
            
            
//            if (ArrSearchList.count==0)
//            {
//                
//                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Result Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                
//                [alrt show];
//            
//            
//            
//            }
//            else
//            {
//                lblMesg.hidden=YES;
//                LocationView.hidden=YES;
//                btnBack.hidden=NO;
//                lblProduct.text=@"";
//            }
            srchBtn.userInteractionEnabled=YES;
        }];
    }
    else{
        
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        
        srchBtn.userInteractionEnabled=YES;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if([tableView isEqual:serviceSearchTable])
    {
    
        bsnsOrServcTextField.text=[filteredServiceArr objectAtIndex:indexPath.row];
        [bsnsOrServcTextField resignFirstResponder];
        
        serviceSearchTable.hidden=YES;
        
        productname=[filteredServiceArr objectAtIndex:indexPath.row];
    
    }
    
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  NSLog(@"arr count1=%lu",(unsigned long)[ArrProductList count]);
    
    
        return [filteredServiceArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        serviceCell=(servicelTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"servicecell"];
    
        serviceCell.titleLabel.text = [filteredServiceArr objectAtIndex:indexPath.row];
    
    
    
        return serviceCell;
        
   
    
   
    
}
- (IBAction)BackClick:(id)sender
{
    LocationView.hidden=NO;
    btnBack.hidden=YES;
}


    - (IBAction)EndateBtnTap:(id)sender
    {
        [txtPreductName resignFirstResponder];
        [txtLocation resignFirstResponder];
        [pickerview removeFromSuperview];
        [self enddatepicker];
    }




-(void)enddatepicker

{
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 256, self.view.frame.size.width, 256)];
    
    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor colorWithRed:92.0f/255.0 green:92.0f/255.0f blue:92.0f/255.0f alpha:1];
    [cancelbtn setTitle:LocalizedString(@"Cancel") forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor colorWithRed:74.0f/255.0f green:182.0f/255.0f blue:125.0f/255.0f alpha:1];
    [okbtn setTitle:LocalizedString(@"Ok") forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okDateAction1) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelDateAction) forControlEvents:UIControlEventTouchUpInside];
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - 80)];
    //    [datepicker sizeToFit];
    [datepicker setDatePickerMode:UIDatePickerModeDate];
    //[datepicker setMinimumDate:[NSDate date]];
    
    // [datepicker setMaximumDate:];
    
    [pickerview addSubview:datepicker];
    [self.view addSubview:pickerview];

}
- (IBAction)locationTextFieldTapped:(id)sender {
    
    FWlocationSearchViewController *locationVC=[self.storyboard instantiateViewControllerWithIdentifier:@"location"];
    
    [self.navigationController presentViewController:locationVC animated:YES completion:^{
        
        
        // After completing
        
    }];

    
}

#pragma mark-Service name Selction methods

-(void)gettingAllServices
{
    
    
    NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_service_search_list",App_Domain_Url];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        if([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            
            
            NSMutableDictionary *infoDic =[[NSMutableDictionary alloc]init];
            infoDic=[[result valueForKey:@"info"] mutableCopy];
            
         //   NSLog(@"Dictionary----> %@",infoDic);
            
            if (infoDic.count>0)
            {
                NSLog(@"Creating service array....");
                
                    serviceName=[infoDic valueForKey:@"name"];
                    serviceId=[infoDic valueForKey:@"id"];
                
                // NSLog(@"Service array---> %@",serviceName);
                // NSLog(@"Service id---> %@",serviceId);
                
                
                catPicker.dataSource=self;
                catPicker.delegate=self;
                
                [self gettingAllCategories];
            }
            
            
        }
        
    }];
    
}





#pragma mark-Keyword Selction methods

-(void)gettingAllKeyword
{
    
    
    NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_keyword_list",App_Domain_Url];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        if([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            
            
            NSMutableArray *infoarray = [[result valueForKey:@"info"] mutableCopy];
            
            if (infoarray.count>0)
            {
                for (int i=0; i<infoarray.count; i++)
                {
                    
                    NSString *key_idTemp = [NSString stringWithFormat:@"%@",[infoarray[i]valueForKey:@"id"]];
                    NSString *key_nameTemp = [NSString stringWithFormat:@"%@",[infoarray[i]valueForKey:@"name"]];
                    
                    [keywordName insertObject:key_nameTemp atIndex:i];
                    [keywordId insertObject:key_idTemp atIndex:i];
                }
                catPicker.dataSource=self;
                catPicker.delegate=self;
            }
            
            //NSLog(@"Key word....\n %@",keywordName);
            
            //NSLog(@"Key id....\n %@",keywordId);
            
        }
        
    }];
    
}



- (IBAction)chooseKeywordTapped:(id)sender {
    
    [self.view addSubview:categoryPickerBaseView];
    
    catPicker.tag=1;
    
    [catPicker reloadAllComponents];
    [catPicker selectRow:0 inComponent:0 animated:NO];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        categoryPickerBaseView.frame=CGRectMake(categoryPickerBaseView.frame.origin.x, self.view.frame.size.height-(categoryPickerBaseView.frame.size.height), categoryPickerBaseView.frame.size.width, categoryPickerBaseView.frame.size.height);
        
    }];
    
    // self.view.frame.size.height-(categoryPickerBaseView.frame.size.height)
    
}


#pragma mark-category Selction methods


-(void)gettingAllCategories
{
    
    
    NSString *url = [NSString stringWithFormat:@"%@app_all_categories",App_Domain_Url];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
          if([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            
            
            NSMutableArray *infoarray = [[result valueForKey:@"infoarray"] mutableCopy];
            
            if (infoarray.count>0)
            {
                 for (int i=0; i<infoarray.count; i++)
                {
                    
                    NSString *cat_idTemp = [NSString stringWithFormat:@"%@",[infoarray[i]valueForKey:@"id"]];
                    NSString *cat_nameTemp = [NSString stringWithFormat:@"%@",[infoarray[i]valueForKey:@"cat_name"]];
                              [catname insertObject:cat_nameTemp atIndex:i];
                    [catid insertObject:cat_idTemp atIndex:i];
                }
                catPicker.dataSource=self;
                catPicker.delegate=self;
                
                [self gettingAllKeyword];
            }
            
        }
        
    }];
    
}

- (IBAction)chooseCategoryTapped:(id)sender {
    
      [self.view addSubview:categoryPickerBaseView];
    
    catPicker.tag=0;
    
    [catPicker reloadAllComponents];
    
     [catPicker selectRow:0 inComponent:0 animated:NO];
    
    [UIView animateWithDuration:0.4 animations:^{
        
      
        categoryPickerBaseView.frame=CGRectMake(categoryPickerBaseView.frame.origin.x, self.view.frame.size.height-(categoryPickerBaseView.frame.size.height), categoryPickerBaseView.frame.size.width, categoryPickerBaseView.frame.size.height);
        
    }];
    
   // self.view.frame.size.height-(categoryPickerBaseView.frame.size.height)
    
}

- (IBAction)catPickerDoneTapped:(id)sender {
   
if(catPicker.tag==0)
{
    if([categoryLbl.text isEqualToString:@"Select Category"])
    {
    
        if(catname.count>0)
        categoryLbl.text=catname[0];
        else
        {
            UIAlertView *categorySelectAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Category Found For Selection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [categorySelectAlert show];
        
        }
    
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        
   
     categoryPickerBaseView.frame=CGRectMake(categoryPickerBaseView.frame.origin.x, self.view.bounds.size.height, categoryPickerBaseView.frame.size.width, categoryPickerBaseView.frame.size.height);
        
        
        
         }completion:^(BOOL finished) {
             
             [categoryPickerBaseView removeFromSuperview];
             
         }];
    
}
else
    if(catPicker.tag==1)
    {
        if([keywordLbl.text isEqualToString:@"Keyword"])
        {
            
            if(keywordName.count>0)
                keywordLbl.text=keywordName[0];
            else
            {
                UIAlertView *keySelectAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Keyword Found For Selection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [keySelectAlert show];
                
            }
            
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            
            
            categoryPickerBaseView.frame=CGRectMake(categoryPickerBaseView.frame.origin.x, self.view.bounds.size.height, categoryPickerBaseView.frame.size.width, categoryPickerBaseView.frame.size.height);
            
            
            
        }completion:^(BOOL finished) {
            
            [categoryPickerBaseView removeFromSuperview];
            
        }];
        
    }

    
    
}

- (IBAction)catPickerCancelTapped:(id)sender {
  if(catPicker.tag==0)
  {
    if([categoryLbl.text isEqualToString:@"Select Category"])
        categoryLbl.text=@"Select Category";
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        categoryPickerBaseView.frame=CGRectMake(categoryPickerBaseView.frame.origin.x, self.view.bounds.size.height, categoryPickerBaseView.frame.size.width, categoryPickerBaseView.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        [categoryPickerBaseView removeFromSuperview];
        
    }];
  }
  else if(catPicker.tag==1)
  {
  
      if([keywordLbl.text isEqualToString:@"Keyword"])
          keywordLbl.text=@"Keyword";
      
      [UIView animateWithDuration:0.4 animations:^{
          
          
          categoryPickerBaseView.frame=CGRectMake(categoryPickerBaseView.frame.origin.x, self.view.bounds.size.height, categoryPickerBaseView.frame.size.width, categoryPickerBaseView.frame.size.height);
          
      }completion:^(BOOL finished) {
          
          [categoryPickerBaseView removeFromSuperview];
          
      }];

  
  }
}

#pragma mark-Pickerview delegates

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    if(catPicker.tag==0)
     return catname.count;
    else
        return keywordName.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    
    if(catPicker.tag==0)
        return catname[row];
    else
       return keywordName[row];

    

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(catPicker.tag==0)
    {
       categoryLbl.text=catname[row];
        category=catid[row];
        
    }else
    {
      keywordLbl.text=keywordName[row];
      keyword=keywordId[row];
        
    }

}

#pragma mark-Slider Methods


-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


- (void)slideValueChanged:(id)control
{
    
    pricerangeLbl.text = [NSString stringWithFormat:@"%d-%d",(int)priceRangeSlider.lowerValue,(int)priceRangeSlider.upperValue];
    
     minPrice=[NSString stringWithFormat:@"%d",(int)priceRangeSlider.lowerValue];
     maxPrice=[NSString stringWithFormat:@"%d",(int)priceRangeSlider.upperValue];
   
    
   // NSLog(@"Slider value changed: %d,%d",(int)slider.lowerValue, (int)slider.upperValue);
}


- (IBAction)backToPrevPage:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
