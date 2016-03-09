//
//  MyBooking & Request.m
//  FreeWilder
//
//  Created by kausik on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "MyBooking & Request.h"

#pragma mark - Footer related imports
#import "FW_JsonClass.h"
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


@interface MyBooking___Request ()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>

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
    FW_JsonClass *globalobj;
    NSUserDefaults *prefs;
    
}

@end

@implementation MyBooking___Request


//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
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
    
    prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    NSLog(@"userid %@",userid);

    
    obj=[[FW_JsonClass alloc]init];
    mainArray =[[NSMutableArray alloc]init];
    
    bookingTableview.hidden=YES;
    
    
    
    
    [self url];
    
    
    

    
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MybookingCell *cell = (MybookingCell *) [bookingTableview dequeueReusableCellWithIdentifier:@"bookingcell"];
    
    [cell.mainImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[mainArray objectAtIndex:indexPath.row] valueForKey:@"service_image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    
    cell.service_name.text =[mainArray[indexPath.row]valueForKey:@"service_name"];
     NSString *str = @"Seller: ";
    NSString *yourString =[str stringByAppendingString:[mainArray[indexPath.row]valueForKey:@"seller_name"]];
    
    
    
    //NSString *yourString = @"Seller: ";
    NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
    NSString *boldString = @"Seller:";
    NSRange boldRange = [yourString rangeOfString:boldString];
    [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange];
    [cell.seller_name setAttributedText: yourAttributedString];
    
    
    
    
    cell.price.text = [@"Price : " stringByAppendingString:[mainArray [indexPath.row]valueForKey:@"price"]];
    cell.quantity.text =[@"Quantity : " stringByAppendingString:[mainArray [indexPath.row]valueForKey:@"quantity"]];
    
  NSString *oderdate=  [mainArray[indexPath.row]valueForKey:@"booking_date"];
    
    NSArray *holedatetime=[oderdate componentsSeparatedByString:@" "];
    NSString *date1=[holedatetime objectAtIndex:0];
    NSString *time=[holedatetime objectAtIndex:1];
    
    NSArray *finaltime=[time componentsSeparatedByString:@":"];
    NSString *currenttime=[NSString stringWithFormat:@"%@:%@",[finaltime objectAtIndex:0],[finaltime objectAtIndex:1]];
    
   
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSDate *date = [dateFormatter dateFromString:currenttime];
    
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *pmamDateString = [dateFormatter stringFromDate:date];
   
    

    
    
    cell.booking_date.text =[NSString stringWithFormat:@"%@   %@",date1,pmamDateString];
    
    if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"C"])
    {
        
        NSString *yourString = @"Status: Confirmed";
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = @"Status:";
        NSRange boldRange = [yourString rangeOfString:boldString];
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange];
        [cell.status setAttributedText: yourAttributedString];
        
       
    }
    
    else if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"CM"])
    {
       
        NSString *yourString = @"Status: Completed";
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = @"Status:";
        NSRange boldRange = [yourString rangeOfString:boldString];
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange];
        [cell.status setAttributedText: yourAttributedString];
        
      
    }
    
    else
    {
        NSString *yourString = @"Status: Pending";
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = @"Status:";
        NSRange boldRange = [yourString rangeOfString:boldString];
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange];
        [cell.status setAttributedText: yourAttributedString];
        
        

    }
    
    if ([[mainArray[indexPath.row]valueForKey:@"payment_status"] isEqualToString:@"Y"])
    {
        //cell.payment_status.text = @"Payment: Done";
        
        NSString *yourString = @"Payment: Done";
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = @"Payment:";
        NSRange boldRange = [yourString rangeOfString:boldString];
        
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange];
        
        [cell.payment_status setAttributedText: yourAttributedString];
   

    }
    else
    {
        //cell.payment_status.text = @"Payment: Pending";
        
        NSString *yourString = @"Payment: Pending";
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = @"Payment:";
        NSRange boldRange = [yourString rangeOfString:boldString];
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange];
        [cell.payment_status setAttributedText: yourAttributedString];
        
    }

    
    cell.subViewContainer.layer.shadowOffset=CGSizeMake(0, 1);
    cell.subViewContainer.layer.shadowRadius=3.5;
    cell.subViewContainer.layer.shadowColor=[UIColor blackColor].CGColor;
    cell.subViewContainer.layer.shadowOpacity=0.4;
    cell.subViewContainer.clipsToBounds=NO;
    
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"C"] && [[mainArray[indexPath.row]valueForKey:@"payment_status"] isEqualToString:@"Y"])
    {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
        
    {
        
        
        
        //add code here for when you hit delete
        
    }
    }
  else  if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"CM"])
    {
        
        
        if (editingStyle == UITableViewCellEditingStyleDelete)
            
        {
            
            
            
            //add code here for when you hit delete
            
        }
    }
    
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"C"] && [[mainArray[indexPath.row]valueForKey:@"payment_status"] isEqualToString:@"Y"])
    {
    
    return UITableViewCellEditingStyleDelete;
    }
     else  if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"CM"])
     {
         return UITableViewCellEditingStyleDelete;
     }
    
    return nil;
    
}


- (NSArray *)tableView:(UITableView *)tableView

editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
     if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"C"] && [[mainArray[indexPath.row]valueForKey:@"payment_status"] isEqualToString:@"Y"])
     {
       
         UITableViewRowAction *button;
         
         
         button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Add Review" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                   
                   {
                       
                       NSLog(@"remove action");
                       
                   }];
         
         button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
         
          return @[button];
    }
    
    
    else  if ([[mainArray[indexPath.row]valueForKey:@"status"] isEqualToString:@"CM"])
    {
        
        
        UITableViewRowAction *button;
        
        button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"View Review" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                  
                  {
                      
                      NSLog(@"remove action");
                      
                  }];
        
        button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
        
        return @[button];
        
    }
    
    
    
    return nil;
   
    
}




-(void)url
{
    UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    
    
    
    userid=[prefs valueForKey:@"UserId"];
    NSString *curr_id;
    curr_id=[prefs valueForKey:@"curr_id"];
    
    NSString *url = [NSString stringWithFormat:@"%@app_my_booking_det?userid=%@&cur_id=%@",App_Domain_Url,userid,curr_id];
    NSLog(@"%@",url);
    
    [spinner startAnimating];
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
        {

        mainArray = [[result valueForKey:@"infoarray" ] mutableCopy];
        
            
        [bookingTableview reloadData];
            bookingTableview.hidden=NO;
        }
        
        [spinner stopAnimating];
        [polygonView removeFromSuperview];
        
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

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}

- (IBAction)BackTap:(id)sender
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

@end
