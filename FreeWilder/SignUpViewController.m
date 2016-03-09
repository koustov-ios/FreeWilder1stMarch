//
//  SignUpViewController.m
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "SignUpViewController.h"
#import "LocalizeHelper.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

{

    UITextField *currentField;
    NSString *countryCode,*tzName;
    
    AppDelegate *appDelegate;
    IBOutlet UILabel *selectGenderLbl;
    IBOutlet UILabel *dobLbl;

}

@property(nonatomic,strong)UISegmentedControl *segControl;

@end

@implementation SignUpViewController
@synthesize lblDtOfBirth,lblGender,lblSignUp,btnSignUp;
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLocale *locale = [NSLocale currentLocale];
    countryCode = [locale objectForKey: NSLocaleCountryCode];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    tzName = [timeZone name];
    
    
    NSLog(@"Country code---> %@",countryCode);
    NSLog(@"Time zone---> %@",tzName);
    
    // Do any additional setup after loading the view.
    
    obj = [[FW_JsonClass alloc]init];
    
    _jsonResult = [[NSMutableArray alloc]init];
    
    
    
    _Signup_confrmpwd.placeholder=[appDelegate.currentLangDic valueForKey:@"Confirm Password"];//LocalizedString(@"Confirm Password");
    _Signup_email.placeholder=[appDelegate.currentLangDic valueForKey:@"Email"];//LocalizedString(@"Email");//@"Email";
    _Signup_name.placeholder=[appDelegate.currentLangDic valueForKey:@"Name"];//LocalizedString(@"Name");//@"Name";
    _Signup_password.placeholder=[appDelegate.currentLangDic valueForKey:@"Password"];//LocalizedString(@"Password");//@"Password";
    
    
    lblSignUp.text=[appDelegate.currentLangDic valueForKey:@"Sign up for Free"];//LocalizedString(@"Sign up for Free");//@"Sign up for Free";
    lblGender.text=[appDelegate.currentLangDic valueForKey:@"Select your Gender"];//LocalizedString(@"Select your Gender");
    lblGender.numberOfLines=2;
    lblDtOfBirth.text=[appDelegate.currentLangDic valueForKey:@"Date of Birth"];//LocalizedString(@"Date of Birth");//@"Date of Birth";
    [btnSignUp setTitle:[appDelegate.currentLangDic valueForKey:@"SIGN UP"]/*LocalizedString(@"SIGN UP")*/ forState:UIControlStateNormal];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    [myview removeFromSuperview];
    
    currentField=textField;
    
    textField.inputAccessoryView = [self keyboardToolBar];
    
    if([textField isEqual:_Signup_name])
    {
        
        [self.segControl setEnabled:NO forSegmentAtIndex:0];
        
        
    }
    
    else     if([textField isEqual:_Signup_confrmpwd])
    {
        
        [self.segControl setEnabled:NO forSegmentAtIndex:1];
        
        
    }

    
    
    
}


- (UIToolbar *)keyboardToolBar {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"Previous", @"Next"]];
    
   //[self.segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    self.segControl.momentary = YES;
    
    [self.segControl addTarget:self action:@selector(changeRow:) forControlEvents:(UIControlEventValueChanged)];
    
    //    [self.segControl setEnabled:NO forSegmentAtIndex:0];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithCustomView:self.segControl];
    
    NSArray *itemsArray = @[nextButton];
    
    [toolbar setItems:itemsArray];
    
    return toolbar;
}



