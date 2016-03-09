//
//  AddServiceViewController.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 01/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "UIImageView+WebCache.h"
#import "calender_View.h"
#import "price_View.h"
#import "overview_View.h"
#import "photos_View.h"
#import "location_View.h"
@interface AddServiceViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,Slide_menu_delegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
       
    // Creating Side menu object
    
    IBOutlet UIButton *savebtn;
    
    IBOutlet UIScrollView *topScroll;
    Side_menu *sidemenu;
    UIView *overlay;
    
    
    IBOutlet UIScrollView *Scroll;
    
    
    IBOutlet UIButton *basicBtn;
    
    IBOutlet UIButton *calenderBtn;
    
    
    
    IBOutlet UIButton *pricing;
    
    IBOutlet UIButton *overViewBtn;
    
    IBOutlet UIButton *photoBtn;
    
    IBOutlet UIButton *location;
    
    
    IBOutlet UIView *GreenLine;
    
    IBOutlet UITextField *quantity_txt;
   
    IBOutlet UITextField *name_text;
    
    IBOutlet UIPickerView *picker1;
   
    
    
    IBOutlet UITextView *keyWordText;
    
    IBOutlet UILabel *textviewplaceholder;
    
    calender_View *CalenderView;
    
        
    UITableViewCell *cell1;
    
    price_View *pricingview;
    
     overview_View *overviewview;
    photos_View *photosview;
    
    location_View *locationview;
    IBOutlet UIScrollView *locationScroll;
    
    
    
    ///Add service
    
    
    IBOutlet UIButton *categoryBtn;
    
    IBOutlet UIView *firstview;
    IBOutlet UIView *Downview;
    
    IBOutlet UIImageView *tapbatImage;
    
    IBOutlet UISwitch *bookingswitch;
    
}
- (IBAction)pickerDone:(id)sender;
- (IBAction)back_button:(id)sender;
- (IBAction)pickerCancelBtn:(id)sender;
- (IBAction)CategoriesTap:(id)sender;



@property (weak, nonatomic) IBOutlet UITextView *description1;
@property (weak, nonatomic) IBOutlet UIView *footer_base;
@property (weak, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)NextClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoto;

- (IBAction)keywordBtntap:(id)sender;

- (IBAction)BasicTap:(id)sender;
- (IBAction)calenderTap:(id)sender;
- (IBAction)Pricing:(id)sender;
- (IBAction)OverViewTap:(id)sender;
- (IBAction)PhotosTap:(id)sender;
- (IBAction)LocationTap:(id)sender;


//save btn
- (IBAction)saveBtnTap:(id)sender;



@end
