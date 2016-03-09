//
//  notificationsettingsViewController.h
//  FreeWilder
//
//  Created by subhajit ray on 11/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notificationsettingsViewController : UIViewController
- (IBAction)backbtntapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mainview;
- (IBAction)firstvalue:(id)sender;
- (IBAction)secvalue:(id)sender;
- (IBAction)thirdvalue:(id)sender;
- (IBAction)forthvalue:(id)sender;
- (IBAction)fifthvalue:(id)sender;
- (IBAction)sixthvalue:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *one;
@property (weak, nonatomic) IBOutlet UISwitch *two;
@property (weak, nonatomic) IBOutlet UISwitch *three;
@property (weak, nonatomic) IBOutlet UISwitch *four;
@property (weak, nonatomic) IBOutlet UISwitch *five;
@property (weak, nonatomic) IBOutlet UISwitch *six;

- (IBAction)savebtn:(id)sender;

@end
