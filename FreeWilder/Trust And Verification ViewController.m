//
//  Trust And Verification ViewController.m
//  FreeWilder
//
//  Created by kausik on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Trust And Verification ViewController.h"
#import "FW_JsonClass.h"
#import "verifyView.h"
#import "ImageResize.h"
#import "AFNetworking.h"

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


@interface Trust_And_Verification_ViewController ()<verify_menu_delegate,UIGestureRecognizerDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{
    FW_JsonClass *obj;
    NSMutableArray *countryArry,*country_idArray;
    NSString *coutnry,*temp1 ,*country_id;
    CGRect buttonfrm ,newfrn;
   verifyView *subview1;
    BOOL pickercheck;
    
    int tap;
    NSString *userid;
    
    UIImage *img,*frontimg,*backimg;
    
    NSData *frontdata ,*backdata,*otherdata;
    
    UIView *blackview1;
    UIView *popview1;
    
    NSMutableData *mutableData;
    
    UITextView *othertxt;
    
    CGRect popfrm;
    UILabel *placeholder;
    
    
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

@implementation Trust_And_Verification_ViewController
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

    
    
    
    
    
    
    
    verify.layer.cornerRadius = 5;
    obj = [[FW_JsonClass alloc]init];
    countryArry = [[NSMutableArray alloc]init];
    country_idArray =[[NSMutableArray alloc]init];
    _imagePicker=[[UIImagePickerController alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    
    pickercheck=true;
    [verify addSubview:arroimage];
    arroimage.hidden=YES;
    
    buttonfrm = verify.frame;
    //NSLog(@"%lu",buttonfrm);
    
    pview.frame = CGRectMake(0, self.view.frame.size.height, pview.frame.size.width, pview.frame.size.height);
    
    UIAlertView *alart = [[UIAlertView alloc]initWithTitle:@"Verify Your ID" message:@"Getting your Verified ID is the easiest way to help build trust in the Freewilder community. We’ll verify you by matching information from an online account to an official ID. Learn more Or, you can choose to only add the verifications you want below" delegate:self cancelButtonTitle:@"Verify Me" otherButtonTitles:nil, nil];
    
    [alart show];
    
    
    
    
    subview1=[[verifyView alloc] init];
    subview1.verifyDelegate=self;
    
    subview1.passportRight.hidden=YES;
    subview1.IdentyRight.hidden=YES;
    subview1.driverRight.hidden=YES;
    subview1.VatidRight.hidden=YES;
    subview1.taxidCardRight.hidden=YES;
    subview1.otherRight.hidden=YES;
   
    
    subview1.frame =CGRectMake(self.view.frame.size.width+10, self.view.frame.size.height * .35, subview1.frame.size.width,subview1.frame.size.height);
    
    
   
    [self.view addSubview:subview1];
    
    subview1.hidden=YES;
    pview.hidden=YES;
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
    
    if (tap==0)
    {
        
        
        
        img = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
        
        NSData* pictureData = UIImagePNGRepresentation(img);
        
        
        
        
        if (pictureData.length>0)
        {
          /*  UIView   *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,0, self.view.frame.size.width,self.view.frame.size.height )];
            
            polygonView.backgroundColor=[UIColor blackColor];
            
            polygonView.alpha=0.3;
            
            [self.view addSubview:polygonView];
            
            UIActivityIndicatorView    *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            
            
            [polygonView addSubview:spinner];
            
            
            
            
            
            [spinner startAnimating];
            

            */
            
            [self tost];
            
            NSString *url = [NSString stringWithFormat:@"%@/app_verification?country_Id=%@&card_type=passport&userid=%@",App_Domain_Url,country_id,userid];
            
            [obj GlobalDict_image1:url Globalstr_image:@"array" globalimage:pictureData Withblock:^(id result, NSError *error) {
                
                if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                {
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:@"Upload Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alrt show];
                    
                    subview1.passportRight.hidden=NO;
                    
                }
                
                //[polygonView removeFromSuperview];
            }];
        }
  
    }
    
    if (tap==10)
    {
        frontimg = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
        
        frontdata = UIImagePNGRepresentation(frontimg);
        
        NSLog(@"front data ===%@",frontdata);
        
        
       
    }
    
    if (tap==11)
    {
        backimg = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
        
        backdata = UIImagePNGRepresentation(backimg);
        
        NSLog(@"back data ===%@",backdata);
        
    }

    
    
    
    if (tap==2)
    {
        img=[[UIImage alloc]init];
        img = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
        
        NSData* pictureData = UIImagePNGRepresentation(img);
        
        
        if (pictureData.length>0)
        {
            
         /*   UIView   *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,0, self.view.frame.size.width,self.view.frame.size.height )];
            
            polygonView.backgroundColor=[UIColor blackColor];
            
            polygonView.alpha=0.3;
            
            [self.view addSubview:polygonView];
            
            UIActivityIndicatorView    *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            
            
            [polygonView addSubview:spinner];
            
            
            
            
            
            [spinner startAnimating];
            
*/
            
            [self tost];
            
            NSString *url = [NSString stringWithFormat:@"%@/app_verification?country_Id=%@&card_type=drivelisc&userid=%@",App_Domain_Url,country_id,userid];
            
            [obj GlobalDict_image1:url Globalstr_image:@"array" globalimage:pictureData Withblock:^(id result, NSError *error) {
                
                
                if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                {
                    subview1.driverRight.hidden=NO;
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:@"Upload Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alrt show];
                }
               // [polygonView removeFromSuperview];
            }];
        }

    }
    
    
    if (tap==3)
    {
        img=[[UIImage alloc]init];
        
        img = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
        
        NSData* pictureData = UIImagePNGRepresentation(img);
       
        
        
        
        if (pictureData.length>0)
        {
           /* UIView   *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,0, self.view.frame.size.width,self.view.frame.size.height )];
            
            polygonView.backgroundColor=[UIColor blackColor];
            
            polygonView.alpha=0.3;
            
            [self.view addSubview:polygonView];
            
            UIActivityIndicatorView    *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            
            
            [polygonView addSubview:spinner];
            
            
            
            
            
            [spinner startAnimating];
            
*/
            
            [self tost];
            
            
            NSString *url = [NSString stringWithFormat:@"%@/app_verification?country_Id=%@&card_type=vatid&userid=%@",App_Domain_Url,country_id,userid];
            
            [obj GlobalDict_image1:url Globalstr_image:@"array" globalimage:pictureData Withblock:^(id result, NSError *error) {
                
                if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                {
                    subview1.VatidRight.hidden=NO;
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:@"Upload Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alrt show];
                }
                
               // [polygonView removeFromSuperview];
            }];
        }
        
    }
    
    if (tap==4)
    {
        img=[[UIImage alloc]init];
        img = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
        
        NSData* pictureData = UIImagePNGRepresentation(img);
        
        
        
        
        if (pictureData.length>0)
        {
          /*
            UIView   *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,0, self.view.frame.size.width,self.view.frame.size.height )];
            
            polygonView.backgroundColor=[UIColor blackColor];
            
            polygonView.alpha=0.3;
            
            [self.view addSubview:polygonView];
            
            UIActivityIndicatorView    *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            
            
            [polygonView addSubview:spinner];
            
            
            
            
            
            [spinner startAnimating];
            
*/
            [self tost];
            
            NSString *url = [NSString stringWithFormat:@"%@/app_verification?country_Id=%@&card_type=taxid&userid=%@",App_Domain_Url,country_id,userid];
            
            [obj GlobalDict_image1:url Globalstr_image:@"array" globalimage:pictureData Withblock:^(id result, NSError *error) {
                
                if ([[result valueForKey:@"response"]isEqualToString:@"success"])
                {
                    subview1.taxidCardRight.hidden=NO;
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:@"Upload Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alrt show];
                }
                
                //[polygonView removeFromSuperview];
            }];
        }
        
    }
    

    
    
    if (tap==5)
    {
        
        img=[[UIImage alloc]init];
        img = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
        
      otherdata   = UIImagePNGRepresentation(img);
        
        
        
        
    }
    
    
    
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    
    
    
    
    
    
    if (buttonIndex==1)
    {
        _imagePicker.delegate=self;
        
        [self presentViewController:_imagePicker animated:YES completion:nil];
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
   else if(buttonIndex==0)
   {
        _imagePicker.delegate=self;
        [self presentViewController:_imagePicker animated:YES completion:nil];
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        

    }
}


-(void)btn_method:(UIButton *)sender
{
    if (sender.tag==0)
    {
        NSLog(@"0");
        
        
        tap=0;
        
        
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"Camera",
                                @"Photo Gallery",nil];
        
        
        [popup showInView:self.view];
        
        
        
        
        
        
        
        
        
    }
    else if (sender.tag==1)
    {
        NSLog(@"1");
        
        
        
//        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
//                                @"Font Side",
//                                @"Back Side",nil];
//        
//        
//        [popup showInView:self.view];
       
        
        blackview1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        blackview1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel_ByTap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [blackview1 addGestureRecognizer:tapGestureRecognize];

        
        popview1 =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
        
        popview1.backgroundColor=[UIColor whiteColor];
        
        popview1.layer.cornerRadius = 10;
        
        UIImageView *close = [[UIImageView alloc]initWithFrame:CGRectMake(popview1.frame.size.width-30, -35,30, 30)];
        
        close.image=[UIImage  imageNamed:@"Cancel"];
        
        
        [popview1 addSubview:close];

        
        
        UIButton *frontside = [[UIButton alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+20, popview1.frame.size.width-20, popview1.frame.size.height*.2)];
        frontside.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
        
        [frontside setTitle:@"Upload Font Side" forState:UIControlStateNormal];
       // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [frontside addTarget:self action:@selector(fontside) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *backside = [[UIButton alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+frontside.frame.size.height+25, frontside.frame.size.width, frontside.frame.size.height)];
        backside.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
        // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [backside addTarget:self action:@selector(backside) forControlEvents:UIControlEventTouchUpInside];
        [backside setTitle:@"Upload Back Side" forState:UIControlStateNormal];
        
        
        
        
        UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview1.bounds.origin.x+30, frontside.frame.size.height+backside.frame.size.height+50, popview1.frame.size.width-60, frontside.frame.size.height)];
        submit.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
       
        [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [submit setTitle:@"Submit" forState:UIControlStateNormal];
        
        
        blackview1.alpha=.01f;
        
        frontside.layer.cornerRadius = 5;
        backside.layer.cornerRadius =5;
        submit.layer.cornerRadius =5;
        
        [popview1 addSubview:submit];
        [popview1 addSubview:backside];
        
        [popview1 addSubview:frontside];
        
        [self.view addSubview:blackview1];
        
        [self.view addSubview:popview1];
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            
            
            popview1.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            
            blackview1.alpha=1;
            popfrm=popview1.frame;
            
            
        }];
        
        
        
        
    }
    else if (sender.tag==2)
    {
        NSLog(@"2");
        
        
        tap=2;
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"Camera",
                                @"Photo Gallery",nil];
        
        
        [popup showInView:self.view];
    }
    else if (sender.tag==3)
    {
        NSLog(@"3");
        
        tap=3;
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"Camera",
                                @"Photo Gallery",nil];
        
        
        [popup showInView:self.view];
        
        
    }
    else if (sender.tag==4)
    {
        NSLog(@"4");
        
        tap=4;
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"Camera",
                                @"Photo Gallery",nil];
        
        
        [popup showInView:self.view];
        
        
    }
    else if (sender.tag==5)
    {
        NSLog(@"5");
        
        
        
       
        
        
        
        blackview1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        blackview1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        
        blackview1.alpha=.01f;
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap1)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [blackview1 addGestureRecognizer:tapGestureRecognize];
        
        
        
        
        
        
        
        popview1 =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5)];
        
        
        
        
        
        UIButton *otherbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+20, popview1.frame.size.width-20, popview1.frame.size.height*.12)];
        otherbtn.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
        
        otherbtn.layer.cornerRadius = 5;
        
        [otherbtn setTitle:@"Upload Other Document" forState:UIControlStateNormal];
        // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [otherbtn addTarget:self action:@selector(other) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImageView *close = [[UIImageView alloc]initWithFrame:CGRectMake(popview1.frame.size.width-30, -35,30, 30)];
        
        close.image=[UIImage  imageNamed:@"Cancel"];
        
        
        [popview1 addSubview:close];

        
        [popview1 addSubview:otherbtn];
        
        
        othertxt = [[UITextView alloc]initWithFrame:CGRectMake(10,otherbtn.frame.size.height+35,popview1.frame.size.width-20,popview1.frame.size.height * .5)];
        othertxt.delegate=self;
        [othertxt setFont:[UIFont fontWithName:@"Lato" size:14]];
        othertxt.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
                othertxt.layer.cornerRadius= 5;
        [popview1 addSubview:othertxt];
        
        placeholder =[[UILabel alloc]initWithFrame:CGRectMake(othertxt.frame.size.width/2-70,otherbtn.frame.size.height+20,popview1.frame.size.width-20,popview1.frame.size.height * .5)];
        
        [placeholder setFont:[UIFont fontWithName:@"Lato" size:14]];
        
        placeholder.text =@"Please Enter Document type";
        [popview1 addSubview:placeholder];
        
        
        UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview1.bounds.origin.x+35,othertxt.frame.size.width-otherbtn.frame.size.height-10 , popview1.frame.size.width-70, otherbtn.frame.size.height)];
        submit.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
        
        [submit addTarget:self action:@selector(submit1) forControlEvents:UIControlEventTouchUpInside];
        [submit setTitle:@"Submit" forState:UIControlStateNormal];

        submit.layer.cornerRadius =5;
        [popview1 addSubview:submit];
        
        
        popview1.backgroundColor=[UIColor whiteColor];
        
        popview1.layer.cornerRadius = 10;
        [self.view addSubview:blackview1];
        
        [self.view addSubview:popview1];
        
        [UIView animateWithDuration:.3 animations:^{
            
            
            
            popview1.frame =CGRectMake(10, self.view.frame.size.height * .3, self.view.frame.size.width-20, self.view.frame.size.height * .5);
            
            blackview1.alpha=1;
            
            
        }];

        
        
        
        
        
    }

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.keyboardAppearance = UIKeyboardAppearanceAlert;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    placeholder.hidden=YES;
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        popview1.frame= CGRectMake(10, 40, self.view.frame.size.width-20, self.view.frame.size.height * .5);
        
        
    }];
    
    
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if ([text isEqualToString:@"\n"])
    {
        if (textView.text.length==0)
        {
            placeholder.hidden=NO;
        }
        [UIView animateWithDuration:.3 animations:^{
            
            [textView resignFirstResponder];
            popview1.frame =CGRectMake(10, self.view.frame.size.height * .3, self.view.frame.size.width-20, self.view.frame.size.height * .5);
            
            
            
            
        }];
        
           }
    
   
    
    
    return YES;
}








