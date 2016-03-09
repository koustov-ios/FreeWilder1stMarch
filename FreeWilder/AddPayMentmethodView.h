//
//  AddPayMentmethodView.h
//  FreeWilder
//
//  Created by subhajit ray on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol addpaymentmethoddelegate<NSObject>
@end

@interface AddPayMentmethodView : UIView



@property(assign)id<addpaymentmethoddelegate>addpaymentmethoddelegate;
@property (weak, nonatomic) IBOutlet UITextField *cardnumbertextfield;

@property (weak, nonatomic) IBOutlet UITextField *securitycodetextfield;
@property (weak, nonatomic) IBOutlet UITextField *firstnametextfield;
@property (weak, nonatomic) IBOutlet UITextField *lastnametextfield;
@property (weak, nonatomic) IBOutlet UITextField *postalcodetextfiled;

@property (weak, nonatomic) IBOutlet UIButton *cardtypebtn;
@property (weak, nonatomic) IBOutlet UILabel *cardtypedatalabel;

@property (weak, nonatomic) IBOutlet UIButton *monthofexpires;
@property (weak, nonatomic) IBOutlet UIButton *yearofexpires;
@property (weak, nonatomic) IBOutlet UILabel *monthdatalabel;

@property (weak, nonatomic) IBOutlet UILabel *yeardatalabel;

@property (weak, nonatomic) IBOutlet UIButton *nameofcountrybtn;

@property (weak, nonatomic) IBOutlet UILabel *nameofcountrydatalabel;
@property (weak, nonatomic) IBOutlet UIButton *closebtn;
@end
