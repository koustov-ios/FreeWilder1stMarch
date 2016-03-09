//
//  BusinessProfileViewController.m
//  FreeWilder
//
//  Created by kausik on 30/09/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "BusinessProfileViewController.h"

#import "UIImageView+WebCache.h"
#import "BusinessReviewDetails.h"
#import "Footer.h"
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
#import "ServiceView.h"
#import "accountsubview.h"
#import "myfavouriteViewController.h"
#import "DashboardViewController.h"
#import "LanguageViewController.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "ImageResize.h"
#import "Videos_ViewController.h"
#import "YTPlayerView.h"
#import "sideMenu.h"



@interface BusinessProfileViewController ()<footerdelegate,Serviceview_delegate,Slide_menu_delegate,Profile_delegate,accountsubviewdelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,MKMapViewDelegate,MKAnnotation,sideMenu
>
{
     IBOutlet UILabel *headerLbl;
    
    sideMenu *leftMenu;
    
    
    NSMutableDictionary *busniness_desc,*infoarray,*user_description;
    
    AppDelegate *appDelegate;
    
    NSMutableArray *prof_images,*service_details,*reviews_about_me,*reviews_from_seller,*verified_id;
    
    NSArray *language,*schools;
    
    IBOutlet UIView *contentview;
    
    NSString *phoneno;
    
    
    NSString *video_url;
   
    
    CGRect contntViewframe , busnissfrm, scholviewfrm;
    BOOL Day ,schol;
    
   
    
    IBOutlet UIView *businessView;
    
    UIView *verifyby, *busneshoursinfo ,*schoolview;
    
    
    
    UIView *imageDetailView;
    UIImageView * img1;
    UIButton *imageclearbtn;
    UIScrollView *imgscroll;
    UIView *overlay;
    
    BOOL tapchk,tapchk1,tapchk2,verifybtnbool,busnissbool,scholbool;
    
    UITextField *phoneText;
    
    NSString *userid;
    UILabel *schoollbl;
    
    
    NSMutableArray *jsonArray ,*tempArray1,*business_hours;
    
    CGRect ReviewFrm;
    
    ServiceView *service;
    profile *profileview;
    accountsubview *subview;
    UIView *popview ,*blackview;
    Side_menu *sidemenu;
    
    IBOutlet UIImageView *lineImage;
    
    UIImagePickerController *imagePicker;
    
    UIImage *img;
    
    
    IBOutlet UILabel *verified_by;
    
    IBOutlet UILabel *value ,*placeholder;
    
     UILabel *verified_by1,*value1;
    UILabel *business_Hours_lbl, *breaktime_lbl;
    
    
    IBOutlet UIView *ReviewView;
    UITextField *Subject;
    
    BOOL Dropdwn;
    
    
    
    MKMapView *userMap;
    
    UITextView *othertxt;
    NSString *busness_id;
    
    NSData* pictureData;
    
}

@end

