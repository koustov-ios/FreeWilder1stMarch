//
//  AddServiceViewController.m
//  FreeWilder
//
//  Created by Rahul Singha Roy on 01/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "AddServiceViewController.h"
#import "Footer.h"
#import "Side_menu.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AFNetworking.h"
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "AppDelegate.h"
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
#import "PaymentMethodViewController.h"
#import "SettingsViewController.h"
#import "PrivacyViewController.h"
#import "WishlistViewController.h"
#import "profile.h"
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "ViewController.h"
#import "FW_JsonClass.h"
#import "eventcell.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "locationCell.h"
#import "RadioCell.h"
#import "BusinessProfileViewController.h"
#import "sideMenu.h"

@interface AddServiceViewController ()<footerdelegate,Slide_menu_delegate,accountsubviewdelegate,Serviceview_delegate,Profile_delegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,NSURLSessionDelegate,MKMapViewDelegate,MKAnnotation,CLLocationManagerDelegate,sideMenu>
{
   
    sideMenu *leftMenu;
    
    AppDelegate *appDelegate;
    ServiceView *service;
    accountsubview *subview;
    BOOL tapchk,tapchk1,tapchk2;
    
    UIView *blackview,*popview;
    
    
    NSMutableArray *backup_name,*backup_id ,*searchResult,*locArray;
    
    UITextField *phoneText;
    NSString *phoneno;
    FW_JsonClass *globalobj;
    NSString *userid;
    
    profile *profileview;
    NSMutableArray *jsonArray;
    
    ////////map////////
    
    CLLocationCoordinate2D droppedAt;
    NSString *drag_lat, *drag_long;
    MKAnnotationView *pinView;
    MKAnnotationView *annotationPoint;
    
    NSMutableArray *cordintArray;
    
    
    IBOutlet UIScrollView *mainScroll;
    UITableView *KeywordTableView;
    UIButton *doneBtn;
    UILabel *heading;
    
    UIView *itemsView;
    
    eventcell  *cell,*cellCheckbox;
    
    BOOL TapCheck;
    BOOL locbool;
    NSMutableArray   *arry;

    
    NSMutableArray *keyword,*keyword_name,*keyword_id,*tapdata;
    
    NSString *keyword_idstr;
    
    NSMutableArray *key_value;
    
    
    UIView *pickerview;
    
    UISearchBar *SearchBar;
    
    BOOL calenderbool,priceboool,overviewbool,photobool,locationbool;
    
    
    NSMutableDictionary *data;
    
    UITableView *SearchTable;
    
    NSMutableArray *Arraytable;
    
    BOOL txtfeildcheck;
    
    
    MKPointAnnotation *myAnnotation,*myAnnotation1;
    CLLocationCoordinate2D coordinate1,coordinate[3];
    
    MKPolylineRenderer *renderer;
    MKRoute *route;
    
    NSMutableArray *routIns;
    
    //////////////////
    
    ////loader
    
    UIView *polygonView;
    UIActivityIndicatorView *spinner;
    
    
    UIImageView   *Breakcheckimg;
    UIButton    *breaktimebtn;
    NSMutableArray *breaktime;
    NSMutableArray *celllblarr;
    NSMutableSet *collapsedSections;
    NSMutableDictionary *dicTab;
    NSMutableDictionary *dicBtn;
    NSMutableDictionary *dicTab1,*dicTab10;
    NSMutableDictionary *dicBtn1,*dicBtn10;
    NSInteger prev;
    UIDatePicker *datepicker;
    UIButton *headerButton;
    UIPickerView *picker;
    NSMutableArray *hours,*hours2;
    UILabel *timelblstart, *timelblend;
    NSInteger pickerflag;
    NSString *selecttime, *selecttimestart;
    UIButton *headerTapped;
    NSInteger tapcheck,tickbool;
    UIImageView *checkimg;
    NSMutableArray *selectedRows, *sectionar0, *sectionar1, *sectionar2, *sectionar3, *sectionar4,*sectionar5,*sectionar6 ;
    NSString *chkstring0;
    NSString *chkstring1;
    NSString *chkstring2;
    NSString *chkstring3;
    NSString *chkstring4;
    NSString *chkstring5;
    NSString *chkstring6;
    
    
    NSString *chkstring00;
    NSString *chkstring10;
    NSString *chkstring20;
    NSString *chkstring30;
    NSString *chkstring40;
    NSString *chkstring50;
    NSString *chkstring60;
    
    
    NSInteger sundaysrttimechk,sundayendtimechk,mondaysrttimechk,mondayendtimechk,tuesdaysrttime,tuesdayendtime,wednessdaysrttime,wednessdayendtime,thurdaysrttime,thurdayendime,fridaysrttime,fridayendtime,saturdaysrttimechk,saturdayendtimechk;
    BOOL finishtimetap,finishtimetap1,finishtimetap2,finishtimetap3,finishtimetap4,finishtimetap5,
    finishtimetap6,cellchk;
    
    NSMutableArray *anotation;
    
    NSMutableArray *RightTapcheck;
   
    
    BOOL RightTap;
    UIView *backview;
    
//////Add product...Basic
    
    
    NSMutableArray *temp;
    
    //Product
    NSMutableArray *categoriesArray;
    UITableView *categoriesTable;
    UIView  *categoriesTablebackview;
    NSString *categoriesName;
    
    UIImageView *dropdownimage;
    UIButton * Main_Categories;
    
    //service
    
    UIButton * Booking_Type;
    
    UIButton * Service_Main_Categories;
    UIImageView *dropdownimage_Service;
    
    //Main_Categories tap
    
    UITableView *Main_Categories_Table;
    NSMutableArray *Main_Categories_ArrayId,*Main_Categories_ArrayName;
    NSString *Main_Categories_name,*Main_Categories_id;
    
    
    //Service_Main_Categories Button Tap
    
    UITableView *Service_Main_Categories_Table;
    NSMutableArray *Service_Main_Categories_ArrayName,*Service_Main_Categories_ArrayId;
    NSString *Service_Main_Categories_name;
    
    
    
    
    //Booking Type
    
    NSMutableArray *Booking_Type_Array;
    UITableView *Booking_Type_Table;
    UIView *back_Bookingview ,*Booking_tableBack;
    
    NSString *Booking_TypeString;
    
//
    
    
    
    NSMutableArray *checkboxName,*checkboxId;
    
    NSMutableArray *selectName,*selectId;
    NSMutableArray *radioName,*radioId;
    
    int y;
    UIView      *checkboxview;
    
    
    
    ///checkbox
    
    
    UITableView *checkTable;
    
    NSMutableArray *cheboxMain_Array;
    
    UIButton *checkbox_done;
    UIButton *checkboxbtn;
    
    UITableView *aminitiesTable;
    NSMutableArray *aminitieArray;
    
    UIButton *checktagbtn;
    
    //radio
    
    UITableView *radioTable;
    NSString *radioid;
    UIButton *radioBtn;
    
    
    
    UIButton *subCatbtn;
    
    
    UITableView *subcatTable;
    
    NSString *subcat_id;
    
    UIView *subcatview;
    int yy;
    //select
    
    
    UITableView *selectTable;
    UIButton *selectBtn;
    
    NSString *selectedid;
    UIView *adjustview;
    
    //other sub category
    
    int selecttag,radiotag, checkboxtag;
    
    UIButton *select_sub_btn,*radio_sub_btn,*checkBox_sub_btn, *buttontagset;
    
    NSMutableArray *select_sub_Array ,*radio_sub_Array,*chekbox_sub_Array;
    
    
    UITableView *select_sub_Table;
    
    NSMutableArray *select_sub_Table_Array;
    
    NSMutableArray *radio_tableArray;
    
    int selecttagcheck;
    ///
    NSMutableArray *mainradioArray ,*mainSelectArray ;
    
    int select_tag;
    
    
    int SubcheckBtntag;
    UIButton *subcheckTagbtn;
    
    
    
    
    UIButton *selecttagbtn;
    
    //radio
    
    UITableView *radio_sub_table;
    
    UITableView *checkbox_sub_table;
    
    NSMutableArray *checkbox_sub_mainArray;
    
    
    ////////////// product ////////////
    
    
    int radiosubbtnTap;
    UIButton *radioTagbtn;
    
    int radiotap;
    
    UIButton *radioTagbtnsender;
    
    UITextField *text,*textarea;
    
    
    
    
    
    
    NSMutableArray *All_id_Array;
    
    NSMutableArray *tem_Id_Array;
   
    
    
    /////id array//////
  
    NSMutableArray *aminities_id_Array;
    NSMutableArray *chebox_id_Array;
    NSMutableArray *radio_id_Array;
    NSMutableArray *option_id;
    
    
    NSString *idtext0;
    NSString *idtext1;
    NSString *idtext2;
    NSString *idtext3;
    
    
    
    int checkboxTag;
    
    ///////
    
    UIButton *aminitiesbtn;
    
    
    //select id
    
    
    NSString *select_id0;
    NSString *select_id1;
    NSString *select_id2;
    NSString *select_id3;
    
    
    
    NSMutableArray *Basic_Id_Array;
    
    
    
    int loopcount;
    
    ////
    
    int keybordheight;
    
    
    NSString *val;
    int texttag, textareatag;
    
    
    NSMutableArray *textvaleArray;
    
    
    //////
    
    int button_Tap_check;
    
    NSString *instand_booking;
    
    
    NSUserDefaults *prefs;
    
}

@property(nonatomic,strong)CLLocationManager *myLocationManager;

@end

@implementation AddServiceViewController
@synthesize lblPageTitle,lblPhoto,txtName,txtPrice,btnCategory,btnNext;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}
- (void)viewDidLoad
{
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here

    
    [super viewDidLoad];
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
    footer.Delegate=self;
    [footer TapCheck:4];
    [_footer_base addSubview:footer];
  
     prefs = [NSUserDefaults standardUserDefaults];
    
    cordintArray =[[NSMutableArray alloc]initWithCapacity:2];
//    CalenderView=Nil;
//    pricingview=Nil;
//    overviewview=Nil;
//    photosview=Nil;
//    locationview=Nil;
//    tapdata=Nil;
//    key_value=Nil;
//    locArray=Nil;
//    routIns=Nil;
//    anotation=Nil;
//    keyword=Nil;
//    keyword_id=Nil;
//    keyword_name=Nil;
    
    
    [bookingswitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    instand_booking=@"no";
    
    button_Tap_check=0;
    
    
 keybordheight= firstview.frame.origin.y;
    
    RightTapcheck =[[NSMutableArray alloc]init];
    
    tapdata = [[NSMutableArray alloc]init];
    textvaleArray = [[NSMutableArray alloc]init];
    
    selecttag=0;
    radiotag=0;
    checkboxtag=0;
    
    
    checkboxName = [[NSMutableArray alloc]init];
    checkboxId = [[NSMutableArray alloc]init];
    
    selectName = [[NSMutableArray alloc]init];
    selectId = [[NSMutableArray alloc]init];
    radioName= [[NSMutableArray alloc]init];
    
    radioId= [[NSMutableArray alloc]init];
    temp =[[NSMutableArray alloc]init];
    
    select_sub_Array= [[NSMutableArray alloc]init];
    radio_sub_Array= [[NSMutableArray alloc]init];
    chekbox_sub_Array= [[NSMutableArray alloc]init];
    
    aminities_id_Array=[[NSMutableArray alloc]init];
    chebox_id_Array=[[NSMutableArray alloc]init];
    radio_id_Array=[[NSMutableArray alloc]init];
    
    
    categoriesArray = [[NSMutableArray alloc]initWithObjects:@"Select One",@"Service",@"Product", nil];
    
    Booking_Type_Array = [[NSMutableArray alloc]initWithObjects:@"Select",@"Per Day",@"Slot", nil];
    
    Service_Main_Categories_ArrayName = [[NSMutableArray alloc]init];
    Service_Main_Categories_ArrayId =[[NSMutableArray alloc]init];
    Main_Categories_ArrayName= [[NSMutableArray alloc]init];
    Main_Categories_ArrayId= [[NSMutableArray alloc]init];
    
    globalobj = [[FW_JsonClass alloc]init];
     tapdata=[[NSMutableArray alloc] init];
    key_value = [[NSMutableArray alloc]init];
    locArray=[[NSMutableArray alloc]init];
    routIns=[[NSMutableArray alloc]init];
    All_id_Array = [[NSMutableArray alloc]init];

    
    savebtn.layer.cornerRadius =5;
    calenderbool =YES;
    locationbool=YES;
    priceboool=YES;
    photobool=YES;
    overviewbool=YES;
    
     locbool=YES;
    
    anotation=[[NSMutableArray alloc]init];
    
    Scroll.frame=CGRectMake(0, tapbatImage.frame.size.height+tapbatImage.frame.origin.y, Scroll.frame.size.width, Scroll.frame.size.height);
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.width == 320)
    {
        
        Scroll.contentSize=CGSizeMake(555, 0);
        
        
    }
    else if(screenBounds.size.width == 375)
    {
       Scroll.contentSize=CGSizeMake(645, 0);
        
    }
    else
    {
        Scroll.contentSize=CGSizeMake(705, 0);
        
    }
    
    [self allockinit];
    
    mainScroll.frame = CGRectMake(0, Scroll.frame.size.height+Scroll.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-_footer_base.frame.size.height-Scroll.frame.size.height-tapbatImage.frame.size.height);
    
    
    
    mainScroll.contentSize=CGSizeMake(0, 380);
    TapCheck=YES;
    keyword =[[NSMutableArray alloc ]init];
    keyword_id=[[NSMutableArray alloc ]init];
    keyword_name=[[NSMutableArray alloc ]init];;
    
    
  
    
    
   
   // CalenderView.hidden=YES;
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@app_all_keywords",App_Domain_Url];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
       
        
        
        
        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            for (NSDictionary *tempdic in [result valueForKey:@"infoarray"])
            {
                [keyword addObject:tempdic];
            }
            
            NSLog(@"key word========%@",keyword);
            
            if (keyword.count>0)
            {
                for (int i=0; i<keyword.count; i++)
                {
                    NSString *keyid = [NSString stringWithFormat:@"%@",[keyword[i] valueForKey:@"id"]];
                    NSString *keyname =[NSString stringWithFormat:@"%@",[keyword[i] valueForKey:@"keyword_name"]];
                    
                    
                    [keyword_id insertObject:keyid atIndex:i];
                    [keyword_name insertObject:keyname atIndex:i];
                    
                }
                
                
                
                
            }
            
            
            backup_id=[keyword_id mutableCopy];
            backup_name = [keyword_name mutableCopy];
            
            
        }
        
        
        
        
       
        
        
        
    }];
    

    
   
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,[UIScreen mainScreen].bounds.size.width, 35.0f)];
    toolbar.barStyle=UIBarStyleBlackOpaque;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
   
   
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close_textview)];
    barButtonItem.tintColor=[UIColor whiteColor];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    _description1.inputAccessoryView = toolbar;
    
    
  
    
    
    
    
    userid=[prefs valueForKey:@"UserId"];
    
    
    lblPageTitle.text=@"Add a Service";
    lblPhoto.text=@"Add Photos";
    txtName.placeholder=@"Name";
    _description1.text=@"Description";
    txtPrice.placeholder=@"Price";
    [btnCategory setTitle:@"Select Category" forState:UIControlStateNormal];
    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    
    
    
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


//-(void)side
//{
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    
//    
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
//   
//   
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
// 
//    
//    
//    
//    
//    
//    
//    
//
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
//}
//
//
//
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
//              
//              
//              [service removeFromSuperview];
//              [sidemenu removeFromSuperview];
//              [overlay removeFromSuperview];
//             // overlay.userInteractionEnabled=NO;
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
                 
                 NSLog(@"Logging out---------");
                 
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 
//                  NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//                 [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
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


-(void)doneWithNumberPad{
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        [phoneText resignFirstResponder];
        
    }];
    
    
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==quantity_txt)
    {
        NSLog(@"end");
        
        
    }
    
    
    
   
    
    
    return YES;
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
    if (textField ==quantity_txt || textField ==name_text)
    {
        
    }
    
    else
    {
        [self doneEditing:textField tagIs:text.tag];
    }
       
            
            
   
}


-(IBAction)doneEditing:(UITextField *)sender tagIs:(NSInteger)tag
{
    

    NSString *fieldValue=sender.text;
    
    
    for (int a=0; a<option_id.count; a++)
    {
        if ((sender.tag==[[[option_id objectAtIndex:a]valueForKey:@"option_id"] integerValue]))
        {
            
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            
            
            [dic setObject:[[option_id objectAtIndex:a]valueForKey:@"option_id"] forKey:@"option_id"];
            
            [dic setObject:fieldValue forKey:@"text_Value"];
            
            
            [textvaleArray addObject:dic];
        }
    }

    
    
        NSLog(@"Field  has value: %@", textvaleArray);
    
    // NSLog(@"Field  has value: %@", option_id);
 }



//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//}

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
    
    
    if (textField==text  )
    {
       
        
//        for (int a=0; a<10; a++)
//        {
//            UITextField *textField = (UITextField*)[subcatview viewWithTag:a];
//            NSString *fieldValue = textField.text;
//            NSLog(@"Field %d has value: %@", a, fieldValue);
//        }
        
        
        
        [UIView transitionWithView:mainScroll
                          duration:0.75
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            
                            [mainScroll setContentOffset:CGPointMake(0, textField.frame.origin.y+textField.frame.size.height*2)];
                        }
                        completion:nil];
        
        
        
    }
    
    
    
    
    
    return YES;
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

-(void)close_textview
{
    if (_description1.text.length==0)
    {
        _description1.text=@"Description";
    }
    [_description1 resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if(textField==locationview.TypeAddressTxt)
    {
        
        
        txtfeildcheck=YES;
        
        [locationview.TypeAddressTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [SearchTable removeFromSuperview];
        
        SearchTable = [[UITableView alloc]init];
        
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            
            [locationview.locationScroll setContentOffset:CGPointMake(0.0f, 310.0f) animated:YES];
            
            SearchTable.frame = CGRectMake(0,200 , self.view.frame.size.width,140);
            
        }
        
        else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
        {
            [locationview.locationScroll setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
            
            SearchTable.frame = CGRectMake(0,220 , self.view.frame.size.width,200);
            
            
        }
        else
        {
            
            [locationview.locationScroll setContentOffset:CGPointMake(0.0f, 232.0f) animated:YES];
            
            SearchTable.frame = CGRectMake(0,250+locationview.TypeAddressTxt.frame.size.height , self.view.frame.size.width,250);
            
        }

        
        
        
        
        [self.view addSubview:SearchTable];
        
        SearchTable.dataSource=self;
        SearchTable.delegate=self;
        
        SearchTable.hidden=YES;
     //  [locationview.locationScroll setScrollEnabled:NO];
        
        //SearchTable.backgroundColor = [UIColor blackColor];
        
        
        
        
    }
   
    
    
    if(textField==locationview.TypeAddressTxt2)
    {
        txtfeildcheck=NO;
        
        [locationview.TypeAddressTxt2 addTarget:self action:@selector(textFieldDidChange1:) forControlEvents:UIControlEventEditingChanged];
        
        [SearchTable removeFromSuperview];
        
        SearchTable = [[UITableView alloc]init];
        
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            
            [locationview.locationScroll setContentOffset:CGPointMake(0.0f, 540.0f) animated:YES];
            
            SearchTable.frame = CGRectMake(0,185 , self.view.frame.size.width,140);
            
        }
        
        else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
        {
            [locationview.locationScroll setContentOffset:CGPointMake(0.0f, 520.0f) animated:YES];
            
            SearchTable.frame = CGRectMake(0,220 , self.view.frame.size.width,200);
            
            
        }
        else
        {
            
            [locationview.locationScroll setContentOffset:CGPointMake(0.0f, 430.0f) animated:YES];
            
            SearchTable.frame = CGRectMake(0,320 , self.view.frame.size.width,250);
            
        }
        
        
        
        
        
        [self.view addSubview:SearchTable];
        
        SearchTable.dataSource=self;
        SearchTable.delegate=self;
        
        SearchTable.hidden=YES;
       // [locationview.locationScroll setScrollEnabled:NO];
        
        //SearchTable.backgroundColor = [UIColor blackColor];
        
        
        
        
    }

    
    
    
}


-(void)textFieldDidChange:(UITextField *)thetextfield
{
    
    
    if (locationview.TypeAddressTxt.text.length==0)
    {
        SearchTable.hidden=YES;
        [locationview.locationScroll setScrollEnabled:YES];
        
        
    }
    
    
    
    
    
    else
    {
        
            SearchTable.hidden=NO;
        
        
       
        
      //  [locationview.locationScroll setScrollEnabled:NO];
        
        // Main thread work (UI usually)
        
        
        NSString *urlll =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?region=GB&key=AIzaSyA9CuugBNIOxYTO_GVn0fTEUaPzM03jvNo&input=%@",[locationview.TypeAddressTxt text]];
        
        
        NSLog(@"url-----------%@",urlll);
        
        
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



-(void)textFieldDidChange1:(UITextField *)thetextfield
{
    
    
    if (locationview.TypeAddressTxt2.text.length==0)
    {
        SearchTable.hidden=YES;
        [locationview.locationScroll setScrollEnabled:YES];
        
        
    }
    
    
    
    
    
    else
    {
        
        SearchTable.hidden=NO;
        
        
        
        
        [locationview.locationScroll setScrollEnabled:NO];
        
        // Main thread work (UI usually)
        
        
        NSString *urlll =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?region=GB&key=AIzaSyA9CuugBNIOxYTO_GVn0fTEUaPzM03jvNo&input=%@",[locationview.TypeAddressTxt2 text]];
        
        
        NSLog(@"url-----------%@",urlll);
        
        
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





- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField==locationview.TypeAddressTxt)
    {
        
        [locationview.locationScroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    }
    
   else if (textField==locationview.TypeAddressTxt2)
   {
       
       
       [locationview.locationScroll setContentOffset:CGPointMake(0.0f,100.0f) animated:YES];

    }
    
    
    [SearchTable removeFromSuperview];
    
    [textField resignFirstResponder];
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
   _description1.text=@"";
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//
//
//    return YES;
//}

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

- (IBAction)pickerDone:(id)sender
{
    
}

- (IBAction)back_button:(id)sender
{
    [self POPViewController];
}

- (IBAction)pickerCancelBtn:(id)sender
{
//   [UIView animateWithDuration:.3f animations:^{
//       
//       pview.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, pview.frame.size.height);
//       
//   }
//    completion:^(BOOL finished) {
//        
//        
//        pview.hidden=YES;
//        
//    }];
    
    
    
    
}

- (IBAction)CategoriesTap:(id)sender
{
    
    
    
    
    
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor clearColor];
    
    
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoriesCancel)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [itemsView addGestureRecognizer:tapGestureRecognize];
    
    
    
    categoriesTable = [[UITableView alloc]initWithFrame:CGRectMake(categoryBtn.frame.origin.x,categoryBtn.frame.origin.y+categoryBtn.frame.size.height, categoryBtn.frame.size.width   , categoryBtn.frame.size.height+100)];
    
    categoriesTablebackview=[[UIView alloc]initWithFrame:categoriesTable.frame];
    
    categoriesTablebackview.backgroundColor =[UIColor blackColor];
    
    categoriesTable.showsVerticalScrollIndicator = NO;
    
    categoriesTable.delegate = self;
    categoriesTable.dataSource = self;
    
    //[categoriesTable setAllowsSelection:NO];
    
    categoriesTablebackview.layer.masksToBounds = NO;
    categoriesTablebackview.layer.shadowOffset = CGSizeMake(10, 10);
    categoriesTablebackview.layer.shadowRadius = 3;
    categoriesTablebackview.layer.shadowOpacity = 0.3;
    
    categoriesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    categoriesTable.backgroundColor = [UIColor whiteColor];
    
   
   // mainScroll.bounces=NO;
    
    [mainScroll addSubview:itemsView];
    
    [mainScroll addSubview:categoriesTablebackview];
    
    [mainScroll addSubview:categoriesTable];
    

    
    
    
    
    
}

-(void)categoriesCancel
{
    [itemsView removeFromSuperview];
    [categoriesTablebackview removeFromSuperview];
    [categoriesTable removeFromSuperview];
    
    
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

- (IBAction)NextClick:(id)sender {
}









- (IBAction)keywordBtntap:(id)sender
{
    
    
    
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor whiteColor];
    
    
    
    doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 20, 80, 40)];
    
    heading = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, self.view.frame.size.width - 100, 40)];
    heading.text = @"Select Maximum Five";
    
    heading.textColor = [UIColor colorWithRed:59.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:1];
    heading.font = [UIFont fontWithName:@"Lato-bold" size:14];
    heading.textAlignment = NSTextAlignmentCenter;
    
    //heading.backgroundColor=[UIColor blackColor];
    
    
    SearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,heading.frame.origin.y+heading.frame.size.height, self.view.frame.size.width, 64)];
    
    SearchBar.delegate=self;
    
    [itemsView addSubview:SearchBar];
    
    KeywordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SearchBar.frame.origin.y+SearchBar.frame.size.height , self.view.frame.size.width, self.view.frame.size.height - SearchBar.frame.size.height-heading.frame.size.height)];
    
    //KeywordTableView.tableHeaderView = searchBar;
    
    KeywordTableView.showsVerticalScrollIndicator = NO;
    
    KeywordTableView.delegate = self;
    KeywordTableView.dataSource = self;
    
    KeywordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    
    
    KeywordTableView.backgroundColor = [UIColor whiteColor];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
     [doneBtn addTarget:self action:@selector(doneTap) forControlEvents:UIControlEventTouchUpInside];
    
   // [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont fontWithName:@"Lato-regular" size:14];
    
    [self.view addSubview:itemsView];
    [itemsView addSubview:heading];
    [itemsView addSubview:KeywordTableView];
    [itemsView addSubview:doneBtn];
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        
        
        itemsView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }];

    
    
    
    
    
}


