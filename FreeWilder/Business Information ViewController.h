//
//  Business Information ViewController.h
//  FreeWilder
//
//  Created by kausik on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Business_Information_ViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    
    IBOutlet UITextField *nametxt1;
    IBOutlet UITextField *valuetxt1;
    __weak IBOutlet UIScrollView *scroll;
    
    
    __weak IBOutlet UITextField *business_name;
    
    __weak IBOutlet UITextField *Location;
    
    IBOutlet UITextField *Facebook_link;
    
    IBOutlet UITextField *website_Link;
    IBOutlet UITextField *phone;
    
    IBOutlet UITextField *Taxid;
    
    IBOutlet UITextField *Bank_Acount;
    
    IBOutlet UITextView *Address;
    IBOutlet UITextView *Discrption;
    
    
    IBOutlet UILabel *addresslbl;
    
    IBOutlet UILabel *descriptionlbl;
}
@property (strong, nonatomic) IBOutlet UIButton *updateDetailBtn;

- (IBAction)updateDetailBtnTap:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)addInfoBtnTap:(id)sender;

@end