@implementation BusinessProfileViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[UIScreen mainScreen] bounds
         ].size.height == 667  && [[UIScreen mainScreen] bounds
                                   ].size.width == 375)
    {
        
        headerLbl.frame=CGRectMake(118, 32, 136, 22);
    }
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here

    
    
    
    globalobj = [[FW_JsonClass alloc]init];
    Day=YES;
    scholbool=YES;
    verifybtnbool=YES;
    busnissbool=YES;
    Dropdwn=YES;
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    footer.greenline.hidden=YES;
    
    [footer_base addSubview:footer];
    
    
    imagePicker = [[UIImagePickerController alloc]init];
    contntViewframe=contentview.frame;
    busnissfrm = businessView.frame;
   
    ReviewFrm = ReviewView.frame;
    
    
   // _Scroll.frame =CGRectMake(0, topbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-topbar.frame.size.height-footer_base.frame.size.height);
     _Scroll.contentSize=CGSizeMake(0, 952);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
    userid=[prefs valueForKey:@"UserId"];
    
    profileImage.layer.cornerRadius = profileImage.frame.size.height/2;
    profileImage.clipsToBounds=YES;
    reviews_about_me = [[NSMutableArray alloc]init];
    
    
    NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_user_business_det?bus_user_id=%@",App_Domain_Url,_BusnessUserId];
    
    
    NSLog(@"url------------%@",url);
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        infoarray = [result valueForKey:@"infoarray"];
        
       
        
       
        
        verified_id = [infoarray valueForKey:@"verified_id"];
        
        busniness_desc = [infoarray valueForKey:@"busniness_desc"];
        
        service_details = [infoarray valueForKey:@"service_details"];
      
     
      
       
        
        business_hours =[infoarray valueForKey:@"business_hours_android"];
        
        
        
        
       


        
        

        

       
        
        
        
        
        
    
        
        
        
        reviews_about_me = [infoarray valueForKey:@"reviews_about_me"];
        reviews_from_seller = [infoarray valueForKey:@"reviews_from_seller"];
        
        
        
      //  NSLog(@",(unsigned long)reviews_about_me.count);
        
        user_description = [infoarray valueForKey:@"user_description"];
        
        busness_id = [busniness_desc valueForKey:@"bus_user_id"];
        
      NSString  *schoolsstr = [user_description valueForKey:@"school_android"];
        
         NSString   *languagestr = [user_description valueForKey:@"lang_android"];
        
        video_url=[user_description valueForKey:@"video_url"];
        
        
        if (schoolsstr.length>0)
        {
            schools = [schoolsstr componentsSeparatedByString:@","];
        }
        
        
        
       
        
        
        
               
                
                
                
                
                
        
        
        
        
       // phoneNumberlbl.text =[NSString stringWithFormat:@"%@", [verified_id valueForKey:@"phone_no"]];
     //   reviewLbl.text = [NSString stringWithFormat:@"%@",[verified_id valueForKey:@"num_of_reviews"]];
        
        
        
        prof_images = [busniness_desc valueForKey:@"prof_images"];
        
        
        if (prof_images.count>0)
        {
             [profileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[prof_images objectAtIndex:0] valueForKey:@"link"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
        }
        
        
        
        namelbl.text = [busniness_desc valueForKey:@"business_name"];
        
        worklbl.text = [user_description valueForKey:@"work"];
        
     
        
        descriptionTextview.text = [NSString stringWithFormat:@"%@",[busniness_desc valueForKey:@"business_desc"]];
        
        busnessname.text = [NSString stringWithFormat:@"Business Name %@",[busniness_desc valueForKey:@"business_name"]];
        
        
        languagelbl.text = [NSString stringWithFormat:@"%@",languagestr];
        
        
        
        
        
        
        
        
        
    }];
    
    
    
    
   
  //  NSLog(@"busniid======%@",_BusnessUserId);
    
    // Do any additional setup after loading the view.
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

- (IBAction)BackTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ServiceBtnTap:(id)sender
{
    if (service_details.count==0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Service Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alrt show];
    }
    
    else
    {
    
    BusinessReviewDetails *object=[self.storyboard instantiateViewControllerWithIdentifier:@"BusinessReview"];
    
    
    object.service =@"Service" ;
    
    object.serviceArray=service_details;
    
    [self.navigationController pushViewController:object animated:YES];
    
    }
    
    
    
}

- (IBAction)ReviewBtnTap:(id)sender
{
    if (reviews_from_seller.count==0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Review For you" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alrt show];
    }
    else
    {
        
        
        BusinessReviewDetails *object=[self.storyboard instantiateViewControllerWithIdentifier:@"BusinessReview"];
        
        
        object.service =@"Reviews From Seller" ;
        
        object.reviews_from_seller=reviews_from_seller;
        
        [self.navigationController pushViewController:object animated:YES];
    }
    
    
}

- (IBAction)ReviewAboutMeTap:(id)sender
{
    
    if (reviews_about_me.count ==0)
    {
         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Review For you" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alrt show];
    }
    
    else
    {
        
    
    BusinessReviewDetails *object=[self.storyboard instantiateViewControllerWithIdentifier:@"BusinessReview"];
    
    
    object.service =@"Reviews About Me" ;
    
    object.ReviewMe=reviews_about_me;
    
    [self.navigationController pushViewController:object animated:YES];
    }
    
}

- (IBAction)ReviewDropDown:(id)sender

{
    
    
    
    
}