-(void)doneTap
{
    
    if (tapdata.count>5)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You can Select Maximun Five" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        
        [alrt show];
        
    }
    
    else
    {
    [UIView animateWithDuration:.2f animations:^{
        
        
        
        
        itemsView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }
     completion:^(BOOL finished) {
         
         
         keyword_name =[backup_name mutableCopy];
         keyword_id=[backup_id mutableCopy];
         [KeywordTableView reloadData];
         
         
         [doneBtn removeFromSuperview];
         [heading removeFromSuperview];
         [KeywordTableView removeFromSuperview];
         [itemsView removeFromSuperview];
         
     }];

    
        int k=0;
        
        [key_value removeAllObjects];
  
        
        
        
        for (int i=0; i<tapdata.count; i++)
    {
     //   NSInter chk = [NSString stringWithFormat:@"%@",[tapdata [i] ]];
        
        
        
        NSInteger chk = [[tapdata objectAtIndex:i]integerValue];
        
        
        
       NSLog(@"chk---%ld",(long)chk);
        
        for (int j=0; j<keyword.count; j++)
        {
            NSInteger equal = [[keyword[j] valueForKey:@"id"]integerValue];
            
            NSLog(@"eql----%ld",(long)equal);
            
            
            if (chk==equal)
            {
                
                NSLog(@"%ld  =  %ld",(long)chk,(long)equal);
                
                NSString *match = [keyword[j]valueForKey:@"keyword_name"];
                
               
                [key_value insertObject:[NSString stringWithFormat:@"%@",match] atIndex:k];
                
                k++;
                
                
                
                
            }
            
            
            
        }
    }
    
       // NSLog(@"match===  %@",key);
       
            
        keyWordText.text = [key_value componentsJoinedByString:@" , "];
        
        
        
        if (keyWordText.text.length>0)
        {
            textviewplaceholder.hidden=YES;
        }
        
    else
    {
        textviewplaceholder.hidden=NO;
    }
        
        
    
    }
    
}




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length==0)
    {
        
        
        keyword_name =[backup_name mutableCopy];
       keyword_id=[backup_id mutableCopy];
        [KeywordTableView reloadData];
        
        NSLog(@"key_id----%@",backup_id);
    }
    
    
    
    else
    {
        
        NSLog(@"search text========>%@",searchText);
        
        NSLog(@"filterContentForSearchText");
        //   NSMutableArray *ary;
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
        
        
        
        // arry   = [[finaldata valueForKey:@"name"]filteredArrayUsingPredicate:resultPredicate];
        searchResult   = (NSMutableArray *)[[keyword valueForKey:@"keyword_name"] filteredArrayUsingPredicate:resultPredicate];
        
        int j = 0;
        
        
        
        if (searchResult.count>0)
        {
         arry= [[NSMutableArray alloc]init];
            
            for (int i=0; i<keyword.count; i++)
            {
                
                
                NSString *name = [NSString stringWithFormat:@"%@",[keyword[i] valueForKey:@"keyword_name"] ];
                NSLog(@"string=======%@",name);
                
                
                
                
                for (int a=0; a<searchResult.count; a++)
                {
                    NSString *check = [NSString stringWithFormat:@"%@",searchResult [a]];
                    
                    
                    if ([check isEqualToString:name])
                    {
                        NSLog(@"Name===%@=%@",name,check );
                        
                        [arry insertObject:[keyword objectAtIndex:i] atIndex:j];
                        
                        j++;
                        
                    }
                }
                
                
                [keyword_name removeAllObjects];
                [keyword_id removeAllObjects];
                
                
                for (int i=0; i<arry.count; i++)
                {
                    NSString *keyid = [NSString stringWithFormat:@"%@",[arry[i] valueForKey:@"id"]];
                    NSString *keyname =[NSString stringWithFormat:@"%@",[arry[i]valueForKey:@"keyword_name"]];
                    
                    
                    [keyword_id insertObject:keyid atIndex:i];
                    [keyword_name insertObject:keyname atIndex:i];
                    
                }
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        NSLog(@"searchResults-----%@",searchResult);
       
        NSLog(@"array=========%@",arry);
        
        
        NSLog(@"===========%@",keyword_name);
        NSLog(@"----------%@",keyword_id);
        
       // keyword_name=[arry mutableCopy];
        [KeywordTableView reloadData];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [SearchBar resignFirstResponder];
    
}



- (IBAction)BasicTap:(id)sender
{
    [SearchTable removeFromSuperview];
    
    mainScroll.hidden=NO;
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            
                            
                            
                            
           GreenLine.frame = CGRectMake(basicBtn.frame.origin.x, GreenLine.frame.origin.y, GreenLine.frame.size.width, GreenLine.frame.size.height);
                            
                            
                            
        [Scroll setContentOffset:CGPointMake(self.view.frame.origin.x, 0.0f) animated:YES];
                            
                            
                        }
     
     
     
     
     
                     completion:^(BOOL finished)
     {
         
         
         
         
         
         
     }];

    
    [UIView animateWithDuration:.2f animations:^{
       
         mainScroll.frame = CGRectMake(self.view.frame.size.width-mainScroll.frame.size.width, mainScroll.frame.origin.y, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        CalenderView.frame = CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        pricingview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
          overviewview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        photosview.frame=CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        locationview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
    }
     
     completion:^(BOOL finished) {
        
         
         [CalenderView setHidden:YES];
         [pricingview setHidden:YES];
         [overviewview setHidden:YES];
         [photosview setHidden:YES];
         [locationview setHidden:YES];
         
     }];
    
  
    
}

- (IBAction)calenderTap:(id)sender
{
    
    if (calenderbool==YES)
    {
     
        
        CalenderView =[[calender_View alloc]init];
        
        CalenderView.frame = CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        [self.view addSubview:CalenderView];
        
        
        calenderbool=NO;

        
    }
    
    [SearchTable removeFromSuperview];
    
    
    CalenderView.hidden=NO;
    CalenderView.productview.hidden=NO;
    CalenderView.serviceview.hidden=YES;
        
        CalenderView.tableview.delegate=self;
    CalenderView.tableview.dataSource=self;
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
                     
                        
                            
                            
      GreenLine.frame = CGRectMake(calenderBtn.frame.origin.x, GreenLine.frame.origin.y, GreenLine.frame.size.width, GreenLine.frame.size.height);
                            
           [Scroll setContentOffset:CGPointMake(self.view.frame.size.width*.01, 0.0f) animated:YES];
                            
                        
                          
                            
                            
                            
                        
                        }
     
   
     
     
     
                     completion:^(BOOL finished)
     {
         
         
         
         
         
         
     }];

    
    
    
    
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        mainScroll.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, mainScroll.frame.origin.y, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        CalenderView.frame = CGRectMake(self.view.frame.size.width-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
         pricingview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
          overviewview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        photosview.frame=CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        locationview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        
        
    }
     completion:^(BOOL finished) {
         
         mainScroll.hidden=YES;
         [pricingview setHidden:YES];
         [overviewview setHidden:YES];
         [photosview setHidden:YES];
         [locationview setHidden:YES];
         
         
     }];
    
   
    
}

- (IBAction)Pricing:(id)sender {
  
    
    if (priceboool==YES)
    {
        pricingview =[[price_View alloc]init];
        
        pricingview.frame = CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        [self.view addSubview:pricingview];
        
        priceboool=NO;

    }
    
    [SearchTable removeFromSuperview];
    
    pricingview.hidden=NO;
    pricingview.Slot_Pricing_view.hidden=YES;
    pricingview.Per_Day_Pricing_view.hidden=NO;
    pricingview.Per_day_pricing_Scroll.contentSize = CGSizeMake(0, 531);
    
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
               
                            GreenLine.frame = CGRectMake(pricing.frame.origin.x, GreenLine.frame.origin.y, GreenLine.frame.size.width, GreenLine.frame.size.height);
                            
                            
                            [Scroll setContentOffset:CGPointMake(self.view.frame.size.width*.3, 0.0f) animated:YES];
                        
                        
                        
                        }
     
     
     
                     completion:^(BOOL finished)
     {
         
         
         
         
         
     }];
    

    
    [UIView animateWithDuration:.2f animations:^{
        
        
        mainScroll.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, mainScroll.frame.origin.y, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        CalenderView.frame = CGRectMake(self.view.frame.origin.x-CalenderView.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        pricingview.frame =CGRectMake(self.view.frame.size.width-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
          overviewview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        photosview.frame=CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        locationview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
    }
     
                     completion:^(BOOL finished) {
                         
                         
                         mainScroll.hidden=YES;
                         [CalenderView setHidden:YES];
                         [overviewview setHidden:YES];
                         [photosview setHidden:YES];
                         [locationview setHidden:YES];
                         
                     }];
    
    
     [pricingview.CurrencyBtn addTarget:self action:@selector(ShowCurrency) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}




-(void)ShowCurrency
{
    
    
    
    NSLog(@"tap");
    
    
    
    
}

- (IBAction)OverViewTap:(id)sender {
  
    
    
    if (overviewbool==YES)
    {
        overviewview =[[overview_View alloc]init];
        
        overviewview.frame = CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        [self.view addSubview:overviewview];
        
        
        overviewbool=NO;
    }
    
    [SearchTable removeFromSuperview];
    
    overviewview.hidden=NO;
   
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            
                            GreenLine.frame = CGRectMake(overViewBtn.frame.origin.x, GreenLine.frame.origin.y, GreenLine.frame.size.width, GreenLine.frame.size.height);
                            
                            
                            [Scroll setContentOffset:CGPointMake(self.view.frame.size.width*.3, 0.0f) animated:YES];
                            
                            
                        }
     
     
     
                     completion:^(BOOL finished)
     {
         
         
         
         
         
         
     }];
    
    [UIView animateWithDuration:.2f animations:^{
        
        
         mainScroll.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, mainScroll.frame.origin.y, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        CalenderView.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
      
        pricingview.frame =CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        overviewview.frame =CGRectMake(self.view.frame.size.width-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        photosview.frame=CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        locationview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        
    }
     completion:^(BOOL finished) {
         
         
         
         mainScroll.hidden=YES;
         [CalenderView setHidden:YES];
         [pricingview setHidden:YES];
         [photosview setHidden:YES];
         [locationview setHidden:YES];
         
     }];

    
    
    
    
}

- (IBAction)PhotosTap:(id)sender {
   
    
    if (photobool==YES)
    {
        photosview = [[photos_View alloc]init];
        
        photosview.frame=CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        [self.view addSubview:photosview];
        
        photobool=NO;
    }
    
    photosview.hidden=NO;
    
    [SearchTable removeFromSuperview];
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                     
                        
                            GreenLine.frame = CGRectMake(photoBtn.frame.origin.x, GreenLine.frame.origin.y, GreenLine.frame.size.width, GreenLine.frame.size.height);
                            
                            [Scroll setContentOffset:CGPointMake(self.view.frame.size.width*.72, 0.0f) animated:YES];
                        
                        
                        
                        }
     
     
     
                     completion:^(BOOL finished)
     {
         
         
         
         
         
         
     }];
    

    [UIView animateWithDuration:.2f animations:^{
        
        
        mainScroll.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, mainScroll.frame.origin.y, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        CalenderView.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        pricingview.frame =CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        overviewview.frame =CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        photosview.frame=CGRectMake(self.view.frame.size.width-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        locationview.frame =CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
    }
     
     completion:^(BOOL finished) {
         
         mainScroll.hidden=YES;
         [CalenderView setHidden:YES  ];
         [pricingview setHidden:YES];
         [overviewview setHidden:YES];
         [locationview setHidden:YES];
         
         
     }];
    
    
    
}

