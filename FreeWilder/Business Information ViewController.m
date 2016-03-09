//
//  Business Information ViewController.m
//  FreeWilder
//
//  Created by kausik on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Business Information ViewController.h"
#import "FW_JsonClass.h"

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


@interface Business_Information_ViewController ()<UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{
    FW_JsonClass *obj;
    NSArray *dataArray;
    
    UITextField *nametxt2;
    UITextField *valuetxt2;
    NSString *valu2 ,*nam2;
    CGRect btnfrm2;
    UIButton *close2;
    
    UITextField *nametxt3;
    UITextField *valuetxt3;
    NSString *valu3,*nam3;
    CGRect btnfrm3;
    UIButton *close3;
    
    UITextField *nametxt4;
    UITextField *valuetxt4;
    NSString *valu4,*nam4;
    CGRect btnfrm4;
    UIButton *close4;
    
    UITextField *nametxt5;
    UITextField *valuetxt5;
    NSString *valu5,*nam5;
    CGRect btnfrm5;
    UIButton *close5;
    
    UITextField *nametxt6;
    UITextField *valuetxt6;
    NSString *valu6,*nam6;
    CGRect btnfrm6,btnfrm7;
    UIButton *close6;

    NSMutableArray *addinfo;
    
    int tap,tap1;
    NSString  *userid;
    
    
    IBOutlet UIView *footerBaseView;
    int btn;
    
    __weak IBOutlet UIImageView *topbar;
    __weak IBOutlet UIButton *btckbtn;
    __weak IBOutlet UILabel *hdrlbl;

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




}

@end

@implementation Business_Information_ViewController


//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tap=1;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
//    if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
//    {
//        topbar.frame = CGRectMake(0, 0, 375, 93);
//       
//        btckbtn.frame=CGRectMake(0, 14, 69, 76);
//        hdrlbl.frame=CGRectMake(70, 28, 250, 46);
//    }
//    
//    else if (screenBounds.size.height ==736  && screenBounds.size.width == 414)
//    {
//        
//        topbar.frame = CGRectMake(0, 0, 414, 102);app_business
//        btckbtn.frame=CGRectMake(0, 13, 76, 90);
//        hdrlbl.frame=CGRectMake(80, 35, 270, 46);
//        
//    }

    
  scroll.contentSize=CGSizeMake(0,1050);
    obj = [[FW_JsonClass alloc]init];
    
    dataArray=[[NSArray alloc]init];
    addinfo= [[NSMutableArray alloc]init];
    
     btnfrm2=_updateDetailBtn.frame;
    
    valu2=@"";
    nam2=@"";
    valu3=@"";
    nam3=@"";
    valu4=@"";
    nam4=@"";
    valu5=@"";
    nam5=@"";
    valu6=@"";
    nam6=@"";
    
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer_base  addSubview:footer];
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

   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   userid=[prefs valueForKey:@"UserId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/app_business_info?userid=%@",App_Domain_Url,userid];
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         if ([[result valueForKey:@"response"]isEqualToString:@"success"])
         {
            NSArray *results = (NSArray *) result[@"infoarray"];
             dataArray = (NSArray *)[results[0] mutableCopy];
             
           
             
             if ([dataArray valueForKey:@"business_name"] !=NULL)
             {
                 business_name.text= [NSString stringWithFormat:@"%@",[dataArray valueForKey:@"business_name"]];
             }
             
             
             if ([dataArray valueForKey:@"address"] !=NULL)
             {
                 
             Address.text = [NSString stringWithFormat:@"%@",[dataArray valueForKey:@"address"]];
             }
             
             if ([dataArray valueForKey:@"description"] !=NULL)
             {
             Discrption.text =[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"description"]];
             }
             if ([dataArray valueForKey:@"location"] !=NULL)
             {
             
             Location.text =[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"location"]];
             }
             if ([dataArray valueForKey:@"facebook_link"] !=NULL)
             {
             
             Facebook_link.text=[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"facebook_link"]];
             }
             if ([dataArray valueForKey:@"website_link"] !=NULL)
             {
                 website_Link.text=[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"website_link"]];
             }
             if ([dataArray valueForKey:@"phone"] !=NULL)
             {
             phone.text=[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"phone"]];
             }
             if ([dataArray valueForKey:@"taxId"] !=NULL)
             {
             Taxid.text=[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"taxId"]];
             }
             if ([dataArray valueForKey:@"bank_account"] !=NULL)
             {
             Bank_Acount.text=[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"bank_account"]];
             }
             
             
             
             
             if (Address.text.length==0)
             {
                 addresslbl.hidden=NO;
             }
             else
             {
                 addresslbl.hidden=YES;
             }
             
             if (Discrption.text.length==0)
             {
                 descriptionlbl.hidden=NO;
             }
             else
             {
                 descriptionlbl.hidden=YES;
             }
        
             
             addinfo = [result valueForKey:@"additional_info"];
             
             
             NSInteger addinfocount = [[result valueForKey:@"total_additional_info"] intValue];
             
             NSLog(@"====%ld",(long)addinfocount);
             
             
             if (addinfo.count>0)
             {
                 if (addinfocount==1)
                 {
                     nametxt1.text = [[addinfo objectAtIndex:0]valueForKey:@"field_name"];
                     valuetxt1.text = [[addinfo objectAtIndex:0]valueForKey:@"field_val"];
                     
                     tap=(int)addinfocount;
                     
                 }
                 
                 else if (addinfocount==2)
                 {
                     [self creare2];
                     tap=(int)addinfocount;
                 }
                 
                 else if (addinfocount==3)
                     
                 {
                     NSLog(@"==========================");
                     [self create3];
                     
                     tap=(int)addinfocount;
                 }
                 
                 else if (addinfocount==4)
                 {
                     [self create4];
                     
                     tap=(int)addinfocount;
                 }
                 
                 else if (addinfocount==5)
                 {
                     [self create5];
                     
                     tap=(int)addinfocount;
                 }
                 
                 else if (addinfocount==6)
                     
                 {
                     [self create6];
                     
                     tap=(int)addinfocount;
                 }
                 
                 
             }
             
             
             
             
             
             
             
             
             scroll.contentSize=CGSizeMake(0, _updateDetailBtn.frame.size.height+_updateDetailBtn.frame.origin.y+10);
             
             
             
             
             
         }
         
         
         
         
         
         
         
         
         
         
         
         
     }];
    
    
    
    
    
    
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.keyboardAppearance = UIKeyboardAppearanceAlert;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if (textView==Address)
    {
        addresslbl.hidden=YES;
        
        if (Discrption.text.length==0)
        {
            descriptionlbl.hidden=NO;
        }
        
        
    }
    
    if(textView==Discrption)
    {
        [scroll setContentOffset:CGPointMake(0.0f, 80.0f) animated:YES];
        
         descriptionlbl.hidden=YES;
        
        if (Address.text.length==0)
        {
            addresslbl.hidden=NO;
        }
        
        
    }
    
    
    scroll.contentSize=CGSizeMake(0,900);

    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    
    
    
