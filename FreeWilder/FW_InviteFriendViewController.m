//
//  InviteFriendViewController.m
//  FreeWilder
//
//  Created by Soumen on 01/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "FW_InviteFriendViewController.h"
#import "InviteFriendcell.h"
#import "Footer.h"
#import "Side_menu.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "ServiceView.h"
#import "accountsubview.h"
#import "LanguageViewController.h"
#import "notificationsettingsViewController.h"
#import "ChangePassword.h"
#import "UserService.h"
#import "MyBooking & Request.h"
#import "userBookingandRequestViewController.h"
#import "myfavouriteViewController.h"
#import "Business Information ViewController.h"
#import "SettingsViewController.h"
#import "PaymentMethodViewController.h"
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
#import "BusinessProfileViewController.h"
#import "sideMenu.h"
#import "FW_JsonClass.h"
#import <AFNetworking/AFNetworking.h>



@interface FW_InviteFriendViewController ()<footerdelegate,Slide_menu_delegate,MFMailComposeViewControllerDelegate,accountsubviewdelegate,Serviceview_delegate,Profile_delegate,UIGestureRecognizerDelegate,UITextFieldDelegate,sideMenu,UIActionSheetDelegate>
{
    
    
#pragma mark - Footer variables
    
    IBOutlet UIView *footer_base;
    sideMenu *leftMenu;
    UIView *overlay;
    NSMutableArray *ArrProductList;
    AppDelegate *appDelegate;
    bool data;
    UIView *loader_shadow_View;
    BOOL tapchk,tapchk1,tapchk2;
    NSMutableArray *jsonArray,*temp;
    UIView *blackview ,*popview;
    NSString *phoneno;
    ServiceView *service;
    profile *profileview;
    UITextField *phoneText;
    accountsubview *subview;
    NSString *userid;
    FW_JsonClass *globalobj;
    
    InviteFriendcell *cell;
    NSMutableArray *arrindexpath;
    int i;
    BOOL flag;
    int selected;
    NSMutableArray *contactList,*ArrSearchList;
    
    NSMutableData *responseData;
    
    __weak IBOutlet UIButton *sendmailBtn;
    NSMutableArray *emailAddresses,*allemails;
    
#pragma mark--Contact list filetring & Indexing variables
    
    NSArray *indexList,*sectionTitles;
    
    NSMutableDictionary *indexedContactDic;
    
    NSMutableArray *filtrationOfContactArray;
    
    NSMutableArray *allIndexPath;
    
    NSDictionary *user;
    
    
#pragma mark--
    


}
@property (weak, nonatomic) IBOutlet UITableView *inviteTable;
@property(nonatomic,strong) NSMutableArray *cellSelected;

@end

@implementation FW_InviteFriendViewController