- (IBAction)BusinessHours:(id)sender
{
    
    
    
    
    
    
    if(scholbool==NO)
    {
        
        
        
        [UIView animateWithDuration:.2f animations:^{
            
            schoolview.frame = CGRectMake(0, pview.frame.origin.y+pview.frame.size.height,self.view.frame.size.width, 0) ;
            
            languageWorkview.frame=CGRectMake(0, schoolview.frame.origin.y+schoolview.frame.size.height+2, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
            
            
            businessView.frame=CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
            
            
            contentview.frame=CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height, contentview.frame.size.width, contentview.frame.size.height);
            
            _Scroll.contentSize = CGSizeMake(0, 952+schoolview.frame.size.height);
            
            
            [schoolview removeFromSuperview];
            
            
        }];
        
        scholbool=YES;
        
        
    }

    
    
    
    
   
    if (verifybtnbool==NO)
    {
        [UIView animateWithDuration:.2f animations:^{
            
            
            verifyby.frame = CGRectMake(0, verifibtn.frame.origin.y+verifibtn.frame.size.height, self.view.frame.size.width,0);
            
            
            
            
            
            
            
            
            
            pview.frame =CGRectMake(0, verifyby.frame.origin.y+verifyby.frame.size.height+2, pview.frame.size.width, pview.frame.size.height);
            
            languageWorkview.frame =CGRectMake(0, pview.frame.origin.y+pview.frame.size.height, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
            
            
            businessView.frame =CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
            
            contentview.frame =CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height+1, contentview.frame.size.width, contentview.frame.size.height);
            
            
            _Scroll.contentSize =CGSizeMake(0, 952+verifyby.frame.size.height);
            
            [verifyby removeFromSuperview];
            
        }];
        
        
        verifybtnbool=YES;
    }
    
   

    
    
    if (business_hours.count>0)
    {
        
   
    
    
    
    if (busnissbool==YES)
    {
        
       
        
        busneshoursinfo = [[UIView alloc]init];
        
        
        busneshoursinfo.frame = CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height , self.view.frame.size.width,80);
        
        UILabel *worktime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2+25, 40)];
        UILabel *breaktime =[[UILabel alloc]initWithFrame:CGRectMake(worktime.frame.size.width+worktime.frame.origin.x, 0, self.view.frame.size.width-worktime.frame.size.width, 40)];
        
        
        worktime.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:.5];
        breaktime.backgroundColor =[UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:.5];
        
        
        worktime.text=@"Work Time";
        breaktime.text =@"Break Time";
        
        [worktime setFont:[UIFont fontWithName:@"Lato" size:15]];
        [breaktime setFont:[UIFont fontWithName:@"Lato" size:15]];
        
        worktime.textAlignment=NSTextAlignmentCenter;
        breaktime.textAlignment=NSTextAlignmentCenter;
        
        
        [busneshoursinfo addSubview:worktime];
        [busneshoursinfo addSubview:breaktime];
        
       // busneshoursinfo.frame = CGRectMake(0,contentview.frame.origin.y, 0,0);
           
        
        
       // NSLog(@"uyuuuuu8888----%f",contentview.frame.origin.y);
        
        
        NSInteger y=worktime.frame.size.height;
        
        for (int i=0; i<business_hours.count; i++)
        {
            
            
            business_Hours_lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width/2+25, 50)];
            
            breaktime_lbl = [[UILabel alloc]initWithFrame:CGRectMake(business_Hours_lbl.frame.origin.x+business_Hours_lbl.frame.size.width, business_Hours_lbl.frame.origin.y, self.view.frame.size.width/2-30, 50)];
            
            
            busneshoursinfo.frame = CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height , self.view.frame.size.width, worktime.frame.size.height+business_Hours_lbl.frame.size.height*business_hours.count);
            
            
            
            
//            business_Hours_lbl.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1];
           // breaktime_lbl.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1];
            
            
            business_Hours_lbl.text = [NSString stringWithFormat:@"    %@  %@",[business_hours[i]valueForKey:@"day"],[business_hours[i]valueForKey:@"time"]];
            
            breaktime_lbl.text =[NSString stringWithFormat:@"%@",[business_hours[i]valueForKey:@"break_time"]];
            
            
            breaktime_lbl.textAlignment=NSTextAlignmentCenter;
            
            [business_Hours_lbl setFont:[UIFont fontWithName:@"Lato" size:15]];
            [breaktime_lbl setFont:[UIFont fontWithName:@"Lato" size:15]];
            
            
            
            [busneshoursinfo addSubview:business_Hours_lbl];
            [busneshoursinfo addSubview:breaktime_lbl];
            
            
            [_Scroll addSubview:busneshoursinfo];
            
            
            y=breaktime_lbl.frame.size.height+breaktime_lbl.frame.origin.y+2;
            
            
        }
        
        
        contentview.frame =CGRectMake(0,busneshoursinfo.frame.origin.y + busneshoursinfo.frame.size.height+2, contentview.frame.size.width, contentview.frame.size.height);
        
        
        _Scroll.contentSize =CGSizeMake(0,952+verifyby.frame.size.height+ busneshoursinfo.frame.size.height+2);
        
       
        
        busnissbool=NO;
        
    }
    
    
    else
    {
        [UIView animateWithDuration:.2f animations:^{
           
             busneshoursinfo.frame = CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height, self.view.frame.size.width, 0);
            
            
            contentview.frame =CGRectMake(0,busneshoursinfo.frame.origin.y + busneshoursinfo.frame.size.height+1, contentview.frame.size.width, contentview.frame.size.height);
            
            
            _Scroll.contentSize =CGSizeMake(0,952+verifyby.frame.size.height+ busneshoursinfo.frame.size.height);
            
            [busneshoursinfo removeFromSuperview];
        }];
        
        
        busnissbool=YES;
    }
    
    
    }
    
    
    
    
    
}