-(void)other
{
    tap=5;
    
    
    [othertxt resignFirstResponder];
    
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        
        popview1.frame =CGRectMake(10, self.view.frame.size.height * .3, self.view.frame.size.width-20, self.view.frame.size.height * .5);
        
        
        
        
    }];
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Camera",
                            @"Photo Gallery",nil];
    
    
    [popup showInView:blackview1];
    
    
    
}


-(void)submit1
{
    
    
    
    
    
  
    if (otherdata.length==0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Faild" message:@"Upload Image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alrt show];
        
    }
    
    
    
    
    
    
    
    
    
    else if (othertxt.text.length==0)
    {
        
        
        
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Faild" message:@"Pleaase Enter Document type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alrt show];
        

    }
    
    
    
    
    
    else
    {
      
        [othertxt resignFirstResponder];
        
     /*
        UIView   *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,0, self.view.frame.size.width,self.view.frame.size.height )];
        
        polygonView.backgroundColor=[UIColor blackColor];
        
        polygonView.alpha=0.3;
        
        [self.view addSubview:polygonView];
        
        UIActivityIndicatorView    *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        
        
        [polygonView addSubview:spinner];
        
        
        
        
        
        [spinner startAnimating];
        
      */
        
        
        
        
        
        [self tost];
        
        
        NSString *url = [NSString stringWithFormat:@"%@/app_verification?country_Id=%@&card_type=other&userid=%@&doc_info=%@",App_Domain_Url,country_id,userid,[othertxt text]];
        
         NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [obj GlobalDict_image1:encodedUrl Globalstr_image:@"array" globalimage:otherdata Withblock:^(id result, NSError *error) {
            
            
            
            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
            {
                
                subview1.otherRight.hidden=NO;
                [UIView animateWithDuration:.3 animations:^{
                    
                    
                    
                    popview1.frame= CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5);
                    
                }
                                 completion:^(BOOL finished)
                 {
                     //[polygonView removeFromSuperview];
                     [blackview1 removeFromSuperview];
                     [popview1 removeFromSuperview];
                     
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:@"Upload Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                     [alrt show];
                     
                 }];
                
            }
            
            
           // [polygonView removeFromSuperview];
        }];
    }

    
    
    
}

