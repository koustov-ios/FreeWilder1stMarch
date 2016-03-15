//
//  addPaymentNewViewController.m
//  FreeWilder
//
//  Created by koustov basu on 16/02/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import "addPaymentNewViewController.h"

#import "BKCardNumberField.h"
#import "BKCardExpiryField.h"
#import "BKCurrencyTextField.h"
#import "BKCardNumberLabel.h"
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

#define MAXLENGTH 3

@interface addPaymentNewViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{


    NSMutableArray *countryArray,*country_idArray;
    
    FW_JsonClass *globalobj;
    
    NSString *countryName,*countryId;
    NSString *cardName;
    NSString *cardNumber;
    long month,year;
    

    IBOutlet UIPickerView *country_picker;
    IBOutlet UIButton *saveBtn;
    
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

}

@property (strong, nonatomic) IBOutlet BKCardNumberField *cardNumberField;
@property (strong, nonatomic) IBOutlet UITextField *cvvField;

@property (weak, nonatomic) IBOutlet BKCardNumberLabel *cardNumberLabel;

@property (weak, nonatomic) IBOutlet BKCardExpiryField *cardExpiryField;
@property (weak, nonatomic) IBOutlet BKCurrencyTextField *currencyTextField;

@property (weak, nonatomic) IBOutlet UILabel *cardNumberInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardExpiryLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyTextLabel;

@property (strong, nonatomic) IBOutlet UITextField *cardHoldersNameField;

@property (strong, nonatomic) IBOutlet UITextField *postalCodeField;

@property (strong, nonatomic) IBOutlet UITextField *countryField;

@property (strong, nonatomic) IBOutlet UIView *countryPickerView;



@end

@implementation addPaymentNewViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    saveBtn.layer.cornerRadius=6.0f;
    saveBtn.clipsToBounds=YES;
    
    countryArray=[[NSMutableArray alloc]init];
    country_idArray=[[NSMutableArray alloc]init];
    
    globalobj=[[FW_JsonClass alloc]init];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackOpaque;
    numberToolbar.tintColor=[UIColor colorWithRed:24.0f/255 green:181.0f/255 blue:124.0f/255 alpha:1];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(clearNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.cardNumberField.inputAccessoryView = numberToolbar;
    self.cardExpiryField.inputAccessoryView=numberToolbar;
    self.cvvField.inputAccessoryView=numberToolbar;
    
    _cvvField.delegate=self;
    _cardHoldersNameField.delegate=self;
    _postalCodeField.delegate=self;
    
    self.cardNumberField.showsCardLogo = YES;
    
    [self.cardNumberField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.cardExpiryField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.currencyTextField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.cardNumberField becomeFirstResponder];
    
    self.cardNumberLabel.cardNumberFormatter.maskingCharacter = @"●";       // BLACK CIRCLE        25CF
    self.cardNumberLabel.cardNumberFormatter.maskingGroupIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)];
    
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

    
    
    
    [self getCountries];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldEditingChanged:(id)sender
{
    if (sender == self.cardNumberField) {
        
        cardName= self.cardNumberField.cardCompanyName;
        if (nil == cardName) {
            cardName = @"unknown";
        }
        
        NSLog(@"card company name----> \n %@---> %@",cardName,self.cardNumberField.cardNumber);
        cardNumber=self.cardNumberField.cardNumber;
        
//        self.cardNumberLabel.cardNumber = self.cardNumberField.cardNumber;
        
//        self.cardNumberInfoLabel.text = [NSString stringWithFormat:@"company=%@\nnumber=%@", cardCompany, self.cardNumberField.cardNumber];
        
    } else if (sender == self.cardExpiryField) {
        
        NSDateComponents *dateComp = self.cardExpiryField.dateComponents;
        self.cardExpiryLabel.text = [NSString stringWithFormat:@"month=%ld, year=%ld", dateComp.month, dateComp.year];
        
        
        month=(long)dateComp.month;
        year=(long)dateComp.year;
        
    } else if (sender == self.currencyTextField) {
        
        self.currencyTextLabel.text = [NSString stringWithFormat:@"currencyCode=%@\namount=%@",
                                       self.currencyTextField.numberFormatter.currencyCode,
                                       self.currencyTextField.numberValue.description];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;

}

-(void)clearNumberPad{
    [self.cardNumberField resignFirstResponder];
    [self.cardExpiryField resignFirstResponder];
    [self.cvvField resignFirstResponder];
     self.cardNumberField.text = @"";
     self.cardExpiryField.text = @"";
    self.cvvField.text=@"";
    
}

-(void)doneWithNumberPad
{
    [self.cardNumberField resignFirstResponder];
    [self.cvvField resignFirstResponder];
    [self.cardExpiryField resignFirstResponder];
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:_cvvField])
    {
    
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
    
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
        return newLength <= MAXLENGTH || returnKey;
        
    }
    else
    {
    
        return YES;
    
    }
    
}