- (IBAction)ProfileImageTap:(id)sender
{
    
    
    imageDetailView = [[UIView alloc]init];
    imageDetailView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    imageDetailView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    
    
    UIButton *imageCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 10, 100, 100)];
    imageCloseBtn.backgroundColor = [UIColor clearColor];
    [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    [imageCloseBtn addTarget:self action:@selector(closeTapped) forControlEvents:UIControlEventTouchUpInside];
    // [imageCloseBtn setBackgroundColor:[UIColor redColor]];
    
    
    
    
    
    imgscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * .2, self.view.frame.size.width, self.view.frame.size.height * .6)];
    [imgscroll setContentSize:CGSizeMake(self.view.frame.size.width * [prof_images count], imgscroll.frame.size.height)];
    // [imgscroll setBackgroundColor:[UIColor greenColor]];
    imgscroll.showsHorizontalScrollIndicator = NO;
    imgscroll.pagingEnabled = YES;
    
    
    
    
    
    
    //  [imgscroll setContentOffset:CGPointMake(  self.view.frame.size.width, 0) animated:NO];
    
    int i;
    float x = 5;
    int width = 0;
    for (i = 0; i<[prof_images count]; i++)
    {
        
      
        
        
        img1 = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, imgscroll.frame.size.width - 10, imgscroll.frame.size.height-imageCloseBtn.frame.size.height+30)];
        
        
        
        
        
        img1.contentMode = UIViewContentModeScaleAspectFit;
        
        [img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prof_images [i] valueForKey:@"link"] ]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        x = x + self.view.frame.size.width;
        
        
        
        
        
        
      
     
        
        // [imgscroll setContentOffset:CGPointMake( self.view.frame.size.width, 0) animated:NO];
        
          [imgscroll addSubview:img1];
        
        width = width + self.view.frame.size.width;
        
        
    
    
}
    
    
    
    [imageDetailView addSubview:imageCloseBtn];
    [imageDetailView addSubview:imgscroll];
    [self.view addSubview:imageDetailView];
    
}

- (IBAction)SchoolTap:(id)sender
{
  
    
    
    if (busnissbool==NO)
    {
        [UIView animateWithDuration:.2f animations:^{
            
            busneshoursinfo.frame = CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height, self.view.frame.size.width, 0);
            
            
            contentview.frame =CGRectMake(0,busneshoursinfo.frame.origin.y + busneshoursinfo.frame.size.height+2, contentview.frame.size.width, contentview.frame.size.height);
            
            
            _Scroll.contentSize =CGSizeMake(0,952+verifyby.frame.size.height+ busneshoursinfo.frame.size.height);
            
            [busneshoursinfo removeFromSuperview];
        }];
        
        
        busnissbool=YES;
    }

    
    
    
    if (verifybtnbool==NO)
    {
        [UIView animateWithDuration:.2f animations:^{
            
            
            verifyby.frame = CGRectMake(0, verifibtn.frame.origin.y+verifibtn.frame.size.height, self.view.frame.size.width,0);
            
            
            
            
            
            
            
            
            
            pview.frame =CGRectMake(0, verifyby.frame.origin.y+verifyby.frame.size.height+1, pview.frame.size.width, pview.frame.size.height);
            
            languageWorkview.frame =CGRectMake(0, pview.frame.origin.y+pview.frame.size.height, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
            
            
            businessView.frame =CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
            
            contentview.frame =CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height+1, contentview.frame.size.width, contentview.frame.size.height);
            
            
            _Scroll.contentSize =CGSizeMake(0, 952+verifyby.frame.size.height);
            
            [verifyby removeFromSuperview];
            
        }];
        
        
        verifybtnbool=YES;
    }
    
    

    
    if (schools.count>0)
    {
        
  
    
    
    if (scholbool==YES)
    {
        schoolview = [[UIView alloc]init];
        
        NSLog(@"-----%lu",(unsigned long)schools.count);
        
        NSInteger y=0;
        
        for (int i=0; i<schools.count; i++)
        {
            
            
            schoollbl =[[UILabel alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 50)];
            
            schoolview.frame = CGRectMake(0, pview.frame.origin.y+pview.frame.size.height,self.view.frame.size.width, schoollbl.frame.size.height*schools.count) ;
            
            
            
            schoollbl.text = [NSString stringWithFormat:@"       %@",schools[i]];
            
            
            [schoollbl setFont:[UIFont fontWithName:@"Lato" size:15]];
            
            
            
            [schoolview addSubview:schoollbl];
            
            [_Scroll addSubview:schoolview];
            
            
            
            y=schoollbl.frame.size.height+y;
            
            
            
        }
        
        
        languageWorkview.frame=CGRectMake(0, schoolview.frame.origin.y+schoolview.frame.size.height+2, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
        
        
        businessView.frame=CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
        
        
        contentview.frame=CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height+1, contentview.frame.size.width, contentview.frame.size.height);
        
        _Scroll.contentSize = CGSizeMake(0, 952+schoolview.frame.size.height);
        
        
        scholbool=NO;
    }
   
    
    else
    {
       
        
        
        [UIView animateWithDuration:.2f animations:^{
            
             schoolview.frame = CGRectMake(0, pview.frame.origin.y+pview.frame.size.height,self.view.frame.size.width, 0) ;
            
            languageWorkview.frame=CGRectMake(0, schoolview.frame.origin.y+schoolview.frame.size.height-1, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
            
            
            businessView.frame=CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
            
            
            contentview.frame=CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height+1, contentview.frame.size.width, contentview.frame.size.height);
            
            _Scroll.contentSize = CGSizeMake(0, 952+schoolview.frame.size.height);
            
            
            [schoolview removeFromSuperview];
            
            
        }];
        
        scholbool=YES;
        
       
    }
    
    }
    
    
}