- (void)changeRow:(id)sender {
    
    int idx = (int)[sender selectedSegmentIndex];
    
    if (idx==1) {
        
        if([currentField isEqual:_Signup_name])
            [_Signup_email becomeFirstResponder];
        
        else  if([currentField isEqual:_Signup_email])
            [_Signup_password becomeFirstResponder];
        
        else  if([currentField isEqual:_Signup_password])
            [_Signup_confrmpwd becomeFirstResponder];

        
        
    }
    else if(idx==0){
      
        
        if([currentField isEqual:_Signup_confrmpwd])
            [_Signup_password becomeFirstResponder];
        
        else  if([currentField isEqual:_Signup_password])
            [_Signup_email becomeFirstResponder];
        
        else  if([currentField isEqual:_Signup_email])
            [_Signup_name becomeFirstResponder];
        
        
        
        
    }
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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

- (IBAction)Back_button:(id)sender
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

- (IBAction)Sugn_up:(id)sender {
    
    if ([self TarminateWhiteSpace:_Signup_name.text].length==0)
    {
//        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Name Alert" message:@" Name field blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertreg show];
        _Signup_name.text=@"";
        _Signup_name.placeholder=@"Please enter your name";
        
    }
    else if (![self validateEmail:[_Signup_email text]])
    {
        
    }
    else if ([self TarminateWhiteSpace:_Signup_password.text].length==0)
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Password Alert" message:@"Password  Mismatches" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        _Signup_password.text=@"";
        _Signup_password.placeholder=@"Please enter valid password";
        
        
    }
    else if (_Signup_password.text.length<6)
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Password Alert" message:@"Password  Mismatches" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        _Signup_password.text=@"";
        _Signup_password.placeholder=@"Password be atleast 6 character";
        
        
    }
    else if (![_Signup_password.text isEqualToString:_Signup_confrmpwd.text])
    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Password Alert" message:@"Password  Mismatches" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
        
        _Signup_confrmpwd.text=@"";
        
        _Signup_confrmpwd.placeholder=@"Password doesn't match";

        
    }
    else if (gender.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select your Gender" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (dateShowlbl.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Select Date of Birth" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    else
    {
        
        
        
     //   Signup_url = [NSString stringWithFormat:@"%@verify_app_signup?name=%@&email=%@&password=%@&confirm_password=%@&gender=%@&birth_date=%@",App_Domain_Url,_Signup_name.text,_Signup_email.text,_Signup_password.text,_Signup_confrmpwd.text,gen,dateShowlbl.text];
        
        Signup_url = [NSString stringWithFormat:@"%@verify_app_signup?name=%@&email=%@&password=%@&confirm_password=%@&gender=%@&birth_date=%@&timezone=%@&country_id=%@",App_Domain_Url,[_Signup_name.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_Signup_email.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_Signup_password.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_Signup_confrmpwd.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[gen stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[dateShowlbl.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],tzName,countryCode];
        
        [obj GlobalDict:Signup_url Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             _jsonResult = [result mutableCopy];
             NSLog(@"jsonResult%@",_jsonResult);
             
             
             if ([[_jsonResult valueForKey:@"response"] isEqualToString:@"Success"]) {
                 //             ViewController *obj_view=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
                 //             [self.navigationController pushViewController:obj_view animated:YES];
                 
                 [self back];
                 UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:[_jsonResult valueForKey:@"email"] message:[_jsonResult valueForKey:@"message"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
                 [objAlert show];
                 
                 
                 
             }
             
             
             else{
                 
                 
                 UIAlertView *myAlert = [[UIAlertView alloc]
                                         initWithTitle:[_jsonResult valueForKey:@"response"]
                                         message:[_jsonResult valueForKey:@"message"]
                                         delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Ok",nil];
                 _Signup_name.text= @"";
                 _Signup_email.text=@"";
                 _Signup_password.text = @"";
                 _Signup_confrmpwd.text=@"";
                 dateShowlbl.text = @"";
                 gender.text =@"";
                 [myAlert show];
                 
             }
             
             
         }];
    }
    
}


-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    
    strday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    stryear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strday = [strday substringWithRange:NSMakeRange(4,2)];
    strmon = [strmon substringWithRange:NSMakeRange(0,3)];
    stryear = [stryear substringWithRange:NSMakeRange(7,4)];
   
}



- (IBAction)datebtn:(id)sender {
    
    [self.view endEditing:YES];
    
  
    [myview removeFromSuperview];
 
    
    
    
    
    
    
    myview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height*.6)];
   
   // [myview setBackgroundColor:[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1]];
    
    myview.backgroundColor = [UIColor redColor];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,myview.frame.size.height-42,myview.frame.size.width/2,42)];
    
     UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(btn.frame.origin.x+btn.frame.size.width,btn.frame.origin.y,myview.frame.size.width/2,42)];
    
  
    picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, myview.frame.size.height-btn.frame.size.height)];
   
    
    [picker setBackgroundColor:[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:0.5f]];
    [myview addSubview:picker];
    
    //[picker setBackgroundColor:[UIColor clearColor]];
    [picker setBackgroundColor: [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1]];
    
    picker.datePickerMode=UIDatePickerModeDate;
    //    picker.hidden=NO;
    
    
    NSDate *minYearDate = [[NSDate date] dateByAddingTimeInterval: -473040000.0];
    picker.maximumDate=minYearDate;
    
    
    
    btn.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
    [btn setTitle:[appDelegate.currentLangDic valueForKey:@"Ok"]/*LocalizedString(@"Ok")*/ forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
   
    [myview addSubview:btn];
    
    
   
    btn1.backgroundColor=[UIColor colorWithRed:(51.0f/255.0f) green:(26.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
    [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:[appDelegate.currentLangDic valueForKey:@"Cancel"]/*LocalizedString(@"Cancel")*/ forState: UIControlStateNormal];
   
    [myview addSubview:btn1];
    
    [self.view addSubview:myview];

    
    
    [UIView animateWithDuration:.3f animations:^{
       
        
        
          myview.frame = CGRectMake(0, self.view.frame.size.height*.6, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height*.6);
        
        
    }];
    
    
    
    
    
}

-(void)ok:(id)sender
{
    
 
    
    [UIView animateWithDuration:.3f animations:^{
        
        
        
        myview.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height*.6);
        
        
    }
     completion:^(BOOL finished) {
         
         
         
         [myview removeFromSuperview];
         
     } ];
     
    
    
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    
    strday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    stryear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strday = [strday substringWithRange:NSMakeRange(4,2)];
    strmon = [strmon substringWithRange:NSMakeRange(0,3)];
    stryear = [stryear substringWithRange:NSMakeRange(7,4)];
    [self monthcheck];
    dateShowlbl.text=[NSString stringWithFormat:@"%@/%@/%@",stryear,strmon,strday];
    
   
    
}
-(void)cancel:(id)sender
{
    [UIView animateWithDuration:.3f animations:^{
        
        
        
        myview.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height*.6);
        
        
    }
                     completion:^(BOOL finished) {
                         
                         
                         
                         [myview removeFromSuperview];
                         
                     } ];

}

