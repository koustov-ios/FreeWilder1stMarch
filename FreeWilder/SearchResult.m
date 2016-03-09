//
//  SearchResult.m
//  FreeWilder
//
//  Created by kausik on 30/09/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "SearchResult.h"
#import "Productcell.h"
#import "UIImageView+WebCache.h"
//#import "CERangeSlider.h"
#import "BusinessProfileViewController.h"
#import "FW_JsonClass.h"
#import "NMRangeSlider.h"
#import "FWProductDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - Footer related imports

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
#import "Reachability.h"

@interface SearchResult () <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    FW_JsonClass *globalobj;
    NSMutableArray *catid,*catname;
    
    __weak IBOutlet UIView *back_ground;
    
    
    NSString *cat_name,*cat_id;
    NSMutableArray *results,*searchArray;
    
    Productcell *cell;
    UIActivityIndicatorView  *activityIndicator;
    UIView *IndicatorView;
    
    
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
    
    
    BOOL nomoredata,processGoingOn;
    

}

@end

@implementation SearchResult
@synthesize ArrSearchList,cellindex,arrtotal,urlString,partofUrl;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nomoredata=NO;
    processGoingOn=NO;
    
    filterBtn.layer.shadowOffset=CGSizeMake(0, 1);
    filterBtn.layer.shadowRadius=10;
    filterBtn.layer.shadowColor=[UIColor blackColor].CGColor;
    filterBtn.layer.shadowOpacity=0.8;
    filterBtn.clipsToBounds=NO;

    
   
   
    
    
   
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [filterBtn addGestureRecognizer:pan];
    
    
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
    
    
    //------>
    
    
    
    
    
    
    cellindex=[[NSMutableArray alloc]init];
    arrtotal=[[NSMutableArray alloc]init];
    searchArray=[[NSMutableArray alloc]init];
    activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];
    activityIndicator.hidden=YES;
    
    IndicatorView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    //IndicatorView.alpha=0.5;
    IndicatorView.hidden=YES;
    IndicatorView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5f];
    [self.view addSubview:IndicatorView];
    
    [self.view addSubview:activityIndicator];
    
    
    
    
    //  [amount1 sizeToFit];
    amount1.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    categorybtn.layer.cornerRadius=3;
    
    pview.frame =CGRectMake(0, self.view.frame.size.height, pview.frame.size.width, pview.frame.size.height);
    pview.hidden=YES;
    
    
    catname = [[NSMutableArray alloc]init];
    catid=[[NSMutableArray alloc]init];
    results=[[NSMutableArray alloc]init];
    
    globalobj=[[FW_JsonClass alloc]init];
    
    //NSUInteger margin = 24; //25
    
//    
//    CGRect sliderFrame = CGRectMake(margin,topbar.frame.size.height+margin+pricerange.frame.size.height , self.view.frame.size.width - margin * 7, 20); //*8
//    // CERangeSlider* slider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
//    NMRangeSlider *slider=[[NMRangeSlider alloc] initWithFrame:sliderFrame];
//    slider.maximumValue = 20000;
//    slider.minimumValue = 1;
//    slider.upperValue = 20000;
//    slider.lowerValue = 1;
//    // slider.curvatiousness = 1;
//    slider.continuous=YES;
//    //  slider.trackHighlightColour = [UIColor colorWithRed:82.0f/255.0F green:57.0f/255.0f blue:84.0f/255.0f alpha:1];
//    
//    //[self.view addSubview:slider];
//    
//    
//    [slider addTarget:self
//               action:@selector(slideValueChanged:)
//     forControlEvents:UIControlEventValueChanged];
    
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectCD:) name:@"end_Touch" object:nil];
    
    
    
    
    // NSLog(@"array = %@",ArrSearchList);
    
    //    for (int i=0; i<ArrSearchList.count; i++)
    //    {
    //        NSString *temp = [[ArrSearchList objectAtIndex:i]valueForKey:@"category_details"];
    //
    //        [testArray insertObject:temp atIndex:i];
    //    }
    
    
}

