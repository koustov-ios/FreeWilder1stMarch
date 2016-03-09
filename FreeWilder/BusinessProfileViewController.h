//
//  BusinessProfileViewController.h
//  FreeWilder
//
//  Created by kausik on 30/09/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"


@interface BusinessProfileViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    
    IBOutlet UIView *pview;
    FW_JsonClass *globalobj;
    
    IBOutlet UIView *languageWorkview;
    
    IBOutlet UIButton *btnDrop;
       IBOutlet UILabel *busnessname;
    IBOutlet UIView *footer_base;
    IBOutlet UILabel *namelbl;
    IBOutlet UITextView *descriptionTextview;
    IBOutlet UILabel *busnissTimelbl;
    IBOutlet UILabel *languagelbl;
    IBOutlet UILabel *worklbl;
    IBOutlet UILabel *schoolname;
    IBOutlet UILabel *reviewLbl;
    IBOutlet UILabel *phoneNumberlbl;
    IBOutlet UIImageView *profileImage;
    IBOutlet UIImageView *topbar;
    IBOutlet UIButton *verifibtn;
    IBOutlet UIButton *busnesshoursbtn;
}
@property (strong, nonatomic) IBOutlet UIScrollView *Scroll;
@property(strong,nonatomic)NSString *BusnessUserId;


- (IBAction)BackTap:(id)sender;
- (IBAction)ServiceBtnTap:(id)sender;
- (IBAction)ReviewBtnTap:(id)sender;
- (IBAction)ReviewAboutMeTap:(id)sender;
- (IBAction)ReviewDropDown:(id)sender;
- (IBAction)BusinessHours:(id)sender;
- (IBAction)ProfileImageTap:(id)sender;
- (IBAction)SchoolTap:(id)sender;
- (IBAction)LocationTap:(id)sender;
- (IBAction)AskQueTap:(id)sender;
- (IBAction)verifid:(id)sender;
- (IBAction)VideoTap:(id)sender;





@end