-(void)cancelByTap1
{
    
    
    
    otherdata=[[NSData alloc]init];
    
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        popview1.frame= CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5);
        
         blackview1.alpha=.01f;
        
        [othertxt resignFirstResponder];
        
        
    }
     
                     completion:^(BOOL finished)
     {
         
         
         
         [blackview1 removeFromSuperview];
         [popview1 removeFromSuperview];
         
         
         
         
     }];
 
}


-(void)tost

{
    UILabel *upload = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-80, self.view.frame.size.height-100, 150, 35)];
    
    
    
    
    //tostlbl.backgroundColor=[UIColor redColor];
    
    upload.textAlignment = NSTextAlignmentCenter;
    upload.text =@"Uploading..";
    
    
    upload.backgroundColor = [UIColor lightGrayColor];
    
    upload.layer.cornerRadius = 15;
    upload.clipsToBounds=YES;
    upload.alpha =1.0f;
    
    
    
    [self.view addSubview:upload];
    
    
    
    [UIView animateWithDuration:.8f animations:^{
        
        
        upload.alpha=.7f;
        
        
        
    }
                     completion:^(BOOL finished) {
                         
                         
                         
                         
                         
                         
                         [UIView animateWithDuration:.3f animations:^{
                             
                             
                             upload.alpha=.2f;
                             
                         }
                          
                          
                          
                                          completion:^(BOOL finished) {
                                              
                                              
                                              
                                              
                                              [UIView animateWithDuration:.2f animations:^{
                                                  
                                                  
                                                  upload.alpha=.001f;
                                                  
                                                  
                                              }
                                               
                                               
                                               
                                               
                                               
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   
                                                                   [upload removeFromSuperview];
                                                                   
                                                                   
                                                                   
                                                                   
                                                               }];
                                              
                                              
                                          }];
                         
                         
                         
                     }];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)fontside
{
    NSLog(@"font side");
    
    
    tap=10;
    
//
//    [UIView animateWithDuration:.3 animations:^{
//
//       popview.frame= CGRectMake(self.view.frame.size.width, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//    }
//     
//          completion:^(BOOL finished)
//        {
//        
//        
//            
//            [blackview removeFromSuperview];
//            [popview removeFromSuperview];
//            
            UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                    @"Camera",
                                    @"Photo Gallery",nil];
            
            
            [popup showInView:blackview1];

            
            
        
   // }];

    
    
}