-(void) handlePan:(UIGestureRecognizer*)panGes
{ CGPoint point = [panGes locationInView:self.view];
    
   // NSLog(@"y----> %f",point.y);
    
    //Only allow movement up to within 100 pixels of the right bound of the screen && 100px of the bottom of the screen
    
    
    
    if (point.x < [UIScreen mainScreen].bounds.size.width - 100 && (point.y<footer_base.frame.origin.y-100 ))
    {
        CGRect newframe = CGRectMake(point.x, point.y, filterBtn.frame.size.width, filterBtn.frame.size.height);
        filterBtn.frame = newframe;
        
       //  filterBtn.alpha=1;
    
    }
    


}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
     self.automaticallyAdjustsScrollViewInsets=NO ;
   //  [self SearchUrl];

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


-(void)SearchUrl
{

    
    NSString *urlstring = urlString;
    NSLog(@"url------------------>str= %@",urlstring);
    
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
                 
                 
              
                 
                 for ( NSDictionary *tempDict1 in  [result objectForKey:@"details"])
                 {
                     [searchArray addObject:tempDict1];
                 }
                 
                 [ArrSearchList removeAllObjects];
                 ArrSearchList=[searchArray mutableCopy];
                 
                    NSLog(@"result----------------> \n%@",ArrSearchList);
                 
                 [_Search_Table reloadData];
                 
                 
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Result Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 
                 [alrt show];
             }
             
         }];
    }
    else{
        
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        
    }
    
}


-(void)connectCD:(NSNotification *)note
{
    NSLog(@"touch end");
    
    
    if (cat_id==0 || cat_id==NULL)
    {
        cat_id=@"";
    }
    IndicatorView.hidden=NO;
    activityIndicator.hidden=NO;
    [activityIndicator startAnimating];
    
    
    NSString *urlstring = [NSString stringWithFormat:@"%@app_product_details_cat?servicename=%@&serviceplae=%@&opendate=%@&enddate=%@&catid=%@&price_low=%@&price_high=%@&cur_id=3",App_Domain_Url,_producrname,_location,_start_date,_end_date,cat_id,amount1.text,amount2.text];
    NSLog(@"str=%@",urlstring);
    
     NSString *encode = [urlstring  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
         
         //   NSLog(@"result=%@",result);
         if([[result valueForKey:@"response"] isEqualToString:@"success"])
             
         {
             [results removeAllObjects];
             
             NSLog(@"result=%@",[result valueForKey:@"details"]);
             
             for ( NSDictionary *tempDict1 in  [result objectForKey:@"details"])
             {
                 [results addObject:tempDict1];
                 
             }
             
             
             // [ArrSearchList addObjectsFromArray:r ]
             [ArrSearchList removeAllObjects];
             
             NSLog(@"+++++++++++++++++++++%@",ArrSearchList);
             
             [ArrSearchList addObjectsFromArray:results];
             
             _Search_Table.hidden=NO;
             [activityIndicator stopAnimating];
             activityIndicator.hidden=YES;
              IndicatorView.hidden=YES;
             
             [_Search_Table reloadData];
             
         }
         
         
         else
         {
             _Search_Table.hidden=YES;
             
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             [alrt show];
             
         }
         
     }];
    
}


