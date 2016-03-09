//
//  LanguageViewController.m
//  FreeWilder
//
//  Created by Somenath on 20/08/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "LanguageViewController.h"
#import "DashboardViewController.h"

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


@interface LanguageViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{
    UIView *pickerview;
    UIPickerView *picker;
    NSMutableDictionary *lanDic, *currDic;
    NSMutableArray *langArr, *currArr;
    NSInteger tapcheck;
    NSString *lang, *curr;
    NSString *lang_code, *curr_id;
    NSUserDefaults *defaults;
    
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

}


@property (strong, nonatomic) IBOutlet UIButton *languageSelectBtn;
@property (strong, nonatomic) IBOutlet UIButton *currencyBtn;
@property (strong, nonatomic) IBOutlet UILabel *languageLbl;
@property (strong, nonatomic) IBOutlet UILabel *currencyLbl;
@property (strong, nonatomic) IBOutlet UIButton *doneBtn;
@end

@implementation LanguageViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    globalobj = [[FW_JsonClass alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSLog(@"lang code=%@, curr_id=%@",[prefs valueForKey:@"lang_code"],[prefs valueForKey:@"curr_id"]);
    lang_code = [prefs valueForKey:@"lang_code"];
    curr_id = [prefs valueForKey:@"curr_id"];
    
    
    
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

    

    
    _languageSelectBtn.layer.borderWidth = 1.0f;
    _languageSelectBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
    _languageSelectBtn.layer.cornerRadius = 6.0f;
    _languageSelectBtn.layer.masksToBounds = YES;
    
    _currencyBtn.layer.borderWidth = 1.0f;
    _currencyBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
    _currencyBtn.layer.cornerRadius = 6.0f;
    _currencyBtn.clipsToBounds = YES;
    
    _doneBtn.layer.borderWidth = 1.0f;
    _doneBtn.layer.borderColor = [UIColor colorWithRed:24.0f/255.0f green:181.0f/255.0f blue:124.0f/255.0f alpha:1].CGColor;
    _doneBtn.layer.cornerRadius = 6.0f;
    _doneBtn.clipsToBounds = YES;
    
//    lang_code = @"en";
//    curr_id = @"3";
    
    NSLog(@"lang code and cur id %@,%@",lang_code,curr_id);
    
    NSString *langStr = [NSString stringWithFormat:@"%@app_language",App_Domain_Url];
    NSString *currStr = [NSString stringWithFormat:@"%@app_currency",App_Domain_Url];
    
    NSLog(@"Lang url-----> %@",langStr);
    
    [globalobj GlobalDict:langStr Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        NSLog(@"Lang array-----> %@",result);
        
        lanDic = [result mutableCopy];
        langArr = [lanDic valueForKey:@"infoarray"];
        if ([[prefs valueForKey:@"language"] isEqualToString:@"en"])
        {
            _languageLbl.text = @"English";
        }
        else if ([[prefs valueForKey:@"language"] isEqualToString:@"pl"])
        {
            _languageLbl.text = @"Polish";
        }
        else if ([[prefs valueForKey:@"language"] isEqualToString:@"vi"])
        {
            _languageLbl.text = @"Vietnamese";
        }
//
//        [picker reloadAllComponents];
        [globalobj GlobalDict:currStr Globalstr:@"array" Withblock:^(id result, NSError *error) {
            currDic = [result mutableCopy];
            currArr = [currDic valueForKey:@"infoarray"];
            if ([[prefs valueForKey:@"curr_id"] isEqualToString:@"1"])
            {
                _currencyLbl.text = @"INR";
            }
            else if ([[prefs valueForKey:@"curr_id"] isEqualToString:@"2"])
            {
                _currencyLbl.text = @"EUR";
            }
            else if ([[prefs valueForKey:@"curr_id"] isEqualToString:@"3"])
            {
                _currencyLbl.text = @"USD";
            }
            else if ([[prefs valueForKey:@"curr_id"] isEqualToString:@"4"])
            {
                _currencyLbl.text = @"PLN";
            }
            
        }];
    }];
}

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