-(void)submit



{
    
    
    
    if (frontdata.length==0 )
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Faild" message:@"Please Select Front Side Image " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        
        [alrt show];
    }
    
    else if (backdata.length==0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Faild" message:@"Please Select Back Side Image " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        
        [alrt show];
    }
    
    else
    {
    
//    if (frontdata.length>0)
//    {
//        NSString *url = [NSString stringWithFormat:@"%@/app_verification?country_Id=%@&card_type=idcard&userid=%@",App_Domain_Url,country_id,userid];
//        
//        [obj GlobalDict_image1:url Globalstr_image:@"array" globalimage:frontdata Withblock:^(id result, NSError *error)
//        {
//            
//            
//            
//            
//        }];
//    }
//    if (backdata.length>0)
//    {
//        NSString *url = [NSString stringWithFormat:@"%@/app_verification?country_Id=%@&card_type=idcard&userid=%@",App_Domain_Url,country_id,userid];
//        
//        [obj GlobalDict_image2:url Globalstr_image:@"array" globalimage:backdata Withblock:^(id result, NSError *error)
//        {
//            
//            
//            
//            
//        }];
//    }
        
        
        
        
  /*
     UIView   *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,0, self.view.frame.size.width,self.view.frame.size.height )];
        
        polygonView.backgroundColor=[UIColor blackColor];
        
        polygonView.alpha=0.3;
        
        [self.view addSubview:polygonView];
        
    UIActivityIndicatorView    *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        
        
        [polygonView addSubview:spinner];
            
        
            
            
            
        [spinner startAnimating];
   */
        [self tost];
            NSString *parameter = [NSString stringWithFormat:@"%@app_verification?country_Id=%@&card_type=idcard&userid=%@",App_Domain_Url,country_id,userid];
            
            NSString* encodedUrl = [parameter stringByAddingPercentEscapesUsingEncoding:
                                    NSUTF8StringEncoding];
            
            
            NSLog(@"parameter=%@",parameter);
            
            //        for (int j=0; j<_secondpagedata.count; j++)
            //        {
            //            NSData *imageData = UIImagePNGRepresentation(_secondpagedata[j]);
            //            /
            //            [trucksArray insertObject:imageData atIndex:j];
            //        }
            
            
            //NSLog(@"truckarry======%@",trucksArray);
            
            
            
            if (frontdata.length > 0)
                
            {
                
                
                
                
                AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:encodedUrl]];
                
                
                
                
                
                
                NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:nil parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                    
                    
                    
                [formData appendPartWithFileData:frontdata name:@"front_doc" fileName:@"temp.png" mimeType:@"image/png"];
                    
                    
                    [formData appendPartWithFileData:backdata name:@"back_doc" fileName:@"temp.png" mimeType:@"image/png"];
        
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }];
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                
                
                
                
                
                
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _operation, id responseObject) {
                    
                    
                    
                    
                    
                    
                    
                    NSString *response = [_operation responseString];
                    
                    
                    
                    
                    
                    
                    
                    NSLog(@"response:.... %@",response);
                    
                    NSError *error;
                    
                    NSString *dictString=[NSString stringWithFormat:@"%@", response];//or ur dict reference..
                    
                    NSData *jsonData = [dictString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                          
                                                                         options:NSJSONReadingMutableContainers
                                          
                                                                           error:&error];
                    
                    
                    NSLog(@"json.....%@",json);
                   
                    
                    if ([[json valueForKey:@"response"]isEqualToString:@"success"])
                    {
                        
                        subview1.IdentyRight.hidden=NO;
                        
                        [UIView animateWithDuration:.3 animations:^{
                            
                            popview1.frame= CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
                        }
                         
                                         completion:^(BOOL finished)
                         {
                             
                             
//                             [spinner stopAnimating];
//                             [polygonView removeFromSuperview];
                             
                             [blackview1 removeFromSuperview];
                             [popview1 removeFromSuperview];
                             
                             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[json valueForKey:@"response"] message:@" Upload Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             
                             
                             [alrt show];
                             
                             
                         }];
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                } failure:^(AFHTTPRequestOperation * _operation, NSError *error) {
                    
                    
                    
                    
                    
                    
                    
                    if([_operation.response statusCode] == 403){
                        
                        
                        
                        
                        
                        //  [self checkLoader];
                        
                        NSLog(@"Upload Failed");
                        
                       // [polygonView removeFromSuperview];
                        
                        
                        
                        
                        
                        return;
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }];
                
                
                
                
                
                
                
                [operation start];
                
            }
            
            else
                
            {
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                
                
                
                [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                
                
                
                [request setHTTPShouldHandleCookies:NO];
                
                
                
                [request setURL:[NSURL URLWithString:parameter]];
                
                
                
                [request setTimeoutInterval:100];
                
                
                
                [request setHTTPMethod:@"POST"];
                
                
                
                
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    
                    
                    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                    
                    
                    
                    if( connection )
                        
                    {
                        
                        mutableData = [[NSMutableData alloc] init];
                        
                        
                        
                    }
                    
                    
                    
                }];
                
            }
            
            
            
            
            
            
            
            
            
        

        
        
        
        
        
        
        
    }

}