- (IBAction)LocationTap:(id)sender
{
    
    
    blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    blackview.alpha=.01f;
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap1)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [blackview addGestureRecognizer:tapGestureRecognize];
    
    
    
    
    
    
    
    popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5)];
    
    
    
    UIImageView *close = [[UIImageView alloc]initWithFrame:CGRectMake(popview.frame.size.width-30, -35,30, 30)];
    
    close.image=[UIImage  imageNamed:@"Cancel"];
    
    
    [popview addSubview:close];
    
    
    
    
    
    
    userMap = [[MKMapView alloc]initWithFrame:CGRectMake(0,0,popview.frame.size.width ,popview.frame.size.height)];
    userMap.delegate=self;
  
   // userMap.backgroundColor = [UIColor blueColor];
    
    userMap.layer.cornerRadius= 5;
    [popview addSubview:userMap];
    
    
    
    
    
    
    popview.backgroundColor=[UIColor whiteColor];
    
    popview.layer.cornerRadius = 10;
    [self.view addSubview:blackview];
    
    [self.view addSubview:popview];
    
    [UIView animateWithDuration:.3 animations:^{
        
        
        
        popview.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
        
        blackview.alpha=1;
        
        
    }];
    
    
    
    
    
    
}

- (IBAction)AskQueTap:(id)sender
{
    
    
    
    blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    blackview.alpha=.01f;
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap1)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [blackview addGestureRecognizer:tapGestureRecognize];
    
    
    
    
    
    
    
    popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5)];
    
    
    
    
    
   
    
    
    UIImageView *close = [[UIImageView alloc]initWithFrame:CGRectMake(popview.frame.size.width-30, -35,30, 30)];
    
    close.image=[UIImage  imageNamed:@"Cancel"];
    
    
    [popview addSubview:close];
    
    
    
    
   
    
    Subject = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, popview.frame.size.width-20, popview.frame.size.height * .1)];
    
    
    Subject.backgroundColor =[UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
    
     Subject.layer.cornerRadius= 5;
    
    Subject.delegate=self;
    
    Subject.placeholder =@"Subject";
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    Subject.leftView = paddingView;
    
    Subject.leftViewMode = UITextFieldViewModeAlways;
    
    
    [Subject setFont:[UIFont fontWithName:@"Lato" size:14]];
    
    
    
    othertxt = [[UITextView alloc]initWithFrame:CGRectMake(10,Subject.frame.origin.y+Subject.frame.size.height+10,popview.frame.size.width-20,popview.frame.size.height * .5)];
    othertxt.delegate=self;
    [othertxt setFont:[UIFont fontWithName:@"Lato" size:14]];
    othertxt.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
    othertxt.layer.cornerRadius= 5;
    [popview addSubview:othertxt];
    
    placeholder =[[UILabel alloc]initWithFrame:CGRectMake(othertxt.frame.size.width/2-60,Subject.frame.origin.y+Subject.frame.size.height+10,popview.frame.size.width-20,popview.frame.size.height * .5)];
   
    
    placeholder.textColor = [UIColor lightGrayColor];
    [placeholder setFont:[UIFont fontWithName:@"Lato" size:14]];
    
    placeholder.text =@"Enter Your Message ";
   
    [popview addSubview:Subject];
    [popview addSubview:placeholder];
    
    
    UIButton *uploadbutton  = [[UIButton alloc]initWithFrame:CGRectMake(10, othertxt.frame.origin.y+othertxt.frame.size.height+10, popview.frame.size.width-20,popview.frame.size.height * .1)];
    
    
    [uploadbutton addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    [uploadbutton setTitle:@"Upload" forState:UIControlStateNormal];
    
    uploadbutton.layer.cornerRadius=5.0f;
    
    
    uploadbutton.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
    
    
    UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+35,uploadbutton.frame.size.height+uploadbutton.frame.origin.y+15 , popview.frame.size.width-70, 35)];
    submit.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
    
    [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    
    submit.layer.cornerRadius =5;
    [popview addSubview:submit];
    
    [popview addSubview:uploadbutton];
    popview.backgroundColor=[UIColor whiteColor];
    
    popview.layer.cornerRadius = 10;
    [self.view addSubview:blackview];
    
    [self.view addSubview:popview];
    
    [UIView animateWithDuration:.3 animations:^{
        
        
        
        
        
        popview.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
        
        blackview.alpha=1;
        
        
    }];

    
    
}