- (IBAction)LocationTap:(id)sender {
 
    
    if (locationbool==YES)
    {
        locationview = [[location_View alloc]init];
        
        locationview.frame=CGRectMake(self.view.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        [self.view addSubview:locationview];
        
        
        locationbool=NO;
    }
    
    
    locationview.hidden=NO;
    
    locationview.To_Addressview.hidden=YES;
    
    locationview.location_Map.delegate=self;
    
   // MKUserLocation *userLocation = locationview.location_Map.userLocation;
  //  MKCoordinateRegion region =  MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 20000, 20000);
    
    
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.delegate = self;
        [self.myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.myLocationManager setDesiredAccuracy:kCLDistanceFilterNone];
        [self.myLocationManager requestWhenInUseAuthorization];
        [self.myLocationManager startMonitoringSignificantLocationChanges];
        [self.myLocationManager startUpdatingLocation];
        
        
        
    } else {
        
        NSLog(@"Location services are not enabled");
    }
    
    
   // locationview.locationScroll.contentSize = CGSizeMake(0, 1060);
    
    locationview.locationScroll.contentSize = CGSizeMake(0, locationview.Addressview.frame.origin.y+locationview.Addressview.frame.size.height);
    locationview.LocationImageview.image=[UIImage imageNamed:@"check_on_category"];
    locationview.RouteImageview.image=[UIImage imageNamed:@"check_off_category"];
    
    
    
   
   
    
    
    
   
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            
                            
                            GreenLine.frame = CGRectMake(location.frame.origin.x, GreenLine.frame.origin.y, GreenLine.frame.size.width, GreenLine.frame.size.height);
                            
                            [Scroll setContentOffset:CGPointMake(self.view.frame.size.width-location.frame.size.width, 0.0f) animated:YES];
                            
                            
                            
                            
                        }
     
     
     
                     completion:^(BOOL finished)
     {
         
         
         
         
         
         
     }];

    
    [UIView animateWithDuration:.2f animations:^{
        
        
        mainScroll.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, mainScroll.frame.origin.y, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        CalenderView.frame = CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        pricingview.frame =CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        overviewview.frame =CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        photosview.frame =CGRectMake(self.view.frame.origin.x-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
        
        locationview.frame=CGRectMake(self.view.frame.size.width-mainScroll.frame.size.width, Scroll.frame.origin.y+Scroll.frame.size.height, mainScroll.frame.size.width, mainScroll.frame.size.height);
        
    }
     
                     completion:^(BOOL finished) {
                         
                         mainScroll.hidden=YES;
                         [CalenderView setHidden:YES];
                         [pricingview setHidden:YES];
                         [overviewview setHidden:YES];
                         [photosview setHidden:YES];
                         
                         
                     }];
    
    
    
    
    [locationview.location_btn addTarget:self action:@selector(locationTapped) forControlEvents:UIControlEventTouchUpInside];
    
      [locationview.Route_btn addTarget:self action:@selector(RouteTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    locationview.nameTxt.delegate=self;
    locationview.TypeAddressTxt.delegate=self;
    locationview.DetailsTxt.delegate=self;
    
    
    locationview.nameTxt2.delegate=self;
    locationview.TypeAddressTxt2.delegate=self;
    locationview.DetailsTxt2.delegate=self;
    
    
    
    
}


//-(MKPointAnnotation*)setAnnotation: (NSString*) title atLocation:(CLLocationCoordinate2D)Location withImage:(UIImage*) LocationImage{
//    
//    MKPointAnnotation *Pin = [[MKPointAnnotation alloc]init];
//    
//    Pin.title = title;
//    
//    [Pin setCoordinate:Location];
//    
//    [self mapView:locationview.location_Map viewForAnnotation:Pin].annotation = Pin;
//    return Pin;
//}



-(void)locationTapped
{
    
    
    
    
           locationview.LocationImageview.image=[UIImage imageNamed:@"check_on_category"];
        locationview.RouteImageview.image=[UIImage imageNamed:@"check_off_category"];
        
        
        locationview.To_Addressview.hidden=YES;
        locationview.locationScroll.contentSize = CGSizeMake(0, locationview.Addressview.frame.origin.y+locationview.Addressview.frame.size.height);
        
        locationview.First_Address_lbl.text=@"Address";
        
    
   
    
    
    
    
    
    
    
}


-(void)RouteTapped
{
    
    
    
   
        locationview.LocationImageview.image=[UIImage imageNamed:@"check_off_category"];
        locationview.RouteImageview.image=[UIImage imageNamed:@"check_on_category"];
        
        
        locationview.First_Address_lbl.text=@"From Address";
        
        locationview.locationScroll.contentSize = CGSizeMake(0, locationview.To_Addressview.frame.origin.y+locationview.To_Addressview.frame.size.height);
        
        locationview.To_Addressview.hidden=NO;
        
        locbool=YES;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView==CalenderView.tableview)
    {
        return 50.0f;

    }
    
    else if (tableView==SearchTable)
        
    {
        return 35.0f;
    }
    
    
    else if (tableView==radioTable)
    {
        return 60.00f;
    }
    
        else
        {
        return 45.0f;
        }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==CalenderView.tableview)
    {
        if(section==0)
        {
            if([dicTab valueForKey:@"0"])
                return 2;
            else
               return 0;
        }
        
        
        if(section==1)
        {
            if([dicTab valueForKey:@"1"])
                return 2;
            else
                return 0;
        }
        if(section==2)
        {
            if([dicTab valueForKey:@"2"])
                return 2;
            else
                return 0;
        }
        if(section==3)
        {
            if([dicTab valueForKey:@"3"])
                return 2;
            else
                return 0;
        }
        if(section==4)
        {
            if([dicTab valueForKey:@"4"])
                return 2;
            else
                return 0;
        }
        
        if(section==5)
        {
            if([dicTab valueForKey:@"5"])
                return 2;
            else
                return 0;
        }
        if(section==6)
        {
            if([dicTab valueForKey:@"6"])
                return 2;
            else
                return 0;
        }

    }
    
    else if (tableView==SearchTable)
    {
        return Arraytable.count;
    }
    
    else if (tableView==categoriesTable)
    {
        return categoriesArray.count;
    }
    
    else if (tableView==Booking_Type_Table)
        
    {
        return Booking_Type_Array.count;
    }
    
    else if (tableView==Service_Main_Categories_Table)
    {
        return Service_Main_Categories_ArrayName.count;
    }
   
    else if (tableView==Main_Categories_Table)
    {
        return Main_Categories_ArrayName.count;
    }
    
     else if (tableView==checkTable)
     {
         return cheboxMain_Array.count;
     }
    
    else if (tableView==aminitiesTable)
    {
        return aminitieArray.count ;
    }
    else if (tableView==radioTable)
    {
        return mainradioArray.count;
    }
    
    else if (tableView==subcatTable)
    {
        return selectName.count;
    }
    
    else if (tableView==selectTable)
    {
        return mainSelectArray.count;
        
    }
    else if (tableView==select_sub_Table)
    {
        
        
            
            return select_sub_Table_Array.count;
       
        
    }
    
    
    else if (tableView==radio_sub_table)
    {
        return   radio_tableArray.count;
    }
    
    else if (tableView==checkbox_sub_table)
    {
        
        return checkbox_sub_mainArray.count;
    }
    
    
    else
    {
    return keyword_name.count;
    }
   
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==CalenderView.tableview)
    {
        static NSString *cellId = @"cellid";
        cell1 = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell1 = [[UITableViewCell alloc]init];
        
        UIImageView *divider = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
        divider.image = [UIImage imageNamed:@"divider-line"];
        
        CGFloat width = self.view.frame.size.width - 30;
        
        UIImageView *plus = [[UIImageView alloc]initWithFrame:CGRectMake(width, 16, 11, 18)];
        plus.contentMode = UIViewContentModeScaleAspectFit;
        plus.image = [UIImage imageNamed:@"arrow"];
        
        UILabel *celllbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 49)];
        celllbl.text = [celllblarr objectAtIndex:indexPath.row];
        
        celllbl.font = [UIFont fontWithName:@"Lato" size:14.0f];
        celllbl.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
        
        timelblstart = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 150, 49)];
        timelblstart.font = [UIFont fontWithName:@"Lato" size:14.0f];
        timelblstart.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
        timelblstart.text = @"00:00";
        [cell1 addSubview:timelblstart];
      
        if (indexPath.section == 0)
        {
            timelblstart.text = [sectionar0 objectAtIndex:indexPath.row];
        }
        else if(indexPath.section == 1)
        {
            timelblstart.text = [sectionar1 objectAtIndex:indexPath.row];
        }
        else if(indexPath.section == 2)
        {
            timelblstart.text = [sectionar2 objectAtIndex:indexPath.row];
        }
        else if (indexPath.section == 3)
        {
            timelblstart.text = [sectionar3 objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==4)
        {
            timelblstart.text = [sectionar4 objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==5)
        {
            timelblstart.text = [sectionar5 objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==6)
        {
            timelblstart.text = [sectionar5 objectAtIndex:indexPath.row];
        }
        
        
        
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell1 addSubview:plus];
        [cell1 addSubview:celllbl];
        //    [cell addSubview:timelblstart];
        //    [cell addSubview:timelblend];
        [cell1 addSubview:divider];
        return  cell1;

    }
    
    
    else if (tableView==SearchTable)
    {
        static NSString *CellIdentifier = @"Cell";
       locationCell  *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell2 = [[[NSBundle mainBundle]loadNibNamed:@"locationCell" owner:self options:nil] objectAtIndex:0];
        
        
        cell2.loationLbl.text = [Arraytable objectAtIndex:indexPath.row];
        
        
        return cell2;
        
    }
    
    else if (tableView==selectTable)
    {
        
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cellselect = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        
        
        cellselect = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cellselect.textLabel.text=[mainSelectArray[indexPath.row] valueForKey:@"name"];
        
        
        return cellselect;

        
        
    }
    
    
    
    else if (tableView==categoriesTable)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cellcategories = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cellcategories.backgroundColor =[UIColor whiteColor];
        
        
        cellcategories = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cellcategories.textLabel.text=categoriesArray[indexPath.row];
        
        
        return cellcategories;
        
    }
    
    else if (tableView==Booking_Type_Table)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cellbooking = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cellbooking.backgroundColor =[UIColor whiteColor];
        
        
        cellbooking = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cellbooking.textLabel.text=Booking_Type_Array[indexPath.row];
        
        
        return cellbooking;

    }
    
    else if (tableView==Main_Categories_Table)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell_Main_Categories = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell_Main_Categories.backgroundColor =[UIColor whiteColor];
        
        
        cell_Main_Categories = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cell_Main_Categories.textLabel.text=Main_Categories_ArrayName[indexPath.row];
        
        
        return cell_Main_Categories;
    }
    
    else if (tableView==Service_Main_Categories_Table)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell_service = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell_service.backgroundColor =[UIColor whiteColor];
        
        
        cell_service = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cell_service.textLabel.text=Service_Main_Categories_ArrayName[indexPath.row];
        
        
        
        return cell_service;
    }
    
    else if (tableView==checkTable)
    {
        
        static NSString *CellIdentifier = @"Cell";
        cellCheckbox = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cellCheckbox = [[[NSBundle mainBundle]loadNibNamed:@"eventcell" owner:self options:nil] objectAtIndex:0];
        
         cellCheckbox.optionnamelabel.text =[cheboxMain_Array[indexPath.row] valueForKey:@"name"];
        
        
        
        for (int k=0; k<chebox_id_Array.count; k++)
        {
            NSString *data1=[[cheboxMain_Array objectAtIndex:indexPath.row] valueForKey:@"id"];
            
            if ([data1 isEqualToString:[chebox_id_Array objectAtIndex:k]])
            {
                cellCheckbox.selectionimage.image=[UIImage imageNamed:@"check_on_category"];
                
            }
            
        }
        
        
        cellCheckbox.selectionStyle=NO;
        
        
        
        
        
        
        
        
        
        
        
        return cellCheckbox;
    }
    
    else if (tableView==aminitiesTable)
    {
        static NSString *CellIdentifier = @"Cell";
        eventcell *aminitiesTablecell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        aminitiesTablecell = [[[NSBundle mainBundle]loadNibNamed:@"eventcell" owner:self options:nil] objectAtIndex:0];
        
        aminitiesTablecell.optionnamelabel.text =[aminitieArray[indexPath.row] valueForKey:@"aminities_name"];
//        aminities_id
//        hb
        
        
        for (int k=0; k<aminities_id_Array.count; k++)
        {
            NSString *data1=[aminitieArray [indexPath.row]valueForKey:@"aminities_id"];
            
            if ([data1 isEqualToString:[aminities_id_Array objectAtIndex:k]])
            {
                aminitiesTablecell.selectionimage.image=[UIImage imageNamed:@"check_on_category"];
                
            }
            
        }
        
        
        aminitiesTablecell.selectionStyle=NO;
        
        return aminitiesTablecell;
    }
    
    else if (tableView==radioTable)
    {
        
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cellradio = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
       
        
        
        cellradio = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cellradio.textLabel.text=[mainradioArray[indexPath.row] valueForKey:@"name"];
        
       
        
        
        
        
        return cellradio;
       
    
    }
    
    else if (tableView==subcatTable)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cellsubcat = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cellsubcat.backgroundColor =[UIColor whiteColor];
        
        
        cellsubcat = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cellsubcat.textLabel.text=selectName[indexPath.row];
        
        
        
        return cellsubcat;

    }
   
    
    
    else if (tableView==select_sub_Table)
    {
        
        if (select_sub_Table.tag==selecttagcheck)
        {
            
            
            
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *cell_select_sub_Table = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
           
            
            
            cell_select_sub_Table = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            
            cell_select_sub_Table.textLabel.text=[select_sub_Table_Array[indexPath.row] valueForKey:@"name"];
            
            
            
            return cell_select_sub_Table;
            
        }
        
        else
        {
            return 0;
        }
        
        
    }
    
    
    else if (tableView==radio_sub_table)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell_radio_sub_table = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        
        
        cell_radio_sub_table = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        cell_radio_sub_table.textLabel.text=[radio_tableArray[indexPath.row] valueForKey:@"name"];
        
        
        
        return cell_radio_sub_table;

    }
    
    
    else if (tableView==checkbox_sub_table)
    {
        static NSString *CellIdentifier = @"Cell";
      eventcell *cell_checkbox_sub_table = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell_checkbox_sub_table = [[[NSBundle mainBundle]loadNibNamed:@"eventcell" owner:self options:nil] objectAtIndex:0];
        
        cell_checkbox_sub_table.optionnamelabel.text =[checkbox_sub_mainArray[indexPath.row] valueForKey:@"name"];
        
        cell_checkbox_sub_table.selectionStyle=NO;
        
        
        for (int k=0; k<chebox_id_Array.count; k++)
        {
            NSString *data1=[[checkbox_sub_mainArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            
            if ([data1 isEqualToString:[chebox_id_Array objectAtIndex:k]])
            {
                cell_checkbox_sub_table.selectionimage.image=[UIImage imageNamed:@"check_on_category"];
                
            }
            
        }
        
        
        
        
        return cell_checkbox_sub_table;

    }
    
    
    else
    {
    
    
    static NSString *CellIdentifier = @"Cell";
  cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"eventcell" owner:self options:nil] objectAtIndex:0];
    
    cell.optionnamelabel.text =keyword_name[indexPath.row];
//    keyword_idstr=keyword_id[indexPath.row];
//    cell.selectionimage.image=[UIImage imageNamed:@"check_off_category"];
    
    for (int k=0; k<tapdata.count; k++)
    {
        NSString *data1=[keyword_id objectAtIndex:indexPath.row];
        
        if ([data1 isEqualToString:[tapdata objectAtIndex:k]])
        {
            cell.selectionimage.image=[UIImage imageNamed:@"check_on_category"];
            
        }
        
    }
    
    cell.selectionStyle=NO;
    
    
    
    return cell;
    }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
       if (tableView == categoriesTable)
    {
        
        
        categoriesName = categoriesArray[indexPath.row];
        
        
        
        [categoryBtn setTitle:categoriesName forState:UIControlStateNormal];
         [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [checkboxview removeFromSuperview];
        [subcatview removeFromSuperview];
        
        ///////Remove Id Array //////////
      
        [aminities_id_Array removeAllObjects];
        [chebox_id_Array removeAllObjects];
        [All_id_Array removeAllObjects];
        [radio_id_Array removeAllObjects];
        
        [option_id removeAllObjects];
        [textvaleArray removeAllObjects];
        
        idtext0=@"";
        idtext1=@"";
        idtext2=@"";
        idtext3=@"";
        
        
        select_id0=@"";
        select_id1=@"";
        select_id2=@"";
        select_id3=@"";
        
        [self categoriesCancel];
        
        if ([categoriesName isEqualToString:@"Product"])
        {
            
            [self BookingCancel_Tap];
            
            //remove
            
            [Booking_Type removeFromSuperview];
            [dropdownimage removeFromSuperview];
            [Service_Main_Categories removeFromSuperview];
            [dropdownimage_Service removeFromSuperview];
            
            Downview.frame =CGRectMake(Downview.frame.origin.x, categoryBtn.frame.size.height+categoryBtn.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
            
             mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);

            
            
            [Main_Categories removeFromSuperview];
            [dropdownimage removeFromSuperview];
            
            
            //create
            
            Main_Categories = [[UIButton alloc]initWithFrame:CGRectMake(firstview.frame.origin.x, categoryBtn.frame.origin.y+categoryBtn.frame.size.height+2, firstview.frame.size.width, firstview.frame.size.height)];
            
            
            dropdownimage = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Categories.frame.origin.x+Main_Categories.frame.size.width-37, Main_Categories.frame.origin.y+Main_Categories.frame.size.height/2-14, 26, 26)];
            
            
            
            [Main_Categories addTarget:self action:@selector(Main_CategoriesTap) forControlEvents:UIControlEventTouchUpInside];
            
            
           // dropdownimage.backgroundColor = [UIColor blackColor];
            dropdownimage.image = [UIImage imageNamed:@"downArrow"];
            
           
            
            Main_Categories.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            Main_Categories.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
          
            [Main_Categories setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
            [Main_Categories.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
            
            Main_Categories.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
            
            [Main_Categories setTitle: @"Main Categories" forState:UIControlStateNormal];
            
            
            Downview.frame =CGRectMake(Downview.frame.origin.x, Main_Categories.frame.size.height+Main_Categories.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
            
            
            [mainScroll addSubview:Main_Categories];
            
            
            [mainScroll addSubview:dropdownimage];
            
            
              mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
            
            
            
        }
        
        
        else if ([categoriesName isEqualToString:@"Service"])
       
        {
            [self BookingCancel_Tap];
            
            //remove
            
            
            [Main_Categories removeFromSuperview];
            [dropdownimage removeFromSuperview];
            
            
             Downview.frame =CGRectMake(Downview.frame.origin.x, categoryBtn.frame.size.height+categoryBtn.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
            
            mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
            
            
            [Booking_Type removeFromSuperview];
            [dropdownimage removeFromSuperview];
            [Service_Main_Categories removeFromSuperview];
            [dropdownimage_Service removeFromSuperview];
            
        
            //Create
            
            
            //1st Button
            
            
            Booking_Type =[[UIButton alloc]initWithFrame:CGRectMake(firstview.frame.origin.x, categoryBtn.frame.origin.y+categoryBtn.frame.size.height+2, firstview.frame.size.width, firstview.frame.size.height)];
            
            
            [Booking_Type addTarget:self action:@selector(Booking_Type_Tap) forControlEvents:UIControlEventTouchUpInside];
            
            dropdownimage = [[UIImageView alloc]initWithFrame:CGRectMake(Booking_Type.frame.origin.x+Booking_Type.frame.size.width-37, Booking_Type.frame.origin.y+Booking_Type.frame.size.height/2-14, 26, 26)];
            
            dropdownimage.image = [UIImage imageNamed:@"downArrow"];
            
            
            Booking_Type.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            Booking_Type.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            [Booking_Type setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
            [Booking_Type.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
            
            Booking_Type.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
            
            [Booking_Type setTitle: @"Booking Type" forState:UIControlStateNormal];
            
            
            
            [mainScroll addSubview:Booking_Type];
            [mainScroll addSubview:dropdownimage];
            
            
            //2nd Button
            
            
            Service_Main_Categories =[[UIButton alloc]initWithFrame:CGRectMake(firstview.frame.origin.x, Booking_Type.frame.origin.y+Booking_Type.frame.size.height+2, firstview.frame.size.width, firstview.frame.size.height)];
            
            
            [Service_Main_Categories addTarget:self action:@selector(Service_Main_Categories_Tap) forControlEvents:UIControlEventTouchUpInside];
            
             dropdownimage_Service = [[UIImageView alloc]initWithFrame:CGRectMake(Service_Main_Categories.frame.origin.x+Service_Main_Categories.frame.size.width-37, Service_Main_Categories.frame.origin.y+Service_Main_Categories.frame.size.height/2-14, 26, 26)];
            
            
            dropdownimage_Service.image = [UIImage imageNamed:@"downArrow"];
            
            Service_Main_Categories.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            Service_Main_Categories.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            [Service_Main_Categories setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
            [Service_Main_Categories.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
            
            Service_Main_Categories.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
            
            [Service_Main_Categories setTitle: @"Main Categories" forState:UIControlStateNormal];
            
            
            
            [mainScroll addSubview:Service_Main_Categories];
            [mainScroll addSubview:dropdownimage_Service];
            
            
            Downview.frame =CGRectMake(Downview.frame.origin.x, Service_Main_Categories.frame.size.height+Service_Main_Categories.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
            

            mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
            
            
        }
        
        else
        {
            [self BookingCancel_Tap];
            
            [Main_Categories removeFromSuperview];
            [dropdownimage removeFromSuperview];
            
            
            [Booking_Type removeFromSuperview];
            [Service_Main_Categories removeFromSuperview];
            [dropdownimage_Service removeFromSuperview];
            
            
            Downview.frame =CGRectMake(Downview.frame.origin.x, categoryBtn.frame.size.height+categoryBtn.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
            
             mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
        }
        
        
        
        
    }
    
    else if (tableView==selectTable)
    {
        
        
        //selectedid= selectId[indexPath.row];
        
      //  NSLog(@"selected--%@",selectedid);
        
        selectBtn =(UIButton *)[checkboxview viewWithTag:select_tag];
        
        
        if (select_tag==0)
        {
            [selecttagbtn setTitle:[mainSelectArray[indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            select_id0 =[mainSelectArray[indexPath.row] valueForKey:@"id"];
            
        }
        
        else if (select_tag==1)
        {
            [selecttagbtn setTitle:[mainSelectArray[indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            select_id1 =[mainSelectArray[indexPath.row] valueForKey:@"id"];
            
        }
        
        else if (select_tag==2)
        {
            [selecttagbtn setTitle:[mainSelectArray[indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            select_id2 =[mainSelectArray[indexPath.row] valueForKey:@"id"];
            
        }
        
        else if (select_tag==3)
        {
            [selecttagbtn setTitle:[mainSelectArray[indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            select_id3 =[mainSelectArray[indexPath.row] valueForKey:@"id"];
            
        }

        
        [selecttagbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        
        
        [self selectTable];
    }
    
    
    
    
    
    
    else if (tableView==radioTable)
    {
       
            
            
            
            
             radioBtn =(UIButton *)[checkboxview viewWithTag:radiotag];
            
            
            if (radiotag==0)
            {
                [radioTagbtnsender setTitle:[mainradioArray[indexPath.row] valueForKey:@"name"]forState:UIControlStateNormal];
                
              
                
                idtext0 = [mainradioArray[indexPath.row] valueForKey:@"id"];
                
                //[radio_id_Array addObject:idtext];
                
                
            }
          else  if (radiotag==1)
            {
                [radioTagbtnsender setTitle:[mainradioArray[indexPath.row] valueForKey:@"name"]forState:UIControlStateNormal];
                
               idtext1 = [mainradioArray[indexPath.row] valueForKey:@"id"];
                
                //[radio_id_Array addObject:idtext];
                
            }

           else if (radiotag==2)
            {
                [radioTagbtnsender setTitle:[mainradioArray[indexPath.row] valueForKey:@"name"]forState:UIControlStateNormal];
                
                idtext2 = [mainradioArray[indexPath.row] valueForKey:@"id"];
                
               // [radio_id_Array addObject:idtext];
                
            }

           else if (radiotag==3)
            {
                [radioTagbtnsender setTitle:[mainradioArray[indexPath.row] valueForKey:@"name"]forState:UIControlStateNormal];
                
                idtext3 = [mainradioArray[indexPath.row] valueForKey:@"id"];
                
               // [radio_id_Array addObject:idtext];
                
            }

            
            [radioTagbtnsender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
          NSLog(@" id0 =%@ \n id1 =%@ \n id2 =%@ \n id3 =%@ \n ",idtext0,idtext1,idtext2,idtext3);
        
        
        [self radioTable];
        
    }
    
    
    else if (tableView==Service_Main_Categories_Table)
    {
        
        Service_Main_Categories_name = Service_Main_Categories_ArrayName[indexPath.row];
        Main_Categories_id = Service_Main_Categories_ArrayId[indexPath.row];
        
        [Service_Main_Categories setTitle:Service_Main_Categories_name forState:UIControlStateNormal];
        [Service_Main_Categories setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self Service_Main_CategoriesCancel_Tap ];
        
        [checkboxview removeFromSuperview];
        [subcatview removeFromSuperview];
        
        
        ////Remove Id Array/////
        [aminities_id_Array removeAllObjects];
        [chebox_id_Array removeAllObjects];
        [All_id_Array removeAllObjects];
        [radio_id_Array removeAllObjects];
        
        
        idtext0=@"";
        idtext1=@"";
        idtext2=@"";
        idtext3=@"";
        
        select_id0=@"";
        select_id1=@"";
        select_id2=@"";
        select_id3=@"";
        
        Downview.frame =CGRectMake(Downview.frame.origin.x, Service_Main_Categories.frame.size.height+Service_Main_Categories.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
        
        
        [self Service_Main_Categories_Function];
        
        
        NSLog(@"id---%@--%@",Service_Main_Categories_name,Main_Categories_id);
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    else if (tableView==Main_Categories_Table)
    {
        
        Main_Categories_name = Main_Categories_ArrayName[indexPath.row];
        Main_Categories_id = Main_Categories_ArrayId[indexPath.row];
        
        [Main_Categories setTitle:Main_Categories_name forState:UIControlStateNormal];
        [Main_Categories setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self Main_CategoriesCancel_Tap ];
        
        NSLog(@"kausik---%@--%@",Main_Categories_name,Main_Categories_id);
        [checkboxview removeFromSuperview];
        [subcatview removeFromSuperview];
        
        ////Remove Id Array/////
        [aminities_id_Array removeAllObjects];
        [chebox_id_Array removeAllObjects];
        [All_id_Array removeAllObjects];
        [radio_id_Array removeAllObjects];
        
        
        idtext0=@"";
        idtext1=@"";
        idtext2=@"";
        idtext3=@"";
        
        select_id0=@"";
        select_id1=@"";
        select_id2=@"";
        select_id3=@"";
        
        
        Downview.frame =CGRectMake(Downview.frame.origin.x, Main_Categories.frame.size.height+Main_Categories.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
        
        
        [aminities_id_Array removeAllObjects];
        [self producr_Function];
        
        
    }
    else if (tableView==aminitiesTable)
    {
        
        
        
        
        BOOL check;
        check=true;
        
        NSLog(@"tapped %ld",(long)indexPath.row);
        
        
        NSString *data1=[[aminitieArray objectAtIndex:indexPath.row] valueForKey:@"aminities_id"];
        
        if (aminities_id_Array.count==0)
        {
            [aminities_id_Array addObject:[[aminitieArray objectAtIndex:indexPath.row] valueForKey:@"aminities_id"]];
            
            [aminitiesTable reloadData];
        }
        
        else
        {
            
            for (int k=0; k<aminities_id_Array.count; k++)
            {
                
                if ([data1 isEqualToString:[aminities_id_Array objectAtIndex:k]])
                {
                    [aminities_id_Array removeObjectAtIndex:k];
                    NSLog(@"if condition");
                    check=false;
                }
                
                
                
                
            }
            if (check==true) {
                
                [aminities_id_Array addObject:[[aminitieArray objectAtIndex:indexPath.row] valueForKey:@"aminities_id"]] ;
                
            }
            
            [aminitiesTable reloadData];
            NSLog(@"else condition");
            
        }
        
        NSLog(@"%@",aminities_id_Array);
        
        
        
        
    }
    
    
    else if (tableView==checkTable)
    {
    
        BOOL chk;
        chk=true;
        
        NSLog(@"tapped %ld",(long)indexPath.row);
        
        
        NSString *data1=[[cheboxMain_Array objectAtIndex:indexPath.row] valueForKey:@"id"];
     
        if (chebox_id_Array.count==0)
        {
            [chebox_id_Array addObject:[[cheboxMain_Array objectAtIndex:indexPath.row] valueForKey:@"id"] ];
          
            [checkTable reloadData];
        }
        
        else
        {
            
            for (int k=0; k<chebox_id_Array.count; k++)
            {
                
                if ([data1 isEqualToString:[chebox_id_Array objectAtIndex:k]])
                {
                    [chebox_id_Array removeObjectAtIndex:k];
                    NSLog(@"if condition");
                    chk=false;
                }
                
                
                
                
            }
            if (chk==true) {
               
                [chebox_id_Array addObject:[[cheboxMain_Array objectAtIndex:indexPath.row] valueForKey:@"id"]] ;
                
            }
          
            [checkTable reloadData];
            NSLog(@"else condition");
            
        }
        
        NSLog(@"%@",chebox_id_Array);
        
    
        
    
    
    }
    
    else if (tableView==checkbox_sub_table)
    {
        
        BOOL checkBoxBool;
        checkBoxBool=true;
        
        NSLog(@"tapped %ld",(long)indexPath.row);
        
        
        NSString *data1=[[checkbox_sub_mainArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        if (chebox_id_Array.count==0)
        {
            [chebox_id_Array addObject:[[checkbox_sub_mainArray objectAtIndex:indexPath.row] valueForKey:@"id"] ];
            
            [checkbox_sub_table reloadData];
        }
        
        else
        {
            
            for (int k=0; k<chebox_id_Array.count; k++)
            {
                
                if ([data1 isEqualToString:[chebox_id_Array objectAtIndex:k]])
                {
                    [chebox_id_Array removeObjectAtIndex:k];
                    NSLog(@"if condition");
                    checkBoxBool=false;
                }
                
                
                
                
            }
            if (checkBoxBool==true) {
                
                [chebox_id_Array addObject:[[checkbox_sub_mainArray objectAtIndex:indexPath.row] valueForKey:@"id"]] ;
                
            }
            
            [checkbox_sub_table reloadData];
            NSLog(@"else condition");
            
        }
        
        NSLog(@"%@",chebox_id_Array);
        

        
    }
    
    
    else if (tableView==Booking_Type_Table)
             {
                 
                 
                 Booking_TypeString = Booking_Type_Array[indexPath.row];
                 
                 [Booking_Type setTitle:Booking_TypeString forState:UIControlStateNormal];
                 [Booking_Type setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 
                 [self BookingCancel_Tap];
                 
                 
                 
             }
    
   
    else if (tableView==subcatTable)
    {
        
        [subCatbtn setTitle:selectName[indexPath.row] forState:UIControlStateNormal];
        [subCatbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        subcat_id = selectId[indexPath.row];
        
        [subcatview removeFromSuperview];
     
        Downview.frame = CGRectMake(Downview.frame.origin.x, checkboxview.frame.origin.y+checkboxview.frame.size.height, Downview.frame.size.width, Downview.frame.size.height);
        
        ////Remove Id Array/////
        [aminities_id_Array removeAllObjects];
        [chebox_id_Array removeAllObjects];
        [All_id_Array removeAllObjects];
      
        idtext0=@"";
        idtext1=@"";
        idtext2=@"";
        idtext3=@"";
        
        select_id0=@"";
        select_id1=@"";
        select_id2=@"";
        select_id3=@"";
        
        
        [aminities_id_Array removeAllObjects];
        
        if ([categoriesName isEqualToString:@"Service"])
        {
           [self Sub_Categories_function];
            
           // [self Product_sub_catFunction];
            
        }
        
        else
        {
            NSLog(@"***************************");
            
        [self Product_sub_catFunction];
            
            //[self Sub_Categories_function];
        }
        
        
        NSLog(@"subcat----%@",subcat_id);
        
        [self subcatCancel];
        
        
    }
    
    
    
    else if (tableView==radio_sub_table)
    {
        
        
        NSLog(@"working");
        
        
        radio_sub_btn =(UIButton *)[subcatview viewWithTag:radiosubbtnTap];
        
        if (radiosubbtnTap==0)
        {
            [radioTagbtn setTitle:[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            idtext0 =[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            
            
        }
        
        
       else if (radiosubbtnTap==1)
        {
            [radioTagbtn setTitle:[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            idtext1 =[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            
        }
        
      else  if (radiosubbtnTap==2)
        {
            [radioTagbtn setTitle:[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            idtext2 =[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            
        }
      else  if (radiosubbtnTap==3)
        {
            [radioTagbtn setTitle:[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            idtext3 =[[radio_tableArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            
        }
        
        
        [radioTagbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        NSLog(@" id0 =%@ \n id1 =%@ \n id2 =%@ \n id3 =%@ \n ",idtext0,idtext1,idtext2,idtext3);
        
        [self radio_sub_tablecancel];
        
        
    }
    
    else if (tableView==select_sub_Table)
    {
        


   
        select_sub_btn=(UIButton *)[subcatview viewWithTag:selecttagcheck];
       
        NSLog(@"class: %@", [select_sub_btn class]);
        if (selecttagcheck==0)
        {
            
            NSString *temp1 =[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"name"];
            
            NSLog(@"0 tag===%@",temp1);
            
            [buttontagset setTitle:temp1 forState:UIControlStateNormal];
            
            select_id0 =[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"id"];
            
        }
        
        else if(selecttagcheck==1)
        {
            [buttontagset setTitle:[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            select_id1 =[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"id"];

          
        }
        
        
        else if(selecttagcheck==2)
        {
            [buttontagset setTitle:[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            select_id2 =[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"id"];

            
        }
        
        else if(selecttagcheck==3)
        {
            [buttontagset setTitle:[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            select_id3 =[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"id"];

            
        }
        
        else
        {
            [buttontagset setTitle:[[select_sub_Table_Array objectAtIndex:indexPath.row]valueForKey:@"name"] forState:UIControlStateNormal];
            
        }
        
        
        [buttontagset setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self selectcancelTap];
    

    
        
        
        
        
        
        
        
        
        
        
       
    }
    
    
    
  else  if (tableView==KeywordTableView)
    {
        BOOL chk;
        chk=true;
        
        NSLog(@"tapped %ld",(long)indexPath.row);
        
        
        NSString *data1=[keyword_id objectAtIndex:indexPath.row];
        if (tapdata.count==0)
        {
            [tapdata addObject:[keyword_id objectAtIndex:indexPath.row]];
            [KeywordTableView reloadData];
        }
        else
        {
            
            for (int k=0; k<tapdata.count; k++)
            {
                
                if ([data1 isEqualToString:[tapdata objectAtIndex:k]])
                {
                    [tapdata removeObjectAtIndex:k];
                    NSLog(@"if condition");
                    chk=false;
                }
                
                
                
                
            }
            if (chk==true) {
                [tapdata addObject:[keyword_id objectAtIndex:indexPath.row]] ;
                
            }
            [KeywordTableView reloadData];
            NSLog(@"else condition");
            
        }
        
        NSLog(@"%@",tapdata);
        
    }
    
    
    
    else if  (tableView==CalenderView.tableview)
    {
        if (![selectedRows containsObject:indexPath])
            [selectedRows addObject:indexPath];
        else
            [selectedRows removeObject:indexPath];
        NSLog(@"selected rows----%@",selectedRows);
        
        //    [CalenderView.tableview reloadRowsAtIndexPaths:@[indexPath]];
        
        [pickerview removeFromSuperview];
        [backview removeFromSuperview];
        
        if (indexPath.section == 0)
        {
            tapcheck = 1;
            if (indexPath.row == 0)
            {
                   
                pickerflag = 0;
                cellchk=true;
            }
            else if (indexPath.row == 1)
            {
                    
                pickerflag = 1;
                cellchk=false;
            }
            
        }
        else if (indexPath.section == 1)
        {
            tapcheck = 2;
            if (indexPath.row == 0)
            {
                cellchk=true;
                    
                pickerflag = 0;
            }
            else if (indexPath.row == 1)
            {
                
                cellchk=false;
                pickerflag = 1;
            }
        }
        else if (indexPath.section == 2)
        {
            tapcheck = 3;
            if (indexPath.row == 0)
            {
                cellchk=true;
                    
                pickerflag = 0;
            }
            else if (indexPath.row == 1)
            {
                    cellchk=false;
                pickerflag = 1;
            }
        }
        else if (indexPath.section == 3)
        {
            tapcheck = 4;
            if (indexPath.row == 0)
            {
                  cellchk=true;
                pickerflag = 0;
            }
            else if (indexPath.row == 1)
            {
                    cellchk=false;
                pickerflag = 1;
            }
        }
        else if (indexPath.section == 4)
        {
            tapcheck = 5;
            if (indexPath.row == 0)
            {
                cellchk=true;
                      
                pickerflag = 0;
            }
            else if (indexPath.row == 1)
            {
                      cellchk=false;
                pickerflag = 1;
            }
        }
        
        else if (indexPath.section == 5)
        {
            tapcheck = 6;
            if (indexPath.row == 0)
            {
                cellchk=true;
                
                pickerflag = 0;
            }
            else if (indexPath.row == 1)
            {
                cellchk=false;
                
                pickerflag = 1;
            }
        }
        
        else if (indexPath.section == 6)
        {
            tapcheck = 7;
            if (indexPath.row == 0)
            {
                cellchk=true;
                pickerflag = 0;
            }
            else if (indexPath.row == 1)
            {
                cellchk=false;
                pickerflag = 1;
            }
        }
        
        //    NSLog(@"array: %@",arraytime);
        
        [self createpicker];\

    }
    
    
    
    else if (tableView==SearchTable)
        
    {
        [SearchTable removeFromSuperview];
        [locationview.TypeAddressTxt resignFirstResponder];
        
        [locationview.locationScroll setScrollEnabled:YES];
        
        
        
        if (txtfeildcheck==YES)
        {
            
            
            
            
            
            locationview.TypeAddressTxt.text=[Arraytable objectAtIndex:indexPath.row];
            
            [locationview.locationScroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            
            if (locationview.TypeAddressTxt.text.length>0)
            
                
            {
                
                
                
                
                
                
//                NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=AIzaSyAsdkm0gt7PAsMO7uUFH-BnYOwclf0KsZI",locationview.TypeAddressTxt.text];
//                
//                
//                NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                
//                
//                [globalobj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error) {
//                    
//                    NSArray *addressArray1;
//                    
//                    if ([[result valueForKey:@"status"]isEqualToString:@"OK"])
//                    {
//                        
//                        NSMutableArray *arryAddress =[result valueForKey:@"results"];
//                        
//                        
//                        NSString *address = [arryAddress [0] valueForKey:@"formatted_address"];
//                        
//                        
//                        if (address.length>0)
//                        {
//                            addressArray1 = [address componentsSeparatedByString:@", "];
//                        }
//                        
//                        
//                        
//                        NSLog(@"^^^^^^^^^^^^^^^^^^^>>>>>>>>%@",address);
//                        
//                        NSLog(@"^^^^^^^^^^^^^^^^^^^>>>>>>>>%@",addressArray1);
//                        
//                        
//                        
//                        
//                        
//                        if (addressArray1.count>0)
//                        {
//                            
//                            
//                            for (int i=0; i<addressArray1.count; i++)
//                            {
//                                
//                                
//                                if (i==addressArray1.count-1)
//                                {
//                                    locationview.locationCountrytext.text = [addressArray1 objectAtIndex:i];
//                                }
//                                
//                                else if (i==addressArray1.count-2)
//                                {
//                                    
//                                    
//                                    
//                                    
//                                    
//                                    
//                                    
//                                    //  if([[addressArray1 objectAtIndex:i]rangeOfCharacterFromSet:numbers].location)
//                                    
//                                    
//                                    if ([[addressArray1 objectAtIndex:i] rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
//                                        
//                                    {
//                                        
//                                        
//                                        NSLog(@"if ififififififiififi");
//                                        
//                                        
//                                        
//                                        
//                                        NSString *numberString;
//                                        
//                                        NSScanner *scanner = [NSScanner scannerWithString:[addressArray1 objectAtIndex:i]];
//                                        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//                                        
//                                        
//                                        // Throw away characters before the first number.
//                                        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
//                                        
//                                        // Collect numbers.
//                                        [scanner scanCharactersFromSet:numbers intoString:&numberString];
//                                        
//                                        
//                                        locationview.locationZipcode.text = numberString;
//                                        
//                                        
//                                        
//                                        NSString *filter = [[addressArray1 objectAtIndex:i] stringByReplacingOccurrencesOfString:numberString withString:@""];
//                                        
//                                        
//                                        
//                                        locationview.LocationState.text=filter;
//                                        
//                                    }
//                                    
//                                    else
//                                    {
//                                        locationview.LocationState.text=[addressArray1 objectAtIndex:i];
//                                    }
//                                    
//                                    
//                                    
//                                    
//                                    
//                                }
//                                
//                                else if (i==addressArray1.count-3)
//                                {
//                                    
//                                    
//                                    
//                                    
//                                    locationview.location_city.text = [addressArray1 objectAtIndex:i];
//                                    
//                                    
//                                    
//                                }
//                                
//                                
//                                
//                                else if (i==addressArray1.count-addressArray1.count)
//                                {
//                                    
//                                    
//                                    if(addressArray1.count>=4)
//                                    {
//                                        
//                                    
//                                    locationview.locationStreetaddress.text = [addressArray1 objectAtIndex:i];
//                                    
//                                    }
//                                    
//                                }
//                                
//                                
//                                
//                                
//                                
//                            }
//                        }
//                        
//                        
//                        [locationview.Address resignFirstResponder];
//                        
//                        
//                        
//                    }
//                    
//                    
//                }];
                
                
                
                
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                [geocoder geocodeAddressString:[locationview.TypeAddressTxt text] completionHandler:^(NSArray *placemarks, NSError *error) {
                    if (error) {
                        NSLog(@"%@", error);
                    } else {
                        
                        
                         [locationview.location_Map removeAnnotation:myAnnotation];
                        [locationview.location_Map removeAnnotation:myAnnotation1];
                        
                        
                        if (renderer)
                        {
                           
                            
                             [locationview.location_Map removeOverlays:locationview.location_Map.overlays];
                        }
                        
                        
                       
                        
                        
                        CLPlacemark *placemark = [placemarks objectAtIndex:0];
                        NSLog(@"place===%@",placemark);
                        CLLocation *locationplace = placemark.location;
                        coordinate[0] = locationplace.coordinate;
                        NSLog(@"coordinate = (%f, %f)", coordinate[0].latitude, coordinate[0].longitude);
                        
                        
                       myAnnotation = [[MKPointAnnotation alloc]init];
                        myAnnotation.coordinate = coordinate[0];
                        
                        myAnnotation.title=[locationview.TypeAddressTxt text];
                       
                        
                        [locationview.location_Map addAnnotation:myAnnotation];
                        
                        
                        [anotation removeAllObjects];
                        
                        [anotation addObject:myAnnotation];
                        [locationview.location_Map showAnnotations:anotation animated:YES];
                        
                        
                        
                        // NSLog(@"lat----%f---%f ",region.center.latitude,placemark.location.coordinate.latitude);
                        // NSLog(@"lon----%f -----%f",region.center.longitude, placemark.location.coordinate.longitude);
                        
                        
                        
                        
                    }
                }];

                
            }
            
            
        }
        
        
        
     
        
        else
        {
            
            
            
            
          
            [SearchTable removeFromSuperview];
            [locationview.TypeAddressTxt2 resignFirstResponder];
            
             [locationview.locationScroll setContentOffset:CGPointMake(0.0f,100.0f) animated:YES];
           
                
                
                locationview.TypeAddressTxt2.text=[Arraytable objectAtIndex:indexPath.row];
                
                
                if (locationview.TypeAddressTxt2.text.length>0)
                    
                    
                {
//                    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=AIzaSyAsdkm0gt7PAsMO7uUFH-BnYOwclf0KsZI",locationview.TypeAddressTxt2.text];
//                    
//                    
//                    NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                    
//                    
//                    [globalobj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error) {
//                        
//                        NSArray *addressArray1;
//                        
//                        if ([[result valueForKey:@"status"]isEqualToString:@"OK"])
//                        {
//                            
//                            NSMutableArray *arryAddress =[result valueForKey:@"results"];
//                            
//                            
//                            NSString *address = [arryAddress [0] valueForKey:@"formatted_address"];
//                            
//                            
//                            if (address.length>0)
//                            {
//                                addressArray1 = [address componentsSeparatedByString:@", "];
//                            }
//                            
//                            
//                            
//                            NSLog(@"^^^^^^^^^^^^^^^^^^^>>>>>>>>%@",address);
//                            
//                            NSLog(@"^^^^^^^^^^^^^^^^^^^>>>>>>>>%@",addressArray1);
//                            
//                            
//                            
//                            
//                            
//                            if (addressArray1.count>0)
//                            {
//                                
//                                
//                                for (int i=0; i<addressArray1.count; i++)
//                                {
//                                    
//                                    
//                                    if (i==addressArray1.count-1)
//                                    {
//                                        locationview.locationcountry2.text = [addressArray1 objectAtIndex:i];
//                                    }
//                                    
//                                    else if (i==addressArray1.count-2)
//                                    {
//                                        
//                                        
//                                        
//                                        
//                                        
//                                        
//                                        
//                                        //  if([[addressArray1 objectAtIndex:i]rangeOfCharacterFromSet:numbers].location)
//                                        
//                                        
//                                        if ([[addressArray1 objectAtIndex:i] rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
//                                            
//                                        {
//                                            
//                                            
//                                            NSLog(@"if ififififififiififi");
//                                            
//                                            
//                                            
//                                            
//                                            NSString *numberString;
//                                            
//                                            NSScanner *scanner = [NSScanner scannerWithString:[addressArray1 objectAtIndex:i]];
//                                            NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//                                            
//                                            
//                                            // Throw away characters before the first number.
//                                            [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
//                                            
//                                            // Collect numbers.
//                                            [scanner scanCharactersFromSet:numbers intoString:&numberString];
//                                            
//                                            
//                                            locationview.locationzipcode2.text = numberString;
//                                            
//                                            
//                                            
//                                            NSString *filter = [[addressArray1 objectAtIndex:i] stringByReplacingOccurrencesOfString:numberString withString:@""];
//                                            
//                                            
//                                            
//                                            locationview.locationstate2.text=filter;
//                                            
//                                        }
//                                        
//                                        else
//                                        {
//                                            locationview.locationstate2.text=[addressArray1 objectAtIndex:i];
//                                        }
//                                        
//                                        
//                                        
//                                        
//                                        
//                                    }
//                                    
//                                    else if (i==addressArray1.count-3)
//                                    {
//                                        
//                                        
//                                        
//                                        
//                                        locationview.locationcity2.text = [addressArray1 objectAtIndex:i];
//                                        
//                                        
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                    else if (i==addressArray1.count-addressArray1.count)
//                                    {
//                                        
//                                        
//                                        
//                                        locationview.locationstreet2.text = [addressArray1 objectAtIndex:i];
//                                        
//                                        
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                    
//                                    
//                                }
//                            }
//                            
//                            
//                            [locationview.Address2 resignFirstResponder];
//                            
//                            
//                            
//                        }
//                        
//                        
//                    }];
                    
                    
                    
                    
                    
                    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                    [geocoder geocodeAddressString:[locationview.TypeAddressTxt2 text] completionHandler:^(NSArray *placemarks, NSError *error) {
                        if (error) {
                            NSLog(@"%@", error);
                        } else {
                            
            [locationview.location_Map removeAnnotation:myAnnotation1];
                            
                            if (renderer)
                            {
                                
                                
                                [locationview.location_Map removeOverlays:locationview.location_Map.overlays];
                            }
                            
                            CLPlacemark *placemark = [placemarks objectAtIndex:0];
                            NSLog(@"place===%@",placemark);
                            CLLocation *locationplace = placemark.location;
                            coordinate[1] = locationplace.coordinate;
                            NSLog(@"coordinate1 = (%f, %f)", coordinate[1].latitude, coordinate[1].longitude);
                            
                            
                           
                            
                            myAnnotation1 = [[MKPointAnnotation alloc]init];
                            myAnnotation1.coordinate = coordinate[1];
                            
                            myAnnotation1.title=[locationview.TypeAddressTxt2 text];
                            
                            
                            [locationview.location_Map addAnnotation:myAnnotation1];
                            
                            
                            locationview.location_Map.camera.altitude *= 0.4;
                            
                            
                            [anotation removeAllObjects];
                            
                            if (myAnnotation)
                            {
                                [anotation addObject:myAnnotation];
                            }
                            
                            [anotation addObject:myAnnotation1];
                            
                            
                            
                            
                            [locationview.location_Map showAnnotations:anotation animated:YES];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        [self getDirections];
                        
                        
                    }];
                    
                    
                }
                
                
            
            
            
            
            
            
            
            
            
        }
        
       
        
        
        
    }
    
}


- (void)getDirections
{
    MKDirectionsRequest *request =[[MKDirectionsRequest alloc] init];
    
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate[0] addressDictionary:nil];
    MKMapItem *mapitem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    MKPlacemark *placemark1 = [[MKPlacemark alloc] initWithCoordinate:coordinate[1] addressDictionary:nil];
    MKMapItem *mapitem1 = [[MKMapItem alloc] initWithPlacemark:placemark1];
    
    request.source = mapitem;
    
    request.destination = mapitem1;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle error
             
              NSLog(@"kausik if");
             NSLog(@"=======%@",error);
             
             
             
         } else {
             [self showRoute:response];
             
             CLLocation *locA = [[CLLocation alloc] initWithLatitude:coordinate[0].latitude longitude:coordinate[0].longitude];
             
             CLLocation *locB = [[CLLocation alloc] initWithLatitude:coordinate[1].longitude longitude:coordinate[1].longitude];
             CLLocationDistance distance = [locA distanceFromLocation:locB]/1000;
             
             
             NSLog(@"distance=====%f",distance);
              NSLog(@"kausik else");
         }
     }];
}



-(void)showRoute:(MKDirectionsResponse *)response
{
    for (route in response.routes)
    {
        [locationview.location_Map addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
           // NSLog(@"%@", step.instructions);
            
            
            [routIns addObject:[NSString stringWithFormat:@"%@",step.instructions]];
            
           
        }
    }
     NSLog(@"rout=====%@",routIns);
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    renderer =[[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [[UIColor blueColor]colorWithAlphaComponent:.5f];
    renderer.lineWidth = 5.0;
    return renderer;
}



-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    [self applyMapViewMemoryHotFix];
}


- (void)applyMapViewMemoryHotFix{
    
    switch (locationview.location_Map.mapType) {
        case MKMapTypeHybrid:
        {
            locationview.location_Map.mapType = MKMapTypeStandard;
            
            
            
        }
            
            break;
        case MKMapTypeStandard:
        {
            locationview.location_Map.mapType = MKMapTypeHybrid;
            
        }
            
            break;
        default:
            break;
    }
    
    
    locationview.location_Map.mapType = MKMapTypeStandard;
    
    
    
}







- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    pinView = nil;
    if(annotation != locationview.location_Map.userLocation)
    {
        static NSString *defaultPinID = @"kausik.pin";
        pinView = (MKAnnotationView *)[locationview.location_Map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        //pinView.pinColor = MKPinAnnotationColorGreen;
        pinView.canShowCallout = YES;
        //pinView.animatesDrop = YES;
        pinView.image = [UIImage imageNamed:@"locationPin"];//as suggested by Squatch
        pinView.draggable = YES;
        pinView.dragState = MKAnnotationViewDragStateNone;
       
        //        pinView.centerOffset = CGPointMake(0, -10);
        
        NSLog(@"if");
        
        
        
        
    }
    else {
        [locationview.location_Map.userLocation setTitle:@"I am here"];
        
        
        NSLog(@"else");
    }
   // pinView.dragState = MKAnnotationViewDragStateEnding;
    return pinView;

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
         pinView.draggable = NO;
        
        
        droppedAt = annotationView.annotation.coordinate;
        [annotationView.annotation setCoordinate:droppedAt];
        if(1)
        {
            NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
            
            
         coordinate[0]=coordinate[1];
//            
          //  myAnnotation = [[MKPointAnnotation alloc]init];
            myAnnotation.coordinate=coordinate[0];
            
            //coordinate[2]=droppedAt;
            
            coordinate[1]=droppedAt ;
            
            if (renderer)
            {
                
                
                [locationview.location_Map removeOverlays:locationview.location_Map.overlays];
            }
            
            
            [locationview.location_Map removeAnnotations:anotation];
            
          //  myAnnotation1 = [[MKPointAnnotation alloc]init];
            myAnnotation1.coordinate = droppedAt;
            
            
            
           
            [anotation removeAllObjects];
            
            if (myAnnotation)
            {
                
                 // [locationview.location_Map addAnnotation:myAnnotation];
                
                [anotation addObject:myAnnotation];
            }
            
            if (myAnnotation1)
            {
                [anotation addObject:myAnnotation1];
            }
           
            
            
            
            
            
            [locationview.location_Map showAnnotations:anotation animated:YES];
            
            
            
            annotationView.canShowCallout = YES;
            annotationView.draggable = YES;
            annotationView.dragState = MKAnnotationViewDragStateNone;
            
            // annotationView.dragState = MKAnnotationViewDragStateNone ;
            
            
            CLGeocoder *ceo = [[CLGeocoder alloc]init];
            CLLocation *location = [[CLLocation alloc]initWithLatitude:droppedAt.latitude longitude:droppedAt.longitude]; //insert your coordinates
            
            [ceo reverseGeocodeLocation:location
                      completionHandler:^(NSArray *placemarks, NSError *error)
             {
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 NSLog(@"placemark %@",placemark);
                 //String to hold address
                 NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                 NSLog(@"addressDictionary %@", placemark.addressDictionary);
                 
                 NSLog(@"placemark %@",placemark.region);
                 NSLog(@"placemark %@",placemark.country);  // Give Country Name
                 NSLog(@"placemark %@",placemark.locality); // Extract the city name
                 NSLog(@"location %@",placemark.name);
                 NSLog(@"location %@",placemark.ocean);
                 NSLog(@"location %@",placemark.postalCode);
                 NSLog(@"location %@",placemark.subLocality);
                 
                 NSLog(@"location %@",placemark.location);
                 //Print the location to console
                // NSLog(@"I am currently at %@",locatedAt);
                
                 
                 
                 
                
                 [self getDirections];
                
             }];

            
            
        }
        
        
        
    }
    
    
    
    else
    {
        NSLog(@"I am else part");
        
        
        
        
    }
}


- (void)mapView:(MKMapView *)mapView didAddOverlayRenderers:(NSArray<MKOverlayRenderer *> *)renderers
{
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100);
    [locationview.location_Map setRegion:[locationview.location_Map regionThatFits:region] animated:YES];
}


//////////////////


-(void)allockinit
{
    celllblarr = [NSMutableArray arrayWithObjects:@"Opening Time ", @"Closing Time ", nil];
    
    breaktime = [NSMutableArray arrayWithObjects:@"If Open", @"Opening Time", nil];
   
    
    hours = [NSMutableArray arrayWithObjects:@"00:00",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30", nil];
    
    
     hours2 = [NSMutableArray arrayWithObjects:@"00:00",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30",@"24:00", nil];
    
   // hours2 = [NSMutableArray arrayWithObjects:@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00", nil];
    sectionar0 = [NSMutableArray arrayWithCapacity:2];
    
    sectionar0 = [NSMutableArray arrayWithObjects:@"00:00",@"00:00", nil];
    sectionar1 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    sectionar2 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    sectionar3 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    sectionar4 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
     sectionar5 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
     sectionar6 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    
    collapsedSections = [NSMutableSet new];
    tapcheck = 0;
    dicTab=[[NSMutableDictionary alloc]init];
    dicBtn=[[NSMutableDictionary alloc]init];
    
    dicTab1=[[NSMutableDictionary alloc]init];
    dicBtn1=[[NSMutableDictionary alloc]init];
    dicBtn10=[[NSMutableDictionary alloc]init];
    dicTab10=[[NSMutableDictionary alloc]init];
    
    selectedRows = [[NSMutableArray alloc]init];
    finishtimetap=true;
    finishtimetap1=true;
    finishtimetap2=true;
    finishtimetap3=true;
    finishtimetap4=true;
     finishtimetap5=true;
     finishtimetap6=true;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==CalenderView.tableview)
    {
        return 7;
    }
    else
    {
        return 1;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView==CalenderView.tableview)
    {
        return 40.0f;
    }
    
    else
    {
        return 0;
    }
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView==CalenderView.tableview)
    {
        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CalenderView.tableview.frame.size.width, 40)];
        headerView.backgroundColor=[UIColor clearColor];
        UIImageView *sectionimg = [[UIImageView alloc]initWithFrame:CGRectMake (0, 0,[UIScreen mainScreen].bounds.size.width, 39)];
        sectionimg.image = [UIImage imageNamed:@"rowlbl"];
       
        headerView.tag=section;
       
        UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 40)];
        headLbl.textColor=[UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
        headLbl.font=[UIFont fontWithName:@"Lato" size:14.0f];
       
        
        if (section == 0)
        {
            headLbl.text = @"Sunday";
        }
        else if(section == 1)
        {
            headLbl.text = @"Monday";
        }
        else if(section == 2)
        {
            headLbl.text = @"Tuesday";
        }
        else if (section == 3)
        {
            headLbl.text = @"Wednesday";
        }
        else if(section == 4)
        {
            headLbl.text = @"Thursday";
        }
        else if(section == 5)
        {
            headLbl.text = @"Friday";
        }
        else if(section == 6)
        {
            headLbl.text = @"Saturday";
        }
        
      
        UIImageView *plusimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-35, (headerView.bounds.size.height-20)/2, 20, 20)];
        
        
        
        
     
        
        checkimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-90, (headerView.bounds.size.height-20)/2, 20, 20)];
        
        
         Breakcheckimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-190, (headerView.bounds.size.height-20)/2, 20, 20)];
        
        Breakcheckimg.image = [UIImage imageNamed:@"check_unselect"];
        
        Breakcheckimg.tag=section;
        
        
        
        
        
        
        
        
        
        
        
        NSString *keyBreak=[NSString stringWithFormat:@"%ld",(long)section];
        
        if ([dicBtn10 valueForKey:keyBreak])
        {
            Breakcheckimg.image = [UIImage imageNamed:@"check"];
            
            if (section==0)
            {
                chkstring00=@"Y";
            }
            if (section==1)
            {
                chkstring10=@"Y";
            }
            if (section==2) {
                chkstring20=@"Y";
            }
            if (section==3)
            {
                chkstring30=@"Y";
            }
            if (section==4)
            {
                chkstring40=@"Y";
            }
            if (section==5)
            {
                chkstring50=@"Y";
            }
            if (section==6)
            {
                chkstring60=@"Y";
            }
            
            NSLog(@"%@",chkstring00);
            NSLog(@"%@",chkstring10);
            NSLog(@"%@",chkstring20);
            NSLog(@"%@",chkstring30);
            NSLog(@"%@",chkstring40);
        }
        else
        {
            Breakcheckimg.image = [UIImage imageNamed:@"check_unselect"];
            if (section==0)
            {
                chkstring00=@"N";
            }
            if (section==1)
            {
                chkstring10=@"N";
            }
            if (section==2)
            {
                chkstring20=@"N";
            }
            if (section==3)
            {
                chkstring30=@"N";
            }
            if (section==4)
            {
                chkstring40=@"N";
            }
            if (section==5)
            {
                chkstring30=@"N";
            }
            if (section==6)
            {
                chkstring40=@"N";
            }
            NSLog(@"%@",chkstring00);
            NSLog(@"%@",chkstring10);
            NSLog(@"%@",chkstring20);
            NSLog(@"%@",chkstring30);
            NSLog(@"%@",chkstring40);
            
        }
        
        
        
        
        
        
        
        
        
        
        breaktimebtn = [[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-200, 0, 50, 39)];
        [breaktimebtn addTarget:self action:@selector(breaktimebtn:) forControlEvents:UIControlEventTouchUpInside];
        
        breaktimebtn.tag=section;
        
        breaktimebtn.backgroundColor = [UIColor clearColor];
        
        
        plusimg.image = [UIImage imageNamed:@"plus_grey"];
        checkimg.image = [UIImage imageNamed:@"check_unselect"];
        
        headerTapped = [[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-110, 0, 50, 39)];
        
        headerTapped.tag=section;
        headerTapped.backgroundColor = [UIColor clearColor];
        [headerTapped addTarget:self action:@selector(headerTappedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        headerButton=[[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-60, 0, 60, 39)];
        headerButton.backgroundColor = [UIColor clearColor];
        headerButton.tag=section;
      
        
        
        NSString *key=[NSString stringWithFormat:@"%ld",(long)section];
       
        
        if([dicBtn valueForKey:key])
        {
            plusimg.image = [UIImage imageNamed:@"minus_grey"];
        }
        else
        {
            plusimg.image = [UIImage imageNamed:@"plus_grey"];
            
        }
        
        NSString *key1=[NSString stringWithFormat:@"%ld",(long)section];
        
        if ([dicBtn1 valueForKey:key1])
        {
            checkimg.image = [UIImage imageNamed:@"check"];
            
            if (section==0)
            {
                chkstring0=@"Y";
            }
            if (section==1)
            {
                chkstring1=@"Y";
            }
            if (section==2) {
                chkstring2=@"Y";
            }
            if (section==3)
            {
                chkstring3=@"Y";
            }
            if (section==4)
            {
                chkstring4=@"Y";
            }
            if (section==5)
            {
                chkstring5=@"Y";
            }
            if (section==6)
            {
                chkstring6=@"Y";
            }
            
            NSLog(@"%@",chkstring0);
            NSLog(@"%@",chkstring1);
            NSLog(@"%@",chkstring2);
            NSLog(@"%@",chkstring3);
            NSLog(@"%@",chkstring4);
        }
        else
        {
            checkimg.image = [UIImage imageNamed:@"check_unselect"];
            if (section==0)
            {
                chkstring0=@"N";
            }
            if (section==1)
            {
                chkstring1=@"N";
            }
            if (section==2)
            {
                chkstring2=@"N";
            }
            if (section==3)
            {
                chkstring3=@"N";
            }
            if (section==4)
            {
                chkstring4=@"N";
            }
            if (section==5)
            {
                chkstring3=@"N";
            }
            if (section==6)
            {
                chkstring4=@"N";
            }
            NSLog(@"%@",chkstring0);
            NSLog(@"%@",chkstring1);
            NSLog(@"%@",chkstring2);
            NSLog(@"%@",chkstring3);
            NSLog(@"%@",chkstring4);
            
        }
        
        [headerButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [headerView addSubview:sectionimg];
        [headerView addSubview:checkimg];
        [headerView addSubview:Breakcheckimg];
        [headerView addSubview:plusimg];
        [headerView addSubview:headerButton];
        [headerView addSubview:headerTapped];
        [headerView addSubview:headLbl];
        [headerView addSubview:breaktimebtn];
        
        // NSLog(@"Button for section %ld is created",(long)section);
        
        return headerView;
    }
    
    else
    {
        return 0;
    }
    
}
-(void)headerTappedAction: (UIButton *)sender
{
    UIButton *tapped_button=(UIButton *)(id)sender;
    UIView *supView=[tapped_button superview];
    NSLog(@"Superview tag is: %ld and prev value is: %ld",(long)supView.tag,(long)prev);
    NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
    NSInteger section=supView.tag;
    if(![dicBtn1 valueForKey:key])
    {
        prev=supView.tag;
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        [dicTab1 setObject:@"YES" forKey:key];
        [dicBtn1 setObject:@"YES" forKey:key];
        NSLog(@"dic1---%@",dicBtn1);
        [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
        
        NSLog(@"headerButton---tag%d",(int)sender.tag);
        
        
//        for (int i=0; i<RightTapcheck.count; i++)
//        {
//            int check = (int)[RightTapcheck[i]integerValue];
//            
//            if (check!=(int)sender.tag)
//            {
                 [RightTapcheck addObject:[NSString stringWithFormat:@"%d",(int)sender.tag]];
//            }
//            
//            else
//            {
//                
//            }
        
     //   }
        
       
        
        //        checkimg.image = [UIImage imageNamed:@"check"];
        
        NSLog(@"my array--%@",RightTapcheck);
        
    }
    
    else
    {
        NSLog(@"Entering second condition...");
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        [dicTab1 removeObjectForKey:key];
        [dicBtn1 removeObjectForKey:key];
        [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
        
        //[RightTapcheck removeObjectAtIndex:sender.tag];
        
        
       

        
                for (int i=0; i<RightTapcheck.count; i++)
                {
                    int check = (int)[RightTapcheck[i]integerValue];
        
                    if (check==(int)sender.tag)
                    {
                        
                        [RightTapcheck removeObjectAtIndex:i];
                        
                        
                        
                        
                        //       header close
                        
                                UIButton *tapped_button=(UIButton *)(id)sender;
                        
                                UIView *supView1=[tapped_button superview];
                                NSLog(@"Entering second condition...");
                                NSString *key2=[NSString stringWithFormat:@"%ld",(long)supView1.tag];
                                [dicTab removeObjectForKey:key2];
                                [dicBtn removeObjectForKey:key2];
                                [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
                        
                        
                        
                        ///breaktime
                        
                        
                        
                        NSLog(@"Entering second condition...");
                        NSString *keyBreak=[NSString stringWithFormat:@"%ld",(long)supView.tag];
                        [dicTab10 removeObjectForKey:keyBreak];
                        [dicBtn10 removeObjectForKey:keyBreak];
                        [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
        
                    }
        
             
                    
        
           }
        
        
         NSLog(@"my array Remove --%@",RightTapcheck);
        
        

    }
    
}



-(void)buttonTapped:(UIButton *)sender
{
   
//    if (RightTap==YES)
//    {
    
    for (int i=0; i<RightTapcheck.count; i++)
    {
        int check = (int)[RightTapcheck[i]integerValue];
        
        if (check==(int)sender.tag)
        {
            NSLog(@"tap");
            
            UIButton *tapped_button=(UIButton *)(id)sender;
            
            UIView *supView=[tapped_button superview];
            
            NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
            
            NSInteger section=supView.tag;
            
            if(![dicBtn valueForKey:key])
            {
                
                prev=supView.tag;
                
                NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
                
                [dicTab setObject:@"YES" forKey:key];
                
                [dicBtn setObject:@"YES" forKey:key];
                
                [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
                
            }
            
            
            else
            {
                NSLog(@"Entering second condition...");
                NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
                [dicTab removeObjectForKey:key];
                [dicBtn removeObjectForKey:key];
                [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
                
            }

        }
    }
    
    
    

   // }
}

////Breaktime Btn Tap


-(void)breaktimebtn : (UIButton *)sender
{
    
    
    for (int i=0; i<RightTapcheck.count; i++)
    {
        int check = (int)[RightTapcheck[i]integerValue];
        
        if (check==(int)sender.tag)
        {
            
            NSLog(@"tap ---%d",(int)sender.tag);
            UIButton *tapped_button=(UIButton *)(id)sender;
            UIView *supView=[tapped_button superview];
            NSLog(@"Superview tag is: %ld and prev value is: %ld",(long)supView.tag,(long)prev);
            NSString *keyBreak=[NSString stringWithFormat:@"%ld",(long)supView.tag];
            NSInteger section=supView.tag;
            if(![dicBtn10 valueForKey:keyBreak])
            {
                prev=supView.tag;
                NSString *keyBreak=[NSString stringWithFormat:@"%ld",(long)supView.tag];
                [dicTab10 setObject:@"YES" forKey:keyBreak];
                [dicBtn10 setObject:@"YES" forKey:keyBreak];
                NSLog(@"dic1---%@",dicBtn10);
                [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
                
                
                blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                
                blackview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5f];
                
                
                UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
                tapGestureRecognize.delegate = self;
                tapGestureRecognize.numberOfTapsRequired = 1;
                
                [blackview addGestureRecognizer:tapGestureRecognize];
                
                popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height*.3, self.view.frame.size.width-20, self.view.frame.size.height * .32)];
                
                UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, popview.frame.size.width, 20)];
                header.font = [UIFont fontWithName:@"Lato" size:14.0f];
                header.text = @"Set Break Time";
                header.textAlignment=NSTextAlignmentCenter;
                header.textColor=[UIColor blackColor];
                
                [popview addSubview:header];
                
                
                UILabel *IfOpen = [[UILabel alloc]initWithFrame:CGRectMake(15,header.frame.origin.y+header.frame.size.height+7, 100, 50)];
                // IfOpen.backgroundColor = [UIColor blackColor];
                
                IfOpen.font = [UIFont fontWithName:@"Lato" size:14.0f];
                
                IfOpen.text=@"If Open :";
                
                
                UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(IfOpen.frame.origin.x+IfOpen.frame.size.width+10, IfOpen.frame.origin.y, 200, IfOpen.frame.size.height)];
                
                [btn1 setTitle:@"00:00" forState:UIControlStateNormal];
                
                [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                // btn1.backgroundColor =[UIColor redColor];
                
//                UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, popview.frame.size.height/2, popview.frame.size.width, 1)];
//                
//                line.backgroundColor =[UIColor blackColor];
                
                UILabel * OpeningTime  = [[UILabel alloc]initWithFrame:CGRectMake(15,IfOpen.frame.origin.y+IfOpen.frame.size.height+7 , 100, 50)];
                
                
                
                UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.frame.origin.x, OpeningTime.frame.origin.y, 200, OpeningTime.frame.size.height)];
                
                [btn2 setTitle:@"00:00" forState:UIControlStateNormal];
                
                [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // btn2.backgroundColor =[UIColor redColor];
                
                
                OpeningTime.text =@"Opening Time :";
                
                OpeningTime.font = [UIFont fontWithName:@"Lato" size:14.0f];
                // OpeningTime.backgroundColor = [UIColor blackColor];
                
                
                
                UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(popview.frame.size.width/2-60, popview.frame.size.height-popview.frame.size.height*.15-7, 120, popview.frame.size.height*.15)];
                
                [save setTitle:@"Save" forState:UIControlStateNormal];
                
                save.backgroundColor=[UIColor lightGrayColor];
                
                popview.backgroundColor = [UIColor whiteColor];
                
                [self.view addSubview:blackview];
                [self.view addSubview:popview];
                [popview addSubview:IfOpen];
                [popview addSubview: OpeningTime];
                [popview addSubview:save];
                [popview addSubview:btn1];
                [popview addSubview:btn2];
                
                NSLog(@"headerButton---tag%d",(int)sender.tag);
            }
            
            else
            {
                NSLog(@"Entering second condition...");
                NSString *keyBreak=[NSString stringWithFormat:@"%ld",(long)supView.tag];
                [dicTab10 removeObjectForKey:keyBreak];
                [dicBtn10 removeObjectForKey:keyBreak];
                [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
                
            }

            
            
        }
        
    }

    
    
    
    
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing
             animated:animated];
    [CalenderView.tableview setEditing:editing
                      animated:animated];
}


-(void)OpenDatePicker
{
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - self.view.frame.size.height * .45, self.view.frame.size.width, self.view.frame.size.height * .45)];
    
    pickerview.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor darkGrayColor];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor darkGrayColor];
    [okbtn setTitle:@"Ok" forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okDateAction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelDateAction) forControlEvents:UIControlEventTouchUpInside];
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - okbtn.frame.size.height)];
    //    [datepicker sizeToFit];
    [datepicker setDatePickerMode:UIDatePickerModeDate];
    [datepicker setMinimumDate:[NSDate date]];
    
    [pickerview addSubview:datepicker];
    [self.view addSubview:pickerview];
}

-(void)okDateAction
{
    [pickerview removeFromSuperview];
    [backview removeFromSuperview];
    NSDateFormatter *dateFormator=[[NSDateFormatter alloc] init];
    //[dateFormator setDateFormat:@"dd-MM-YYYY"];
    [dateFormator setDateFormat:@"YYYY-MM-dd"];
  //  NSString *datenew=[dateFormator stringFromDate:datepicker.date];
    //[self.datelbl setText:datenew];
    
    //date pick.......////.......
}

-(void) cancelDateAction
{
    [pickerview removeFromSuperview];
    [backview removeFromSuperview];
}

- (IBAction)dateAvailableTapped:(id)sender
{
    NSLog(@"pickUpDateTapped");
    
    [pickerview removeFromSuperview];
    [backview removeFromSuperview];
    [datepicker removeFromSuperview];
    [self OpenDatePicker];
}

-(void)createpicker
{
    
    backview = [[UIView alloc]initWithFrame:self.view.frame];
    
    backview.backgroundColor = [UIColor clearColor];
   
    [self.view addSubview:backview];
    
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - self.view.frame.size.height * .35, self.view.frame.size.width, self.view.frame.size.height * .35)];
    
    //    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    pickerview.backgroundColor = [UIColor whiteColor];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, 0, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor darkGrayColor];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor darkGrayColor];
    [okbtn setTitle:@"OK" forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okaction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 40,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - 40)];
    
    [pickerview addSubview:picker];
    [self.view addSubview:pickerview];
    //    [picker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    
    picker.delegate = self;
    picker.dataSource = self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (cellchk==true)
    {
        return hours.count;
    }
    else if (cellchk==false)
    {
        return hours2.count;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (cellchk==true) {
        return [hours objectAtIndex:row];
    }
    else if (cellchk==false)
    {
        return [hours2 objectAtIndex:row];
    }
    return 0;
}


-(void)okaction
{
    if (tapcheck == 1)
    {
        if (pickerflag == 0)
        {
            [sectionar0 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            sundaysrttimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar0 insertObject:selecttime atIndex:0];
            if (finishtimetap==false) {
                if (sundaysrttimechk>sundayendtimechk || sundaysrttimechk==sundayendtimechk) {
                    [sectionar0 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                         
                    [pickerview removeFromSuperview];
                    [backview removeFromSuperview];
                    [sectionar0 insertObject:selecttime atIndex:0];
                          
                }
            }
            else
            {
                     
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar0 insertObject:selecttime atIndex:0];
                      
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap=false;
            [sectionar0 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            sundayendtimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar0 insertObject:selecttime atIndex:1];
            if (sundayendtimechk > sundaysrttimechk) {
                
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar0 insertObject:selecttime atIndex:1];
                     
                      
                
            }
            else
            {
                [sectionar0 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
            
            
        }
        [CalenderView.tableview reloadData];
    }
    else if (tapcheck == 2)
    {
        if (pickerflag == 0)
        {
            [sectionar1 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            mondaysrttimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar1 insertObject:selecttime atIndex:0];
            if (finishtimetap1==false) {
                if (mondaysrttimechk > mondayendtimechk || mondaysrttimechk==mondayendtimechk) {
                    [sectionar1 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                         
                    [pickerview removeFromSuperview];
                    [backview removeFromSuperview];
                    [sectionar1 insertObject:selecttime atIndex:0];
                          
                }
            }
            else
            {
                     
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar1 insertObject:selecttime atIndex:0];
                      
            }
            
        }
        else if (pickerflag == 1)
        {
            finishtimetap1=false;
            [sectionar1 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            mondayendtimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            // [sectionar1 insertObject:selecttime atIndex:1];
            
            
            if (mondayendtimechk > mondaysrttimechk)
            {
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar1 insertObject:selecttime atIndex:1];
                     
                      
            }
            else
            {
                [sectionar1 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
            
            
            
        }
        [CalenderView.tableview reloadData];
    }
    else if (tapcheck == 3)
    {
        if (pickerflag == 0)
        {
            [sectionar2 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            tuesdaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar2 insertObject:selecttime atIndex:0];
            if (finishtimetap2==false)
            {
                if (tuesdaysrttime>tuesdayendtime || tuesdaysrttime==tuesdayendtime) {
                    [sectionar2 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                         
                    [pickerview removeFromSuperview];
                    [backview removeFromSuperview];
                    [sectionar2 insertObject:selecttime atIndex:0];
                          
                }
            }
            else
            {
                     
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar2 insertObject:selecttime atIndex:0];
                      
                
            }
            
        }
        else if (pickerflag == 1)
        {
            finishtimetap2=false;
            [sectionar2 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            tuesdayendtime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar2 insertObject:selecttime atIndex:1];
            if (tuesdayendtime > tuesdaysrttime) {
                
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar2 insertObject:selecttime atIndex:1];
                     
                      
            }
            else
            {
                [sectionar2 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [CalenderView.tableview reloadData];
    }
    else if (tapcheck == 4)
    {
        if (pickerflag == 0)
        {
            [sectionar3 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            wednessdaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar3 insertObject:selecttime atIndex:0];
            if (finishtimetap3==false) {
                if (wednessdaysrttime>wednessdayendtime || wednessdaysrttime==wednessdayendtime) {
                    [sectionar3 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                         
                    [pickerview removeFromSuperview];
                    [backview removeFromSuperview];
                    [sectionar3 insertObject:selecttime atIndex:0];
                          
                }
            }
            else
            {
                     
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar3 insertObject:selecttime atIndex:0];
                      
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap3=false;
            [sectionar3 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            wednessdayendtime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar3 insertObject:selecttime atIndex:1];
            if (wednessdayendtime > wednessdaysrttime) {
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar3 insertObject:selecttime atIndex:1];
                     
                      
            }
            else
            {
                [sectionar3 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [CalenderView.tableview reloadData];
    }
    else if (tapcheck == 5)
    {
        if (pickerflag == 0)
        {
            [sectionar4 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            thurdaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar4 insertObject:selecttime atIndex:0];
            if (finishtimetap4==false) {
                if (thurdaysrttime>thurdayendime || thurdaysrttime==thurdayendime) {
                    [sectionar4 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                         
                    [pickerview removeFromSuperview];
                    [backview removeFromSuperview];
                    [sectionar4 insertObject:selecttime atIndex:0];
                          
                }
            }
            else
            {
                     
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar4 insertObject:selecttime atIndex:0];
                      
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap4=false;
            [sectionar4 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            thurdayendime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar4 insertObject:selecttime atIndex:1];
            if (thurdayendime > thurdaysrttime) {
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar4 insertObject:selecttime atIndex:1];
                     
                      
                
            }
            else
            {
                [sectionar4 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [CalenderView.tableview reloadData];
    }
    
    else if (tapcheck == 6)
    {
        if (pickerflag == 0)
        {
            [sectionar5 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            fridaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar4 insertObject:selecttime atIndex:0];
            if (finishtimetap5==false) {
                if (fridaysrttime>fridayendtime || fridaysrttime==fridayendtime) {
                    [sectionar5 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                    
                    [pickerview removeFromSuperview];
                    [backview removeFromSuperview];
                    [sectionar5 insertObject:selecttime atIndex:0];
                    
                }
            }
            else
            {
                
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar5 insertObject:selecttime atIndex:0];
                
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap5=false;
            [sectionar5 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            fridayendtime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar4 insertObject:selecttime atIndex:1];
            if (fridayendtime > fridaysrttime) {
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar5 insertObject:selecttime atIndex:1];
                
                
                
            }
            else
            {
                [sectionar5 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [CalenderView.tableview reloadData];
    }

    
    
    
    else if (tapcheck == 7)
    {
        if (pickerflag == 0)
        {
            [sectionar6 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            saturdaysrttimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar4 insertObject:selecttime atIndex:0];
            if (finishtimetap6==false) {
                if (saturdaysrttimechk>saturdayendtimechk || saturdaysrttimechk==saturdayendtimechk) {
                    [sectionar5 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                    
                    [pickerview removeFromSuperview];
                    [backview removeFromSuperview];
                    [sectionar6 insertObject:selecttime atIndex:0];
                    
                }
            }
            else
            {
                
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar6 insertObject:selecttime atIndex:0];
                
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap5=false;
            [sectionar6 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            saturdayendtimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar4 insertObject:selecttime atIndex:1];
            if (saturdayendtimechk > saturdaysrttimechk) {
                [pickerview removeFromSuperview];
                [backview removeFromSuperview];
                [sectionar6 insertObject:selecttime atIndex:1];
                
                
                
            }
            else
            {
                [sectionar6 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Closing Time Must Be Greater Than Opening Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [CalenderView.tableview reloadData];
    }
    

    
    
    
    NSLog(@"array0:-----%@,/n arr1-----%@,/n arr2-----%@,/n arr3-----%@,/n arr4-----%@,/n arr5-----%@,/n arr6-----%@",sectionar0,sectionar1,sectionar2,sectionar3,sectionar4,sectionar5,sectionar6);
}

-(void)cancelaction
{
  
     if (sundaysrttimechk>sundayendtimechk || sundayendtimechk<sundaysrttimechk || sundaysrttimechk==sundayendtimechk) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    
    
    else if (mondaysrttimechk>mondayendtimechk || mondayendtimechk<mondaysrttimechk || mondaysrttimechk==mondayendtimechk) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (tuesdaysrttime > tuesdayendtime || tuesdayendtime < tuesdaysrttime || tuesdayendtime == tuesdaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (wednessdaysrttime > wednessdayendtime || wednessdayendtime < wednessdaysrttime|| wednessdayendtime == wednessdaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (thurdaysrttime > thurdayendime || thurdayendime < thurdaysrttime || thurdayendime == thurdaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (fridaysrttime > fridayendtime || fridayendtime < fridaysrttime || fridayendtime == fridaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    
    else if (saturdaysrttimechk > saturdayendtimechk || saturdayendtimechk < saturdaysrttimechk || saturdayendtimechk == saturdaysrttimechk)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    
    
    else
    {
        [pickerview removeFromSuperview];
        [backview removeFromSuperview];
              
    }
}

//addservice basic


-(void)Main_CategoriesTap
{
   
    
    if (Main_Categories_ArrayId.count>0 && Main_Categories_ArrayName>0)
    {
        itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        itemsView.backgroundColor = [UIColor clearColor];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Main_CategoriesCancel_Tap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [itemsView addGestureRecognizer:tapGestureRecognize];
        
        
        
        Main_Categories_Table = [[UITableView alloc]initWithFrame:CGRectMake(Main_Categories.frame.origin.x, Main_Categories.frame.origin.y+Main_Categories.frame.size.height, Main_Categories.frame.size.width, Main_Categories.frame.size.height+100)];
        
        Booking_tableBack = [[UIView alloc]initWithFrame:Main_Categories_Table.frame];
        
        Booking_tableBack.backgroundColor =[UIColor blackColor];
        
        Booking_Type_Table.showsVerticalScrollIndicator = NO;
        
        
        Booking_tableBack.layer.masksToBounds = NO;
        Booking_tableBack.layer.shadowOffset = CGSizeMake(5, 10);
        Booking_tableBack.layer.shadowRadius = 3;
        Booking_tableBack.layer.shadowOpacity = 0.3;
        
        Main_Categories_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        Main_Categories_Table.dataSource=self;
        Main_Categories_Table.delegate=self;
        
        [mainScroll addSubview:itemsView];
        [mainScroll addSubview:Booking_tableBack];
        [mainScroll addSubview:Main_Categories_Table];
        
        
        [Main_Categories_Table reloadData];
    }
    
    else
    {
        
        
        [self loader];
    
    NSString *url = [NSString stringWithFormat:@"%@app_main_category?userid=%@&top_cat=%@",App_Domain_Url,userid,categoriesName];
    NSLog(@"url--%@",url);
    NSString *encode = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         NSMutableArray *tempresult= [result valueForKey:@"infoarray"];
         
      //   NSLog(@"Service_Main_Categories_ArrayName %@",tempresult);
         
         for (int i=0; i<tempresult.count ; i++)
         {
             NSString *tempid = [NSString stringWithFormat:@"%@",[tempresult[i]valueForKey:@"cat_id"]];
             NSString *tempName = [NSString stringWithFormat:@"%@",[tempresult[i]valueForKey:@"category_name"]];
             
             
             [Main_Categories_ArrayId addObject:tempid];
             [Main_Categories_ArrayName addObject:tempName];
         }
         
         
         
         NSLog(@"----%@",Main_Categories_ArrayName);
         
         itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
         itemsView.backgroundColor = [UIColor clearColor];
         
         
         
         UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Main_CategoriesCancel_Tap)];
         tapGestureRecognize.delegate = self;
         tapGestureRecognize.numberOfTapsRequired = 1;
         
         [itemsView addGestureRecognizer:tapGestureRecognize];
         
         
         
         Main_Categories_Table = [[UITableView alloc]initWithFrame:CGRectMake(Main_Categories.frame.origin.x, Main_Categories.frame.origin.y+Main_Categories.frame.size.height, Main_Categories.frame.size.width, Main_Categories.frame.size.height+100)];
         
         Booking_tableBack = [[UIView alloc]initWithFrame:Main_Categories_Table.frame];
         
         Booking_tableBack.backgroundColor =[UIColor blackColor];
         
         Booking_Type_Table.showsVerticalScrollIndicator = NO;
         
         
         Booking_tableBack.layer.masksToBounds = NO;
         Booking_tableBack.layer.shadowOffset = CGSizeMake(5, 10);
         Booking_tableBack.layer.shadowRadius = 3;
         Booking_tableBack.layer.shadowOpacity = 0.3;
         
         Main_Categories_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
         
         
         Main_Categories_Table.dataSource=self;
         Main_Categories_Table.delegate=self;
         
         [mainScroll addSubview:itemsView];
         [mainScroll addSubview:Booking_tableBack];
         [mainScroll addSubview:Main_Categories_Table];
         
         
         [Main_Categories_Table reloadData];
         
         
         [self stoploader];
     }];

    }
    
}

-(void)Booking_Type_Tap
{
    back_Bookingview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    back_Bookingview.backgroundColor = [UIColor clearColor];
    
    
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BookingCancel_Tap)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [back_Bookingview addGestureRecognizer:tapGestureRecognize];

    
    
    Booking_Type_Table = [[UITableView alloc]initWithFrame:CGRectMake(Booking_Type.frame.origin.x, Booking_Type.frame.origin.y+Booking_Type.frame.size.height, Booking_Type.frame.size.width, Booking_Type.frame.size.height+70)];
    
    Booking_tableBack = [[UIView alloc]initWithFrame:Booking_Type_Table.frame];
    
    Booking_tableBack.backgroundColor =[UIColor blackColor];
    
    Booking_Type_Table.showsVerticalScrollIndicator = NO;

    
    Booking_tableBack.layer.masksToBounds = NO;
    Booking_tableBack.layer.shadowOffset = CGSizeMake(5, 10);
    Booking_tableBack.layer.shadowRadius = 3;
    Booking_tableBack.layer.shadowOpacity = 0.3;
    
    Booking_Type_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    Booking_Type_Table.dataSource=self;
    Booking_Type_Table.delegate=self;
    
    [mainScroll addSubview:back_Bookingview];
    [mainScroll addSubview:Booking_tableBack];
    [mainScroll addSubview:Booking_Type_Table];
    
    
}

-(void)Service_Main_Categories_Tap
{
    
    
    
    if (Service_Main_Categories_ArrayId.count>0 && Service_Main_Categories_ArrayName.count>0 )
    {
        
        
        itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        itemsView.backgroundColor = [UIColor clearColor];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Service_Main_CategoriesCancel_Tap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [itemsView addGestureRecognizer:tapGestureRecognize];
        
        
        
        Service_Main_Categories_Table = [[UITableView alloc]initWithFrame:CGRectMake(Service_Main_Categories.frame.origin.x, Service_Main_Categories.frame.origin.y+Service_Main_Categories.frame.size.height, Service_Main_Categories.frame.size.width, Service_Main_Categories.frame.size.height+100)];
        
        Booking_tableBack = [[UIView alloc]initWithFrame:Service_Main_Categories_Table.frame];
        
        Booking_tableBack.backgroundColor =[UIColor blackColor];
        
        Booking_Type_Table.showsVerticalScrollIndicator = NO;
        
        
        Booking_tableBack.layer.masksToBounds = NO;
        Booking_tableBack.layer.shadowOffset = CGSizeMake(5, 10);
        Booking_tableBack.layer.shadowRadius = 3;
        Booking_tableBack.layer.shadowOpacity = 0.3;
        
        Service_Main_Categories_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        Service_Main_Categories_Table.dataSource=self;
        Service_Main_Categories_Table.delegate=self;
        
        [mainScroll addSubview:itemsView];
        [mainScroll addSubview:Booking_tableBack];
        [mainScroll addSubview:Service_Main_Categories_Table];
        
        
        [Service_Main_Categories_Table reloadData];
        
    }
    
    else
    {
        
        [self loader];
    
    NSString *url = [NSString stringWithFormat:@"%@app_main_category?userid=%@&top_cat=%@",App_Domain_Url,userid,categoriesName];
    NSLog(@"url--%@",url);
    NSString *encode = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        
        NSMutableArray *tempresult= [result valueForKey:@"infoarray"];
        
         NSLog(@"Service_Main_Categories_ArrayName %@",tempresult);
        
        for (int i=0; i<tempresult.count ; i++)
        {
            NSString *tempid = [NSString stringWithFormat:@"%@",[tempresult[i]valueForKey:@"cat_id"]];
             NSString *tempName = [NSString stringWithFormat:@"%@",[tempresult[i]valueForKey:@"category_name"]];
            
            
            [Service_Main_Categories_ArrayId addObject:tempid];
            [Service_Main_Categories_ArrayName addObject:tempName];
        }
        
        
        
        
        itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        itemsView.backgroundColor = [UIColor clearColor];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Service_Main_CategoriesCancel_Tap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [itemsView addGestureRecognizer:tapGestureRecognize];
        
        
        
        Service_Main_Categories_Table = [[UITableView alloc]initWithFrame:CGRectMake(Service_Main_Categories.frame.origin.x, Service_Main_Categories.frame.origin.y+Service_Main_Categories.frame.size.height, Service_Main_Categories.frame.size.width, Service_Main_Categories.frame.size.height+100)];
        
        Booking_tableBack = [[UIView alloc]initWithFrame:Service_Main_Categories_Table.frame];
        
        Booking_tableBack.backgroundColor =[UIColor blackColor];
        
        Booking_Type_Table.showsVerticalScrollIndicator = NO;
        
        
        Booking_tableBack.layer.masksToBounds = NO;
        Booking_tableBack.layer.shadowOffset = CGSizeMake(5, 10);
        Booking_tableBack.layer.shadowRadius = 3;
        Booking_tableBack.layer.shadowOpacity = 0.3;
        
        Service_Main_Categories_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        Service_Main_Categories_Table.dataSource=self;
        Service_Main_Categories_Table.delegate=self;
        
        [mainScroll addSubview:itemsView];
        [mainScroll addSubview:Booking_tableBack];
        [mainScroll addSubview:Service_Main_Categories_Table];
        
        
        [Service_Main_Categories_Table reloadData];
        
        [self stoploader];
        
       
    }];
    

    }
}
-(void)Service_Main_CategoriesCancel_Tap
{
    [itemsView removeFromSuperview];
    [Booking_tableBack removeFromSuperview];
    [Service_Main_Categories_Table removeFromSuperview];
}
-(void)Main_CategoriesCancel_Tap
{
    [itemsView removeFromSuperview];
    [Booking_tableBack removeFromSuperview];
    [Main_Categories_Table removeFromSuperview];
}

-(void)BookingCancel_Tap
{
    [back_Bookingview removeFromSuperview];
    [Booking_Type_Table removeFromSuperview];
    [Booking_tableBack removeFromSuperview];
}
-(void)Service_Main_Categories_Function
{
    [checkboxName removeAllObjects];
    
    [self loader];
    
    
    
    
    NSString *url =[NSString stringWithFormat:@"%@app_sub_category?userid=%@&top_cat=%@&category_id=%@",App_Domain_Url,userid,categoriesName,Main_Categories_id];
    
    
    NSLog(@"url===%@",url);
   
   
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            [checkboxview removeFromSuperview];
            
             checkboxview = [[UIView alloc]initWithFrame:CGRectMake(firstview.frame.origin.x, Downview.frame.origin.y+1, firstview.frame.size.width, 0)];
            
            selecttag=0;
            radiotag=0;
            checkboxtag=0;
            
            
            checkboxName=[[NSMutableArray alloc]init];
            radioName=[[NSMutableArray alloc]init];
            selectName =[[NSMutableArray alloc]init];
            
             y=0;
            
             NSMutableArray *TempArray = [result valueForKey:@"infoarray"];
            
            NSMutableArray *aminities = [result valueForKey:@"aminities"];
            
            if ([[result valueForKey:@"sub_category_status"]isEqualToString:@"N"])
            {
                
                
                NSLog(@"No");
                
                
                option_id = [[NSMutableArray alloc]init];
                
                
                for (int i=0; i<TempArray.count; i++)
                {
                    
                    
                if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"checkbox"])
                    {
                        
                        NSLog(@"checkbox");
                        
                        
                        NSMutableArray *checkboxArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                        
//                        [checkboxName removeAllObjects];
//                        [checkboxId removeAllObjects];
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                       
                        
                 
                       
                       // [checkboxMainview addSubview:checkboxview];
                        
                      
                        
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        
                        for (int j=0; j<checkboxArray.count; j++)
                        {
                            
                            NSString *name = [[checkboxArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * checkboxid=[[checkboxArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:checkboxid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                            
                            
                           
                            
                            
                            
                          //  NSLog(@"temp---array=====%@",temp);
                            
                            
                            
                          

                            
                        }
                        
                        
                       
                        
                        [checkboxName insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:checkboxtag];
                        
                        
                        [dic setObject:indexArray forKey:@"id"];
                        

                        
                        NSLog(@"check box name===%@",checkboxName);
                        
                        
                        
                         [option_id addObject:dic];
                        
                       // [temp removeAllObjects];
                        
                        
                        
                        
                        
                       // checkboxview.backgroundColor = [UIColor redColor];
                        
                   //  checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+y);
                        
                        
                        
                        checkboxbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                        
                        
                        
              
                        
                        
                        
                        checkboxbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        checkboxbtn.tag =selecttag;
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(checkboxbtn.frame.origin.x+checkboxbtn.frame.size.width-30, checkboxbtn.frame.origin.y+checkboxbtn.frame.size.height/2-10, 12, 20)];
                        
                        imagedown.image = [UIImage imageNamed:@"frontarrow"];
                        
                        
                        [checkboxbtn addTarget:self action:@selector(checkboxbtnTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        checkboxbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        checkboxbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [checkboxbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [checkboxbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [checkboxbtn setTitle:[[TempArray objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        [checkboxview addSubview:checkboxbtn];
                        [checkboxview addSubview:imagedown];
                        
                        [mainScroll addSubview:checkboxview];
                        
                      //  y=y+firstview.frame.size.height+2;
                        
//                        Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
//                        
//                        
//                        
//                        mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                        
                        
                        loopcount=i;
                        
                        checkboxtag++;
                       
                        
                        
                         NSLog(@"%d",y);
                        
                    }
                    
                    
                 else   if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"radio"])
                        
                    {
                        
                        
                        
                        
                        
                        NSLog(@"radio");
                        
                        
                        
                        
                        
                        
                        NSMutableArray *radioArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        
                        
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        for (int j=0; j<radioArray.count; j++)
                        {
                            
                            NSString *name = [[radioArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * radiid=[[radioArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:radiid forKey:@"id"];
                            
                            // [dic setObject:[[radioArray objectAtIndex:j]valueForKey:@"id"] forKey:@"id"];
                            
                            
                            [indexArray addObject:tempdic];
                            
                            
                            
                            
                            
                            NSLog(@"%d",y);
                            
                            
                            
                            
                            
                        }
                        
                        
                        [radioName insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:radiotag];
                       
                        [dic setObject:indexArray forKey:@"id"];
                        
                        [option_id  addObject:dic];
                        
                        
                     //   checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+y);
                        
                        
                        //  NSLog(@"i=======%d",i);
                        
                        radioBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                        
                        
            
                        
                        
                        radioBtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        // radioBtn.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        
                        radioBtn.tag =radiotag;
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(radioBtn.frame.origin.x+radioBtn.frame.size.width-37, radioBtn.frame.origin.y+radioBtn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                        
                        [radioBtn addTarget:self action:@selector(radioBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        radioBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        radioBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [radioBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [radioBtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [radioBtn setTitle:[[TempArray objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        
                        [checkboxview addSubview:radioBtn];
                        [checkboxview addSubview:imagedown];
                        
                        
                        
                        
                        
                        
                       // y=y+firstview.frame.size.height+2;
                        
                        
                        
                        [mainScroll addSubview:checkboxview];
                        // NSLog(@"radioName name===%@",radioName);
                        
                                               
                        
                        radiotag++;
                        

                        loopcount=i;
                        
                        
                        
                        
                    }
                    

                    
                    
               else if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                    {
                        
                        
                        
                          NSLog(@"select");
                        
                        NSMutableArray *selectArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        
                        
                        
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        for (int j=0; j<selectArray.count; j++)
                        {
                            
                            NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * radiid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:radiid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                            //[dic setObject:[[selectArray objectAtIndex:j]valueForKey:@"id"] forKey:@"id"];
                            
                            
                            
                            NSLog(@"%d",y);
                            
                            
                            
                            
                            
                        }
                        
                        
                        [selectName insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:selecttag];
                       
                        [dic setObject:indexArray forKey:@"id"];
                        
                        
                        [option_id  addObject:dic];
                       // checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+y);
                        
                        
                        selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(selectBtn.frame.origin.x+selectBtn.frame.size.width-37, selectBtn.frame.origin.y+selectBtn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                        
                        
                        
                        
                            
                            
                            
                            
                            
                        
                        selectBtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                        
                        // radioBtn.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        
                        selectBtn.tag =selecttag;
                        
                        
                        [selectBtn addTarget:self action:@selector(selectBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        selectBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [selectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [selectBtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [selectBtn setTitle:[[TempArray objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        
                        
                        [checkboxview addSubview:selectBtn];
                        [checkboxview addSubview:imagedown];
                        
                        
                        
                        
                        
                        
                       // y=y+firstview.frame.size.height+2;
                        
                        
                        [mainScroll addSubview:checkboxview];
                        //NSLog(@"radioName name===%@",radioName);
                        
                      
                        NSLog(@"select name===%@",selectName);
                        
                        
                        selecttag++;
                        loopcount=i;
                        
                    }
                    
                    
                    
               else  if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"text"] )
               {
                   
                   
                   
                   NSLog(@"textarea");
                   
                   NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                   
                   [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                   
                   [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                   
                   
                   
                   
                   [option_id  addObject:dic];
                   
                   
                   text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                   
                   text.delegate=self;
                   
                   UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                   text.leftView = paddingView;
                   text.leftViewMode = UITextFieldViewModeAlways;
                   
                   text.placeholder =[[TempArray objectAtIndex:i] valueForKey:@"option_name"];
                   
                   [text setFont:[UIFont fontWithName:@"Lato" size:14]];
                   
                   text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                   
                   
                   [checkboxview addSubview:text];
                   
                   [mainScroll addSubview:checkboxview];
                   
                   loopcount=i;
                   
                   
               }

                    
                    
                    
               else  if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"textarea"] )
               {
                   
                   
                   
                   NSLog(@"textarea");
                   
                   NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                   
                   [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                   
                   [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                   
                   [option_id  addObject:dic];
                   
                   
                   textarea=[[UITextField alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                   
                    textarea.delegate=self;
                   
                   UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, textarea.frame.size.width)];
                   textarea.leftView = paddingView;
                   textarea.leftViewMode = UITextFieldViewModeAlways;
                   
                   textarea.placeholder =[[TempArray objectAtIndex:i] valueForKey:@"option_name"];
                   
                   [textarea setFont:[UIFont fontWithName:@"Lato" size:14]];
                   
                   textarea.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                   
                   
                   [checkboxview addSubview:textarea];
                   
                   [mainScroll addSubview:checkboxview];
                   
                   loopcount=i;
                   
                   
               }

                    
                    
                    
                    
                    
                    
                    
                     y=y+firstview.frame.size.height+2;
                    
                   
                    
                    
                    
                    
                }
                
                
                if (aminities.count>0)
                {
                
                 checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+loopcount+2+firstview.frame.size.height*(TempArray.count+1));
                
                Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+loopcount+1, Downview.frame.size.width, Downview.frame.size.height);
                
                
                
                mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                }
                
                else
                {
                    
                    
                    
                    checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+loopcount+firstview.frame.size.height*TempArray.count );
                    
                    Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+loopcount+1, Downview.frame.size.width, Downview.frame.size.height);
                    
                    
                    
                    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);

                    
                    
                }
                
            }
            
            else
            {
                NSLog(@"yes");
                
                for (int i=0; i<TempArray.count; i++)
                {
                    
                    if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                    {
                        
                        
                        
                        NSLog(@"select");
                        
                        NSMutableArray *selectArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                        
                        [selectName removeAllObjects];
                        [selectId removeAllObjects];
                        
                        
                        for (int j=0; j<selectArray.count; j++)
                        {
                            
                            NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"cat_name"];
                            NSString * selectionid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            
                            [selectName addObject:name];
                            [selectId addObject:selectionid];
                            
                        }
                        
                        
                        subCatbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                        
                        
                        
                 UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(subCatbtn.frame.origin.x+subCatbtn.frame.size.width-37, subCatbtn.frame.origin.y+subCatbtn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                        
                      
                        
                        
                        
                        [subCatbtn addTarget:self action:@selector(subCatbtnTap) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                      
                        [subCatbtn setTitle:@"Other Sub-Categories" forState:UIControlStateNormal];
                        
                        subCatbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        subCatbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        subCatbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [subCatbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [subCatbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        
                        
                       // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        [checkboxview addSubview:subCatbtn];
                        
                        [checkboxview addSubview:imagedown];
                        
                        
                        
                        
                        
                        y=y+subCatbtn.frame.size.height+2;
                        
                        
                        [mainScroll addSubview:checkboxview];
                       
                        
                        
                        
                        NSLog(@"select name===%@",selectName);
                        
                        
                        
                        
                    }
                    
                    
                    
                     checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, firstview.frame.size.height);
                    
                    Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
                    
                    
                    
                    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                    
                }
                

                    
                
                
                
                
                
                
                
            }
            
            
            
            
            
            if (aminities.count>0)
            {
                
                
                aminitieArray=[[NSMutableArray alloc]init];
                
                aminitieArray = [aminities mutableCopy];
                
                
                aminitiesbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                
                
                
                UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(aminitiesbtn.frame.origin.x+aminitiesbtn.frame.size.width-30, aminitiesbtn.frame.origin.y+aminitiesbtn.frame.size.height/2-10, 12, 20)];
                
                imagedown.image = [UIImage imageNamed:@"frontarrow"];
                
               
                
                
                [aminitiesbtn addTarget:self action:@selector(aminitiesbtnTap) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                
                [aminitiesbtn setTitle:@"Amenities" forState:UIControlStateNormal];
                
                aminitiesbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                
                aminitiesbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                aminitiesbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                
                [aminitiesbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                
                [aminitiesbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                
                
                
                // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                
                [checkboxview addSubview:aminitiesbtn];
                
                [checkboxview addSubview:imagedown];
                
                
                
                
                
               // y=y+aminitiesbtn.frame.size.height+2;
                
                
                [mainScroll addSubview:checkboxview];
                NSLog(@"radioName name===%@",radioName);
                
                
                
//                 checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+firstview.frame.size.height+4);
//                
//                
//                Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+5, Downview.frame.size.width, Downview.frame.size.height);
//                
//                
//                
//                mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);

                
                
                
            }
            
            
        }
        
        
        [self stoploader];
        
    }];
    
    
}


-(void)aminitiesbtnTap
{
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 20, 80, 40)];
    
    heading = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, self.view.frame.size.width - 100, 40)];
    heading.text = @"Select";
    
    heading.textColor = [UIColor colorWithRed:59.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:1];
    heading.font = [UIFont fontWithName:@"Lato-bold" size:14];
    heading.textAlignment = NSTextAlignmentCenter;
    
    //heading.backgroundColor=[UIColor blackColor];
    
    
    
    
    aminitiesTable = [[UITableView alloc]initWithFrame:CGRectMake(0, heading.frame.origin.y+heading.frame.size.height+20 , self.view.frame.size.width, self.view.frame.size.height - heading.frame.origin.y+heading.frame.size.height+20)];
    
    
    
    aminitiesTable.showsVerticalScrollIndicator = NO;
    
    aminitiesTable.delegate = self;
    aminitiesTable.dataSource = self;
    
    aminitiesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    
    
    aminitiesTable.backgroundColor = [UIColor whiteColor];
    
    [done setTitle:@"Done" forState:UIControlStateNormal];
    
    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [done addTarget:self action:@selector(doneTapaminitiesTable) forControlEvents:UIControlEventTouchUpInside];
    
    // [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkbox_done.titleLabel.font = [UIFont fontWithName:@"Lato-regular" size:14];
    
    [self.view addSubview:itemsView];
    [itemsView addSubview:heading];
    [itemsView addSubview:aminitiesTable];
    [itemsView addSubview:done];
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        
        
        itemsView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }];
    

    
    
    
}


-(void)checkboxbtnTap:(UIButton *)sender
{
    NSLog(@"checkboxbtnTap--%d",(int)sender.tag);
    
    checkboxTag = (int)sender.tag;
    
    checktagbtn=(UIButton *)sender;
    
    NSLog(@"index=====%@",[checkboxName objectAtIndex:sender.tag]);
    
    cheboxMain_Array = [[NSMutableArray alloc]init];
    
    cheboxMain_Array = [[checkboxName objectAtIndex:sender.tag] mutableCopy];
    

    
   NSLog(@"array====%@",cheboxMain_Array);
    
    
   // tapdata = [[NSMutableArray alloc]init];
    
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor whiteColor];
    
    
    
    checkbox_done = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 20, 80, 40)];
    
    heading = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, self.view.frame.size.width - 100, 40)];
    heading.text = @"Select";
    
    heading.textColor = [UIColor colorWithRed:59.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:1];
    heading.font = [UIFont fontWithName:@"Lato-bold" size:14];
    heading.textAlignment = NSTextAlignmentCenter;
    
    //heading.backgroundColor=[UIColor blackColor];
    
    
   
    
    checkTable = [[UITableView alloc]initWithFrame:CGRectMake(0, heading.frame.origin.y+heading.frame.size.height+20 , self.view.frame.size.width, self.view.frame.size.height - heading.frame.origin.y+heading.frame.size.height+20)];
    
    
    
    checkTable.showsVerticalScrollIndicator = NO;
    
    checkTable.delegate = self;
    checkTable.dataSource = self;
    
    checkTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    
    
    checkTable.backgroundColor = [UIColor whiteColor];
    
    [checkbox_done setTitle:@"Done" forState:UIControlStateNormal];
    
    [checkbox_done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [checkbox_done addTarget:self action:@selector(checkbox_done) forControlEvents:UIControlEventTouchUpInside];
    
    // [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkbox_done.titleLabel.font = [UIFont fontWithName:@"Lato-regular" size:14];
    
    [self.view addSubview:itemsView];
    [itemsView addSubview:heading];
    [itemsView addSubview:checkTable];
    [itemsView addSubview:checkbox_done];
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        
        
        itemsView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }];
    

    
    
    
    
    
    
    
    
    
    
}

-(void)doneTapaminitiesTable
{
    
    
    
    
    
    NSMutableArray *BtnNameArray=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<aminities_id_Array.count; i++)
    {
        
        
        
        NSInteger chk = [[aminities_id_Array objectAtIndex:i]integerValue];
        
        
        
        NSLog(@"chk---%ld",(long)chk);
        
        for (int j=0; j<aminitieArray.count; j++)
        {
            NSInteger equal = [[aminitieArray[j] valueForKey:@"aminities_id"]integerValue];
            
            NSLog(@"eql----%ld",(long)equal);
            
            
            if (chk==equal)
            {
                
                NSLog(@"%ld  =  %ld",(long)chk,(long)equal);
                
                NSString *match = [aminitieArray[j]valueForKey:@"aminities_name"];
                
                
                
                
                [BtnNameArray addObject:[NSString stringWithFormat:@"%@",match]];
                
                
                
                
            }
            
            
            
        }
    }
    

    NSString *BtnName=[NSString stringWithFormat:@"%@",[BtnNameArray componentsJoinedByString:@","]];
    
    [aminitiesbtn setTitle:BtnName forState:UIControlStateNormal];
    
    [aminitiesbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    if (BtnNameArray.count==0)
    {
        [aminitiesbtn setTitle:@"Amenities" forState:UIControlStateNormal];
        
        [aminitiesbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        itemsView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }
                     completion:^(BOOL finished) {
                         
                         
                         [itemsView removeFromSuperview];
                         
                     }];

}

-(void)checkbox_done
{
    
   
    NSMutableArray *BtnNameArray=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<chebox_id_Array.count; i++)
    {
        
        
        
        NSInteger chk = [[chebox_id_Array objectAtIndex:i]integerValue];
        
        
        
        NSLog(@"chk---%ld",(long)chk);
        
        for (int j=0; j<cheboxMain_Array.count; j++)
        {
            NSInteger equal = [[cheboxMain_Array[j] valueForKey:@"id"]integerValue];
            
            NSLog(@"eql----%ld",(long)equal);
            
            
            if (chk==equal)
            {
                
                NSLog(@"%ld  =  %ld",(long)chk,(long)equal);
                
                NSString *match = [cheboxMain_Array[j]valueForKey:@"name"];
                
                
               
                
                [BtnNameArray addObject:[NSString stringWithFormat:@"%@",match]];
                
                
                
                
            }
            
            
            
        }
    }

    
    NSString *BtnName=[NSString stringWithFormat:@"%@",[BtnNameArray componentsJoinedByString:@","]];
    
    
    NSLog(@"");
    
    
      checkboxbtn=(UIButton *)[checkboxview viewWithTag:checkboxTag];
    
    if (checkboxTag==0)
    {
        
        [checktagbtn setTitle:BtnName forState:UIControlStateNormal];
        
    }
    
    else if (checkboxTag==1)
    {
         [checktagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    else if (checkboxTag==2)
    {
        [checktagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    else if (checkboxTag==3)
    {
        [checktagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    else if (checkboxTag==4)
    {
        [checktagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    
    
    [checktagbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        itemsView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }
     completion:^(BOOL finished) {
         
         
         [itemsView removeFromSuperview];
         
     }];
    
    
    
    
    
}

-(void)radioBtnTap:(UIButton *)sender
{
    NSLog(@"tap");
    
    NSLog(@"Radio name=====%@",radioName);
    
    mainradioArray = [[NSMutableArray alloc]init];
    
    
    mainradioArray = [[radioName objectAtIndex:sender.tag] mutableCopy];
    
    
    radiotag=(int)sender.tag;
    radioTagbtnsender =(UIButton *)sender;
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor clearColor];
    
    
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(radioTable)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [itemsView addGestureRecognizer:tapGestureRecognize];
    
    
       radioTable = [[UITableView alloc]initWithFrame:CGRectMake(radioTagbtnsender.frame.origin.x,radioTagbtnsender.frame.origin.y+radioTagbtnsender.frame.size.height, radioTagbtnsender.frame.size.width   , radioTagbtnsender.frame.size.height+50)];
    
    categoriesTablebackview=[[UIView alloc]initWithFrame:radioTable.frame];
    
    categoriesTablebackview.backgroundColor =[UIColor blackColor];
    
    radioTable.showsVerticalScrollIndicator = NO;
    
    radioTable.delegate = self;
    radioTable.dataSource = self;
    
    //[categoriesTable setAllowsSelection:NO];
    
    categoriesTablebackview.layer.masksToBounds = NO;
    categoriesTablebackview.layer.shadowOffset = CGSizeMake(10, 10);
    categoriesTablebackview.layer.shadowRadius = 3;
    categoriesTablebackview.layer.shadowOpacity = 0.3;
    
    radioTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    radioTable.backgroundColor = [UIColor whiteColor];
    
    
    // mainScroll.bounces=NO;
  //  itemsView.backgroundColor = [UIColor redColor];
    
    [mainScroll addSubview:itemsView];
    
    
    
    checkboxview.frame = CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+radioTable.frame.size.height);
    
    adjustview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, checkboxview.frame.size.width, checkboxview.frame.size.height)];
    //  adjustview.backgroundColor =[UIColor grayColor];
    
    
    UITapGestureRecognizer *tapGestureRecognize1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(radioTable)];
    tapGestureRecognize1.delegate = self;
    tapGestureRecognize1.numberOfTapsRequired = 1;
    [adjustview addGestureRecognizer:tapGestureRecognize1];
   
    [checkboxview addSubview:adjustview];
    
    [mainScroll addSubview:checkboxview];
    
    
   
    
    [checkboxview addSubview:categoriesTablebackview];
    
    [checkboxview addSubview:radioTable];

    
}

-(void)radioTable
{
    
      checkboxview.frame = CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height-radioTable.frame.size.height);
    
    [adjustview removeFromSuperview];
    [itemsView removeFromSuperview];
    [categoriesTablebackview removeFromSuperview];
    [radioTable removeFromSuperview];
    
}

-(void)selectBtnTap:(UIButton *)sender
{
    NSLog(@"selectBtnTap--%d",(int)sender.tag);
    
    mainSelectArray = [[NSMutableArray alloc]init];
    
    
    mainSelectArray = [[selectName objectAtIndex:sender.tag] mutableCopy];
    
    select_tag =(int)sender.tag;
    
    selecttagbtn = (UIButton *)sender;
    
   // NSLog(@"ihasgfdiohesbrgnijenfgd");
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor clearColor];
    
    
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTable)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [itemsView addGestureRecognizer:tapGestureRecognize];
    
    
    
    selectTable = [[UITableView alloc]initWithFrame:CGRectMake(selecttagbtn.frame.origin.x,selecttagbtn.frame.origin.y+selecttagbtn.frame.size.height, selecttagbtn.frame.size.width   , selecttagbtn.frame.size.height+50)];
    
    categoriesTablebackview=[[UIView alloc]initWithFrame:selectTable.frame];
    
    categoriesTablebackview.backgroundColor =[UIColor blackColor];
    
    selectTable.showsVerticalScrollIndicator = NO;
    
    selectTable.delegate = self;
    selectTable.dataSource = self;
    
    //[categoriesTable setAllowsSelection:NO];
    
    categoriesTablebackview.layer.masksToBounds = NO;
    categoriesTablebackview.layer.shadowOffset = CGSizeMake(10, 10);
    categoriesTablebackview.layer.shadowRadius = 3;
    categoriesTablebackview.layer.shadowOpacity = 0.3;
    
    selectTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    selectTable.backgroundColor = [UIColor whiteColor];
    
   
    
    // mainScroll.bounces=NO;
   // itemsView.backgroundColor = [UIColor redColor];
    
    [mainScroll addSubview:itemsView];
    
    
    checkboxview.frame = CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+selectTable.frame.size.height);
    
    adjustview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, checkboxview.frame.size.width, checkboxview.frame.size.height)];
  //  adjustview.backgroundColor =[UIColor grayColor];
    
    
    UITapGestureRecognizer *tapGestureRecognize1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTable)];
    tapGestureRecognize1.delegate = self;
    tapGestureRecognize1.numberOfTapsRequired = 1;
    
    [adjustview addGestureRecognizer:tapGestureRecognize1];
  
    [checkboxview addSubview:adjustview];
    
    [mainScroll addSubview:checkboxview];
    
    
    [checkboxview addSubview:categoriesTablebackview];
    
    [checkboxview addSubview:selectTable];
    
    
    
    
    
    
    
    
}
-(void)selectTable
{
    
    checkboxview.frame = CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height-selectTable.frame.size.height);
    
    [adjustview removeFromSuperview];
    [itemsView removeFromSuperview];
    [categoriesTablebackview removeFromSuperview];
    [selectTable removeFromSuperview];
}

-(void)subCatbtnTap
{
    
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor clearColor];
    
    
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subcatCancel)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [itemsView addGestureRecognizer:tapGestureRecognize];
    
    
    if ([categoriesName isEqualToString:@"Service"])
    {
        subcatTable = [[UITableView alloc]initWithFrame:CGRectMake(firstview.frame.origin.x,subCatbtn.frame.origin.y+subCatbtn.frame.size.height+215, subCatbtn.frame.size.width   , subCatbtn.frame.size.height+100)];
    }
    
    else
    {
        subcatTable = [[UITableView alloc]initWithFrame:CGRectMake(firstview.frame.origin.x,subCatbtn.frame.origin.y+subCatbtn.frame.size.height+165, subCatbtn.frame.size.width   , subCatbtn.frame.size.height+100)];
    }
    
    
    
    
    categoriesTablebackview=[[UIView alloc]initWithFrame:subcatTable.frame];
    
    categoriesTablebackview.backgroundColor =[UIColor blackColor];
    
    subcatTable.showsVerticalScrollIndicator = NO;
    
    subcatTable.delegate = self;
    subcatTable.dataSource = self;
    
    //[categoriesTable setAllowsSelection:NO];
    
    categoriesTablebackview.layer.masksToBounds = NO;
    categoriesTablebackview.layer.shadowOffset = CGSizeMake(10, 10);
    categoriesTablebackview.layer.shadowRadius = 3;
    categoriesTablebackview.layer.shadowOpacity = 0.3;
    
    subcatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    categoriesTable.backgroundColor = [UIColor whiteColor];
    
    
    // mainScroll.bounces=NO;
    
    [mainScroll addSubview:itemsView];
    
    [mainScroll addSubview:categoriesTablebackview];
    
    [mainScroll addSubview:subcatTable];

    
    
}

-(void)subcatCancel
{
    [itemsView removeFromSuperview];
    [categoriesTablebackview removeFromSuperview];
    [subcatTable removeFromSuperview];
    
}



-(void)Sub_Categories_function
{
    
    [self loader];
    
    NSString *url =[NSString stringWithFormat:@"%@app_sub_category?userid=%@&top_cat=%@&category_id=%@",App_Domain_Url,userid,categoriesName,subcat_id];
    
    
    NSLog(@"url===%@",url);
    
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            select_sub_Array= [[NSMutableArray alloc]init];
            radio_sub_Array= [[NSMutableArray alloc]init];
            chekbox_sub_Array= [[NSMutableArray alloc]init];
            
            
            selecttag=0;
            radiotag=0;
            checkboxtag=0;
            
            [subcatview removeFromSuperview];
            
            subcatview = [[UIView alloc]initWithFrame:CGRectMake(firstview.frame.origin.x, Downview.frame.origin.y+2, firstview.frame.size.width, 0)];
            
           // subcatview.backgroundColor = [UIColor redColor];
            
            y=0;
            
            
            NSMutableArray *TempArray1 = [result valueForKey:@"infoarray"];
            
            NSMutableArray *aminities = [result valueForKey:@"aminities"];
            
            if ([[result valueForKey:@"sub_category_status"]isEqualToString:@"N"])
            {
                
                
                NSLog(@"No");
                
                
                option_id = [[NSMutableArray alloc]init];
                
                
                for (int i=0; i<TempArray1.count; i++)
                {
                    
                    
                    
                    
                    
                    if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"text"])
                    {
                        
                        
                        
                        // NSMutableArray *TextArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        [option_id  addObject:dic];
                        
                        
                        
                        text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        text.delegate=self;
                        
                        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                        text.leftView = paddingView;
                        text.leftViewMode = UITextFieldViewModeAlways;
                        
                        text.tag=[[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] integerValue];
                        
                        text.placeholder =[[TempArray1 objectAtIndex:i] valueForKey:@"option_name"];
                        
                        [text setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                        [subcatview addSubview:text];
                        
                        [mainScroll addSubview:subcatview];
                        
                        
                        loopcount=i;
                        
                    }
                    
                    
                    else  if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"textarea"])
                    {
                        
                        
                        
                        NSLog(@"textarea");
                        
                        /*
                         
                         UITextView *textarea=[[UITextView alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                         
                         UILabel *textareaplaceholder = [[UILabel alloc]initWithFrame:CGRectMake(8, textarea.frame.origin.y+5, textarea.frame.size.width, 40)];
                         
                         [textareaplaceholder setFont:[UIFont fontWithName:@"Lato" size:14]];
                         
                         textareaplaceholder.textAlignment = NSTextAlignmentLeft;
                         
                         textareaplaceholder.textColor=[UIColor lightGrayColor];
                         
                         textareaplaceholder.text = [[TempArray1 objectAtIndex:i] valueForKey:@"option_name"];
                         
                         textarea.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         [subcatview addSubview:textarea];
                         [subcatview addSubview:textareaplaceholder];
                         
                         
                         
                         
                         [mainScroll addSubview:subcatview];
                         
                         */
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        [option_id  addObject:dic];
                        
                        
                        text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        text.delegate=self;
                        
                        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                        text.leftView = paddingView;
                        text.leftViewMode = UITextFieldViewModeAlways;
                        
                        text.placeholder =[[TempArray1 objectAtIndex:i] valueForKey:@"option_name"];
                        text.tag=[[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] integerValue];
                        
                        [text setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                        [subcatview addSubview:text];
                        
                        [mainScroll addSubview:subcatview];
                        
                        
                        loopcount=i;
                        
                        
                        
                        
                    }
                    
                    
                    
                 else   if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"checkbox"])
                    {
                        
                        NSLog(@"checkbox");
                        
                        
                        NSMutableArray *checkboxArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        //                        [checkboxName removeAllObjects];
                        //                        [checkboxId removeAllObjects];
                        
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                       
                        
                        
                        
                        // [checkboxMainview addSubview:checkboxview];
                        
                        
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        

                        for (int j=0; j<checkboxArray.count; j++)
                        {
                            
                            NSString *name = [[checkboxArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * checkboxid=[[checkboxArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:checkboxid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                            
                            
                            
                            
                            
                            
                            //  NSLog(@"temp---array=====%@",temp);
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        [chekbox_sub_Array insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:checkboxtag];
                        
                        
                        
                         [dic setObject:indexArray forKey:@"id"];
                        
                        
                        [option_id addObject:dic];
                        
                        
                        NSLog(@"check box name===%@",chekbox_sub_Array);
                        
                        
                        
                        
                        
                    
                        
                        
                        
                        checkBox_sub_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        checkBox_sub_btn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        checkBox_sub_btn.tag=checkboxtag;
                        
                        
                        [checkBox_sub_btn addTarget:self action:@selector(checkBox_sub_btn:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(checkBox_sub_btn.frame.origin.x+checkBox_sub_btn.frame.size.width-30, checkBox_sub_btn.frame.origin.y+checkBox_sub_btn.frame.size.height/2-10, 12, 20)];
                        
                        imagedown.image = [UIImage imageNamed:@"frontarrow"];
                        
                        
                     
                        
                        
                        checkBox_sub_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        checkBox_sub_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [checkBox_sub_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [checkBox_sub_btn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [checkBox_sub_btn setTitle:[[TempArray1 objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        [subcatview addSubview:checkBox_sub_btn];
                        [subcatview addSubview:imagedown];
                        
                        [mainScroll addSubview:subcatview];
                        
                     
                        
                     
                        
                        
                        
                     //   mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                        
                        
                        
                        checkboxtag++;
                        
                        loopcount=i;
                        
                        
                        NSLog(@"%d",y);
                        
                    }
                    
                    
                 else   if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"radio"])
                        
                    {
                        
                        
                        NSLog(@"radio");
                        
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        

                        
                        
                        NSMutableArray *radioArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        
                        
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        for (int j=0; j<radioArray.count; j++)
                        {
                            
                            NSString *name = [[radioArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * radiid=[[radioArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:radiid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                            
                            
                            
                            
                            NSLog(@"%d",y);
                            
                            
                            
                            
                            
                        }
                        
                        
                        [radio_sub_Array insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:radiotag];
                        
                        
                        
                        [dic setObject:indexArray forKey:@"id"];
                        
                        
                        [option_id addObject:dic];
                        
                        NSLog(@"radio=====%@",radio_sub_Array);
                        
                        radio_sub_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        // subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+radio_sub_btn.frame.size.height);
                        
                        radio_sub_btn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        // radioBtn.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        
                        radio_sub_btn.tag =radiotag;
                        
                        
                        [radio_sub_btn addTarget:self action:@selector(radio_sub_btn:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(radio_sub_btn.frame.origin.x+radio_sub_btn.frame.size.width-37, radio_sub_btn.frame.origin.y+radio_sub_btn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                        
                        //  [radioBtn addTarget:self action:@selector(radioBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        radio_sub_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        radio_sub_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [radio_sub_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [radio_sub_btn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [radio_sub_btn setTitle:[[TempArray1 objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        
                        [subcatview addSubview:radio_sub_btn];
                        [subcatview addSubview:imagedown];
                        
                        
                        
                        
                        
                        
                        //  y=y+radio_sub_btn.frame.size.height+2;
                        
                        
                        
                        [mainScroll addSubview:subcatview];
                        //NSLog(@"radioName name===%@",radioName);
                        
                        //  Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
                        
                        
                        
                        //    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                        
                        
                        
                        radiotag++;
                        
                        loopcount=i;
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                 else   if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                    {
                        
                        
                        
                        NSLog(@"select");
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        
                        
                        

                        
                        
                        NSMutableArray *selectArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
     
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        for (int j=0; j<selectArray.count; j++)
                        {
                            
                            NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * selectionid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:selectionid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                        }
                        
                         [select_sub_Array insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:selecttag];
                        
                        
                        
                        [dic setObject:indexArray forKey:@"id"];
                        
                        
                        [option_id addObject:dic];
                        
                        NSLog(@"select----%@",select_sub_Array);
                        
                        select_sub_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(select_sub_btn.frame.origin.x+select_sub_btn.frame.size.width-37, select_sub_btn.frame.origin.y+select_sub_btn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                    
                        
                        select_sub_btn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        select_sub_btn.tag=selecttag;
                        
                        
                        [select_sub_btn addTarget:self action:@selector(select_sub_btn:) forControlEvents:UIControlEventTouchUpInside];
                     
                        
                        
                        select_sub_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        select_sub_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [select_sub_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [select_sub_btn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [select_sub_btn setTitle:[[TempArray1 objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        
                        
                        [subcatview addSubview:select_sub_btn];
                        [subcatview addSubview:imagedown];
                        
                        
                        
                        
                        
                        
                     
                        
                        
                        [mainScroll addSubview:subcatview];
                        
                        
                        
                        
                        
                        selecttag++;
                        loopcount=i;
                        
                    }
                    
                    
                    
                    
                   else if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"text"])
                    {
                        
                        
                        
                        // NSMutableArray *TextArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        
                       
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                       
                       
                        
                        
                        [option_id addObject:dic];
                        
                        text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        text.delegate=self;
                        
                        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                        text.leftView = paddingView;
                        text.leftViewMode = UITextFieldViewModeAlways;
                        
                        text.placeholder =[[TempArray1 objectAtIndex:i] valueForKey:@"option_name"];
                        text.tag = [[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"]integerValue];
                        
                        text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                        [subcatview addSubview:text];
                        
                        [mainScroll addSubview:subcatview];
                        
                        
                        loopcount=i;
                        
                    }
                    
                    
                    
                    
                    y=y+firstview.frame.size.height+2;
                    
                    
                    
                    
                }
                
                
                if (aminities.count>0)
                {
                    subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, loopcount+2+subcatview.frame.size.height+firstview.frame.size.height*(TempArray1.count+1));
                    
                    
                    Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+loopcount+1, Downview.frame.size.width, Downview.frame.size.height);
                    
                    
                    
                    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                }
                
                
                else
                {
                    subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, loopcount+1+subcatview.frame.size.height+firstview.frame.size.height*TempArray1.count);
                    
                    
                    Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+loopcount, Downview.frame.size.width, Downview.frame.size.height);
                    
                    
                    
                    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                }
                
                
                
                
            }
            
            else
            {
                NSLog(@"yes");
                
                for (int i=0; i<TempArray1.count; i++)
                {
                    
                    if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                    {
                        
                        
                        
                        NSLog(@"select");
                        
        //                NSMutableArray *selectArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
//                        [selectName removeAllObjects];
//                        [selectId removeAllObjects];
//                        
//                        
//                        for (int j=0; j<selectArray.count; j++)
//                        {
//                            
//                            NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"cat_name"];
//                            NSString * selectionid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
//                            
//                            
//                            
//                            [selectName addObject:name];
//                            [selectId addObject:selectionid];
//                            
//                        }
                        
                        
                        subCatbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(subCatbtn.frame.origin.x+subCatbtn.frame.size.width-37, subCatbtn.frame.origin.y+subCatbtn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                        
                        subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+y);
                        
                        
                        
                       // [subCatbtn addTarget:self action:@selector(subCatbtnTap) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        
                        [subCatbtn setTitle:@"Select" forState:UIControlStateNormal];
                        
                        subCatbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        subCatbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        subCatbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [subCatbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [subCatbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        
                        
                        // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        [subcatview addSubview:subCatbtn];
                        
                        [subcatview addSubview:imagedown];
                        
                        
                        
                        
                        
                        y=y+subCatbtn.frame.size.height+2;
                        
                        
                        [mainScroll addSubview:subcatview];
                        
                        
                        Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
                        
                        
                        
                        mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                        
                        NSLog(@"select name===%@",selectName);
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
            }
            
            
            
            
            
            if (aminities.count>0)
            {
                
                
                aminitieArray=[[NSMutableArray alloc]init];
                
                aminitieArray = [aminities mutableCopy];
                
                
                aminitiesbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                
                
                
                UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(aminitiesbtn.frame.origin.x+aminitiesbtn.frame.size.width-30, aminitiesbtn.frame.origin.y+aminitiesbtn.frame.size.height/2-10, 12, 20)];
                
                imagedown.image = [UIImage imageNamed:@"frontarrow"];
                
               
                
                
                [aminitiesbtn addTarget:self action:@selector(aminitiesbtnTap) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                
                [aminitiesbtn setTitle:@"Amenities" forState:UIControlStateNormal];
                
                aminitiesbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                
                aminitiesbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                aminitiesbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                
                [aminitiesbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                
                [aminitiesbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                
                
                
                // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                
                [subcatview addSubview:aminitiesbtn];
                
                [subcatview addSubview:imagedown];
                
                
                
                
                
                y=y+aminitiesbtn.frame.size.height+2;
                
                
                [mainScroll addSubview:subcatview];
               // NSLog(@"radioName name===%@",radioName);
                
                
//                 subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+firstview.frame.size.height+2);
//                
//                
//                Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
//                
//                
//                
//                mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                
                
                
                
            }
            
            
        }
        
        
        [self stoploader];
        
    }];

  

}
 -(void) checkBox_sub_btn: (UIButton *)sender

{
    //NSLog(@"check box----%@",[chekbox_sub_Array objectAtIndex:sender.tag]);
    
    checkbox_sub_mainArray = [[NSMutableArray alloc]init];
    
    checkbox_sub_mainArray = [[chekbox_sub_Array objectAtIndex:sender.tag]mutableCopy];
    
    NSLog(@"check box----%@",checkbox_sub_mainArray);
    
    SubcheckBtntag=(int)sender.tag;
    subcheckTagbtn=(UIButton *)sender;
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor whiteColor];
    
    
    
    checkbox_done = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 20, 80, 40)];
    
    heading = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, self.view.frame.size.width - 100, 40)];
    heading.text = @"Select";
    
    heading.textColor = [UIColor colorWithRed:59.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:1];
    heading.font = [UIFont fontWithName:@"Lato-bold" size:14];
    heading.textAlignment = NSTextAlignmentCenter;
    
    //heading.backgroundColor=[UIColor blackColor];
    
    
    
    
    checkbox_sub_table = [[UITableView alloc]initWithFrame:CGRectMake(0, heading.frame.origin.y+heading.frame.size.height+20 , self.view.frame.size.width, self.view.frame.size.height - heading.frame.origin.y+heading.frame.size.height+20)];
    
    
    
    checkbox_sub_table.showsVerticalScrollIndicator = NO;
    
    checkbox_sub_table.delegate = self;
    checkbox_sub_table.dataSource = self;
    
    checkbox_sub_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //checkbox_sub_table.sectionIndexColor
    
    
    
    
    
    checkbox_sub_table.backgroundColor = [UIColor whiteColor];
    
    [checkbox_done setTitle:@"Done" forState:UIControlStateNormal];
    
    [checkbox_done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [checkbox_done addTarget:self action:@selector(Sub_checkbox_done) forControlEvents:UIControlEventTouchUpInside];
    
    // [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkbox_done.titleLabel.font = [UIFont fontWithName:@"Lato-regular" size:14];
    
    [self.view addSubview:itemsView];
    [itemsView addSubview:heading];
    [itemsView addSubview:checkbox_sub_table];
    [itemsView addSubview:checkbox_done];
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        
        
        itemsView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }];
    
    
    
    
    
    
    
    

    
    
    
    
}

-(void)Sub_checkbox_done
{
    
    NSLog(@"kausk jati");
    
    NSMutableArray *BtnNameArray=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<chebox_id_Array.count; i++)
    {
        
        
        
        NSInteger chk = [[chebox_id_Array objectAtIndex:i]integerValue];
        
        
        
        NSLog(@"chk---%ld",(long)chk);
        
        for (int j=0; j<checkbox_sub_mainArray.count; j++)
        {
            NSInteger equal = [[checkbox_sub_mainArray[j] valueForKey:@"id"]integerValue];
            
            NSLog(@"eql----%ld",(long)equal);
            
            
            if (chk==equal)
            {
                
                NSLog(@"%ld  =  %ld",(long)chk,(long)equal);
                
                NSString *match = [checkbox_sub_mainArray[j]valueForKey:@"name"];
                
                
                
                
                [BtnNameArray addObject:[NSString stringWithFormat:@"%@",match]];
                
                
                
                
            }
            
            
            
        }
    }
    
    
    NSString *BtnName=[NSString stringWithFormat:@"%@",[BtnNameArray componentsJoinedByString:@","]];
    
    
    NSLog(@"");
    
    
    checkBox_sub_btn=(UIButton *)[subcatview viewWithTag:SubcheckBtntag];
    
    if (SubcheckBtntag==0)
    {
        
        [subcheckTagbtn setTitle:BtnName forState:UIControlStateNormal];
        
    }
    
    else if (SubcheckBtntag==1)
    {
        [subcheckTagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    else if (SubcheckBtntag==2)
    {
        [subcheckTagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    else if (SubcheckBtntag==3)
    {
        [subcheckTagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    else if (SubcheckBtntag==4)
    {
        [subcheckTagbtn setTitle:BtnName forState:UIControlStateNormal];
    }
    
    
    [subcheckTagbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    
    
    [UIView animateWithDuration:.2f animations:^{
        
        
        itemsView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
    }
                     completion:^(BOOL finished) {
                         
                         
                         [itemsView removeFromSuperview];
                         
                     }];
}

 -(void) radio_sub_btn: (UIButton *)sender
{
    
    radio_tableArray = [[NSMutableArray alloc]init];
    
     NSLog(@"radio----%@",[radio_sub_Array objectAtIndex:sender.tag]);
    
    radiosubbtnTap = (int)sender.tag;
    
    radioTagbtn=(UIButton *)sender;
    
    radio_tableArray = [[radio_sub_Array objectAtIndex:sender.tag]mutableCopy];
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    itemsView.backgroundColor = [UIColor clearColor];
    
    
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(radio_sub_tablecancel)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [itemsView addGestureRecognizer:tapGestureRecognize];
    
    
    
           radio_sub_table = [[UITableView alloc]initWithFrame:CGRectMake(radioTagbtn.frame.origin.x,radioTagbtn.frame.origin.y+radioTagbtn.frame.size.height*sender.tag, radioTagbtn.frame.size.width   , radioTagbtn.frame.size.height+100)];
   
    
    
    categoriesTablebackview=[[UIView alloc]initWithFrame:radio_sub_table.frame];
    
    categoriesTablebackview.backgroundColor =[UIColor blackColor];
    
    radio_sub_table.showsVerticalScrollIndicator = NO;
    
    radio_sub_table.delegate = self;
    radio_sub_table.dataSource = self;
    
    //[categoriesTable setAllowsSelection:NO];
    
    categoriesTablebackview.layer.masksToBounds = NO;
    categoriesTablebackview.layer.shadowOffset = CGSizeMake(10, 10);
    categoriesTablebackview.layer.shadowRadius = 3;
    categoriesTablebackview.layer.shadowOpacity = 0.3;
    
    radio_sub_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    radio_sub_table.backgroundColor = [UIColor whiteColor];
    
   
    
    // mainScroll.bounces=NO;
    //  itemsView.backgroundColor = [UIColor redColor];
    
    [mainScroll addSubview:itemsView];
    
    
    subcatview.frame= CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+radio_sub_table.frame.size.height);
    
    adjustview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, subcatview.frame.size.width, subcatview.frame.size.height)];
    UITapGestureRecognizer *tapGestureRecognize1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(radio_sub_tablecancel)];
    tapGestureRecognize1.delegate = self;
    tapGestureRecognize1.numberOfTapsRequired = 1;
    
    [adjustview addGestureRecognizer:tapGestureRecognize1];
    
    
    
    
    
    
    [subcatview addSubview:adjustview];
    
    
    
    
    [mainScroll addSubview:subcatview];
    
    [subcatview addSubview:categoriesTablebackview];
    
    [subcatview addSubview:radio_sub_table];
    

    
    
    
    
    
    
}

-(void)radio_sub_tablecancel
{
    subcatview.frame= CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height-radio_sub_table.frame.size.height);
    
    [adjustview removeFromSuperview];
    [itemsView removeFromSuperview];
    [categoriesTablebackview removeFromSuperview];
    [radio_sub_table removeFromSuperview];
}


-(void) select_sub_btn: (UIButton *)sender
{
     NSLog(@"select----%@",[select_sub_Array objectAtIndex:sender.tag]);
    
    
    NSLog(@"button %ld -- frame: %@", (long)sender.tag, NSStringFromCGRect(select_sub_btn.frame));
    
    
    select_sub_Table_Array =[[NSMutableArray alloc]init];
    
    
    
    select_sub_Table_Array =[[select_sub_Array objectAtIndex:sender.tag] mutableCopy];
    
    
    selecttagcheck=(int)sender.tag;
    
    buttontagset = (UIButton *)sender;
    
   // buttontagset.frame=select_sub_btn.frame;
   
    
   // [subcatview addSubview:buttontagset];
    
    itemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    
    
    
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectcancelTap)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [itemsView addGestureRecognizer:tapGestureRecognize];
    
    
    
    select_sub_Table = [[UITableView alloc]init ];
    
    select_sub_Table.tag=sender.tag;
                        
        select_sub_Table.frame=  CGRectMake(buttontagset.frame.origin.x,buttontagset.frame.origin.y+(buttontagset.frame.size.height)*sender.tag, buttontagset.frame.size.width   , buttontagset.frame.size.height+50);
    
    categoriesTablebackview=[[UIView alloc]initWithFrame:select_sub_Table.frame];
    
    categoriesTablebackview.backgroundColor =[UIColor blackColor];
    
    select_sub_Table.showsVerticalScrollIndicator = NO;
    
    select_sub_Table.delegate = self;
    select_sub_Table.dataSource = self;
    
    //[categoriesTable setAllowsSelection:NO];
    
    categoriesTablebackview.layer.masksToBounds = NO;
    categoriesTablebackview.layer.shadowOffset = CGSizeMake(10, 10);
    categoriesTablebackview.layer.shadowRadius = 3;
    categoriesTablebackview.layer.shadowOpacity = 0.3;
    
    select_sub_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    select_sub_Table.backgroundColor = [UIColor whiteColor];
    
    
    // mainScroll.bounces=NO;
    //  itemsView.backgroundColor = [UIColor redColor];
    
    [mainScroll addSubview:itemsView];
    
    subcatview.frame= CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+select_sub_Table.frame.size.height);
    
    adjustview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, subcatview.frame.size.width, subcatview.frame.size.height)];
    UITapGestureRecognizer *tapGestureRecognize1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectcancelTap)];
    tapGestureRecognize1.delegate = self;
    tapGestureRecognize1.numberOfTapsRequired = 1;
    
    [adjustview addGestureRecognizer:tapGestureRecognize1];
    
   
    
    
    
    
    [subcatview addSubview:adjustview];
    
    
    
    [mainScroll addSubview:subcatview];
    
    [subcatview addSubview:categoriesTablebackview];
    
    [subcatview addSubview:select_sub_Table];
    

}

-(void)selectcancelTap
{
     subcatview.frame= CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height-select_sub_Table.frame.size.height);
    
    [itemsView removeFromSuperview];
    [adjustview removeFromSuperview];
    
    [categoriesTablebackview removeFromSuperview];
    [select_sub_Table removeFromSuperview];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
///Product///////////////////////////////////


-(void)producr_Function
{
    
    [checkboxName removeAllObjects];
        
    [self loader];
    
        NSString *url =[NSString stringWithFormat:@"%@app_sub_category?userid=%@&top_cat=%@&category_id=%@",App_Domain_Url,userid,categoriesName,Main_Categories_id];
        
        
        NSLog(@"url===%@",url);
        
        
        
        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            
            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
            {
                
                selecttag=0;
                radiotag=0;
                checkboxtag=0;
                
                
                checkboxName=[[NSMutableArray alloc]init];
                radioName=[[NSMutableArray alloc]init];
                selectName =[[NSMutableArray alloc]init];
                
                [checkboxview removeFromSuperview];
                
                checkboxview = [[UIView alloc]initWithFrame:CGRectMake(firstview.frame.origin.x, Downview.frame.origin.y+1, firstview.frame.size.width, 0)];
                
               
                y=0;
                
                NSMutableArray *TempArray = [result valueForKey:@"infoarray"];
                
                NSMutableArray *aminities = [result valueForKey:@"aminities"];
                
                if ([[result valueForKey:@"sub_category_status"]isEqualToString:@"N"])
                {
                    
                    
                    NSLog(@"No");
                    
                    option_id = [[NSMutableArray alloc]init];
                    
                    
                    
                    for (int i=0; i<TempArray.count; i++)
                    {
                        
                        
                        if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"checkbox"])
                        {
                            
                            NSLog(@"checkbox");
                            
                            
                            NSMutableArray *checkboxArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                            
                            //                        [checkboxName removeAllObjects];
                            //                        [checkboxId removeAllObjects];
                            
                            
                            
                            
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                            
                           
                            
                            
                            // [checkboxMainview addSubview:checkboxview];
                            
                            
                            
                            NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                            
                            
                            for (int j=0; j<checkboxArray.count; j++)
                            {
                                
                                NSString *name = [[checkboxArray objectAtIndex:j] valueForKey:@"name"];
                                NSString * checkboxid=[[checkboxArray objectAtIndex:j] valueForKey:@"id"];
                                
                                
                                NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                                
                                [tempdic setObject:name forKey:@"name"];
                                [tempdic setObject:checkboxid forKey:@"id"];
                                
                                
                                
                                
                                [indexArray addObject:tempdic];
                                
                                
                                
                                
                                
                                
                                
                                //  NSLog(@"temp---array=====%@",temp);
                                
                                
                                
                                
                                
                                
                            }
                            
                            [checkboxName insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:i];
                            
                            
                            NSLog(@"check box name===%@",checkboxName);
                            
                            
                            [dic setObject:indexArray forKey:@"id"];
                            
                            
                            [option_id addObject:dic];
                            
                            
                          //  [temp removeAllObjects];
                            
                            
                          
                           
                            

                            
                            // checkboxview.backgroundColor = [UIColor redColor];
                            
                            
                            
                           checkboxbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                            
                            
                            
                            
                            
                            checkboxbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                            
                            checkboxbtn.tag =checkboxtag;
                            
                            
                            NSLog(@"i=====%d",i);
                            
                            
                            UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(checkboxbtn.frame.origin.x+checkboxbtn.frame.size.width-30, checkboxbtn.frame.origin.y+checkboxbtn.frame.size.height/2-10, 12, 20)];
                            
                            imagedown.image = [UIImage imageNamed:@"frontarrow"];
                            
                            
                            [checkboxbtn addTarget:self action:@selector(checkboxbtnTap:) forControlEvents:UIControlEventTouchUpInside];
                            
                            
                            checkboxbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            checkboxbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                            
                            [checkboxbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            
                            [checkboxbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                            
                            [checkboxbtn setTitle:[[TempArray objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                            
                            [checkboxview addSubview:checkboxbtn];
                            [checkboxview addSubview:imagedown];
                            
                            [mainScroll addSubview:checkboxview];
                            
                           
                            
                          
                            
                            
                            
                            
                            checkboxtag++;
                            
                            NSLog(@"%d",y);
                            
                            loopcount=i;
                            
                        }
                        
                        
                       else if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"radio"])
                            
                        {
                            
                            
                            
                            NSLog(@"radio");
                            
                            
                            
                            
                            
                            
                            NSMutableArray *radioArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                            
                            
                            
                            
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                            
                            
                            
                            
                            NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                            
                            for (int j=0; j<radioArray.count; j++)
                            {
                                
                                NSString *name = [[radioArray objectAtIndex:j] valueForKey:@"name"];
                                NSString * radiid=[[radioArray objectAtIndex:j] valueForKey:@"id"];
                                
                                
                                
                                
                                
                                NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                                
                                [tempdic setObject:name forKey:@"name"];
                                [tempdic setObject:radiid forKey:@"id"];
                                
                                
                                
                                
                                [indexArray addObject:tempdic];
                                
                                
                                
                                
                                
                                NSLog(@"%d",y);
                                
                                
                                
                                
                                
                            }
                            
                            
                             [radioName insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:radiotag];
                            
                            
                            
                            [dic setObject:indexArray forKey:@"id"];
                            
                            
                            [option_id addObject:dic];

                            
                            
                          //  NSLog(@"i=======%d",i);
                            
                            radioBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                            
                            
                            
                            
                           
                            
                            radioBtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                            
                            // radioBtn.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                            
                            
                            radioBtn.tag =radiotag;
                            
                            
                            UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(radioBtn.frame.origin.x+radioBtn.frame.size.width-37, radioBtn.frame.origin.y+radioBtn.frame.size.height/2-14, 26, 26)];
                            
                            imagedown.image = [UIImage imageNamed:@"downArrow"];
                            
                            
                            [radioBtn addTarget:self action:@selector(radioBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                            
                            
                            radioBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            radioBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                            
                            [radioBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            
                            [radioBtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                            
                            [radioBtn setTitle:[[TempArray objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                            
                            
                            [checkboxview addSubview:radioBtn];
                            [checkboxview addSubview:imagedown];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            [mainScroll addSubview:checkboxview];
                           // NSLog(@"radioName name===%@",radioName);
                            
                           
                            
                            
                            
                            radiotag++;
                            
                            loopcount=i;
                            
                        }
                        
                        
                        
                        
                       else if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                        {
                            
                            
                            
                            NSLog(@"select");
                            
                            NSMutableArray *selectArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                            
                           
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                          
                            
                            
                            NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                            
                            for (int j=0; j<selectArray.count; j++)
                            {
                                
                                NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"name"];
                                NSString * radiid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
                                
                                
                                
                                
                                
                                NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                                
                                [tempdic setObject:name forKey:@"name"];
                                [tempdic setObject:radiid forKey:@"id"];
                                
                                
                                
                                
                                [indexArray addObject:tempdic];
                                
                                
                                
                                
                                
                                NSLog(@"%d",y);
                                
                                
                                
                                
                                
                            }
                            
                            
                            [selectName insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:selecttag];
                            
                            
                            [dic setObject:indexArray forKey:@"id"];
                            
                            
                            [option_id addObject:dic];

                            
                            
                            selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                            
                            
                            UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(selectBtn.frame.origin.x+selectBtn.frame.size.width-37, selectBtn.frame.origin.y+selectBtn.frame.size.height/2-14, 26, 26)];
                            
                            imagedown.image = [UIImage imageNamed:@"downArrow"];
                            
                            
                            
                            
                            selectBtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                            
                            
                            
                            // radioBtn.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                            
                            
                            selectBtn.tag =selecttag;
                            
                            
                            [selectBtn addTarget:self action:@selector(selectBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                            
                            
                            selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            selectBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                            
                            [selectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            
                            [selectBtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                            
                            [selectBtn setTitle:[[TempArray objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                            
                            
                            
                            [checkboxview addSubview:selectBtn];
                            [checkboxview addSubview:imagedown];
                            
                            
                            
                            
                            
                            
                          
                            
                            
                            [mainScroll addSubview:checkboxview];
                            //NSLog(@"radioName name===%@",radioName);
                            
                           
                            
                            NSLog(@"select name===%@",selectName);
                            
                            
                            selecttag++;
                            
                            
                            loopcount=i;
                            
                        }
                        
                        
                        
                        
                        
                        
                      else  if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"textarea"])
                        {
                            
                            
                            
                            NSLog(@"textarea");
                            
                            
                        /*
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                            
                           
                            
                            
                            [option_id addObject:dic];
                            
                            UITextView *textarea=[[UITextView alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                            
                            UILabel *textareaplaceholder = [[UILabel alloc]initWithFrame:CGRectMake(8, textarea.frame.origin.y+5, textarea.frame.size.width, 40)];
                          
                            [textareaplaceholder setFont:[UIFont fontWithName:@"Lato" size:14]];
                            
                            textareaplaceholder.textAlignment = NSTextAlignmentLeft;
                            
                            textareaplaceholder.textColor=[UIColor lightGrayColor];
                            
                            textareaplaceholder.text = [[TempArray objectAtIndex:i] valueForKey:@"option_name"];
                          
                            textarea.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                            
                            
                            
                            
                           
                            
                            
                           
                           
                            [checkboxview addSubview:textarea];
                            [checkboxview addSubview:textareaplaceholder];
                           
                            
                           
                            
                            [mainScroll addSubview:checkboxview];
                           
                            */
                            
                            
                            
                            
                            
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                            
                            [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                            
                            [option_id  addObject:dic];
                            
                            
                            text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                            
                            text.delegate=self;
                            
                            text.tag=[[[TempArray objectAtIndex:i]valueForKey:@"option_id"] integerValue];
                            
                            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                            text.leftView = paddingView;
                            text.leftViewMode = UITextFieldViewModeAlways;
                            
                            text.placeholder =[[TempArray objectAtIndex:i] valueForKey:@"option_name"];
                            
                            [text setFont:[UIFont fontWithName:@"Lato" size:14]];
                            
                            text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                            
                            
                            [checkboxview addSubview:text];
                            
                            [mainScroll addSubview:checkboxview];

                            
                            loopcount=i;
                            
                            
                        }
                        
                        
                      else  if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"text"])
                      {
                          
                          NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                          
                          [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                          
                          [dic setObject:[[TempArray objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                          
                          [option_id  addObject:dic];
                          
                          
                          text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                          
                          text.delegate=self;
                          
                          UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                          text.leftView = paddingView;
                          text.leftViewMode = UITextFieldViewModeAlways;
                          
                          text.tag=[[[TempArray objectAtIndex:i]valueForKey:@"option_id"] integerValue];
                          
                          text.placeholder =[[TempArray objectAtIndex:i] valueForKey:@"option_name"];
                          
                          [text setFont:[UIFont fontWithName:@"Lato" size:14]];
                          
                          text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                          
                          
                          [checkboxview addSubview:text];
                          
                          [mainScroll addSubview:checkboxview];
                          
                          
                          
                          loopcount=i;
                          
                      }
                        
                        
                        
                        
                        
                         y=y+firstview.frame.size.height+2;
                        
                    }
                    
                    
                    
                    if (aminities.count>0)
                    {
                        checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, loopcount+2+checkboxview.frame.size.height+firstview.frame.size.height*(TempArray.count+1));
                        
                        Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+loopcount+1, Downview.frame.size.width, Downview.frame.size.height);
                        
                        
                        
                        mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                    }
                   
                    else
                    {
                        
                        NSLog(@"looop==%d",loopcount);
                        
                    checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+loopcount+firstview.frame.size.height*TempArray.count);
                    
                    Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+loopcount+1, Downview.frame.size.width, Downview.frame.size.height);
                    
                    
                    
                    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);

                    }
                }
                
                else
                {
                    NSLog(@"yes");
                    
                    for (int i=0; i<TempArray.count; i++)
                    {
                        
                        if ([[[TempArray objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                        {
                            
                            
                            
                            NSLog(@"select");
                            
                            NSMutableArray *selectArray = [[TempArray objectAtIndex:i] valueForKey:@"option_value"];
                            
                            [selectName removeAllObjects];
                            [selectId removeAllObjects];
                            
                            
                            for (int j=0; j<selectArray.count; j++)
                            {
                                
                                NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"cat_name"];
                                NSString * selectionid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
                                
                                
                                
                                [selectName addObject:name];
                                [selectId addObject:selectionid];
                                
                            }
                            
                            
                            subCatbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                            
                            
                            
                            UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(subCatbtn.frame.origin.x+subCatbtn.frame.size.width-37, subCatbtn.frame.origin.y+subCatbtn.frame.size.height/2-14, 26, 26)];
                            
                            imagedown.image = [UIImage imageNamed:@"downArrow"];
                            
                            
                           
                            
                            
                            
                            [subCatbtn addTarget:self action:@selector(subCatbtnTap) forControlEvents:UIControlEventTouchUpInside];
                            
                            
                            
                            [subCatbtn setTitle:@"Other Sub-Categories" forState:UIControlStateNormal];
                            
                            subCatbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                            
                            subCatbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            subCatbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                            
                            [subCatbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            
                            [subCatbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                            
                            
                            
                            // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                            
                            [checkboxview addSubview:subCatbtn];
                            
                            [checkboxview addSubview:imagedown];
                            
                            
                            
                            
                            
                            y=y+subCatbtn.frame.size.height+2;
                            
                            
                            [mainScroll addSubview:checkboxview];
                            
                          
                            
                            NSLog(@"select name===%@",selectName);
                            
                            
                            
                            
                        }
                        
                        
                        
                        checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, firstview.frame.size.height);
                        
                        Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+1, Downview.frame.size.width, Downview.frame.size.height);
                        
                        
                        
                        mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                if (aminities.count>0)
                {
                    
                    
                    aminitieArray=[[NSMutableArray alloc]init];
                    
                    aminitieArray = [aminities mutableCopy];
                    
                    
                    aminitiesbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, checkboxview.frame.size.width, firstview.frame.size.height)];
                    
                    
                    
                    UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(aminitiesbtn.frame.origin.x+aminitiesbtn.frame.size.width-30, aminitiesbtn.frame.origin.y+aminitiesbtn.frame.size.height/2-10, 12, 20)];
                    
                    imagedown.image = [UIImage imageNamed:@"frontarrow"];
                    
                   
                    
                    
                    [aminitiesbtn addTarget:self action:@selector(aminitiesbtnTap) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    
                    
                    [aminitiesbtn setTitle:@"Amenities" forState:UIControlStateNormal];
                    
                    aminitiesbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                    
                    aminitiesbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    aminitiesbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    
                    [aminitiesbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    
                    [aminitiesbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                    
                    
                    
                    // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                    
                    [checkboxview addSubview:aminitiesbtn];
                    
                    [checkboxview addSubview:imagedown];
                    
                    
                    
                    
                    
                    y=y+firstview.frame.size.height+2;
                    
                    
                    [mainScroll addSubview:checkboxview];
                    NSLog(@"radioName name===%@",radioName);
                    
//                    
//                     checkboxview.frame=CGRectMake(checkboxview.frame.origin.x, checkboxview.frame.origin.y, checkboxview.frame.size.width, checkboxview.frame.size.height+firstview.frame.size.height+2);
//                    
//                    
//                    Downview.frame =CGRectMake(Downview.frame.origin.x, checkboxview.frame.size.height+checkboxview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
//                    
//                    
//                    
//                    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                    
                    
                    
                    
                }
                
                
            }
            
            
            [self stoploader];
            
        }];
        
        
    }



-(void)Product_sub_catFunction
{
    NSString *url =[NSString stringWithFormat:@"%@app_sub_category?userid=%@&top_cat=%@&category_id=%@",App_Domain_Url,userid,categoriesName,subcat_id];
    
    [self loader];
   

    
    
    NSLog(@"url===%@",url);
    
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            select_sub_Array= [[NSMutableArray alloc]init];
            radio_sub_Array= [[NSMutableArray alloc]init];
            chekbox_sub_Array= [[NSMutableArray alloc]init];
            
            
            selecttag=0;
            radiotag=0;
            checkboxtag=0;
            
            
            texttag=0;
            textareatag=0;
            
            [subcatview removeFromSuperview];
            
            subcatview = [[UIView alloc]initWithFrame:CGRectMake(firstview.frame.origin.x, checkboxview.frame.origin.y+checkboxview.frame.size.height+2, firstview.frame.size.width, 0)];
            
            
            
            // subcatview.backgroundColor = [UIColor redColor];
            
            y=0;
            
            
            NSMutableArray *TempArray1 = [result valueForKey:@"infoarray"];
            
            NSMutableArray *aminities = [result valueForKey:@"aminities"];
            
            if ([[result valueForKey:@"sub_category_status"]isEqualToString:@"N"])
            {
                
                
                NSLog(@"No");
                
                option_id = [[NSMutableArray alloc]init];
                
                
                
                for (int i=0; i<TempArray1.count; i++)
                {
                    
                    if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"text"])
                    {
                        
                        
                        
                        // NSMutableArray *TextArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        [option_id  addObject:dic];
                        
                        
                        
                       text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        text.tag=[[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] integerValue];
                        
                       // texttag++;
                        
                        
                        text.delegate=self;
                        
                        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                        text.leftView = paddingView;
                        text.leftViewMode = UITextFieldViewModeAlways;
                        
                        text.placeholder =[[TempArray1 objectAtIndex:i] valueForKey:@"option_name"];
                        
                        [text setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                        [subcatview addSubview:text];
                        
                         [mainScroll addSubview:subcatview];
                        
                        
                        loopcount=i;
                    
                    }
                    
                    
                  else  if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"textarea"])
                    {
                        
                        
                        
                        NSLog(@"textarea");
                        
                     /*
                        
                        UITextView *textarea=[[UITextView alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        UILabel *textareaplaceholder = [[UILabel alloc]initWithFrame:CGRectMake(8, textarea.frame.origin.y+5, textarea.frame.size.width, 40)];
                        
                        [textareaplaceholder setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        textareaplaceholder.textAlignment = NSTextAlignmentLeft;
                        
                        textareaplaceholder.textColor=[UIColor lightGrayColor];
                        
                        textareaplaceholder.text = [[TempArray1 objectAtIndex:i] valueForKey:@"option_name"];
                        
                        textarea.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                      
                        
                        
                        
                        
                        
                        
                        [subcatview addSubview:textarea];
                        [subcatview addSubview:textareaplaceholder];
                        
                        
                        
                        
                        [mainScroll addSubview:subcatview];
                        
                        */
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        [option_id  addObject:dic];
                        
                        
                        
                        
                        text=[[UITextField alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        text.delegate=self;
                        
                        text.tag=[[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] integerValue];
                        
                       // texttag++;
                        
                        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, text.frame.size.width)];
                        text.leftView = paddingView;
                        text.leftViewMode = UITextFieldViewModeAlways;
                        
                        text.placeholder =[[TempArray1 objectAtIndex:i] valueForKey:@"option_name"];
                        
                        [text setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        text.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                        [subcatview addSubview:text];
                        
                        [mainScroll addSubview:subcatview];
                        
                        loopcount=i;
                        
                        
                        
                        
                    }

                    
                    
                   else if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"checkbox"])
                    {
                        
                        NSLog(@"checkbox");
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        
                        
                        
                        
                        NSMutableArray *checkboxArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                                              
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        
                        
                        for (int j=0; j<checkboxArray.count; j++)
                        {
                            
                            NSString *name = [[checkboxArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * checkboxid=[[checkboxArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:checkboxid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        [chekbox_sub_Array insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:checkboxtag];
                        
                        
                        NSLog(@"check box name===%@",chekbox_sub_Array);
                        
                        
                        [dic setObject:indexArray forKey:@"id"];
                        
                        
                        [option_id addObject:dic];

                        
                        
                        
                        
                        
                        // subcatview.backgroundColor = [UIColor redColor];
                        
                        
                        
                        checkBox_sub_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        checkBox_sub_btn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        
                       // subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y+1, subcatview.frame.size.width, subcatview.frame.size.height+checkBox_sub_btn.frame.size.height+2+1);
                        
                        checkBox_sub_btn.tag=checkboxtag;
                        
                        
                        [checkBox_sub_btn addTarget:self action:@selector(checkBox_sub_btn:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(checkBox_sub_btn.frame.origin.x+checkBox_sub_btn.frame.size.width-30, checkBox_sub_btn.frame.origin.y+checkBox_sub_btn.frame.size.height/2-10, 12, 20)];
                        
                        imagedown.image = [UIImage imageNamed:@"frontarrow"];
                        
                        
                        // [checkboxbtn1 addTarget:self action:@selector(checkboxbtn1Tap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        checkBox_sub_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        checkBox_sub_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [checkBox_sub_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [checkBox_sub_btn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [checkBox_sub_btn setTitle:[[TempArray1 objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        [subcatview addSubview:checkBox_sub_btn];
                        [subcatview addSubview:imagedown];
                        
                        [mainScroll addSubview:subcatview];
                        
                      
                        
                        
                        
                        
                        checkboxtag++;
                        
                        loopcount=i;
                        
                        
                        NSLog(@"%d",y);
                        
                    }
                    
                    
               else     if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"radio"])
                        
                    {
                        
                        
                        
                        NSLog(@"radio");
                        
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                       
                        
                        
                        NSMutableArray *radioArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        
                        
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        for (int j=0; j<radioArray.count; j++)
                        {
                            
                            NSString *name = [[radioArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * radiid=[[radioArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:radiid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                            
                            
                            
                            
                            NSLog(@"%d",y);
                            
                            
                            
                            
                            
                        }
                        
                        
                        [radio_sub_Array insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:radiotag];
                        
                        
                        
                        [dic setObject:indexArray forKey:@"id"];
                        
                        
                        [option_id addObject:dic];

                        
                        
                        NSLog(@"radio=====%@",radio_sub_Array);
                        
                        radio_sub_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                       // subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+radio_sub_btn.frame.size.height);
                        
                        radio_sub_btn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        // radioBtn.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        
                        radio_sub_btn.tag =radiotag;
                        
                        
                        [radio_sub_btn addTarget:self action:@selector(radio_sub_btn:) forControlEvents:UIControlEventTouchUpInside];
                        
                      
                        
                          UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(radio_sub_btn.frame.origin.x+radio_sub_btn.frame.size.width-37, radio_sub_btn.frame.origin.y+radio_sub_btn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                        
                        //  [radioBtn addTarget:self action:@selector(radioBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        radio_sub_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        radio_sub_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [radio_sub_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [radio_sub_btn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [radio_sub_btn setTitle:[[TempArray1 objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        
                        [subcatview addSubview:radio_sub_btn];
                        [subcatview addSubview:imagedown];
                        
                        
                        
                        
                        
                        
                      //  y=y+radio_sub_btn.frame.size.height+2;
                        
                        
                        
                        [mainScroll addSubview:subcatview];
                      
                        
                        
                        
                        
                        radiotag++;
                        
                        loopcount=i;
                        
                        
                        
                    }
                    
                    
                    
                    
                else    if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                    {
                        
                        
                        
                        NSLog(@"select");
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        
                        
                        
                        NSMutableArray *selectArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        
                        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
                        
                        for (int j=0; j<selectArray.count; j++)
                        {
                            
                            NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"name"];
                            NSString * selectionid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
                            
                            
                            
                            
                            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                            
                            [tempdic setObject:name forKey:@"name"];
                            [tempdic setObject:selectionid forKey:@"id"];
                            
                            
                            
                            
                            [indexArray addObject:tempdic];
                            
                        }
                        
                        [select_sub_Array insertObject:[NSMutableArray arrayWithArray:indexArray] atIndex:selecttag];
                        
                        
                        
                        [dic setObject:indexArray forKey:@"id"];
                        
                        
                        [option_id addObject:dic];
                        
                        NSLog(@"select----%@",select_sub_Array);
                        
                        select_sub_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(select_sub_btn.frame.origin.x+select_sub_btn.frame.size.width-37, select_sub_btn.frame.origin.y+select_sub_btn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                      //  subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+select_sub_btn.frame.size.height);
                        
                        select_sub_btn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        select_sub_btn.tag=selecttag;
                        
                        
                        [select_sub_btn addTarget:self action:@selector(select_sub_btn:) forControlEvents:UIControlEventTouchUpInside];
                        // radioBtn.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        
                        //   selectBtn.tag =i;
                        
                        
                        //  [selectBtn addTarget:self action:@selector(selectBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        select_sub_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        select_sub_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [select_sub_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [select_sub_btn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        [select_sub_btn setTitle:[[TempArray1 objectAtIndex:i]valueForKey:@"option_name"] forState:UIControlStateNormal];
                        
                        
                        
                        [subcatview addSubview:select_sub_btn];
                        [subcatview addSubview:imagedown];
                        
                        
                        
                        
                        
                        
                      //  y=y+select_sub_btn.frame.size.height+2;
                        
                        
                        [mainScroll addSubview:subcatview];
                        
                        
                      //  Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
                        
                        
                        
                       // mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                        
                        
                        
                        selecttag++;
                        
                        
                        loopcount=i;
                        
                        
                    }
                    
                    
                    y=y+firstview.frame.size.height+2;
                    
                    
                    
                    
                }
                
                
                if (aminities.count>0)
                {
                    subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+loopcount+1+firstview.frame.size.height*(TempArray1.count+1));
                    
                    
                    Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+loopcount+1, Downview.frame.size.width, Downview.frame.size.height);
                    
                    
                    mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                }
                
                
                else
                {
                
                 subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+loopcount+firstview.frame.size.height*TempArray1.count);
                
                
                Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+loopcount+1, Downview.frame.size.width, Downview.frame.size.height);
                
                
                mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                }
                
            }
            
            else
            {
                NSLog(@"yes");
                
                for (int i=0; i<TempArray1.count; i++)
                {
                    
                    if ([[[TempArray1 objectAtIndex:i] valueForKey:@"option_type"] isEqualToString:@"select"])
                    {
                        
                        
                        
                        NSLog(@"select");
                        
                        
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_id"] forKey:@"option_id"];
                        
                        [dic setObject:[[TempArray1 objectAtIndex:i]valueForKey:@"option_type"] forKey:@"option_type"];
                        
                        [option_id  addObject:dic];
                        
                        
                        NSMutableArray *selectArray = [[TempArray1 objectAtIndex:i] valueForKey:@"option_value"];
                        
                        //                        [selectName removeAllObjects];
                        //                        [selectId removeAllObjects];
                        //
                        //
                        //                        for (int j=0; j<selectArray.count; j++)
                        //                        {
                        //
                        //                            NSString *name = [[selectArray objectAtIndex:j] valueForKey:@"cat_name"];
                        //                            NSString * selectionid=[[selectArray objectAtIndex:j] valueForKey:@"id"];
                        //
                        //
                        //
                        //                            [selectName addObject:name];
                        //                            [selectId addObject:selectionid];
                        //
                        //                        }
                        
                        
                        subCatbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                        
                        
                        
                        UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(subCatbtn.frame.origin.x+subCatbtn.frame.size.width-37, subCatbtn.frame.origin.y+subCatbtn.frame.size.height/2-14, 26, 26)];
                        
                        imagedown.image = [UIImage imageNamed:@"downArrow"];
                        
                        
                        subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+y);
                        
                        
                        
                        // [subCatbtn addTarget:self action:@selector(subCatbtnTap) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        
                        [subCatbtn setTitle:@"Select" forState:UIControlStateNormal];
                        
                        subCatbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                        
                        subCatbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        subCatbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        
                        [subCatbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        
                        [subCatbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                        
                        
                        
                        // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                        
                        [subcatview addSubview:subCatbtn];
                        
                        [subcatview addSubview:imagedown];
                        
                        
                        
                        
                        
                        y=y+subCatbtn.frame.size.height+2;
                        
                        
                        [mainScroll addSubview:subcatview];
                        
                        
                        Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
                        
                        
                        
                        mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                        
                        NSLog(@"select name===%@",selectName);
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
            }
            
            
            
            
            
            if (aminities.count>0)
            {
                
                
                aminitieArray=[[NSMutableArray alloc]init];
                
                aminitieArray = [aminities mutableCopy];
                
                
                aminitiesbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, subcatview.frame.size.width, firstview.frame.size.height)];
                
                
                
                UIImageView  *imagedown = [[UIImageView alloc]initWithFrame:CGRectMake(aminitiesbtn.frame.origin.x+aminitiesbtn.frame.size.width-30, aminitiesbtn.frame.origin.y+aminitiesbtn.frame.size.height/2-10, 12, 20)];
                
                imagedown.image = [UIImage imageNamed:@"frontarrow"];
                
               
                
                
                [aminitiesbtn addTarget:self action:@selector(aminitiesbtnTap) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                
                [aminitiesbtn setTitle:@"Amenities" forState:UIControlStateNormal];
                
                aminitiesbtn.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
                
                aminitiesbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                aminitiesbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                
                [aminitiesbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                
                [aminitiesbtn.titleLabel setFont:[UIFont fontWithName:@"Lato" size:14]];
                
                
                
                // lbl2.text=[[TempArray objectAtIndex:i]valueForKey:@"option_name"];
                
                [subcatview addSubview:aminitiesbtn];
                
                [subcatview addSubview:imagedown];
                
                
                
                
                
                y=y+aminitiesbtn.frame.size.height;
                
                
                [mainScroll addSubview:subcatview];
                // NSLog(@"radioName name===%@",radioName);
                
                
//                
//                 subcatview.frame=CGRectMake(subcatview.frame.origin.x, subcatview.frame.origin.y, subcatview.frame.size.width, subcatview.frame.size.height+aminitiesbtn.frame.size.height+2);
//                
//                
//                Downview.frame =CGRectMake(Downview.frame.origin.x, subcatview.frame.size.height+subcatview.frame.origin.y+2, Downview.frame.size.width, Downview.frame.size.height);
//                
//                
//                
//                mainScroll.contentSize =CGSizeMake(0, Downview.frame.origin.y+Downview.frame.size.height+5);
                
                
                
                
            }
            
            
        }
        
        
        [self stoploader];
        
    }];

}




- (IBAction)saveBtnTap:(id)sender
{
    
    if (button_Tap_check==0)
    {
        
         [self basis_Save];
        
        button_Tap_check++;
        
    }
    

}


    

-(void)loader
{
   polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
}

-(void)stoploader
{
    [spinner stopAnimating];
    [polygonView removeFromSuperview];
}




-(void)basis_Save
{
    Basic_Id_Array = [[NSMutableArray alloc]init];
    
    NSLog(@"categoriesName ---%@",categoriesName);
    
    
    NSMutableArray *final_Array = [[NSMutableArray alloc]init];
    
    
    if (idtext0.length>0)
    {
        //[dic setObject:idtext0  forKey:@"radio1"];
        [Basic_Id_Array addObject:idtext0];
        
    }
    if (idtext1.length>0)
    {
        // [dic setObject:idtext1  forKey:@"radio2"];
        [Basic_Id_Array addObject:idtext1];
        
    }
    if (idtext2.length>0)
    {
        // [dic setObject:idtext2  forKey:@"radio3"];
        [Basic_Id_Array addObject:idtext2];
    }
    if (idtext3.length>0)
    {
        // [dic setObject:idtext0  forKey:@"radio4"];
        [Basic_Id_Array addObject:idtext3];
    }
    
    
    if (select_id0.length>0)
    {
        //[dic setObject:select_id0  forKey:@"select1"];
        [Basic_Id_Array addObject:select_id0];
    }
    if (select_id1.length>0)
    {
        // [dic setObject:select_id1  forKey:@"select2"];
        
        [Basic_Id_Array addObject:select_id1];
    }
    if (select_id2.length>0)
    {
        // [dic setObject:select_id2  forKey:@"select3"];
        
        [Basic_Id_Array addObject:select_id2];
    }
    if (select_id3.length>0)
    {
        /// [dic setObject:select_id3  forKey:@"select4"];
        
        [Basic_Id_Array addObject:select_id3];
    }
    
    
    
    
    
    
    [chebox_id_Array addObjectsFromArray:Basic_Id_Array];
    
    
    
    
    
    for (int i=0; i<option_id.count; i++)
    {
        
        NSMutableArray *tempid = [[option_id objectAtIndex:i] valueForKey:@"id"];
        
        for (int j=0; j<tempid.count; j++)
        {
            
            
            NSString *tempidsrt  = [[tempid objectAtIndex:j] valueForKey:@"id"];
            
            for (int k=0; k<chebox_id_Array.count; k++)
            {
                
                NSString *idcheck = [chebox_id_Array objectAtIndex:k];
                
                if ([tempidsrt isEqualToString:idcheck])
                    
                    
                {
                    
                    
                    
                    NSMutableDictionary *temdic  = [[NSMutableDictionary alloc]init];
                    
                    
                    [temdic setObject:[[tempid objectAtIndex:j] valueForKey:@"id"] forKey:@"Select_id"];
                    [temdic setObject:[[option_id objectAtIndex:i] valueForKey:@"option_id"] forKey:@"option_id"];
                    [temdic setObject:[[option_id objectAtIndex:i] valueForKey:@"option_type"] forKey:@"option_type"];
                    
                    
                    [final_Array addObject:temdic];
                    
                    break;
                    
                    
                }
                
                
                
            }
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    NSMutableArray *lastArray_checkbox=[[NSMutableArray alloc]init];
    NSMutableArray *lastArray_select=[[NSMutableArray alloc]init];
    NSMutableArray *lastArray_radio=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<final_Array.count; i++)
    {
        
        if ([[final_Array [i]valueForKey:@"option_type"] isEqualToString:@"checkbox"])
        {
            NSString *str = [NSString stringWithFormat:@"%@/%@",[final_Array [i]valueForKey:@"Select_id"],[final_Array[i] valueForKey:@"option_id"]];
            
            
            [lastArray_checkbox addObject:str];
        }
        
        else if ([[final_Array [i]valueForKey:@"option_type"] isEqualToString:@"radio"])
        {
            NSString *str = [NSString stringWithFormat:@"%@/%@",[final_Array [i]valueForKey:@"Select_id"],[final_Array[i] valueForKey:@"option_id"]];
            
            [lastArray_radio addObject:str];
            
        }
        
        else if ([[final_Array [i]valueForKey:@"option_type"] isEqualToString:@"select"])
        {
            NSString *str = [NSString stringWithFormat:@"%@/%@",[final_Array [i]valueForKey:@"Select_id"],[final_Array[i] valueForKey:@"option_id"]];
            
            [lastArray_select addObject:str];
            
        }
        
        
        
        
    }
    
    
    
    NSString *Send_checkbox = [lastArray_checkbox componentsJoinedByString:@","];
    NSString *Send_radio = [lastArray_radio componentsJoinedByString:@","];
    NSString *Send_select = [lastArray_select componentsJoinedByString:@","];
    
    NSLog(@"send---%@ \n %@ \n %@",Send_checkbox,Send_radio,Send_select);
    
    [lastArray_checkbox removeAllObjects];
    [lastArray_radio removeAllObjects];
    
    
    for (int a=0; a<textvaleArray.count; a++)
    {
        
        //        [lastArray_checkbox addObject:[[textvaleArray objectAtIndex:a] valueForKey:@"option_id"]];
        //        [lastArray_radio addObject:[[textvaleArray objectAtIndex:a] valueForKey:@"text_Value"]];
        
        
        NSString *str = [NSString stringWithFormat:@"%@@*%@",[textvaleArray[a]valueForKey:@"option_id"],[textvaleArray[a]valueForKey:@"text_Value"]];
        
        [lastArray_checkbox addObject:str];
        
    }
    
    
    NSLog(@" %@ ",lastArray_checkbox);
    
    NSLog(@"aminits---%@",aminities_id_Array);
    
    
    NSString *aminities_string =@"";
    
    if (aminities_id_Array.count>0)
    {
        aminities_string = [aminities_id_Array componentsJoinedByString:@","];
    }
    
    
    // [textvaleArray removeAllObjects];
    
    
    NSString *text_value = [lastArray_checkbox componentsJoinedByString:@"@@"];
    
    NSString *keyword_selected_id=[tapdata componentsJoinedByString:@","];
    
    NSLog(@"id%@",text_value);
    
    
    // esolz.co.in/lab6/freewilder/app_service_insert?userid=100&srv_name=ios service&cat_type=product&book_type=&main_cat=2&sub_cat=14&quantity=3&keyword=2,6&video=&instant_book=no&amen_arr=&option_value_chk=130/46,131/46,97/37&option_value_radio=91/36&option_value_select=128/,1/&option_value_other=
    
    NSString *url = [NSString stringWithFormat:@"%@app_service_insert?userid=%@&srv_name=%@&cat_type=%@&book_type=&main_cat=%@&sub_cat=%@&quantity=%@&keyword=%@&video=&instant_book=%@&amen_arr=%@&option_value_chk=%@&option_value_radio=%@&option_value_select=%@&option_value_other=%@",App_Domain_Url,userid,name_text.text,categoriesName,Main_Categories_id,subcat_id,quantity_txt.text,keyword_selected_id,instand_booking,aminities_string,Send_checkbox,Send_radio,Send_select,text_value];
    
    
    NSLog(@"url----%@",url);
    
    NSString *encode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
         NSLog(@"result--%@",result);
         
         
     }];
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


- (IBAction)changeSwitch:(id)sender
{
    
    if([sender isOn])
    {
        NSLog(@"Switch is ON");
        instand_booking=@"yes";
    }
    
    else
    
    {
        NSLog(@"Switch is OFF");
        instand_booking=@"no";
    }
    
}


@end
