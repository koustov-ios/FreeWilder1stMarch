//
//  Trust And Verification ViewController.h
//  FreeWilder
//
//  Created by kausik on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Trust_And_Verification_ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    
    __weak IBOutlet UIImageView *arroimage;
    IBOutlet UIImageView *headerview;
    IBOutlet UIPickerView *picker;
    IBOutlet UIView *pview;
    IBOutlet UIButton *verify;
}
@property (strong ,nonatomic) UIImagePickerController *imagePicker;

- (IBAction)verifybtntap:(id)sender;
- (IBAction)backTap:(id)sender;
- (IBAction)pickerDoneBtn:(id)sender;
- (IBAction)pickerCancelbtn:(id)sender;
@end
