//
//  PaymentMethodViewController.m
//  FreeWilder
//
//  Created by subhajit ray on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PaymentMethodViewController.h"
#import "AddPayMentmethodView.h"
#import "FW_JsonClass.h"
#import "carddetailsTableViewCell.h"
#import "addPaymentNewViewController.h"

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



@interface PaymentMethodViewController ()<addpaymentmethoddelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{
    UIView *detalisview;
    AddPayMentmethodView *subview;
    UIScrollView *mainscroll;
    NSMutableDictionary *tempdic;
    NSMutableArray *data1,*data2,*data3,*data4,*tempdata,*cardhistorydata;
    NSString *firstpikercarddata,*monthdata,*yeardata,*countrynamedata;
    CGRect prevFrame;
    FW_JsonClass *globalobj;
    BOOL tap_chk;
    
    
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
    NSString *userid;

}
@property (weak, nonatomic) IBOutlet UIPickerView *mainpickerview;

@end

@implementation PaymentMethodViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    
    
    
    _mainpickerview.hidden=YES;
    _pickerview.hidden=YES;
    tap_chk=false;
    data1=[[NSMutableArray alloc] initWithObjects:@"Visa",@"Master Card",@"Ameracan Express",@"Discover", nil];
    data2=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    
    data3=[[NSMutableArray alloc] initWithObjects:@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2026",@"2027", nil];
    
    
    data4=[[NSMutableArray alloc] initWithObjects:@"india",@"india",@"india",@"india",@"india",@"india", nil];
    [self urlfire];
    
    
    _maintableview.delegate=self;
    _maintableview.dataSource=self;
    
    [_maintableview setShowsHorizontalScrollIndicator:NO];
    [_maintableview setShowsVerticalScrollIndicator:NO];
    _maintableview.separatorColor = [UIColor clearColor];
    
}


-(void)urlfire
{
    globalobj=[[FW_JsonClass alloc] init];
    tempdata=[[NSMutableArray alloc] init];
    tempdic=[[NSMutableDictionary alloc] init];
    cardhistorydata=[[NSMutableArray alloc] init];
    
     NSString *urlstring1=[NSString stringWithFormat:@"%@app_payment_info?userid=30",App_Domain_Url];
    
     NSString *urlstring=[NSString stringWithFormat:@"http://esolzdemos.com/lab1/countries-object-array.json"];
    [globalobj GlobalDict:urlstring1 Globalstr:@"array" Withblock:^(id result, NSError *error){
        
        NSLog(@"tableviewdata %@",result);
        tempdic=[result mutableCopy];
        cardhistorydata=[tempdic valueForKey:@"infoarray"];
        NSLog(@"tableviewdata %@",cardhistorydata);
        [_maintableview reloadData];
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
        tempdata=[result mutableCopy];
        data4=[tempdata valueForKey:@"name"];
        NSLog(@"data %@",data4);
        }];
     }];
}

