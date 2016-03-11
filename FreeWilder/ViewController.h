//
//  ViewController.h
//  FreeWilder
//
//  Created by Koustov Basu on 01/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "ForgotpasswordViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    IBOutlet UITextField *forgot_Password;
    NSMutableArray *forgotArray;
    CLLocationManager *locationManager;
}

- (IBAction)login_button:(id)sender;
- (IBAction)sign_up:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblLogin;
@property (weak, nonatomic) IBOutlet UILabel *lblFacebook;
@property (weak, nonatomic) IBOutlet UILabel *lbldontHaveAccount;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIButton *btnForgetPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnlogin;

@end

