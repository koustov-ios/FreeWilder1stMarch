//
//  ChangePassword.h
//  FreeWilder
//
//  Created by kausik on 11/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePassword : UIViewController<UITextFieldDelegate>
{
    
    __weak IBOutlet UITextField *currentPassword;
    __weak IBOutlet UITextField *changePass;
    __weak IBOutlet UITextField *confirmPass;
}
- (IBAction)changePassBtn:(id)sender;
- (IBAction)BackTap:(id)sender;

@end