- (IBAction)addpaymentmethod:(id)sender
{
    addPaymentNewViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"addPaymentMethod"];
    [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    
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


-(void)close1
{
    [mainscroll removeFromSuperview];
    [subview removeFromSuperview];
    _pickerview.hidden=YES;
    _mainpickerview.hidden=YES;
    [_mainview setHidden:NO];
}


-(void)card
{
    
    _pickerview.hidden=NO;
    _mainpickerview.hidden=NO;
    [self.view addSubview:_pickerview];
    _mainpickerview.delegate=self;
    _mainpickerview.dataSource=self;
    _mainpickerview.tag=1;
    
   subview.cardtypedatalabel.text=[data1 objectAtIndex:0];
    
    firstpikercarddata=subview.cardnumbertextfield.text;
    NSLog(@"first time data %@",firstpikercarddata);
    
    [_mainpickerview selectRow:0 inComponent:0 animated:YES];
    
    [subview.cardnumbertextfield resignFirstResponder];
    [subview.securitycodetextfield resignFirstResponder];
    [subview.firstnametextfield resignFirstResponder];
    [subview.lastnametextfield resignFirstResponder];
    [subview.postalcodetextfiled resignFirstResponder];
}

-(void)month1
{
    _pickerview.hidden=NO;
    _mainpickerview.hidden=NO;
    [self.view addSubview:_pickerview];
    _mainpickerview.delegate=self;
    _mainpickerview.dataSource=self;
    _mainpickerview.tag=2;
    
     subview.monthdatalabel.text=[data2 objectAtIndex:0];
    monthdata=subview.monthdatalabel.text;
    
    [_mainpickerview selectRow:0 inComponent:0 animated:YES];
    
    [subview.cardnumbertextfield resignFirstResponder];
    [subview.securitycodetextfield resignFirstResponder];
    [subview.firstnametextfield resignFirstResponder];
    [subview.lastnametextfield resignFirstResponder];
    [subview.postalcodetextfiled resignFirstResponder];
}


-(void)year1
{
    _pickerview.hidden=NO;
    _mainpickerview.hidden=NO;
    [self.view addSubview:_pickerview];
    _mainpickerview.delegate=self;
    _mainpickerview.dataSource=self;
    _mainpickerview.tag=3;
    
    subview.yeardatalabel.text=[data3 objectAtIndex:0];
    yeardata=subview.yeardatalabel.text;
    
    [_mainpickerview selectRow:0 inComponent:0 animated:YES];
    
    [subview.cardnumbertextfield resignFirstResponder];
    [subview.securitycodetextfield resignFirstResponder];
    [subview.firstnametextfield resignFirstResponder];
    [subview.lastnametextfield resignFirstResponder];
    [subview.postalcodetextfiled resignFirstResponder];
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    return YES;
//}

-(void)country1
{
    _pickerview.hidden=NO;
    _mainpickerview.hidden=NO;
    prevFrame=_pickerview.frame;
    
    [self.view addSubview:_pickerview];
    
     CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
    
        [mainscroll setContentOffset:CGPointMake(0, 290) animated:YES];
        [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+710)];
    }
    else if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
        
        
        if (tap_chk==false)
        {
           [mainscroll setContentOffset:CGPointMake(0, 400) animated:YES];

        }
        else if (tap_chk==true)
        {
            [mainscroll setContentOffset:CGPointMake(0, 440) animated:YES];
            tap_chk=false;
        }
        
        
        [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+710)];
        
        
    }
    
    _mainpickerview.delegate=self;
    _mainpickerview.dataSource=self;
    _mainpickerview.tag=4;
    
    
    subview.nameofcountrydatalabel.text=[data4 objectAtIndex:0];
    
    countrynamedata=subview.nameofcountrydatalabel.text;
    
    
    [_mainpickerview selectRow:0 inComponent:0 animated:YES];
    
    [subview.cardnumbertextfield resignFirstResponder];
    [subview.securitycodetextfield resignFirstResponder];
    [subview.firstnametextfield resignFirstResponder];
    [subview.lastnametextfield resignFirstResponder];
    [subview.postalcodetextfiled resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_mainpickerview.tag==1) {
        return [data1 count];
    }
    else if (_mainpickerview.tag==2)
    {
        return [data2 count];
    }
    else if (_mainpickerview.tag==3)
    {
        return [data3 count];
    }
    else if (_mainpickerview.tag==4)
    {
        return [data4 count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_mainpickerview.tag==1) {
        return [data1 objectAtIndex:row];
    }
    else if (_mainpickerview.tag==2) {
        return [data2 objectAtIndex:row];
    }
    else if (_mainpickerview.tag==3)
    {
        return [data3 objectAtIndex:row];
    }
    else if (_mainpickerview.tag==4)
    {
        return [data4 objectAtIndex:row];
    }
    
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_mainpickerview.tag==1)
    {
        firstpikercarddata=[data1 objectAtIndex:row];
        NSLog(@"%@",firstpikercarddata);
    }
    else if (_mainpickerview.tag==2)
    {
        monthdata=[data2 objectAtIndex:row];
        NSLog(@"%@",monthdata);
    }
    else if (_mainpickerview.tag==3)
    {
        yeardata=[data3 objectAtIndex:row];
    }
    else if (_mainpickerview.tag==4)
    {
        countrynamedata=[data4 objectAtIndex:row];
    }
    
}