-(void)getCountries
{

    NSString *curl =[NSString stringWithFormat:@"%@/app_country",App_Domain_Url];
    
    [globalobj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        NSLog(@"Country result----> %@",result);
        
        NSArray  *temp_countryArr ;
        temp_countryArr= [[result valueForKey:@"infoarray" ] mutableCopy];
        
        
        for (int i=0 ; i<temp_countryArr.count; i++)
        {
            
            
            NSString *tempcounry = [[temp_countryArr objectAtIndex:i]valueForKey:@"country_name"];
            NSString *temp_id = [[temp_countryArr objectAtIndex:i]valueForKey:@"country_id"];
            
            [countryArray insertObject:tempcounry atIndex:i];
           
            [country_idArray insertObject:temp_id atIndex:i];
            
            
        }
        
        [country_picker reloadAllComponents];

        
        
    }];

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return countryArray.count;

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return [countryArray objectAtIndex:row];

}

- (IBAction)pickerDoneTapped:(id)sender {
    
    if(countryName.length==0)
    {
      countryName=[countryArray objectAtIndex:0];
        
        countryId=[country_idArray objectAtIndex:0];
    }
    
    _countryField.text=countryName;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        NSLog(@"Country picker appearing....");
        
        _countryPickerView.frame=CGRectMake(_countryPickerView.frame.origin.x, self.view.bounds.size.height, _countryPickerView.frame.size.width, _countryPickerView.frame.size.height);
        
        
    }];
    
}
- (IBAction)pickerCancelTapped:(id)sender {
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        NSLog(@"Country picker appearing....");
        
        _countryPickerView.frame=CGRectMake(_countryPickerView.frame.origin.x, self.view.bounds.size.height, _countryPickerView.frame.size.width, _countryPickerView.frame.size.height);
        
        
    }];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    countryName=[countryArray objectAtIndex:row];
    
    countryId=[country_idArray objectAtIndex:row];
    
   // _countryField.text=countryName;

}

- (IBAction)countryClicked:(id)sender
{
    
    if(countryArray.count>0)
    {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        NSLog(@"Country picker appearing....");
        
        _countryPickerView.frame=CGRectMake(_countryPickerView.frame.origin.x, self.view.bounds.size.height-_countryPickerView.frame.size.height, _countryPickerView.frame.size.width, _countryPickerView.frame.size.height);
        
        
    }];
    }
    else
    {
    
        UIAlertController * nocountryAlertView=   [UIAlertController
                                     alertControllerWithTitle:@"Network Error"
                                     message:@"Country Data Not Available"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [nocountryAlertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
//        UIAlertAction* cancel = [UIAlertAction
//                                 actionWithTitle:@"Cancel"
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [nocountryAlertView dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                 }];
        
        
        [nocountryAlertView addAction:ok];
       // [nocountryAlertView addAction:cancel];
        [self presentViewController:nocountryAlertView animated:YES completion:nil];
    
    }
    
    
    
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


-(void)doneWithNumberPad_phone
{
    
    
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
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad_phone)]];
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
#pragma mark - save card details

- (IBAction)saveCardDetails:(id)sender {
    
    if(_cardNumberField.text.length==0 || [cardName isEqualToString:@"unknown"] || [self luhnCheck:cardNumber]==NO)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Provide a valid Card Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }
    else
    {
     
        if(_cardExpiryField.text.length==0 || month==0 || year==0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Provide card expiry date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
        else
        {
        
            if(_cvvField.text.length==0 && _cvvField.text.length<3)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Provide valid CVV code." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }
            else
            {
            
                if(_cardHoldersNameField.text.length==0)
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Provide card holders name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                }
                else
                {
                
                    if(_postalCodeField.text.length==0)
                    {
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Provide valid Postal code." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                    else
                    {
                    
                        if(_countryField.text.length==0)
                        {
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Provide country Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            
                        }
                        else
                        {
                        
                          //URL fire
                            
       
                            NSString *userId=[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"];
                            
                            NSString *urlStr =[NSString stringWithFormat:@"%@app_user_service/app_payout_method?userid=%@&card_type=%@&month=%ld&year=%ld&first_name=%@&last_name=&card_no=%@&security_code=%@&postal_code=%@&country_id=%@",App_Domain_Url,userId,cardName,month,year,_cardHoldersNameField.text,cardNumber,_cvvField.text,_postalCodeField.text,countryId];
                            
                            urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            [globalobj GlobalDict:urlStr Globalstr:@"array" Withblock:^(id result, NSError *error) {
                                
                                NSLog(@"card Details Saving details.... \n %@",result);
                                
                            }];
                            
                        
                        }
   
                    
                    }
                
                }
            
            }

        
        }
    
    }
    
    
}


- (NSArray *) toCharArray:(NSString *)str
{
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[str length]];
    for (int i=0; i < [str length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%C", [str characterAtIndex:i]];
        [characters addObject:ichar];
    }
    
    return characters;
}

-(BOOL) luhnCheck:(NSString *)stringToTest
{
    
    NSArray *stringAsChars = [self toCharArray:stringToTest];
    
    BOOL isOdd = YES;
    int oddSum = 0;
    int evenSum = 0;
    
    for (int i = (int)[stringToTest length] - 1; i >= 0; i--) {
        
        int digit = [(NSString *)stringAsChars[i] intValue];
        
        if (isOdd)
            oddSum += digit;
        else
            evenSum += digit/5 + (2*digit) % 10;
        
        isOdd = !isOdd;				 
    }
    
    return ((oddSum + evenSum) % 10 == 0);
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}



- (IBAction)backToPrev:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:NO];
}

@end