- (IBAction)verifid:(id)sender
{
  
    
    
    
    
    if(scholbool==NO)
    {
        
        
        
        [UIView animateWithDuration:.2f animations:^{
            
            schoolview.frame = CGRectMake(0, pview.frame.origin.y+pview.frame.size.height,self.view.frame.size.width, 0) ;
            
            languageWorkview.frame=CGRectMake(0, schoolview.frame.origin.y+schoolview.frame.size.height-1, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
            
            
            businessView.frame=CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
            
            
            contentview.frame=CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height, contentview.frame.size.width, contentview.frame.size.height);
            
            _Scroll.contentSize = CGSizeMake(0, 952+schoolview.frame.size.height);
            
            
            [schoolview removeFromSuperview];
            
            
        }];
        
        scholbool=YES;
        
        
    }

    
    
    
    
    
    if (busnissbool==NO)
    {
        [UIView animateWithDuration:.2f animations:^{
            
            busneshoursinfo.frame = CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height, self.view.frame.size.width, 0);
            
            
            contentview.frame =CGRectMake(0,busneshoursinfo.frame.origin.y + busneshoursinfo.frame.size.height+2, contentview.frame.size.width, contentview.frame.size.height);
            
            
            _Scroll.contentSize =CGSizeMake(0,952+verifyby.frame.size.height+ busneshoursinfo.frame.size.height);
            
            [busneshoursinfo removeFromSuperview];
        }];
        
        
        busnissbool=YES;
    }

    
    
    if (verified_id.count>0)
    {
        
       
    
    if (verifybtnbool==YES)
    {
       
        
        verifyby = [[UIView alloc]init];
        
        
        verifyby.frame = CGRectMake(0, verifibtn.frame.origin.y+verifibtn.frame.size.height, self.view.frame.size.width,0);
        
        
        
        
        
        
        NSInteger y = 0;
        
        for (int i=0; i<verified_id.count; i++)
        {
            
            
            
            
            
            verified_by1 = [[UILabel alloc]initWithFrame:CGRectMake(0, y+2, self.view.frame.size.width-200, 50)];
            
            value1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-140, verified_by1.frame.origin.y, 130, verified_by1.frame.size.height)];
            
            //value1.backgroundColor = [UIColor grayColor];
            
            verifyby.frame = CGRectMake(0, verifibtn.frame.origin.y+verifibtn.frame.size.height, self.view.frame.size.width,verified_by1.frame.size.height * verified_id.count);
            
            
            [verified_by1 setFont:[UIFont fontWithName:@"Lato" size:15]];
            
            
            
            verified_by1.text = [NSString stringWithFormat:@"       %@",[verified_id [i] valueForKey:@"verified_by"]];
            
            
            
            
            value1.text = [NSString stringWithFormat:@"%@",[verified_id [i] valueForKey:@"value"]];
            
            value1.textAlignment =NSTextAlignmentRight;
            
            //  ReviewView.frame =CGRectMake(0,ReviewView.frame.origin.y , self.view.frame.size.width, ReviewView.frame.size.height+verified_by2.frame.size.height);
            
            
            // _Scroll.contentSize = CGSizeMake(0, 1190+verified_by2.frame.size.height*[verified_id count]+10);
            
            
            [verifyby addSubview:verified_by1];
            [verifyby addSubview:value1];
            
            
            
            
            
            
            
            [_Scroll addSubview:verifyby];
            
            
            
            
            y=verified_by1.frame.origin.y+verified_by1.frame.size.height;
            
            
        }
        
        
        
        [ UIView animateWithDuration:.2f animations:^{
            
            
            pview.frame =CGRectMake(0, verifyby.frame.origin.y+verifyby.frame.size.height+5, pview.frame.size.width, pview.frame.size.height);
            
            languageWorkview.frame =CGRectMake(0, pview.frame.origin.y+pview.frame.size.height, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
            
            
            businessView.frame =CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
            
            contentview.frame =CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height+1, contentview.frame.size.width, contentview.frame.size.height);
            
            
            _Scroll.contentSize =CGSizeMake(0, 952+verifyby.frame.size.height);
            
            
        }];
        
        
        verifybtnbool=NO;
        
    }
    
    
    
    
    else
    {
        [UIView animateWithDuration:.2f animations:^{
            
            
            verifyby.frame = CGRectMake(0, verifibtn.frame.origin.y+verifibtn.frame.size.height, self.view.frame.size.width,0);
            
            
        
         
             
             
             
             
             
             pview.frame =CGRectMake(0, verifyby.frame.origin.y+verifyby.frame.size.height+1, pview.frame.size.width, pview.frame.size.height);
             
             languageWorkview.frame =CGRectMake(0, pview.frame.origin.y+pview.frame.size.height, languageWorkview.frame.size.width, languageWorkview.frame.size.height);
             
             
             businessView.frame =CGRectMake(0, languageWorkview.frame.origin.y+languageWorkview.frame.size.height, businessView.frame.size.width, businessView.frame.size.height);
             
             contentview.frame =CGRectMake(0, businessView.frame.origin.y+businessView.frame.size.height+1, contentview.frame.size.width, contentview.frame.size.height);
             
             
             _Scroll.contentSize =CGSizeMake(0, 952+verifyby.frame.size.height);
             
             [verifyby removeFromSuperview];
             
         }];
        
        
        verifybtnbool=YES;
        
    }
    
    }
    
    
}