- (IBAction)submitpickervalue:(id)sender
{
    if (_mainpickerview.tag==1)
    {
        subview.cardtypedatalabel.text=firstpikercarddata;
        
    }
    else if (_mainpickerview.tag==2)
    {
        subview.monthdatalabel.text=monthdata;
    }
    else if (_mainpickerview.tag==3)
    {
        subview.yeardatalabel.text=yeardata;
    }
    else if (_mainpickerview.tag==4)
    {
        [mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, subview.frame.size.height)];
        subview.nameofcountrydatalabel.text=countrynamedata;
    }
    
    _mainpickerview.hidden=YES;
    _pickerview.hidden=YES;
}
- (IBAction)cancelpicker:(id)sender
{
    if (_mainpickerview.tag==4) {
        [mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, subview.frame.size.height)];
    }
    NSLog(@"hidden");
    _mainpickerview.hidden=YES;
    _pickerview.hidden=YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   // [mainscroll setContentOffset:CGPointMake(0, 0) animated:YES];
    [mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, subview.frame.size.height)];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _pickerview.hidden=YES;
    _mainpickerview.hidden=YES;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    NSLog(@"%f",screenBounds.size.width);
    NSLog(@"%f",screenBounds.size.height);
    
    
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
    
        if (textField==subview.firstnametextfield)
        {
            [mainscroll setContentOffset:CGPointMake(0, 330) animated:YES];
            [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+765)];
        }
        else if (textField==subview.lastnametextfield)
        {
            [mainscroll setContentOffset:CGPointMake(0, 330) animated:YES];
            [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+765)];
        }
        else if (textField==subview.postalcodetextfiled)
        {
            tap_chk=true;

            [mainscroll setContentOffset:CGPointMake(0, 330) animated:YES];
            [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+765)];
        }
        else if (textField==subview.securitycodetextfield)
        {
            [mainscroll setContentOffset:CGPointMake(0, 300) animated:YES];
            [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+765)];
        }

    }
    else
    {
        if (textField==subview.firstnametextfield)
        {
            [mainscroll setContentOffset:CGPointMake(0, 250) animated:YES];
            if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            {
                [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+710)];
            }
            else
            {
                [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+682)];
            }
        }
        else if (textField==subview.lastnametextfield)
        {
            [mainscroll setContentOffset:CGPointMake(0, 250) animated:YES];
            if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            {
                [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+710)];
            }
            else
            {
                [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+682)];
            }
            
        }
        else if (textField==subview.postalcodetextfiled)
        {
            
            [mainscroll setContentOffset:CGPointMake(0, 250) animated:YES];
            if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            {
                [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+710)];
            }
            else
            {
                [mainscroll setContentSize:CGSizeMake(0, subview.frame.size.width+682)];
            }
        }
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [cardhistorydata count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   carddetailsTableViewCell *cell=(carddetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"carddetails"];
    
    
//    NSString *fisrtname=[[cardhistorydata valueForKey:@"exp_year"]objectAtIndex:indexPath.row];
//    NSString *lastname=[[cardhistorydata valueForKey:@"exp_month"]objectAtIndex:indexPath.row];
    
    cell.namelabel.text=[NSString stringWithFormat:@"%@ %@",[[cardhistorydata objectAtIndex:indexPath.row]valueForKey:@"first_name"],[[cardhistorydata objectAtIndex:indexPath.row] valueForKey:@"last_name"]];
    
    cell.cardtypelabel.text=[[cardhistorydata objectAtIndex:indexPath.row] valueForKey:@"card_type"];
    
    cell.datelabel.text=[NSString stringWithFormat:@"%@/%@",[[cardhistorydata objectAtIndex:indexPath.row]valueForKey:@"exp_month"],[[cardhistorydata objectAtIndex:indexPath.row]valueForKey:@"exp_year"]];
    
    return cell;
}





//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    UIView *headerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
//    headerview.backgroundColor=[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1];
//    
//    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 60, 20)];
//    name.text=@"Name";
//    
//    
//    
//    UILabel *cardtype=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20, 0, 80, 20)];
//    cardtype.text=@"Card Type";
//    UILabel *experidate=[[UILabel alloc] init];
//    
//    
//    
//    if (screenBounds.size.height == 568  && screenBounds.size.width == 320) {
//        
//        
//        [experidate setFrame:CGRectMake(self.view.frame.size.width-85, 0, 90, 20)];
//        experidate.text=@"Expiry Date";
//        [experidate setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
//        [cardtype setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
//        [name setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
//        
//    }
//    else
//    {
//        [experidate setFrame:CGRectMake(self.view.frame.size.width-92, 0, 90, 20)];
//        experidate.text=@"Expiry Date";
//        
//        [experidate setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
//        [cardtype setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
//        [name setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
//    }
//    
//    
//    
//    
//    [headerview addSubview:experidate];
//    [headerview addSubview:cardtype];
//    [headerview addSubview:name];
//    return headerview;
//    
//}


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

- (IBAction)back:(id)sender
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}
@end