//- (void)slideValueChanged:(id)control
//{
//    // CERangeSlider* slider = (CERangeSlider*)control;
//    NMRangeSlider *slider=(NMRangeSlider *)control;
//    
//    startingrange.text = [NSString stringWithFormat:@"%d",(int)slider.lowerValue];
//    endingrange.text = [NSString stringWithFormat:@"%d",(int)slider.upperValue];
//    
//    NSLog(@"Slider value changed: %d,%d",(int)slider.lowerValue, (int)slider.upperValue);
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//Table View

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 290;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSLog(@"Creating rows............");
    
    
    return ArrSearchList.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Productcell *cell=(Productcell *)[tableView dequeueReusableCellWithIdentifier:@"productcell"];
    cell=[tableView dequeueReusableCellWithIdentifier:@"productcell"];
    cell.lblProductName.text=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.lblProductDesc.text=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"description"];
    
    [cell.ProductImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"product_image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    cell.ProductImage.contentMode=UIViewContentModeScaleAspectFill;
    cell.ProductImage.clipsToBounds = YES;
    
    //product cost
    NSString *priceSign;
    if ([[[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"EUR"])
    {
        priceSign=@"€";
        // NSLog(@"price=%@",priceSign);
    }
    else if ([[[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"INR"])
    {
        priceSign=@"₹";
        //  NSLog(@"price=%@",priceSign);
    }
    else if ([[[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"USD"])
    {
        priceSign=@"$";
        // NSLog(@"price=%@",priceSign);
    }
    else if ([[[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"PLN"])
    {
        priceSign=@"zł";
        // NSLog(@"price=%@",priceSign);
    }
    NSString *price=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"price"];
    NSInteger len=price.length;
    cell.lblProductCost.text=[priceSign stringByAppendingString:[[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"price"] substringWithRange:NSMakeRange(4, len-4)]];
    
    //user image
    cell.UserImage.layer.cornerRadius = cell.UserImage.frame.size.height/2;
    cell.UserImage.clipsToBounds = YES;
    cell.UserImage.userInteractionEnabled=YES;
    cell.UserImage.layer.borderColor=[UIColor whiteColor].CGColor;
    cell.UserImage.layer.borderWidth=1.5;
    cell.UserImage.contentMode=UIViewContentModeScaleAspectFill;
    [cell.UserImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"Profile_image_placeholder"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    cell.lblDate.text=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"date"];
    if ([[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"start_time"] isEqualToString:@""])
    {
        cell.lblStartTime.hidden=YES;
    }
    else
    {
        cell.lblStartTime.hidden=NO;
        cell.lblStartTime.text=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"start_time"];
    }
    
    cell.lblDate.text=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"date"];
    if ([[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"close_time"] isEqualToString:@""])
    {
        cell.lblEndTime.hidden=YES;
    }
    else
    {
        cell.lblEndTime.hidden=NO;
        cell.lblEndTime.text=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"close_time"];
    }
    
    
    cell.ProfileBtnTap.tag=indexPath.row;
    [cell.ProfileBtnTap addTarget:self action:@selector(profileBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.lblDate.text=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"date"];
    
    
    
    //Btn_like implementation
    
    cell.Like_Btn.tag=indexPath.row;
    [cell.Like_Btn addTarget:self action:@selector(syncButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if([[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"wishlist_stat"] isEqualToString:@"Y"])
        
    {
        
        
                             [cell.Like_Btn setImage:[UIImage imageNamed:@"hearticon"] forState:UIControlStateNormal];

                             
        
           }
    else {
       
       
        [cell.Like_Btn setImage:[UIImage imageNamed:@"unfilled_heart"] forState:UIControlStateNormal];
    }
    
    
    
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

  if(!([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable) && nomoredata==NO && ArrSearchList.count-1==indexPath.row && processGoingOn==NO)
  {
  
      int startVal=[_prevStartValue intValue];
      
      startVal+=ArrSearchList.count;
      
      NSString *urlstr=[NSString stringWithFormat:@"%@%@",partofUrl,[NSString stringWithFormat:@"%d",startVal]];
      
      
      [self getDataFromUrl:urlstr];
  
  }



}


#pragma mark-Lazy loading block


-(void)getDataFromUrl:(NSString *)urlstr
{

    [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"str======>>>%@",urlstr);
    
    NSString *encode = [urlstr  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
         
         NSLog(@"result=%@",result);
         
         NSMutableArray *result_temp=[[NSMutableArray alloc]init];
         
         if([[result valueForKey:@"response"] isEqualToString:@"success"])
             
         {
             NSInteger rowToBeInsertedFrom=ArrSearchList.count;
             
            
             
             NSLog(@"result=%@",[result valueForKey:@"details"]);
             
             for ( NSDictionary *tempDict1 in  [result objectForKey:@"details"])
             {
                 [result_temp addObject:tempDict1];
             }
             
//             
             if(result_temp.count>0)
             {
             
             
             [ArrSearchList addObjectsFromArray:result_temp];
                 
                 NSLog(@"hello------> %ld",ArrSearchList.count);
                 
                  NSLog(@"********** %ld ***********",rowToBeInsertedFrom);
             
             
             processGoingOn=YES;
             
             [_Search_Table beginUpdates];
             
             for(int i=(int)rowToBeInsertedFrom; i<ArrSearchList.count; i++)
             {
                 
                 
                 NSIndexPath *indexPathForNextRow=[NSIndexPath indexPathForRow:i inSection:0];
                 
                 NSLog(@"Row to be inserted at pos:---> %d",i);
                 
                 [_Search_Table insertRowsAtIndexPaths:@[indexPathForNextRow] withRowAnimation:UITableViewRowAnimationRight];
                 
                 
             }
             
             [_Search_Table endUpdates];
             
             processGoingOn=NO;
             
           }
             
             else
             {
             
                 nomoredata=YES;
             
             }
         
         }
         
         }];

}

#pragma mark




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    FWProductDetailsViewController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"fw_productdetails"];
    
    if(ArrSearchList.count>0)
    {
        nav.productId=[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"service_id"];
        nav.UsrId=[[NSUserDefaults standardUserDefaults ]valueForKey:@"UserId"];
        
        NSLog(@"Service id---? %@",[[ArrSearchList objectAtIndex:indexPath.row] valueForKey:@"service_id"]);
        
        [self.navigationController pushViewController:nav animated:NO];
    }
}



-(void)syncButtonAction:(UIButton*)sender
{
  //UnfilledGreenHearts
  //GreenHearts
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString  *user_id=[prefs valueForKey:@"UserId"];

    
        if([user_id isEqualToString:[[ArrSearchList objectAtIndex:sender.tag] valueForKey:@"user_id"]])
        {
    
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You can't add your own product in wish list." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
    
        }
    else
    {
        
                NSString *urlString1;
        
                urlString1=[NSString stringWithFormat:@"%@app_json_site/app_wish_add_remove?userid=%@&service_id=%@",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],[[ArrSearchList objectAtIndex:sender.tag] valueForKey:@"service_id"]];
        
                NSLog(@"Wishlist url----> %@",urlString1);
        
                [globalobj GlobalDict:urlString1 Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
                    if(result)
                    {
                        NSLog(@"Wishlist stat----> %@",result);
        
                        if([[result valueForKey:@"message"] isEqualToString:@"product deleted from wishlist successfully"])
                        {
        
                            [sender setImage:[UIImage imageNamed:@"unfilled_heart"] forState:UIControlStateNormal];
        
                            NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
                            tempDic=[[ArrSearchList objectAtIndex:sender.tag] mutableCopy];
                            [tempDic setValue:@"N" forKey:@"wishlist_stat"];
                            [ArrSearchList removeObjectAtIndex:sender.tag];
                            [ArrSearchList insertObject:tempDic atIndex:sender.tag];
                           // [self coreDataValueUpdateWithProduct:tempDic forIndex:sender.tag];
        
        
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Messagae" message:@"Product deleted from wishlist successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                            [alert show];
        
        
                        }
                        else if([[result valueForKey:@"message"] isEqualToString:@"product added in wishlist successfully"])
                        {
        
                            [sender setImage:[UIImage imageNamed:@"hearticon"] forState:UIControlStateNormal];
                            

        
                            NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
                            tempDic=[[ArrSearchList objectAtIndex:sender.tag] mutableCopy];
                            [tempDic setValue:@"Y" forKey:@"wishlist_stat"];
                            [ArrSearchList removeObjectAtIndex:sender.tag];
                            [ArrSearchList insertObject:tempDic atIndex:sender.tag];
                           //[self coreDataValueUpdateWithProduct:tempDic forIndex:sender.tag];
        
        
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Messagae" message:@"Product added in wishlist successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                            [alert show];
                            
                            
                        }
                        
                    }
                    
                    
                }];
                
            }

    
}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    return catname.count;
    
    
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return catname[row];
    
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"--------%@",catname[row]);
    
    NSLog(@"---------%@",catid[row]);
    
    cat_id=catid[row];
    cat_name=catname[row];
    
    
}


-(void)profileBtnTap : (UIButton *)sender
{
    
    
    
    
    NSString *BusnessUserId = [[ArrSearchList objectAtIndex:sender.tag]valueForKey:@"user_id"];
    
    NSLog(@"tap =====%@",BusnessUserId);
    
    BusinessProfileViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"busniessprofile"];
    
    
    obj.BusnessUserId = BusnessUserId;
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
    
    
}