- (IBAction)VideoTap:(id)sender
{
   
    
    
  
    if (video_url.length>0)
    {
        
        
        Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"video"];
        
        
        obj.videoCode=video_url;
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
    }
    
    
    
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"NO Video Found" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        
        [alrt show];
    }
    
    
      
    
    
    
    
    
    
    
    
}







-(void)submit
{
   
    if (Subject.text.length==0)
    {
        Subject.placeholder = @"    Plesae Enter Subject";
    }
    
    
    else if (othertxt.text.length==0)
    {
         placeholder.text =@"Please Enter Your Message ";
    }
    
    else
    {
        
        NSString *url = [NSString stringWithFormat:@"%@app_bus_askaquestion?userid=%@&bus_userid=%@&ask_sub=%@&ask_msg=%@",App_Domain_Url,userid,busness_id,Subject.text,othertxt.text];
        
        
        NSString *encode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSLog(@"url %@\n%@",url,encode);
        
        [othertxt resignFirstResponder];
        [Subject resignFirstResponder];
        
        
        [globalobj GlobalDict_image1:encode Globalstr_image:@"array" globalimage:pictureData Withblock:^(id result, NSError *error) {
           
            
            if ([[result valueForKey:@"response"] isEqualToString:@"success"])
            {
                [UIView animateWithDuration:.2f animations:^{
                    
                    
                    
                    popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5);
                    
                    blackview.alpha =.01f;
                    
                    
                    
                    
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"success" message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    
                    
                    [alrt show];
                    
                }];

               
            }
            
            else
            {
                NSLog( @"result-->%@",result);
            }
            
            
            
            
        }];
        
        
        
        
    }
    
    
}
-(void)upload
{
    
    
    
  
   
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    
    [popup showInView:self.view];
    
    [Subject resignFirstResponder];
    [othertxt resignFirstResponder];
    
    
    
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    img = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
    
    pictureData = UIImagePNGRepresentation(img);
    
    
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}



- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    
    
    
    
    
    
    if (buttonIndex==0)
    {
        imagePicker.delegate=self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    else if(buttonIndex==1)
    {
        imagePicker.delegate=self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
    }
}



-(void)cancelByTap1
{
    
    [UIView animateWithDuration:.3f animations:^{
        
        [self applyMapViewMemoryHotFix];
        popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5);
        
        blackview.alpha =.01f;
        
    }
    completion:^(BOOL finished) {
        
        switch (userMap.mapType) {
            case MKMapTypeHybrid:
            {
                userMap.mapType = MKMapTypeStandard;
                
                
                
            }
                
                break;
            case MKMapTypeStandard:
            {
                userMap.mapType = MKMapTypeHybrid;
                
            }
                
                break;
            default:
                break;
        }
        
        userMap=Nil;

        [userMap removeFromSuperview];
        [popview removeFromSuperview];
        
        [blackview removeFromSuperview];
       
        
        
    }];
    
}