-(void)cancel_ByTap
{
    frontdata = [[NSData alloc]init];
    
    backdata=[[NSData alloc]init];
    
   
    [UIView animateWithDuration:.3 animations:^{
    
            popview1.frame= CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        
        blackview1.alpha=.01f;
        
        
    }
    
                         completion:^(BOOL finished)
         {
    
    
    
             [blackview1 removeFromSuperview];
             [popview1 removeFromSuperview];
    
    

    
         }];
  
}



-(void)backside

{
    
    NSLog(@"back side");
    
    tap=11;
    
//    [UIView animateWithDuration:.3 animations:^{
//        
//        popview.frame= CGRectMake(self.view.frame.size.width, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
//    }
//     
//                     completion:^(BOOL finished)
//     {
//         
//         
//         
//         [blackview removeFromSuperview];
//         [popview removeFromSuperview];
    
         
         UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                 @"Camera",
                                 @"Photo Gallery",nil];
         
         
         [popup showInView:blackview1];
         
//         
//     }];

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)verifybtntap:(id)sender
{
    
    if (pickercheck==true)
    {
        
   
        
    
   NSString *curl =[NSString stringWithFormat:@"%@/app_country",App_Domain_Url];
    
    
   
    [obj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
         NSMutableArray *tempArray ;
         
         tempArray =[[result valueForKey:@"infoarray"] mutableCopy];
         
         
         
         
         
         
         for (int i=0 ; i<tempArray.count; i++)
         {
             
             
             NSString *tempcounry = [[tempArray objectAtIndex:i]valueForKey:@"country_name"];
             NSString *temp_id = [[tempArray objectAtIndex:i]valueForKey:@"country_id"];
             
             
             
             [countryArry insertObject:tempcounry atIndex:i];
             [country_idArray insertObject:temp_id atIndex:i];
             
             
             
             
             
             
         }
         
         
         
         
         
         
         
         picker.dataSource=self;
         picker.delegate=self;
         
         
         
         if (countryArry.count>0) {
             
             pview.hidden=NO;
             
             temp1=[countryArry objectAtIndex:0];
             country_id = [country_idArray objectAtIndex:0];
             NSLog(@"Temp---%@  %@",temp1,country_id);
         
         [UIView animateWithDuration:.4 animations:^{
             
             
             pview.frame = CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, pview.frame.size.width, pview.frame.size.height);
             
             
         }];
         }
         
         
         [picker selectRow:0 inComponent:0 animated:NO];
        
     }];

    
    }
    else
    {
        [UIView animateWithDuration:.4 animations:^{
            
            verify.frame=buttonfrm;
            subview1.frame= CGRectMake(self.view.frame.size.width+10, self.view.frame.size.height * .35, subview1.frame.size.width, subview1.frame.size.height);
        
        [verify setTitle:@"Choose issuing country" forState:normal];
          
            arroimage.hidden=YES;
        
    //    NSString *curl =[NSString stringWithFormat:@"http://esolzdemos.com/lab1/countries-object-array.json"];
        
        
        
       // [obj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
      //   {
             
             
       //      countryArry = [result valueForKey:@"name"];
             
           //  picker.dataSource=self;
            // picker.delegate=self;
             
             if (countryArry.count>0) {
                 
                 pview.hidden=NO;
                 
                 temp1=[countryArry objectAtIndex:0];
                 country_id = [country_idArray objectAtIndex:0];
                 NSLog(@"Temp---%@   %@",temp1,country_id);
                 
                 [UIView animateWithDuration:.4 animations:^{
                     
                     
                     pview.frame = CGRectMake(0, self.view.frame.size.height-pview.frame.size.height, pview.frame.size.width, pview.frame.size.height);
                     
                     
                     
                     
                      [picker selectRow:0 inComponent:0 animated:NO];
                     
                 }];
             }
             
            
             
             
            
             
       //  }];
            }];

    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return countryArry[row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return countryArry.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
     temp1 =countryArry[row];
    country_id = country_idArray[row];
    
}


- (IBAction)backTap:(id)sender
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}