- (IBAction)BackTap:(id)sender
{
    [self .navigationController popViewControllerAnimated:YES];
}
- (IBAction)SelectCategoryTap:(id)sender
{
    
    if (catid.count==0)
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
                    
                    
                    
                    picker.dataSource=self;
                    picker.delegate=self;
                    pview.hidden=NO;
                    
                    
                    
                    
                    
                    [UIView animateWithDuration:.2f animations:^{
                        
                        pview.frame =CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, pview.frame.size.width, pview.frame.size.height);
                        
                    }];
                    
                }
                
            }
            
        }];
        
    }
    
    else
    {
        
        picker.dataSource=self;
        picker.delegate=self;
        pview.hidden=NO;
        
        [UIView animateWithDuration:.2f animations:^{
            
            pview.frame =CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, pview.frame.size.width, pview.frame.size.height);
            
        }];
        
        
    }
    
    
    
}

- (IBAction)pickerCancelBtn:(id)sender
{
    [UIView animateWithDuration:.2f animations:^{
        
        pview.frame =CGRectMake(0, self.view.frame.size.height, pview.frame.size.width, pview.frame.size.height);
        
        
    }
     
                     completion:^(BOOL finished) {
                         
                         pview.hidden=YES;
                     }];
    
}

- (IBAction)PickerDoneTap:(id)sender