-(void)monthcheck
{
    if ([strmon isEqualToString:@"Jan"]) {
        strmon=@"1";
    }
    else if ([strmon isEqualToString:@"Feb"]) {
        strmon=@"2";
    }
    else if ([strmon isEqualToString:@"Mar"]) {
        strmon=@"3";
    }
    else if ([strmon isEqualToString:@"Apr"]) {
        strmon=@"4";
    }
    else if ([strmon isEqualToString:@"May"]) {
        strmon=@"5";
    }
    else if ([strmon isEqualToString:@"Jun"]) {
        strmon=@"6";
    }
    else if ([strmon isEqualToString:@"Jul"]) {
        strmon=@"7";
    }
    else if ([strmon isEqualToString:@"Aug"]) {
        strmon=@"8";
    }
    else if ([strmon isEqualToString:@"Sep"]) {
        strmon=@"9";
    }
    else if ([strmon isEqualToString:@"Oct"]) {
        strmon=@"10";
    }
    else if ([strmon isEqualToString:@"Nov"]) {
        strmon=@"11";
    }
    else if ([strmon isEqualToString:@"Dec"]) {
        strmon=@"12";
    }
}
- (IBAction)check:(id)sender
{
    [myview removeFromSuperview];
    
    NSString *actionSheetTitle = @"Select Your Gender"; //Action Sheet Title
    
    NSString *other1 =[appDelegate.currentLangDic valueForKey:@"Male"];// @"Male";
    NSString *other2 = [appDelegate.currentLangDic valueForKey:@"Female"];//@"Female";
    
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2, nil];
    
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            gender.text = @"Male";
            gen=@"M";
            
        }
            break;
        case 1:
        {
            gender.text= @"Female";
            gen=@"F";
        }
            break;
        default:
            break;
    }
    
    
    
    
    
    
}
- (BOOL)validateEmail:(NSString *)emailStr{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if(![emailTest evaluateWithObject:_Signup_email.text])
    {
        ////NSLog(@"Invalid email address found");
//        UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:@"Mail alert" message:@"Please enter valid Emailid." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
//        [objAlert show];
        
        _Signup_email.text=@"";
        _Signup_email.placeholder=@"Please enter valid email id";
        
        return FALSE;
    }
    return TRUE;
}


-(void)back
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.7f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}


-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


@end

