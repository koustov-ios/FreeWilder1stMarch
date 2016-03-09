//
//  InviteFriendViewController.h
//  FreeWilder
//
//  Created by Soumen on 01/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "UIImageView+WebCache.h"
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>

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


@interface FW_InviteFriendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,Slide_menu_delegate,UISearchBarDelegate,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{
    // Creating Side menu object
    
    Side_menu *sidemenu;
   // UIView *overlay;
    NSInteger IsSearch;
    



}

//@property (strong, nonatomic) IBOutlet UIView *footer_base;
@property (strong, nonatomic) IBOutlet UITextField *searchtextfield;

- (IBAction)Back_button_action:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblInviteFriend;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;
@property (weak, nonatomic) IBOutlet UILabel *lblNoDataFound;

@end