{
    
    
    cat_id = [catid objectAtIndex:[picker selectedRowInComponent:0]];
    cat_name =[catname objectAtIndex:[picker selectedRowInComponent:0]];
    [categorybtn setTitle:cat_name forState:UIControlStateNormal];
    
    
    NSString *urlstring = [NSString stringWithFormat:@"%@app_product_details_cat?servicename=%@&serviceplae=%@&opendate=%@&enddate=%@&catid=%@&price_low=%@&price_high=%@&cur_id=3",App_Domain_Url,_producrname,_location,_start_date,_end_date,cat_id,amount1.text,amount2.text];
    NSLog(@"str=%@",urlstring);
    
    
    
    NSString *encode = [urlstring  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
         
         //   NSLog(@"result=%@",result);
         if([[result valueForKey:@"response"] isEqualToString:@"success"])
             
         {
             [results removeAllObjects];
             
             NSLog(@"result=%@",[result valueForKey:@"details"]);
             
             for ( NSDictionary *tempDict1 in  [result objectForKey:@"details"])
             {
                 [results addObject:tempDict1];
                 
             }
             
             
             // [ArrSearchList addObjectsFromArray:r ]
             [ArrSearchList removeAllObjects];
             
             NSLog(@"+++++++++++++++++++++%@",ArrSearchList);
             
             [ArrSearchList addObjectsFromArray:results];
             
             _Search_Table.hidden=NO;
             
             [_Search_Table reloadData];
             
             
             [UIView animateWithDuration:.2f animations:^{
                 
                 pview.frame =CGRectMake(0, self.view.frame.size.height, pview.frame.size.width, pview.frame.size.height);
                 
                 
             }
              
                              completion:^(BOOL finished) {
                                  
                                  pview.hidden=YES;
                              }];
             
         }
         
         
         else
         {
             _Search_Table.hidden=YES;
             
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             [alrt show];
             
             
         }
         
         
         
         
     }];
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


- (IBAction)filterBtnTapped:(id)sender
{

    [self.navigationController popViewControllerAnimated:NO];


}


@end