@synthesize lblInviteFriend,btnSend,SearchBar,inviteTable,lblNoDataFound;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    indexList=[[NSArray alloc]init];
    sectionTitles=[[NSArray alloc]init];
    indexList=[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    filtrationOfContactArray=[[NSMutableArray alloc]init];
    indexedContactDic=[[NSMutableDictionary alloc]init];
    
    sendmailBtn.layer.shadowOffset=CGSizeMake(0, 1);
    sendmailBtn.layer.shadowRadius=7;
    sendmailBtn.layer.shadowColor=[UIColor blackColor].CGColor;
    sendmailBtn.layer.shadowOpacity=0.5;
    sendmailBtn.clipsToBounds=NO;
    
    self.cellSelected = [NSMutableArray array];
    allIndexPath=[NSMutableArray array];
    emailAddresses=[NSMutableArray array];
    allemails=[NSMutableArray array];
    
    IsSearch=0;
    
    NSLog(@"Invite friends...");
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    
    [footer_base addSubview:footer];
    
    temp= [[NSMutableArray alloc]init];
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    
    
    ///Side menu ends here
    
    
    //Footer ends here------>

    
    
   
    globalobj = [[FW_JsonClass alloc]init];
    contactList = [[NSMutableArray alloc]init];
    ArrSearchList = [[NSMutableArray alloc]init];
    [self contact];
    
   // appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
//    NSManagedObjectContext *context1=[appDelegate managedObjectContext];
//    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"ContactList"];
//   NSMutableArray *fetcharray=[[context1 executeFetchRequest:request error:nil] mutableCopy];
//    NSInteger CoreDataCount=[fetcharray count];
//    NSLog(@"core data count=%ld",(long)CoreDataCount);
//    
//    [contactList removeAllObjects];
//
//    for(NSManagedObject *obj1 in fetcharray)
//    {
//        [contactList addObject:obj1];
//    }

    [SearchBar setBackgroundColor:[UIColor clearColor]];
    //   searchbar.barTintColor = [UIColor colorWithRed:(35/255.0f) green:(154/255.0f) blue:(242/255.0f) alpha:1];
   
    UITextField *searchField = [SearchBar valueForKey:@"_searchField"];
    searchField.textColor = [UIColor blackColor];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    lblNoDataFound.hidden=YES;
    i=0;
    flag=YES;
    selected=0;
    arrindexpath=[[NSMutableArray alloc]init];
    _searchtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    // Do any additional setup after loading the view.
    
    /// initializing app footer view
    
//    Footer *footer=[[Footer alloc]init];
//    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
//    footer.Delegate=self;
//    [_footer_base addSubview:footer];
    
    
    /// Getting side from Xiv & creating a black overlay
    
   
    lblInviteFriend.text=@"Invite Friend";
    [btnSend setTitle:@"Send" forState:UIControlStateNormal];
    [btnSend setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _searchtextfield.placeholder=@"Search";
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
        
        NSLog(@"I am here dashboard...");
        
        DashboardViewController *dashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
        [self PushViewController:dashVC WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    
    
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




////------Side menu methods Starts here
//
//-(void)side
//{
//    [self.view addSubview:overlay];
//    [self.view addSubview:leftMenu];
//    
//}
//
//
//-(void)sideMenuAction:(int)tag
//{
//    
//    NSLog(@"You have tapped menu %d",tag);
//    
//    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
//    
//    if(tag==0)
//    {
//        
//        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//        
//    }
//    if(tag==1)
//    {
//        // Do Rate App related work here
//        
//    }
//    if(tag==2)
//    {
//        
//        userid=[prefs valueForKey:@"UserId"];
//        
//        BusinessProfileViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"busniessprofile"];
//        
//        obj.BusnessUserId = userid;
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    if(tag==3)
//    {
//        EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    if(tag==4)
//    {
//        Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    if(tag==5)
//    {
//        
//        blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        
//        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
//        
//        
//        
//        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
//        tapGestureRecognize.delegate = self;
//        tapGestureRecognize.numberOfTapsRequired = 1;
//        
//        [blackview addGestureRecognizer:tapGestureRecognize];
//        
//        
//        
//        
//        popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
//        
//        
//        UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview.bounds.origin.y+10, popview.frame.size.width-20, 40)];
//        
//        phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, header.frame.size.height+20, popview.frame.size.width-20, 45)];
//        phoneText.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
//        
//        phoneText.delegate=self;
//        phoneText.placeholder=@"Enter Phone Number";
//        
//        
//        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
//        phoneText.leftView = paddingView;
//        phoneText.leftViewMode = UITextFieldViewModeAlways;
//        
//        UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+100, header.frame.size.height+phoneText.frame.size.height+40, phoneText.frame.size.width-180, 30)];
//        
//        submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:79/255.0 alpha:1];
//        
//        submit.layer.cornerRadius = 5;
//        
//        [submit setTitle:@"Save" forState:UIControlStateNormal];
//        // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
//        [submit addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        
//        phoneText.layer.cornerRadius=5;
//        
//        header.text = @"Phone Verification";
//        
//        //  header.backgroundColor = [UIColor redColor];
//        
//        [header setFont:[UIFont fontWithName:@"Lato" size:16]];
//        [phoneText setFont:[UIFont fontWithName:@"Lato" size:14]];
//        
//        // header.textColor=[UIColor redColor];
//        
//        header.textAlignment = NSTextAlignmentCenter;
//        
//        [self.view addSubview:blackview];
//        [popview addSubview:header];
//        [popview addSubview:submit];
//        [popview addSubview:phoneText];
//        popview.backgroundColor=[UIColor whiteColor];
//        popview.layer.cornerRadius =5;
//        
//        [self.view addSubview:popview];
//        
//        [UIView animateWithDuration:.3 animations:^{
//            
//            popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//            
//            phoneText.text=[prefs valueForKey:@"phone_no"];
//            
//            
//        }];
//        
//    }
//    if(tag==6)
//    {
//        Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    if(tag==7)
//    {
//        
//        rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//        
//    }
//    if(tag==8)
//    {
//        Business_Information_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Business"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    if(tag==9)
//    {
//        UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
//        
//        [self.navigationController pushViewController:obj animated:NO];
//        
//    }
//    if(tag==10)
//    {
//        //Add product---//---service
//    }
//    if(tag==11)
//    {
//        
//        userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
//        [self.navigationController pushViewController:obj animated:NO];
//        
//    }
//    if(tag==12)
//    {
//        MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
//        
//        [self.navigationController pushViewController:obj animated:NO];
//        
//    }
//    if(tag==13)
//    {
//        WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
//        
//        [self.navigationController pushViewController:obj animated:NO];
//        
//    }
//    if(tag==14)
//    {
//        myfavouriteViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
//        [self.navigationController pushViewController:obj animated:NO];
//    }
//    if(tag==15)
//    {
//        // Account....
//        
//    }
//    
//    if(tag==16)
//    {
//        LanguageViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"language"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    if(tag==17)
//    {
//        // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//        [self deleteAllEntities:@"ProductList"];
//        [self deleteAllEntities:@"WishList"];
//        [self deleteAllEntities:@"CategoryFeatureList"];
//        [self deleteAllEntities:@"CategoryList"];
//        // [self deleteAllEntities:@"ContactList"];
//        [self deleteAllEntities:@"ServiceList"];
//        
//        
//        [[FBSession activeSession] closeAndClearTokenInformation];
//        
//        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
//        
//        [userData removeObjectForKey:@"status"];
//        
//        [userData removeObjectForKey:@"logInCheck"];
//        
//        ViewController   *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//        
//    }
//    
//    // accountSubArray=@[@"Notification",@"Payment Method",@"payout Preferences",@"Tansaction History",@"Privacy",@"Security",@"Settings"];
//    
//    if(tag==50)
//    {
//        
//        notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
//        [self.navigationController pushViewController:obj animated:NO];
//        
//        
//    }
//    if(tag==51)
//    {
//        PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
//        [self.navigationController pushViewController:obj animated:NO];
//        
//        
//    }
//    if(tag==52)
//    {
//        PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
//        [self.navigationController pushViewController:obj animated:NO];
//        
//    }
//    if(tag==53)
//    {
//        NSLog(@"i am from transaction history");
//        
//        
//    }
//    if(tag==54)
//    {
//        PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
//        [self.navigationController pushViewController:obj animated:NO];
//    }
//    if(tag==55)
//    {
//        ChangePassword *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"changepass"];
//        [self.navigationController pushViewController:obj animated:NO];
//        
//        
//    }
//    if(tag==56)
//    {
//        SettingsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
//        [self.navigationController pushViewController:obj animated:NO];
//        
//    }
//    
//    
//}
//
//-(void)Slide_menu_off
//{
//    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
//                        options:1 animations:^{
//                            
//                            
//                            
//                            
//                            leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//                            
//                        }
//     
//     
//     
//                     completion:^(BOOL finished)
//     
//     {
//         
//         [leftMenu removeFromSuperview];
//         [overlay removeFromSuperview];
//         
//         
//         
//     }];
//    
//}
//
////------Side menu methods end here
//
//
//
////-(void)side
////{
////    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
////    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//////    overlay.hidden=YES;
//////    overlay.userInteractionEnabled=YES;
////    [self.view addSubview:overlay];
////    
////    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
////    tapGesture.numberOfTapsRequired=1;
////    [overlay addGestureRecognizer:tapGesture];
////    
////    
////    sidemenu=[[Side_menu alloc]init];
////    
////    CGRect screenBounds=[[UIScreen mainScreen] bounds];
////    
////    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
////        
////    {
////        
////        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
////        
////        sidemenu.ProfileImage.frame = CGRectMake(46, 26, 77, 77);
////        
////        [sidemenu.lblUserName setFont:[UIFont fontWithName:@"Lato" size:16]];
////        
////        sidemenu.btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
////        
////        sidemenu.btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
////        
////        sidemenu.btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
////        
////        sidemenu.btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.5];
////        
////        sidemenu.btn5.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
////        
////        sidemenu.btn6.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
////        
////        sidemenu.btn7.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
////        
////        sidemenu.btn8.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.0];
////        
////        sidemenu.btn9.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
////        
////        
////        
////        
////        
////        
////        
////    }
////    
////    else{
////        
////        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
////        
////    }
////    
////    
////    
////    
////    
////    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
////    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
////    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
////    
////    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
////    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
////   // sidemenu.hidden=YES;
////    
////    
////    userid=[prefs valueForKey:@"UserId"];
////    
////    NSString *url= [NSString stringWithFormat:@"%@/app_phone_verification?userid=%@",App_Domain_Url,userid];
////    
////    
////    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
////        
////        if ([[result valueForKey:@"response" ]isEqualToString:@"success"])
////        {
////            jsonArray = [result valueForKey:@"infoarray"];
////            
////            phoneno = [jsonArray [0]valueForKey:@"phone_no"];
////            
////        }
////        
////        
////        NSLog(@"phone----%@",phoneno);
////        
////        
////    }];
////    
////    
////    
////    
////    
////
////    
////    
////    sidemenu.SlideDelegate=self;
////    [self.view addSubview:sidemenu];
////
////}
////
////
////
////
////
////
////-(void)Slide_menu_off
////{
////    CGRect screenBounds=[[UIScreen mainScreen] bounds];
////    
////    
////    [UIView animateWithDuration:.4 animations:^{
////        
////        
////        
////        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
////        profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
////        
////        if(screenBounds.size.width == 320)
////        {
////            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
////            
////        }
////        else if(screenBounds.size.width == 375)
////        {
////            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
////        }
////        else
////        {
////            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
////        }
////        
////        
////        
////        
////    }
////     
////     
////                     completion:^(BOOL finished)
////     {
////         
////         [subview removeFromSuperview];
////         
////         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
////                             options:1 animations:^{
////                                 
////                                 
////                                 
////                                 
////                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
////                                 
////                             }
////          
////          
////          
////                          completion:^(BOOL finished)
////          
////          {
////              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
////              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
////              [service removeFromSuperview];
////              sidemenu.hidden=YES;
////              overlay.hidden=YES;
////              overlay.userInteractionEnabled=NO;
////              
////              
////          }];
////         
////         
////         
////         
////         
////         
////         
////     }];
////    
////    
////}
//
//
//-(void)btn_action:(UIButton *)sender
//{
//    
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    
//    [UIView animateWithDuration:.4 animations:^{
//        
//        
//        
//        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
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
//              
//              [overlay removeFromSuperview];
//              [sidemenu removeFromSuperview];
//              
//              
//              if (sender.tag==0)
//              {
//                  NSLog(@"0");
//                  
//                  
//                  UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
//                  
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//                  
//                  
//              }
//              
//              else if (sender.tag==1)
//              {
//                  NSLog(@"1");
//              }
//              else if (sender.tag==2)
//              {
//                  NSLog(@"2");
//                  
//                  
//                  userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//                  
//              }
//              
//              else if (sender.tag==3)
//              {
//                  NSLog(@"3");
//                  
//                  
//                  MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
//                  
//                  
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
//                  
//                  
//                  
//                  
//                  
//                  
//              }
//              
//              
//              
//              else if (sender.tag==4)
//              {
//                  NSLog(@"4");
//                  
//                  WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
//                  
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//                  
//              }
//              else if (sender.tag==5)
//              {
//                  NSLog(@"5");
//                  
//                  
//                  myfavouriteViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  // [self Slide_menu_off];
//                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//                  
//              }
//              
//              
//              
//              
//              
//              
//              
//              
//              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//              [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
//              
//              [service removeFromSuperview];
//              [sidemenu removeFromSuperview];
//              [overlay removeFromSuperview];
//              
//              // overlay.userInteractionEnabled=NO;
//              
//              
//          }];
//         
//         
//         
//     }];
//    
//    
//    
//}
//
//
//-(void)pushmethod:(UIButton *)sender
//{
//    
//    NSLog(@"Test_mode....%ld",(long)sender.tag);
//    tapchk=false;
//    tapchk1=false;
//    tapchk2=false;
//    
//    
//    
//    
//    
//    if (sender.tag==5)
//    {
//        [self side];
//        
//        NSLog(@"Creating side menu.....");
//        
//        
//        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
//                            options:1 animations:^{
//                                
//                                
//                                
//                                
//                                //                                CGRect screenBounds=[[UIScreen mainScreen] bounds];
//                                //                                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
//                                //                                {
//                                //                                    sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
//                                //
//                                //                                }
//                                //                                else
//                                //                                {
//                                //
//                                //                                    sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//                                //
//                                //
//                                //                                }
//                                
//                                leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-leftMenu.frame.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//                                
//                                
//                                
//                            }
//         
//                         completion:^(BOOL finished)
//         {
//             
//             // overlay.userInteractionEnabled=YES;
//             
//             // [service removeFromSuperview];
//             
//             
//             
//             
//         }];
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//    }
//    else if (sender.tag==4)
//    {
//        
//        
//        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    else if (sender.tag==3)
//    {
//        
//        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msg_page"];
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//    else if (sender.tag==2)
//    {
//        
//        
//        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchProductViewControllersid"];
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//    }
//        else if (sender.tag==1)
//        {
//            
//            DashboardViewController *dashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
//            [self PushViewController:dashVC WithAnimation:kCAMediaTimingFunctionEaseIn];
//            
//        }
//    
//    
//    
//    
//    
//    
//    
//}
//
//-(void)subviewclick:(UIButton *)sender
//{
//    NSLog(@"tag%ld",(long)sender.tag);
//    
//    
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    
//    [UIView animateWithDuration:.4 animations:^{
//        
//        
//        
//        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
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
//              
//              if (sender.tag==100) {
//                  NSLog(@"i am notification");
//                  
//                  
//                  notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//              }
//              else if (sender.tag==101)
//              {
//                  NSLog(@"i am  payment method");
//                  
//                  
//                  
//                  
//                  PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//              }
//              else if (sender.tag==102)
//              {
//                  NSLog(@"i am payout preferences");
//                  
//                  
//                  
//                  PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//                  
//                  
//                  
//                  
//                  
//              }
//              else if (sender.tag==103)
//              {
//                  NSLog(@"i am from transaction history");
//              }
//              else if (sender.tag==104)
//              {
//                  NSLog(@"i am from privacy");
//                  
//                  
//                  
//                  PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//                  
//                  
//              }
//              else if (sender.tag==105)
//              {
//                  NSLog(@"i am from security");
//                  
//                  ChangePassword *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"changepass"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//                  
//                  
//                  
//                  
//              }
//              else if (sender.tag==106)
//              {
//                  
//                  
//                  SettingsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
//                  [self.navigationController pushViewController:obj animated:NO];
//                  
//                  
//              }
//              
//              
//              
//              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//              [service removeFromSuperview];
//              [sidemenu removeFromSuperview];
//              [overlay removeFromSuperview];
//              
//              //  overlay.userInteractionEnabled=NO;
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
//    
//    
//    
//    
//}
//
//
//-(void)action_method:(UIButton *)sender
//{
//    NSLog(@"##### test mode...%ld",(long)sender.tag);
//    
//    
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    //[service removeFromSuperview];
//    
//    if (sender.tag==6)
//    {
//        
//        
//        
//        if (tapchk==false)
//        {
//            subview=[[accountsubview alloc] init];
//            subview.accountsubviewdelegate=self;
//            
//            
//            
//            if(screenBounds.size.width == 320)
//            {
//                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 210,subview.frame.size.width, subview.frame.size.height)];
//            }
//            else if(screenBounds.size.width == 375)
//            {
//                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 300,subview.frame.size.width, subview.frame.size.height)];
//            }
//            else
//            {
//                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 320,subview.frame.size.width, subview.frame.size.height)];
//            }
//            
//            
//            [overlay addSubview:subview];
//            
//            
//            
//            
//            [UIView animateWithDuration:.4 animations:^{
//                
//                service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
//                
//                
//                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//                
//                
//                [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//                [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
//                [sidemenu.btn6 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
//                
//                
//                if(screenBounds.size.width == 320)
//                {
//                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 210,subview.frame.size.width, subview.frame.size.height)];
//                }
//                else if(screenBounds.size.width == 375)
//                {
//                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 300,subview.frame.size.width, subview.frame.size.height)];
//                    
//                }
//                else
//                {
//                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 320,subview.frame.size.width, subview.frame.size.height)];
//                }
//                
//                
//                
//                
//                
//                
//                
//            }
//             
//             
//             
//                             completion:^(BOOL finished)
//             {
//                 
//                 //  overlay.userInteractionEnabled=YES;
//                 // [service removeFromSuperview];
//                 
//             }];
//            
//            tapchk=true;
//            tapchk1=false;
//            tapchk2=false;
//        }
//        
//        
//        
//        
//    }
//    
//    
//    
//    else if (sender.tag==5)
//    {
//        
//        //             DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"ServiceListingViewControllersid"];
//        //
//        //             [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//        if (tapchk1==false)
//        {
//            
//            
//            
//            service = [[ServiceView alloc]init];
//            CGRect screenBounds=[[UIScreen mainScreen] bounds];
//            if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
//            {
//                service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,240,service.frame.size.width,service.frame.size.height);
//            }
//            else
//            {
//                service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,240,service.frame.size.width,service.frame.size.height);
//            }
//            service.Serviceview_delegate=self;
//            //[footer TapCheck:1];
//            [overlay addSubview:service];
//            
//            
//            
//            [UIView animateWithDuration:.55f animations:^{
//                
//                
//                [sidemenu.btn5 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
//                [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//                [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
//                
//                
//                
//                
//                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//                
//                
//                CGRect screenBounds=[[UIScreen mainScreen] bounds];
//                
//                if(screenBounds.size.width == 320)
//                {
//                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
//                    
//                }
//                else if(screenBounds.size.width == 375)
//                {
//                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
//                }
//                else
//                {
//                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
//                }
//                
//                tapchk=false;
//                
//                
//                
//                tapchk1=true;
//                
//                tapchk2=false;
//                
//                
//                
//                
//                // CGRect screenBounds=[[UIScreen mainScreen] bounds];
//                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
//                {
//                    service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-155,240,155,service.frame.size.height);
//                }
//                else
//                {
//                    service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-service.frame.size.width,240,service.frame.size.width,service.frame.size.height);
//                }
//                
//                // service.Delegate=self;
//                //[footer TapCheck:1];
//                //[overlay addSubview:service];
//                
//                
//                
//                
//            }
//             
//                             completion:^(BOOL finished)
//             {
//                 
//                 //  overlay.userInteractionEnabled=YES;
//                 
//             }];
//            
//            
//            
//            
//            
//            
//        }
//        
//        //[service removeFromSuperview];
//        
//        
//        
//        
//        
//        
//        
//        
//        
//    }
//    
//    else if (sender.tag==3)
//    {
//        //        [subview removeFromSuperview];
//        //        [service removeFromSuperview];
//        //
//        //        EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
//        //
//        //        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//        
//        
//        if (tapchk2==false)
//        {
//            
//            //[profileview removeFromSuperview];
//            
//            profileview = [[profile alloc]init];
//            profileview.Profile_delegate=self;
//            
//            profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//            
//            [overlay addSubview:profileview];
//            
//            
//            
//            
//            [UIView animateWithDuration:.55f animations:^{
//                
//                
//                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-profileview.frame.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//                
//                
//                [sidemenu.btn3 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
//                [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//                [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//                
//                
//                tapchk=false;
//                tapchk1=false;
//                
//                tapchk2=true;
//                
//                
//                
//                service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
//                
//                
//                CGRect screenBounds=[[UIScreen mainScreen] bounds];
//                
//                if(screenBounds.size.width == 320)
//                {
//                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
//                    
//                }
//                else if(screenBounds.size.width == 375)
//                {
//                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
//                }
//                else
//                {
//                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
//                }
//                
//                
//            }
//                             completion:^(BOOL finished)
//             {
//                 
//                 
//                 
//                 
//             }];
//            
//            
//            
//            
//            
//        }
//    }
//    
//    
//    
//    else
//    {
//        [subview removeFromSuperview];
//        [service removeFromSuperview];
//        [profileview removeFromSuperview];
//        
//        
//        [UIView transitionWithView:sidemenu
//                          duration:0.5f
//                           options:UIViewAnimationOptionTransitionNone
//                        animations:^{
//                            
//                            // overlay.hidden=YES;
//                            sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//                            
//                        }
//         
//                        completion:^(BOOL finished)
//         {
//             
//             [sidemenu removeFromSuperview];
//             
//             
//             [overlay removeFromSuperview];
//             
//             
//             [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//             [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//             
//             
//             if (sender.tag==1)
//             {
//                 [subview removeFromSuperview];
//                 [service removeFromSuperview];
//                 
//                 DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
//                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//                 
//                 
//             }
//             
//             else if (sender.tag==8)
//             {
//                 [subview removeFromSuperview];
//                 [service removeFromSuperview];
//                 NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//                 //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//                 
//                 
//                 
//                 
//                 [self deleteAllEntities:@"ProductList"];
//                 [self deleteAllEntities:@"WishList"];
//                 [self deleteAllEntities:@"CategoryFeatureList"];
//                 [self deleteAllEntities:@"CategoryList"];
//               //  [self deleteAllEntities:@"ContactList"];
//                 [self deleteAllEntities:@"ServiceList"];
//                 
//                 
//                 
//                 
//                 [[FBSession activeSession] closeAndClearTokenInformation];
//                 
//                 NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
//                 
//                 [userData removeObjectForKey:@"status"];
//                 
//                 [userData removeObjectForKey:@"logInCheck"];
//                 
//                 ViewController   *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
//                 
//                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//             }
//             
//             else if (sender.tag==4)
//             {
//                 [subview removeFromSuperview];
//                 [service removeFromSuperview];
//                 
//                 Business_Information_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Business"];
//                 
//                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//             }
//             
//             
//             
//             
//             
//             else if (sender.tag == 9)
//             {
//                 [subview removeFromSuperview];
//                 [service removeFromSuperview];
//                 LanguageViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"language"];
//                 
//                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//             }
//             
//             
//         }];
//    }
//}
//
//
//
//-(void)doneWithNumberPad{
//    
//    
//    [UIView animateWithDuration:.3 animations:^{
//        
//        popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//        [phoneText resignFirstResponder];
//        
//    }];
//    
//    
//    
//}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    
//    
//    
//    
//    
//    if (textField==phoneText)
//    {
//        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
//        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//        numberToolbar.items = @[
//                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
//        [numberToolbar sizeToFit];
//        phoneText.inputAccessoryView = numberToolbar;
//        
//        
//        phoneText.keyboardType =UIKeyboardTypePhonePad;
//        [UIView animateWithDuration:.3 animations:^{
//            
//            popview.frame =CGRectMake(10, self.view.frame.size.height * .12, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//            
//            
//        }];
//        
//        
//    }
//    
//    
//    
//    return YES;
//}
//-(void)Profile_BtnTap:(UIButton *)sender
//{
//    [UIView animateWithDuration:.4 animations:^{
//        
//        
//        
//        
//        
//        profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//        
//        
//        
//        
//    }
//                     completion:^(BOOL finished)
//     {
//         
//         
//         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
//                             options:1 animations:^{
//                                 
//                                 [profileview removeFromSuperview];
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
//              [sidemenu removeFromSuperview];
//              [overlay removeFromSuperview];
//              
//              if (sender.tag==0)
//              {
//                  NSLog(@"I am viewProfile");
//              }
//              else if (sender.tag==1)
//              {
//                  NSLog(@"I am EditProfile");
//                  
//                  
//                  EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
//                  
//                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//                  
//                  
//                  
//              }
//              else if (sender.tag==2)
//              {
//                  NSLog(@"I am Photo & Video");
//                  
//                  
//                  
//                  Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
//                  
//                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//                  
//                  
//                  
//                  
//                  
//              }
//              else if (sender.tag==3)
//              {
//                  NSLog(@"I am Trust & verification");
//                  
//                  
//                  Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
//                  
//                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//                  
//                  
//              }
//              else if (sender.tag==4)
//              {
//                  NSLog(@"I am review");
//                  
//                  
//                  
//                  
//                  rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
//                  
//                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//                  
//                  
//                  
//                  
//                  
//                  
//              }
//              
//              
//              else if (sender.tag==5)
//              {
//                  NSLog(@"I am phone Verification");
//                  
//                  
//                  
//                  
//                  blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//                  
//                  blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
//                  
//                  
//                  
//                  UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
//                  tapGestureRecognize.delegate = self;
//                  tapGestureRecognize.numberOfTapsRequired = 1;
//                  
//                  [blackview addGestureRecognizer:tapGestureRecognize];
//                  
//                  
//                  
//                  
//                  popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
//                  
//                  
//                  UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview.bounds.origin.y+10, popview.frame.size.width-20, 40)];
//                  
//                  phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, header.frame.size.height+20, popview.frame.size.width-20, 45)];
//                  phoneText.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
//                  
//                  phoneText.delegate=self;
//                  phoneText.placeholder=@"Enter Phone Number";
//                  
//                  
//                  UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
//                  phoneText.leftView = paddingView;
//                  phoneText.leftViewMode = UITextFieldViewModeAlways;
//                  
//                  UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+100, header.frame.size.height+phoneText.frame.size.height+40, phoneText.frame.size.width-180, 30)];
//                  
//                  submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:79/255.0 alpha:1];
//                  
//                  submit.layer.cornerRadius = 5;
//                  
//                  [submit setTitle:@"Save" forState:UIControlStateNormal];
//                  // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
//                  [submit addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
//                  
//                  
//                  
//                  phoneText.layer.cornerRadius=5;
//                  
//                  header.text = @"Phone Verification";
//                  
//                  //  header.backgroundColor = [UIColor redColor];
//                  
//                  [header setFont:[UIFont fontWithName:@"Lato" size:16]];
//                  [phoneText setFont:[UIFont fontWithName:@"Lato" size:14]];
//                  
//                  // header.textColor=[UIColor redColor];
//                  
//                  header.textAlignment = NSTextAlignmentCenter;
//                  
//                  [self.view addSubview:blackview];
//                  [popview addSubview:header];
//                  [popview addSubview:submit];
//                  [popview addSubview:phoneText];
//                  popview.backgroundColor=[UIColor whiteColor];
//                  popview.layer.cornerRadius =5;
//                  
//                  [self.view addSubview:popview];
//                  
//                  
//                  
//                  
//                  [UIView animateWithDuration:.3 animations:^{
//                      
//                      
//                      
//                      popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//                      
//                      phoneText.text=phoneno;
//                      
//                      
//                  }];
//                  
//                  
//                  
//              }
//              
//              
//          }];
//         
//         
//     }];
//    
//    
//    
//    
//    
//    
//    
//    
//    
//}
//
//-(void)cancelByTap
//{
//    [UIView animateWithDuration:.3 animations:^{
//        
//        
//        
//        popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//        [phoneText resignFirstResponder];
//        
//    }
//                     completion:^(BOOL finished)
//     {
//         
//         
//         
//         [blackview removeFromSuperview];
//         
//     }];
//    
//}
//
//
//-(void)save
//{
//    
//    if (phoneText.text.length==0)
//    {
//        phoneText.placeholder = @"Please Enter Phone Number";
//    }
//    else
//    {
//        NSLog(@"url");
//        
//        NSString *url = [NSString stringWithFormat:@"%@/app_phone_verify_add?userid=%@&phone_no=%@",App_Domain_Url,userid,[phoneText text]];
//        
//        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
//            
//            
//            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
//            {
//                phoneno=phoneText.text;
//                
//                
//                [UIView animateWithDuration:.3 animations:^{
//                    
//                    
//                    
//                    popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//                    [phoneText resignFirstResponder];
//                    
//                }
//                                 completion:^(BOOL finished)
//                 {
//                     
//                     
//                     
//                     [blackview removeFromSuperview];
//                     
//                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                     [alrt show];
//                     
//                 }];
//                
//            }
//            
//            
//        }];
//        
//        
//    }
//    
//}
//
//
//
//
//
//- (void)deleteAllEntities:(NSString *)nameEntity
//{
//    NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
//    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
//    
//    NSError *error;
//    NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
//    for (NSManagedObject *object in fetchedObjects)
//    {
//        [theContext deleteObject:object];
//    }
//    
//    error = nil;
//    [theContext save:&error];
//}
//
//-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
//{
//    CATransition *Transition=[CATransition animation];
//    [Transition setDuration:0.2f];
//    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//    [Transition setType:AnimationType];
//    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
//    [[self navigationController] pushViewController:viewController animated:NO];
//}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *arr=[[NSArray alloc]init];
    
    if(sectionTitles.count>0)
    {
        return indexList;
    }
    return arr;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    NSArray *arr=[[indexedContactDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSLog(@"return index %lu",(unsigned long)[arr indexOfObject:title]);
    
    return [arr indexOfObject:title];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    return [sectionTitles objectAtIndex:section];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (IsSearch==1)
    {
        indexedContactDic=[[NSMutableDictionary alloc]init];
        if (ArrSearchList.count>0)
        {
            
            for (NSString *charac in indexList) {
                
                filtrationOfContactArray=[[NSMutableArray alloc]init];
                
                for ( NSDictionary *user in ArrSearchList)
                {
                    
                    
                    if ([charac isEqualToString: [[[user valueForKey:@"name"] substringToIndex:1] uppercaseString]])
                    {
                        
                            [filtrationOfContactArray addObject:user];
          
                    }
                    
                }
                
                if (filtrationOfContactArray.count>0)
                {
                  [indexedContactDic setObject:filtrationOfContactArray forKey:charac];
                    
                    sectionTitles = [[indexedContactDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

                }
                
            }
            

            
        }
        
        return indexedContactDic.count;
    }
    
    else if(IsSearch==0)
    {
    
        indexedContactDic=[[NSMutableDictionary alloc]init];
        if (contactList.count>0)
        {
            
            for (NSString *charac in indexList) {
                
                filtrationOfContactArray=[[NSMutableArray alloc]init];
                
                for ( NSDictionary *user in contactList)
                {
                    
                    
                    if ([charac isEqualToString: [[[user valueForKey:@"name"] substringToIndex:1] uppercaseString]])
                    {
                        
                        [filtrationOfContactArray addObject:user];
                        
                    }
                    
                }
                
                if (filtrationOfContactArray.count>0)
                {
                    [indexedContactDic setObject:filtrationOfContactArray forKey:charac];
                    
                     sectionTitles = [[indexedContactDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                }
                
            }
            
            
            
        }
    
        return indexedContactDic.count;
    
    }
    else
        return 0;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (IsSearch==1)
//    {
//        return ArrSearchList.count;
//    }
//    else
//    {
//    return contactList.count;
    
    
   // NSLog(@"Contact list----> %@",[contactList valueForKey:@"name"]);
    
    if (indexedContactDic.count>0) {
        
        return [[indexedContactDic objectForKey:[sectionTitles objectAtIndex:section]] count];
        
    }
    else return 0;


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=(InviteFriendcell *)[tableView dequeueReusableCellWithIdentifier:@"invitefriendcell"];
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    user = [ [indexedContactDic objectForKey:[sectionTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];


//    if (IsSearch==1)
//    {
//        cell.invitefriendName.text = [[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"name"];
//        cell.invitefriendPhonenumber.text = [[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"email"];
//        
//        NSData *imagedata = [[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"image"];
//        
//        cell.invitefriendImage.image  =[UIImage imageWithData:imagedata];
//    }
//    else
//    {
//        
//      //  NSLog(@"-----> %@",contactList);
//        
//    cell.invitefriendName.text = [[contactList objectAtIndex:indexPath.row] valueForKey:@"name"];
//    cell.invitefriendPhonenumber.text = [[contactList objectAtIndex:indexPath.row] valueForKey:@"email"];
//
//    NSData *imagedata = [[contactList objectAtIndex:indexPath.row] valueForKey:@"image"];
//   
//        cell.invitefriendImage.image  =[UIImage imageWithData:imagedata];
//    }
    
    tableView.sectionIndexColor=[UIColor colorWithRed:24.0f/255 green:181.0f/255 blue:124.0f/255 alpha:1];
    
            cell.invitefriendName.text = [user valueForKey:@"name"];
            cell.invitefriendPhonenumber.text = [user valueForKey:@"email"];
            NSData *imagedata = [user valueForKey:@"image"];
            cell.invitefriendImage.image  =[UIImage imageWithData:imagedata];
    
    
    cell.invitefriendImage.layer.cornerRadius = cell.invitefriendImage.bounds.size.width/2;
    cell.invitefriendImage.clipsToBounds = YES;
   
    if(![allIndexPath containsObject:indexPath])
    {
      [allIndexPath addObject:indexPath];
        
        [allemails addObject:cell.invitefriendPhonenumber.text];
    }
    
    if ([self.cellSelected containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (IsSearch==1)
//    {
//        NSString *emailTitle = @"Invitation to join Freewilder";
//        // Email Content
//        NSString *messageBody = [NSString stringWithFormat:@"Hello,\n You have been invited to join Freewilder by your friend %@.Please click on the link below to visit the website.\n http://esolz.co.in/lab6/freewilder/> \n       Thanks & Regards Freewilder Team.",[[contactList objectAtIndex:indexPath.row] valueForKey:@"name"]];
//        // To address
//        NSArray *toRecipents = [NSArray arrayWithObject:[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"email"]];
//        
//        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//        mc.mailComposeDelegate = self;
//        [mc setSubject:emailTitle];
//        [mc setMessageBody:messageBody isHTML:NO];
//        [mc setToRecipients:toRecipents];
//        
//        // Present mail view controller on screen
//        [self presentViewController:mc animated:YES completion:NULL];
//    }
//    else{
//    NSString *emailTitle = @"Invitation to join Freewilder";
//    // Email Content
//    NSString *messageBody = [NSString stringWithFormat:@"Hello,\n You have been invited to join Freewilder by your friend %@.Please click on the link below to visit the website.\n http://esolz.co.in/lab6/freewilder/> \n       Thanks & Regards Freewilder Team.",[[contactList objectAtIndex:indexPath.row] valueForKey:@"name"]];
//    // To address
//    NSArray *toRecipents = [NSArray arrayWithObject:[[contactList objectAtIndex:indexPath.row] valueForKey:@"email"]];
//    
//    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//    mc.mailComposeDelegate = self;
//    [mc setSubject:emailTitle];
//    [mc setMessageBody:messageBody isHTML:NO];
//    [mc setToRecipients:toRecipents];
//    
//    // Present mail view controller on screen
//    [self presentViewController:mc animated:YES completion:NULL];
//    }
    
    
    
    if ([self.cellSelected containsObject:indexPath])
    {
        [self.cellSelected removeObject:indexPath];
        
        [emailAddresses removeObject:[[ [indexedContactDic objectForKey:[sectionTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"email"]];
        
        // NSLog(@"Deselect------");
    }
    else
    {
        [self.cellSelected addObject:indexPath];
        [emailAddresses addObject:[[ [indexedContactDic objectForKey:[sectionTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"email"]];
        
       // NSLog(@"select------");
    }
    
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
    
//    [tableView reloadData];
    
    
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

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


- (IBAction)Back_button_action:(id)sender
{
    [self POPViewController];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    inviteTable.hidden=YES;
    IsSearch=1;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
    searchBar.text=@"";
    lblNoDataFound.hidden=YES;
    IsSearch=0;
    [inviteTable reloadData];
    inviteTable.hidden=NO;
    [searchBar resignFirstResponder];
    //   searchbar.hidden=YES;
    //   btnsearch.hidden=NO;
    //   btnsearchicon.hidden=NO;
    //   btnsearch.selected=NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    
    
    if(searchBar.text.length > 0) {
        NSLog(@"searchbar is");
        
        IsSearch=1;
        [searchBar setShowsCancelButton:YES];
        [ArrSearchList removeAllObjects];
        // Filter the array using NSPredicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@",searchText];
        ArrSearchList = [NSMutableArray arrayWithArray:[contactList filteredArrayUsingPredicate:predicate]];
        if (ArrSearchList.count==0)
        {
            lblNoDataFound.hidden=NO;
        }
        else
        {
            lblNoDataFound.hidden=YES;
        }
        [inviteTable reloadData];
        inviteTable.hidden=NO;
     
        
    }
    else {
        NSLog(@"searchbar is NOT");
        
        
    }
    
    
    
    
}









-(void)contact
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL,NULL);
    
    __block BOOL accessGranted = NO;
    
    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // We are on iOS 6
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
    }
    
    else { // We are on iOS 5 or Older
        accessGranted = YES;
        [self getContactsWithAddressBook:addressBook];
    }
    if (accessGranted) {
        [self getContactsWithAddressBook:addressBook];
    }

}


- (void)getContactsWithAddressBook:(ABAddressBookRef )addressBook {
    
    contactList = [[NSMutableArray alloc] init];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int j=0;j < nPeople;j++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,j);
        
        //For username and surname
        //  ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        if (ABRecordCopyValue(ref, kABPersonLastNameProperty) != NULL)
        {
            if(ABRecordCopyValue(ref, kABPersonFirstNameProperty) != NULL)
            {
                [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
            }
            else
            {
                [dOfPerson setObject:[NSString stringWithFormat:@"%@", lastName] forKey:@"name"];
            }
            
            
        }
        else
        {
            if(ABRecordCopyValue(ref, kABPersonFirstNameProperty) != NULL)
            {
                [dOfPerson setObject:[NSString stringWithFormat:@"%@", firstName] forKey:@"name"];
            }
        }
        
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        //For Image
        
        UIImage *contactImage = [self imageForContact:ref];
        NSData *cpontactimagedata = UIImageJPEGRepresentation(contactImage, 1.0f);
        UIImage *img = [UIImage imageNamed:@"ProfileImage"];
        NSData *imgdata = UIImageJPEGRepresentation(img, 1.0f);
        if (contactImage != nil)
        {
            [dOfPerson setObject:cpontactimagedata forKey:@"image"];
        }
        else
        {
            [dOfPerson setObject:imgdata forKey:@"image"];
        }
        
        /*     ABMultiValueRef phoneNumbers = ABRecordCopyValue(ref, kABPersonPhoneProperty);
         
         for (CFIndex j=0; j < ABMultiValueGetCount(phoneNumbers); j++)
         
         {
         
         NSString* phoneLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phoneNumbers, j);
         
         NSString* phoneNumber = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phoneNumbers, j));
         
         if([phoneLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
         
         {
         
         mobileno = phoneNumber;
         break;
         
         }
         
         else if([phoneLabel isEqualToString:@"_$!<Home>!$_"])
         
         {
         
         homeno = phoneNumber;
         }
         
         else if([phoneLabel isEqualToString:@"_$!<Work>!$_"])
         
         {
         
         workno = phoneNumber;
         }
         
         else
         
         {
         otherno = phoneNumber;
         
         }
         
         }
         
         CFRelease(phoneNumbers);
         
         if (![mobileno isKindOfClass:[NSNull class]] && [mobileno length] > 0)
         
         newstringph = mobileno;
         
         else if (![homeno isKindOfClass:[NSNull class]] && [homeno length] > 0)
         
         newstringph = homeno;
         
         else if (![workno isKindOfClass:[NSNull class]] && [workno length] > 0)
         
         newstringph = workno;
         
         else
         
         newstringph = otherno;        // [contactList addObject:dOfPerson];
         
         //  NSLog(@"---- %@", newstringph);
         [dOfPerson setObject:newstringph forKey:@"Phone"];
         
         */
        
        if ([[dOfPerson objectForKey:@"email"] length] != 0)
        {
            [contactList addObject:dOfPerson];
        }
        
        
        
        
        
    }
    
    
   NSLog(@"contact list = %@",[contactList valueForKey:@"name"]);


}


-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


- (UIImage*)imageForContact: (ABRecordRef)contactRef {
    UIImage *img = nil;
    
    // can't get image from a ABRecordRef copy
    ABRecordID contactID = ABRecordGetRecordID(contactRef);
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABRecordRef origContactRef = ABAddressBookGetPersonWithRecordID(addressBook, contactID);
    
    if (ABPersonHasImageData(origContactRef)) {
        NSData *imgData = (__bridge NSData*)ABPersonCopyImageDataWithFormat(origContactRef, kABPersonImageFormatThumbnail);
        img = [UIImage imageWithData: imgData];
        
        
    }
    
    CFRelease(addressBook);
    
    return img;
}


- (IBAction)sendMail:(id)sender
{
    
    if(emailAddresses.count>0)
    {
    
    //app_user_service/app_invite_email?user_id=30&email=
        
        NSString *emailString=[emailAddresses componentsJoinedByString:@","];//
        
        //NSString *urlstring=[NSString stringWithFormat:@"%@app_user_service/app_invite_email?user_id=%@&email=%@",App_Domain_Url,[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"],emailString];
        NSString *urlstring=[NSString stringWithFormat:@"%@app_user_service/app_invite_email",App_Domain_Url];
        
     //   NSString *urlstring=[NSString stringWithFormat:@"http://esolz.co.in/lab6/Referralonline/app_edit_client_seeking"];
      //  urlstring=[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
      //  NSLog(@"URL>>>>>>>> %@",urlstring);
        
//        [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
//            
//            NSLog(@"Response----- %@",result);
//            
//            
//        }];
        
       

        
#pragma mark--URL fire 1
        
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
//        
//        [request setHTTPMethod:@"POST"];
//        
//        NSString *postData =[NSString stringWithFormat:@"userid=52"]; // [NSString stringWithFormat:@"user_id=%@&email=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"],emailString];
//        
//        NSLog(@"url post ---%@",postData);
//        
//        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        
//        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
//
//        [globalobj GlobalDict_post:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
//        
//        
//            NSLog(@"result %@",result);
//        
//            if([[result valueForKey:@"response"] isEqualToString:@"success"])
//            {
//            
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Invitation successfully sent" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//                
//                self.cellSelected=[[NSMutableArray alloc]init];
//                if(emailAddresses.count>0)
//                {
//                    [emailAddresses removeAllObjects];
//                    
//                }
//                
//                [inviteTable reloadData];
//            
//            }
//        
//        
//        }];
        
 
 #pragma mark--URL fire 2
        
        
        
   //---> http://esolz.co.in/lab6/Referralonline/app_edit_client_seeking?userid=52
        
       // http://esolz.co.in/lab6/freewilder/app_category/invite_email
        
        NSString *post =[NSString stringWithFormat:@"user_id=30&email=%@",emailString];
        post=[post stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]
        
        //[NSString stringWithFormat:@"userid=52&clactyp=I&client_range=20&gender=m&marital=s&fmarital=f@&hobies=bp&occu=op&income_lev=23&geo_loc=Kolkata&description=Hello"];
        
        NSLog(@"------ >  %@  < -------",post);
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding ];//[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab6/freewilder/app_user_service/app_invite_email?"/*,App_Domain_Url*/]]];
        
        //[NSURL URLWithString:[NSString stringWithFormat:@"http://esolz.co.in/lab6/Referralonline/app_edit_client_seeking?"]]
        
        
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
        
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if(conn) {
            NSLog(@"Connection Successful");
        } else {
            NSLog(@"Connection could not be made");
        }


//        NSDictionary *dic2 = @{@"user_id": [[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"] , @"email" : emailString};
//        
//
//        
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        
//        [manager POST:urlstring parameters:dic2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"success!");
//            
//           
//            
//            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//             NSLog(@"Response----> %@",dict);
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error: %@", error);
//        }];

    
    }
    else
    {
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please select friends to invite." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }
    
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data1
{
    [responseData appendData:data1];
}


// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{


}
// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    NSDictionary *result=[[NSDictionary alloc]init];
    
    result=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    NSLog(@"Response----> %@",result);
}

- (IBAction)option:(id)sender {
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Select All",
                            @"Deselect All",nil];
    
    
    [popup showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{


    if(buttonIndex == 0)
    {
        // Select all tapped
    
        
        self.cellSelected=[[NSMutableArray alloc]init];
        self.cellSelected=[allIndexPath mutableCopy];
        emailAddresses=[[NSMutableArray alloc]init];
        emailAddresses=[allemails mutableCopy];
        [inviteTable reloadData];
    
    }
    
    if(buttonIndex == 1)
    {
       // Deselect all tapped
        
        
        self.cellSelected=[[NSMutableArray alloc]init];
        
        if(emailAddresses.count>0)
        {
          [emailAddresses removeAllObjects];
        
        }
        
        [inviteTable reloadData];

        
    }
    
  
    


}



@end
