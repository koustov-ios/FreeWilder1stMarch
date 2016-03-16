//
//  FWServiceOrProductAddingViewController.h
//  FreeWilder
//
//  Created by Koustov Basu on 10/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWServiceOrProductAddingViewController : UIViewController<UITextViewDelegate>


{
    
    __weak IBOutlet UIImageView *dropdownImageView;
    
    __weak IBOutlet UIView *basic_bottomView;
    
    
    __weak IBOutlet UIScrollView *basic_scrollView;
    
    

    __weak IBOutlet UITextField *basic_nameField;

    __weak IBOutlet UIButton *basic_categoryBtn;
    
    IBOutlet UITableView *basic_categoryTable;
    
    __weak IBOutlet UITextField *basic_quntityField;

    __weak IBOutlet UITextField *basic_keywordField;

    __weak IBOutlet UITextField *basic_videoField;
    
    __weak IBOutlet UIButton *basic_instant_yes;
    
    __weak IBOutlet UIButton *basic_instant_no;
    
    
    // Views for creating pop-up
    
    UIView *blackOverLay;
    
    UIView *popUpBaseView;
    
    
}


- (IBAction)basic_categoryTapped:(id)sender;
- (IBAction)basic_instant_yestapped:(id)sender;
- (IBAction)basic_instantNoTapped:(id)sender;




@end
