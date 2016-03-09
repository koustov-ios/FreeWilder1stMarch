//
//  PaymentMethodViewController.h
//  FreeWilder
//
//  Created by subhajit ray on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPayMentmethodView.h"

@interface PaymentMethodViewController : UIViewController
{
  
}
- (IBAction)addpaymentmethod:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UIView *pickerview;
- (IBAction)submitpickervalue:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelpicker;
- (IBAction)cancelpicker:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *maintableview;
- (IBAction)back:(id)sender;

@end
