//
//  PayoutPreferenceViewController.h
//  FreeWilder
//
//  Created by subhajit ray on 17/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

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
#import "accountsubview.h"
#import "WishlistViewController.h"
#import "ViewController.h"
#import "sideMenu.h"


@interface PayoutPreferenceViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>

{

     IBOutlet UIButton *payPalmethodBtn;
     IBOutlet UIButton *directMethodBtn;
     IBOutlet UIImageView *directArrow;
     IBOutlet UIImageView *payPalArrow;
    
    __weak IBOutlet UIImageView *paymentAddArrow;
    __weak IBOutlet UIButton *addPaymentBtn;
    
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
    FW_JsonClass *globalobj;


}


- (IBAction)addpayoutbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerviewmain;
@property (weak, nonatomic) IBOutlet UIView *mainpickerview;
- (IBAction)pickercancelbtn:(id)sender;
- (IBAction)pickersubmitbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *maintableview;
- (IBAction)backTap:(id)sender;

@end
