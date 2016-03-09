//
//  Photos & Videos ViewController.h
//  FreeWilder
//
//  Created by kausik on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "UIImageView+WebCache.h"
#import "PEARImageSlideViewController.h"

@interface Photos___Videos_ViewController : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    
    IBOutlet UIImageView *profileImageview;
    IBOutlet UITextField *videocodetxt;
    IBOutlet UIScrollView *picturescroll;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIImageView *backimage;
}
@property (strong ,nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic,retain)PEARImageSlideViewController * slideImageViewController;


- (IBAction)picBtnTap:(id)sender;

- (IBAction)uploadImage:(id)sender;
- (IBAction)udateurl:(id)sender;

@end
