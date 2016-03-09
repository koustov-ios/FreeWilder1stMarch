//
//  SettingsViewController.h
//  FreeWilder
//
//  Created by kausik on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    __weak IBOutlet UIView *pview;
    
    __weak IBOutlet UIPickerView *picker;
    __weak IBOutlet UILabel *countrylbl;
}
- (IBAction)countryBtn:(id)sender;
- (IBAction)BackBtnTap:(id)sender;
- (IBAction)CancelAccountBtn:(id)sender;
- (IBAction)pickerDoneBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PickerCancelBtn;
- (IBAction)Canclebtn:(id)sender;
- (IBAction)SaveCountry:(id)sender;

@end
