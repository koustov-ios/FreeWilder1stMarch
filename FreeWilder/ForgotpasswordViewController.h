//
//  ForgotpasswordViewController.h
//  FreeWilder
//
//  Created by soumyajit on 01/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface ForgotpasswordViewController : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UILabel *submit;
    FW_JsonClass *fwobj;
    NSMutableArray *forgotArray;
    IBOutlet UITextField *forgot_Password;
    
}
- (IBAction)submit:(id)sender;

@end
