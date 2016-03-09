//
//  SignUpViewController.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "ViewController.h"
@interface SignUpViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>
{
    NSString  *Signup_url;
    FW_JsonClass *obj;
   
    
    NSString *strday;
    NSString *strmon;
    NSString *stryear;
   
    IBOutlet UILabel *dateShowlbl;
   UIView *mainView;
    // UIImageView *imageView;
    UIDatePicker* picker;
    UIView *myview;
    IBOutlet UILabel *gender;
    NSString *gen;
    }
- (IBAction)Back_button:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *Signup_name;
@property (strong, nonatomic) IBOutlet UITextField *Signup_email;
@property (strong, nonatomic) IBOutlet UITextField *Signup_password;
@property (strong, nonatomic) IBOutlet UITextField *Signup_confrmpwd;
@property(strong ,nonatomic)NSMutableArray *jsonResult;
- (IBAction)datebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblSignUp;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblDtOfBirth;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@end