-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    [self applyMapViewMemoryHotFix];
}


- (void)applyMapViewMemoryHotFix{
    
    switch (userMap.mapType) {
        case MKMapTypeHybrid:
        {
            userMap.mapType = MKMapTypeStandard;
            
            
            
        }
            
            break;
        case MKMapTypeStandard:
        {
            userMap.mapType = MKMapTypeHybrid;
            
        }
            
            break;
        default:
            break;
    }
    
    
    userMap.mapType = MKMapTypeStandard;
    
    
    
}



-(void)closeTapped
{
    [imageDetailView removeFromSuperview];
}




//-(void)Slide_menu_off
//
//{
//    
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//
//    [UIView animateWithDuration:.4 animations:^{
//        
//        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
//        
//        
//        
//        profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//        
//        
//        
//        
//        
//        if(screenBounds.size.width == 320)
//            
//        {
//            
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
//            
//            
//            
//        }
//        
//        else if(screenBounds.size.width == 375)
//            
//        {
//            
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
//            
//        }
//        
//        else
//            
//        {
//            
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
//            
//        }
//        
//    }
//     
//                     completion:^(BOOL finished)
//     
//     {
//         
//         
//         
//         [subview removeFromSuperview];
//         
//         [profileview removeFromSuperview];
//         
//         
//         
//         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
//          
//                             options:1 animations:^{
//                                 
//                                 
//                                 leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//                                 
//                                 
//                                 
//                             }
//          
//          
//                          completion:^(BOOL finished)
//          
//          
//          
//          {
//              
//              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//              
//              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//              
//              [service removeFromSuperview];
//              
//              [sidemenu removeFromSuperview];
//              
//              [overlay removeFromSuperview];
//              
//              
//              
//              //  overlay.userInteractionEnabled=NO;
//              
//              
//              
//              
//              
//          }];
//         
///
//     }];
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
                 
                 
                 
                 FW_InviteFriendViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
                 
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
        
        
        if (textField==Subject)
        {
          
            
            
            [UIView animateWithDuration:.3 animations:^{
                
                popview.frame =CGRectMake(10, 90, self.view.frame.size.width-20, self.view.frame.size.height * .5);
                
                
           
                
                
            }];
        }
        
        
        
        
        
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
    
    if (textField==Subject)
    {
        [UIView animateWithDuration:.3f animations:^{
            
            
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
            
            
            
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

-(void)SubmenuPushViewcontroller:(UIViewController *)viewcontroller withAnimation:(NSString *)Animation
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewcontroller animated:NO];
    
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



//-(void)side
//{
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    //overlay.hidden=YES;
//    //  overlay.userInteractionEnabled=NO;
//    [self.view addSubview:overlay];
//    
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
//    tapGesture.numberOfTapsRequired=1;
//    [overlay addGestureRecognizer:tapGesture];
//    
//    
//    sidemenu=[[Side_menu alloc]init];
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
//    {
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
//        sidemenu.ProfileImage.frame = CGRectMake(41, 26, 77, 77);
//        [sidemenu.lblUserName setFont:[UIFont fontWithName:@"Lato" size:16]];
//        sidemenu.btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        sidemenu.btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        sidemenu.btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        sidemenu.btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.5f];
//        sidemenu.btn5.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        sidemenu.btn6.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        sidemenu.btn7.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        sidemenu.btn8.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.0];
//        sidemenu.btn9.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        
//        
//    }
//    else{
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//    }
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//    
//    
//    
//    
//    
//    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
//    //sidemenu.hidden=YES;
//    
//    
//    
//    //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
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
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
//}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView==othertxt)
    {
        textView.keyboardAppearance = UIKeyboardAppearanceAlert;
        textView.autocorrectionType = UITextAutocorrectionTypeNo;
        placeholder.hidden=YES;
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, 90, self.view.frame.size.width-20, self.view.frame.size.height * .5);
            
            
        }];
        
        return YES;

    }
    
    else
    {
        return NO;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==othertxt)
    {
        if ([text isEqualToString:@"\n"])
        {
            if (textView.text.length==0)
            {
                placeholder.hidden=NO;
            }
            
            
            
            [UIView animateWithDuration:.3f animations:^{
             
                [othertxt resignFirstResponder];
                
                 popview.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
                
                
                
            }];
            
            
            
            
            
        }
        
        return YES;
        
    }
    
    else
    {
        return NO;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}



@end