- (IBAction)pickerDoneBtn:(id)sender
{
    coutnry=temp1;
    NSLog(@"countyid------- %@  county name  %@",country_id,coutnry);
    subview1.hidden=NO;
    pickercheck=false;
    
    
    if (coutnry.length>0)
    {
        [UIView animateWithDuration:.4 animations:^{
            
            pview.frame = CGRectMake(0, self.view.frame.size.height, pview.frame.size.width, pview.frame.size.height);
            
            verify.frame =CGRectMake(0, self.view.frame.origin.y+headerview.frame.size.height, verify.frame.size.width, verify.frame.size.height);
            
             subview1.frame=CGRectMake(self.view.frame.size.width/2-137, self.view.frame.size.height * .35, subview1.frame.size.width   , subview1.frame.size.height);
          
           
           
            
            
            
            
        }
                         completion:^(BOOL finished)
         {
             
             pview.hidden=YES;
             newfrn = verify.frame;
             
             arroimage.hidden=NO;
             arroimage.frame=CGRectMake(verify.frame.size.width-20, verify.frame.size.height/2 -12, 13, 22);
             
             [verify setTitle:coutnry  forState:normal];
             
             
         }];
    
    
    }
    
    
    
    
    
}

- (IBAction)pickerCancelbtn:(id)sender
{
    pickercheck=true;
    
    
    
    [UIView animateWithDuration:.4 animations:^{
        
        pview.frame = CGRectMake(0, self.view.frame.size.height, pview.frame.size.width, pview.frame.size.height);
    }
                     completion:^(BOOL finished)
     {
         
         pview.hidden=YES;
         
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

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


@end
