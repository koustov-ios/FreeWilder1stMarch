//
//  EditProfileViewController.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 01/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Footer.h"
#import "Side_menu.h"
#import "FW_JsonClass.h"
#import "UrlconnectionObject.h"
#import "UIImageView+WebCache.h"
@interface EditProfileViewController : UIViewController<UITextFieldDelegate,Slide_menu_delegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
{
    Side_menu *sidemenu;
    UIView *overlay;
    FW_JsonClass *globalobj;
    UrlconnectionObject *urlobj;
    NSString *UserId;
    UIActionSheet *actionsheet;
    
    IBOutlet UILabel *emaillbl;
    
    
    IBOutlet UILabel *countrylbl;
    
    IBOutlet UILabel *statelbl;
    
    IBOutlet UITextField *citytxt;
    IBOutlet UITextField *phonenotxt;
    
    IBOutlet UITextField *schoolname1txt;
    
    IBOutlet UITextField *schoolname2txt;
    
    IBOutlet UITextField *schoolname3txt;
    IBOutlet UITextField *schoolname4txt;
    IBOutlet UITextField *schoolname5txt;
    
    IBOutlet UITextField *worktxt;
    
    IBOutlet UITextField *language1txt;
    
    IBOutlet UITextField *language2txt;
    IBOutlet UITextField *language3txt;
    
    IBOutlet UITextField *language4txt;
    
    IBOutlet UILabel *dateofbirthlbl;
    
    IBOutlet UITextView *shortdescriptiontextview;
    
    IBOutlet UILabel *shortdeclbl;
    
    //DatePicker...........
    
    UIDatePicker *Datepicker;
    UIView *myview;
    NSString *strday;
    NSString *strmon;
    NSString *stryear;
    
    
    IBOutlet UIButton *stateBtn;
    
    //Picker ....................
    
    NSString *country;
    NSMutableArray *countryArry;
    IBOutlet UIView *pview;
    IBOutlet UIPickerView *countryPicker;
    
    IBOutlet UIButton *countrybtn;
}
- (IBAction)stateBtnTap:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *footer_base;
- (IBAction)back_button:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImg;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
- (IBAction)SaveClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UILabel *lblPagetitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)ImageClick:(id)sender;
- (IBAction)countryBtnTap:(id)sender;


- (IBAction)PickerCnclBtn:(id)sender;
- (IBAction)PickerDoneBtn:(id)sender;

- (IBAction)DatePickerBtnTap:(id)sender;





@end