-(void)createpicker
{
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 256, self.view.frame.size.width, 256)];
    
    //    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor colorWithRed:92.0f/255.0 green:92.0f/255.0f blue:92.0f/255.0f alpha:1];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor colorWithRed:74.0f/255.0f green:182.0f/255.0f blue:125.0f/255.0f alpha:1];;
    [okbtn setTitle:@"Ok" forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okaction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - 40)];
    
    [pickerview addSubview:picker];
    [self.view addSubview:pickerview];
    //    [picker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    
    picker.delegate = self;
    picker.dataSource = self;
}

-(void)okaction
{
    NSString *select;
    if (tapcheck == 1)
    {
        select = [[langArr objectAtIndex:[picker selectedRowInComponent:0]] valueForKey:@"lang_name"];
        lang_code = [[langArr objectAtIndex:[picker selectedRowInComponent:0]] valueForKey:@"lang_code"];
        
        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        [userData setObject:[lang_code lowercaseString] forKey:@"language"];
        [userData synchronize];
        NSString *currentLang=[userData valueForKey:@"language"];
        NSLog(@"Current lang----> %@",currentLang);
        
        NSLog(@"Current lang----> %@",currentLang);
        
        if(![currentLang isKindOfClass:[NSString class]])
        {
            LocalizationSetLanguage(@"en");
            
        }
        else
        {
            LocalizationSetLanguage(currentLang);
            
        }



        NSLog(@"picker selected:----%@lang_code-%@, curr_id-%@",select,lang_code,curr_id);
        _languageLbl.text = select;
        [pickerview removeFromSuperview];
    }
    else if (tapcheck == 2)
    {
        select = [[currArr objectAtIndex:[picker selectedRowInComponent:0]] valueForKey:@"cur_name"];
        curr_id = [[currArr objectAtIndex:[picker selectedRowInComponent:0]] valueForKey:@"id"];
        NSLog(@"picker selected:----%@,lang_code-%@, curr_id-%@",select,lang_code,curr_id);
        _currencyLbl.text = select;
        [pickerview removeFromSuperview];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:lang_code  forKey:@"lang_code"];
    [[NSUserDefaults standardUserDefaults] setObject:curr_id  forKey:@"curr_id"];
    
    
}

-(void)cancelaction
{
    [pickerview removeFromSuperview];
}

- (IBAction)languageBtnTapped:(id)sender
{
    tapcheck = 1;
    [pickerview removeFromSuperview];
    [self createpicker];
}

- (IBAction)currencyTapped:(id)sender
{
    tapcheck = 2;
    [pickerview removeFromSuperview];
    [self createpicker];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count;
    if (tapcheck == 1)
    {
        count = [langArr count];
    }
    else if (tapcheck == 2)
    {
        count = [currArr count];
    }
    
    return count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    if (tapcheck == 1)
    {
        title = [[langArr objectAtIndex:row] valueForKey:@"lang_name"];
    }
    else if (tapcheck == 2)
    {
        title = [[currArr objectAtIndex:row] valueForKey:@"cur_name"];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (tapcheck == 1)
    {
        lang = langArr[row];
    }
    else if (tapcheck == 2)
    {
        curr = currArr[row];
    }
}

- (IBAction)doneTapped:(id)sender
{
    DashboardViewController *dash = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
    NSLog(@"Lang code--> %@",lang_code);

    NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
    [userData setObject:[lang_code lowercaseString] forKey:@"language"];
    [userData synchronize];
    
    NSString *currentLang=[userData objectForKey:@"language"];
    
    NSLog(@"Current lang----> %@",currentLang);
    
    if(![currentLang isKindOfClass:[NSString class]])
    {
        LocalizationSetLanguage(@"en");
        
    }
    else
    {
        LocalizationSetLanguage(currentLang);
        
    }

    dash.fromLangChangePage=YES;
    
    
    
    AppDelegate *appObj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *theContext=[appObj managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"LanguageTable"];
    [fetchRequest1 setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSArray *fetchedObjects1 =[[NSArray alloc]initWithObjects:[[theContext executeFetchRequest:fetchRequest1 error:nil] objectAtIndex:0], nil];
    NSDictionary *myLangDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fetchedObjects1[0] valueForKey:@"langDic"]];
    appObj.currentLangDic=[myLangDic valueForKey:currentLang];

    [self PushViewController:dash WithAnimation:kCAMediaTimingFunctionEaseIn];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