if ([text isEqualToString:@"\n"])
    
    
    
{
    
    [textView resignFirstResponder];
    scroll.contentSize=CGSizeMake(0,840);
    
    if (tap>=5)
    {
        scroll.contentSize=CGSizeMake(0,1050);
    }
    
    if (tap==4)
    {
        scroll.contentSize=CGSizeMake(0,1000);
    }
    
    if (tap==3)
    {
        scroll.contentSize=CGSizeMake(0,970);
    }
    if (tap==2)
    {
        scroll.contentSize=CGSizeMake(0,910);
    }
    
    
    if (Address.text.length==0)
    {
        addresslbl.hidden=NO;
    }
    else
    {
        addresslbl.hidden=YES;
    }
    
    if (Discrption.text.length==0)
    {
        descriptionlbl.hidden=NO;
    }
    else
    {
        descriptionlbl.hidden=YES;
    }
    
    
    
    scroll.contentSize=CGSizeMake(0, _updateDetailBtn.frame.size.height+_updateDetailBtn.frame.origin.y+10);
    
    
}
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

    scroll.contentSize=CGSizeMake(0, _updateDetailBtn.frame.size.height+_updateDetailBtn.frame.origin.y+10);

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    if (Address.text.length==0)
    {
        addresslbl.hidden=NO;
    }
    else
    {
        addresslbl.hidden=YES;
    }
    
    if (Discrption.text.length==0)
    {
        descriptionlbl.hidden=NO;
    }
    else
    {
        descriptionlbl.hidden=YES;
    }

    
    
    
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
        if (textField==Location)
        {
            if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                
            {
               [scroll setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
            }
            
            else
            {
                [scroll setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
            }
            
            
            
        }
      else  if (textField==Facebook_link)
        {
            if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                
            {
                [scroll setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
            }
            
            else
            {
                [scroll setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
            }
            
            
            //scroll.contentSize=CGSizeMake(0,700);
            scroll.contentSize=CGSizeMake(0,1100);
        }
    
    
    
    
      else if (textField==website_Link)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scroll setContentOffset:CGPointMake(0.0f, 420.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 370.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1100);
    }
    
   else if (textField==phone)
    {
        
        
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
        [scroll setContentOffset:CGPointMake(0.0f, 470.0f) animated:YES];
        }
        else
        {
           [scroll setContentOffset:CGPointMake(0.0f, 400.0f) animated:YES];
        }
        
        scroll.contentSize=CGSizeMake(0,1100);

    }
   else if (textField==Taxid)
    {
        
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
        [scroll setContentOffset:CGPointMake(0.0f, 530.0f) animated:YES];
        }
        else
        {
           [scroll setContentOffset:CGPointMake(0.0f, 500.0f) animated:YES];
        }
         scroll.contentSize=CGSizeMake(0,1200);

    }
  else  if (textField==Bank_Acount)
    {
         if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
         {
        [scroll setContentOffset:CGPointMake(0.0f, 600.0f) animated:YES];
         }
         else
         {
              [scroll setContentOffset:CGPointMake(0.0f, 530.0f) animated:YES];
         }
         scroll.contentSize=CGSizeMake(0,1210);
    }
  else  if (textField==nametxt1)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 700.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 620.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1230);
    }
 else   if (textField==valuetxt1)
    
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 700.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 620.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1230);
    }
    
    
  else  if (textField==nametxt2)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 750.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 680.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1250);
    }
  else  if (textField==valuetxt2)
        
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 750.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 680.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1250);
    }
    
    
 else   if (textField==nametxt3)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 800.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 750.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1300);
    }
 else   if (textField==valuetxt3)
        
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 800.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 750.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1300);
    }

 else   if (textField==nametxt4 || textField==valuetxt4)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 850.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 770.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1350);
    }
    
 else   if (textField==nametxt5 || textField==valuetxt5)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 900.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 800.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1400);
    }
    
    
  else  if (textField==nametxt6 || textField==valuetxt6)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 930.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 840.0f) animated:YES];
        }
        scroll.contentSize=CGSizeMake(0,1430);
    }
    
    
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (textField==website_Link || textField==Facebook_link|| textField==phone || textField==Taxid || textField==Bank_Acount || textField==nametxt1 || textField==valuetxt1)
    {
        
        scroll.contentSize=CGSizeMake(0,1050);
        
        
        
        if (tap>=5)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50+50);
        }
        
        if (tap==4)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50);
        }
        
        if (tap==3)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50);
        }
        if (tap==2)
        {
            scroll.contentSize=CGSizeMake(0,1050+50);
        }
        
    }
    
    
    
    
    if (textField==nametxt2 || textField==valuetxt2)
    {
        if (tap>=5)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50+50);
        }
        
        if (tap==4)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50);
        }
        
        if (tap==3)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50);
        }
        if (tap==2)
        {
            scroll.contentSize=CGSizeMake(0,1050+50);
        }
        
        
    }
    if (textField==nametxt3 || textField==valuetxt3)
    {
        if (tap>=5)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50+50);
        }
        
        if (tap==4)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50);
        }
        
        if (tap==3)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50);
        }
        if (tap==2)
        {
            scroll.contentSize=CGSizeMake(0,1050+50);
        }
        
    }
    
    if (textField==nametxt4 || textField==valuetxt4)
    {
        if (tap>=5)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50+50);
        }
        
        if (tap==4)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50);
        }
        
        if (tap==3)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50);
        }
        if (tap==2)
        {
            scroll.contentSize=CGSizeMake(0,1050+50);
        }
        
    }
    if (textField==nametxt5 || textField==valuetxt5)
    {
        if (tap>=5)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50+50);
        }
        
        if (tap==4)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50+50);
        }
        
        if (tap==3)
        {
            scroll.contentSize=CGSizeMake(0,1050+50+50);
        }
        if (tap==2)
        {
            scroll.contentSize=CGSizeMake(0,1050+50);
        }
        
    }
    if (textField==nametxt6 || textField==valuetxt6)
    {
        if (tap>=5)
        {
            scroll.contentSize=CGSizeMake(0,1100+50+50+50+50);
        }
        
        if (tap==4)
        {
            scroll.contentSize=CGSizeMake(0,1100+50+50+50);
        }
        
        if (tap==3)
        {
            scroll.contentSize=CGSizeMake(0,1100+50+50);
        }
        if (tap==2)
        {
            scroll.contentSize=CGSizeMake(0,1100+50);
        }
    }
    
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)updateDetailBtnTap:(id)sender
{
    if (business_name.text.length==0)
    {
        business_name.placeholder=@"Please Enter Business Name";
    }
    
    else if (Address.text.length==0)
    {
        
        addresslbl.text = @"Please Enter Address";
        
        
    }
    else if (Discrption.text.length==0)
    {
        descriptionlbl.text=@"Please Enter Discription";
    }
    else if (Location.text.length==0)
    {
        Location.placeholder=@"Please Enter Location";
    }
    
    else if (phone.text.length==0)
    {
        phone.placeholder=@"Please Enter Phone No.";
    }
    else
    {
        NSLog(@"url fire");
        
        if (nametxt1.text.length==0 )
        {
            nametxt1.text=@"";
        }
        if (valuetxt1.text.length ==0)
        {
            valuetxt1.text=@"";
        }
        
        if (nametxt2.text.length==0)
        {
            nametxt2.text=@"";
        }
        
        if (valuetxt2.text.length ==0)
        {
            valuetxt2.text=@"";
        }
        
        
        
        if (nametxt3.text.length==0)
        {
            nametxt3.text=@"";
        }
        
        if (valuetxt3.text.length ==0)
        {
            valuetxt3.text=@"";
        }
        
        if (nametxt4.text.length==0)
        {
            nametxt4.text=@"";
        }
        
        if (valuetxt4.text.length ==0)
        {
            valuetxt4.text=@"";
        }
       
        
        if (nametxt5.text.length==0)
        {
            nametxt5.text=@"";
        }
        
        if (valuetxt5.text.length ==0)
        {
            valuetxt5.text=@"";
        }
        
       if (nametxt6.text.length==0)
            {
                nametxt6.text=@"";
            }
        
        if (valuetxt6.text.length ==0)
        {
            valuetxt6.text=@"";
        }
        
        
        nam2=nametxt2.text;
        valu2=valuetxt2.text;
        
        nam3=nametxt3.text;
        valu3=valuetxt3.text;
        
        nam4=nametxt4.text;
        valu4=valuetxt4.text;
        
        nam5=nametxt5.text;
        valu5=valuetxt5.text;
        
        nam6=nametxt6.text;
        valu6=valuetxt6.text;
        
        
        if (nam2==NULL)
        {
            nam2=@"";
        }
        if (valu2==NULL)
        {
            valu2=@"";
        }

        
        if (nam3==NULL)
        {
            nam3=@"";
        }
        
        if (valu3==NULL)
        {
            valu3=@"";
        }

        
        if (nam4==NULL)
        {
            nam4=@"";
        }
        if (valu4==NULL)
        {
            valu4=@"";
        }
        if (nam5==NULL)
        {
            nam5=@"";
        }
        if (valu5==NULL)
        {
            valu5=@"";
        }
        
        if (nam6==NULL)
        {
            nam6=@"";
        }
        if (valu6==NULL)
        {
            valu6=@"";
        }
        
        
        
        
        NSString *url = [NSString stringWithFormat:@"%@/app_business_update?userid=%@&name=%@&address=%@&description=%@&location=%@&fb_link=%@&website=%@&phone=%@8&tax_id=%@&bank_account=%@&fild_name1=%@&fild_val1=%@&fild_name2=%@&fild_val2=%@&fild_name3=%@&fild_val3=%@&fild_name4=%@&fild_val4=%@&fild_name5=%@&fild_val5=%@&fild_name6=%@&fild_val6=%@",App_Domain_Url,userid,business_name.text,Address.text,Discrption.text,Location.text,Facebook_link.text,website_Link.text,phone.text,Taxid.text,Bank_Acount.text,nametxt1.text,valuetxt1.text,nam2,valu2,nam3,valu3,nam4,valu4,nam5,valu5,nam6,valu6];
        
        
       
        
        NSLog(@"url--------%@",url);
        
        
        
         NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
        {
            
           
            
            
           
            
            
            
            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
            {
                
                
                
//                CATransition *Transition=[CATransition animation];
//                [Transition setDuration:0.3f];
//                [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//                [Transition setType:kCAMediaTimingFunctionEaseOut];
//                [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
//                [[self navigationController] popViewControllerAnimated:NO];
                
                
                UIAlertView *alart = [[UIAlertView alloc]initWithTitle:@"Update" message:[result valueForKey:@"response"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                
                
                [alart show];
                
                
              //  [self viewDidLoad];
                
            }
            
            
            

            
        }];
        
        
    }
    
}

- (IBAction)back:(id)sender
{
    
    
    
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}

- (IBAction)addInfoBtnTap:(id)sender
{
    
    [website_Link resignFirstResponder];
    [phone resignFirstResponder];
    [Taxid resignFirstResponder];
    [Bank_Acount resignFirstResponder];
    [nametxt1 resignFirstResponder];
    [nametxt2 resignFirstResponder];
    [nametxt3 resignFirstResponder];
    [nametxt3 resignFirstResponder];
    [nametxt4 resignFirstResponder];
    [nametxt5 resignFirstResponder];
    [nametxt6 resignFirstResponder];
    [valuetxt1 resignFirstResponder];
    [valuetxt2 resignFirstResponder];
    [valuetxt3 resignFirstResponder];
    [valuetxt4 resignFirstResponder];
    [valuetxt5 resignFirstResponder];
    [valuetxt5 resignFirstResponder];
    
    
    
    
    if (tap==1)
    {
       nametxt2 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt1.frame.origin.y+ nametxt1.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
        nametxt2.delegate=self;
        
       
        
        //[nametxt2 setBackgroundColor:[UIColor redColor]];
        [nametxt2 setBackground:[UIImage imageNamed:@"topbar"]];
        
        [nametxt2 setFont:[UIFont fontWithName:@"Lato" size:14]];

        
       valuetxt2 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt1.frame.origin.y+ valuetxt1.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
        
       // UIButton *close = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //[button setTitle:@"Show View" forState:UIControlStateNormal];
       
        [valuetxt2 setFont:[UIFont fontWithName:@"Lato" size:14]];

        
        close2 = [[UIButton alloc]initWithFrame:CGRectMake(valuetxt2.frame.origin.x+valuetxt2.frame.size.width, valuetxt2.frame.origin.y+8, 20, 20)];
        [close2 addTarget:self
                  action:@selector(text1:)
        forControlEvents:UIControlEventTouchUpInside];
        [close2 setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
        //[close setBackgroundColor:[UIColor blackColor]];
        
        
        
        
        
       // [ setBackgroundColor:[UIColor redColor]];
        [valuetxt2 setBackground:[UIImage imageNamed:@"topbar"]];
        
        _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt1.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
        
        btnfrm3=_updateDetailBtn.frame;
       
        
        
        nametxt2.delegate=self;
        valuetxt2.delegate=self;
        
        
        [scroll addSubview:valuetxt2];
        
        [scroll addSubview:nametxt2];
        [scroll addSubview:close2];
        
        scroll.contentSize=CGSizeMake(0,1050+50);
        
        tap=tap+1;
        
        
    }
  else  if (tap==2)
    {
        
        close2.hidden=YES;
        
        tap1=2;
        
       nametxt3 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt2.frame.origin.y+ nametxt2.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
        [nametxt3 setBackground:[UIImage imageNamed:@"topbar"]];
        
        [nametxt3 setFont:[UIFont fontWithName:@"Lato" size:14]];

        
        valuetxt3 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt2.frame.origin.y+ valuetxt2.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
        [valuetxt3 setFont:[UIFont fontWithName:@"Lato" size:14]];

        
        
        close3 = [[UIButton alloc]initWithFrame:CGRectMake(valuetxt3.frame.origin.x+valuetxt3.frame.size.width, valuetxt3.frame.origin.y+8, 20, 20)];
        [close3 addTarget:self
                   action:@selector(text2:)
         forControlEvents:UIControlEventTouchUpInside];
        [close3 setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
        
        [scroll addSubview:close3];
        
        [valuetxt3 setBackground:[UIImage imageNamed:@"topbar"]];
        
        _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt2.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
        btnfrm4=_updateDetailBtn.frame;
        
        
         scroll.contentSize=CGSizeMake(0,1050+50+50);
        
        nametxt3.delegate=self;
        valuetxt3.delegate=self;
        
        [scroll addSubview:valuetxt3];
        [scroll addSubview:nametxt3];
        
        tap=tap+1;
    }
    
  else  if (tap==3)
  {
      tap1=3;
      
      close3.hidden=YES;
      
      nametxt4 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt3.frame.origin.y+ nametxt3.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
      [nametxt4 setBackground:[UIImage imageNamed:@"topbar"]];
      [nametxt4 setFont:[UIFont fontWithName:@"Lato" size:14]];

      
      valuetxt4 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt3.frame.origin.y+ valuetxt3.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
      [valuetxt4 setFont:[UIFont fontWithName:@"Lato" size:14]];

      
      
      close4 = [[UIButton alloc]initWithFrame:CGRectMake(valuetxt4.frame.origin.x+valuetxt4.frame.size.width, valuetxt4.frame.origin.y+8, 20, 20)];
      [close4 addTarget:self
                 action:@selector(text3:)
       forControlEvents:UIControlEventTouchUpInside];
      [close4 setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
      
      [scroll addSubview:close4];
      
      
      [valuetxt4 setBackground:[UIImage imageNamed:@"topbar"]];
      
      _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt3.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
      btnfrm5=_updateDetailBtn.frame;
      
       scroll.contentSize=CGSizeMake(0,1050+50+50+50);
      nametxt4.delegate=self;
      valuetxt4.delegate=self;
      
      [scroll addSubview:valuetxt4];
      [scroll addSubview:nametxt4];
      
      tap=tap+1;
  }
    
  else  if (tap==4)
  {
      tap1=4;
      close4.hidden=YES;
      
      nametxt5 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt4.frame.origin.y+ nametxt4.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
      [nametxt5 setBackground:[UIImage imageNamed:@"topbar"]];
      [nametxt5 setFont:[UIFont fontWithName:@"Lato" size:14]];

      
      valuetxt5 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt4.frame.origin.y+ valuetxt4.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
      [nametxt5 setFont:[UIFont fontWithName:@"Lato" size:14]];

      
      close5 = [[UIButton alloc]initWithFrame:CGRectMake(valuetxt5.frame.origin.x+valuetxt5.frame.size.width, valuetxt5.frame.origin.y+8, 20, 20)];
      [close5 addTarget:self
                 action:@selector(text4:)
       forControlEvents:UIControlEventTouchUpInside];
      [close5 setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
      
      [scroll addSubview:close5];
      
      
      
      [valuetxt5 setBackground:[UIImage imageNamed:@"topbar"]];
      
      _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt4.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
      
      btnfrm6=_updateDetailBtn.frame;
      
      
       scroll.contentSize=CGSizeMake(0,1050+50+50+50+50);
      nametxt5.delegate=self;
      valuetxt5.delegate=self;
      
      [scroll addSubview:valuetxt5];
      [scroll addSubview:nametxt5];
      
      tap=tap+1;
  }
    
  else  if (tap==5)
  {
      tap1=5;
      close5.hidden=YES;
      
      nametxt6 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt5.frame.origin.y+ nametxt5.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
      [nametxt6 setBackground:[UIImage imageNamed:@"topbar"]];
      [nametxt6 setFont:[UIFont fontWithName:@"Lato" size:14]];

      
      valuetxt6 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt5.frame.origin.y+ valuetxt5.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
      
      
      [valuetxt6 setFont:[UIFont fontWithName:@"Lato" size:14]];

      
      close6 = [[UIButton alloc]initWithFrame:CGRectMake(valuetxt6.frame.origin.x+valuetxt6.frame.size.width, valuetxt6.frame.origin.y+8, 20, 20)];
      [close6 addTarget:self
                 action:@selector(text5:)
       forControlEvents:UIControlEventTouchUpInside];
      [close6 setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
      
      [scroll addSubview:close6];
      
      
      [valuetxt6 setBackground:[UIImage imageNamed:@"topbar"]];
      
      _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt5.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
      
      btnfrm7=_updateDetailBtn.frame;
      
      
      
      scroll.contentSize=CGSizeMake(0,1050+50+50+50+50+50);
      nametxt6.delegate=self;
      valuetxt6.delegate=self;
      
      [scroll addSubview:valuetxt6];
      [scroll addSubview:nametxt6];
      
      tap=tap+1;
  }
    else if (tap>5)
    {
         scroll.contentSize=CGSizeMake(0,1050+50+50+50+50+50);
    }
    
    
}

-(void)text1:(UIButton *)sender
{
 
    if (tap==2)
    {
        [nametxt2 removeFromSuperview];
        [valuetxt2 removeFromSuperview];
        
        [close2 removeFromSuperview];
        _updateDetailBtn.frame=btnfrm2;
        
        scroll.contentSize=CGSizeMake(0,1050);
        
        tap=tap-1;
       
        
    }
//    else
//    {
//        [nametxt3 removeFromSuperview];
//        [valuetxt3 removeFromSuperview];
//        [close3 removeFromSuperview];
//        
//        _updateDetailBtn.frame=btnfrm3;
//        
//        scroll.contentSize=CGSizeMake(0,900+50-50);
//        
//        
//        
//        
//    }
//    
    
    
    
}
-(void)text2:(UIButton *)sender
{
    if (tap==3)
    {
        close2.hidden=NO;
        [nametxt3 removeFromSuperview];
        [valuetxt3 removeFromSuperview];
        [close3 removeFromSuperview];
        
        _updateDetailBtn.frame=CGRectMake(_updateDetailBtn.frame.origin.x, nametxt2.frame.origin.y+nametxt2.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
        
        scroll.contentSize=CGSizeMake(0,1100+50-50);
        
        tap=tap-1;;
        
        
        
    }
    
    
}
-(void)text3:(UIButton *)sender
{
    if (tap==4)
    {
        close3.hidden=NO;
        [nametxt4 removeFromSuperview];
        [valuetxt4 removeFromSuperview];
        [close4 removeFromSuperview];
        
        _updateDetailBtn.frame=btnfrm4;
        
        scroll.contentSize=CGSizeMake(0,1100+50+50-50);
        
        tap=tap-1;;
        
        
        
    }
    
    
}
-(void)text4:(UIButton *)sender
{
    if (tap==5)
    {
        close4.hidden=NO;
        [nametxt5 removeFromSuperview];
        [valuetxt5 removeFromSuperview];
        [close5 removeFromSuperview];
        
        _updateDetailBtn.frame=btnfrm5;
        
       scroll.contentSize=CGSizeMake(0,1100+100+50-50);
        
        tap=tap-1;;
        
        
        
    }
    
    
}


-(void)text5:(UIButton *)sender
{
    if (tap==6)
    {
        close5.hidden=NO;
        
        [nametxt6 removeFromSuperview];
        [valuetxt6 removeFromSuperview];
        [close6 removeFromSuperview];
        
        _updateDetailBtn.frame=btnfrm6;
        
        scroll.contentSize=CGSizeMake(0,1100+150+50-50);

        
        tap=tap-1;;
        
        
        
    }
    
    
}


-(void)creare2
{
    
    nametxt1.text = [[addinfo objectAtIndex:0]valueForKey:@"field_name"];
    valuetxt1.text = [[addinfo objectAtIndex:0]valueForKey:@"field_val"];

    
    
    nametxt2 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt1.frame.origin.y+ nametxt1.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
    nametxt2.delegate=self;
    [nametxt2 setFont:[UIFont fontWithName:@"Lato" size:14]];
    
    
    
    //[nametxt2 setBackgroundColor:[UIColor redColor]];
    [nametxt2 setBackground:[UIImage imageNamed:@"topbar"]];
    
    
    
    valuetxt2 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt1.frame.origin.y+ valuetxt1.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
    [valuetxt2 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
    // UIButton *close = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //[button setTitle:@"Show View" forState:UIControlStateNormal];
    
    
    
    
    [valuetxt2 setBackground:[UIImage imageNamed:@"topbar"]];
    
    _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt1.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
    
    btnfrm3=_updateDetailBtn.frame;
    
    
    
    nametxt2.delegate=self;
    valuetxt2.delegate=self;
    
    
    [scroll addSubview:valuetxt2];
    
    [scroll addSubview:nametxt2];
    
    nametxt2.text = [[addinfo objectAtIndex:1]valueForKey:@"field_name"];
    valuetxt2.text = [[addinfo objectAtIndex:1]valueForKey:@"field_val"];

    
    scroll.contentSize=CGSizeMake(0,1050+50);
    
}


-(void)create3
{
    
    
    [self creare2];
    
    
    
    
        
    
        
        nametxt3 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt2.frame.origin.y+ nametxt2.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
        [nametxt3 setBackground:[UIImage imageNamed:@"topbar"]];
        
    [nametxt3 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
        valuetxt3 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt2.frame.origin.y+ valuetxt2.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
        
    [valuetxt3 setFont:[UIFont fontWithName:@"Lato" size:14]];


    
        [valuetxt3 setBackground:[UIImage imageNamed:@"topbar"]];
        
        _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt2.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
        btnfrm4=_updateDetailBtn.frame;
        
        
        scroll.contentSize=CGSizeMake(0,1050+50+50);
        
        nametxt3.delegate=self;
        valuetxt3.delegate=self;
        
        [scroll addSubview:valuetxt3];
        [scroll addSubview:nametxt3];
    
    nametxt3.text = [[addinfo objectAtIndex:2]valueForKey:@"field_name"];
    valuetxt3.text = [[addinfo objectAtIndex:2]valueForKey:@"field_val"];
        
       // tap=tap+1;
    
    
    
    

}


-(void)create4
{
    
   
    [self create3];
    
    nametxt4 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt3.frame.origin.y+ nametxt3.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
    [nametxt4 setBackground:[UIImage imageNamed:@"topbar"]];
    [nametxt4 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
    valuetxt4 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt3.frame.origin.y+ valuetxt3.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
    
    
    
    [valuetxt4 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
    [valuetxt4 setBackground:[UIImage imageNamed:@"topbar"]];
    
    _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt3.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
    btnfrm5=_updateDetailBtn.frame;
    
    scroll.contentSize=CGSizeMake(0,1050+50+50+50);
    nametxt4.delegate=self;
    valuetxt4.delegate=self;
    
    [scroll addSubview:valuetxt4];
    [scroll addSubview:nametxt4];
    
    
    nametxt4.text = [[addinfo objectAtIndex:3]valueForKey:@"field_name"];
    valuetxt4.text = [[addinfo objectAtIndex:3]valueForKey:@"field_val"];
    
    
 
}

-(void)create5
{
    [self create4];
    
    
    
    nametxt5 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt4.frame.origin.y+ nametxt4.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
    [nametxt5 setBackground:[UIImage imageNamed:@"topbar"]];
    [nametxt5 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
    valuetxt5 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt4.frame.origin.y+ valuetxt4.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
    
    [valuetxt5 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
    
    
    [valuetxt5 setBackground:[UIImage imageNamed:@"topbar"]];
    
    _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt4.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
    
    btnfrm6=_updateDetailBtn.frame;
    
    
    scroll.contentSize=CGSizeMake(0,1050+50+50+50+50);
    nametxt5.delegate=self;
    valuetxt5.delegate=self;
    
    [scroll addSubview:valuetxt5];
    [scroll addSubview:nametxt5];
    
    nametxt5.text = [[addinfo objectAtIndex:4]valueForKey:@"field_name"];
    valuetxt5.text = [[addinfo objectAtIndex:4]valueForKey:@"field_val"];
    
}

-(void)create6

{
    [self create5];
    
    nametxt6 = [[UITextField alloc]initWithFrame:CGRectMake(nametxt1.frame.origin.x, nametxt5.frame.origin.y+ nametxt5.frame.size.height+10, nametxt1.frame.size.width, nametxt1.frame.size.height)];
    [nametxt6 setBackground:[UIImage imageNamed:@"topbar"]];
    [nametxt6 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
    valuetxt6 = [[UITextField alloc]initWithFrame:CGRectMake(valuetxt1.frame.origin.x, valuetxt5.frame.origin.y+ valuetxt5.frame.size.height+10, valuetxt1.frame.size.width, valuetxt1.frame.size.height)];
    
    
    [valuetxt6 setFont:[UIFont fontWithName:@"Lato" size:14]];

    
    
    
    [valuetxt6 setBackground:[UIImage imageNamed:@"topbar"]];
    
    _updateDetailBtn.frame = CGRectMake(_updateDetailBtn.frame.origin.x, _updateDetailBtn.frame.origin.y+nametxt5.frame.size.height+10, _updateDetailBtn.frame.size.width, _updateDetailBtn.frame.size.height);
    
    btnfrm7=_updateDetailBtn.frame;
    
    
    
    scroll.contentSize=CGSizeMake(0,1050+50+50+50+50+50);
    nametxt6.delegate=self;
    valuetxt6.delegate=self;
    
    [scroll addSubview:valuetxt6];
    [scroll addSubview:nametxt6];
    
    
    nametxt6.text = [[addinfo objectAtIndex:5]valueForKey:@"field_name"];
    valuetxt6.text = [[addinfo objectAtIndex:5]valueForKey:@"field_val"];

    
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

   if([textField isEqual:phoneText])
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

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
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



@end
