//
//  addpayoutmethod.h
//  FreeWilder
//
//  Created by subhajit ray on 17/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol addpayoutdelegate<NSObject>
@end

@interface addpayoutmethod : UIView<UITextFieldDelegate>

{

    float keyBoardHeight;

}

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UITextField *bankName;
@property(assign)id<addpayoutdelegate>addpayoutdelegate;
@property (weak, nonatomic) IBOutlet UIButton *closebtn;
@property (weak, nonatomic) IBOutlet UITextField *addresstextfield;

@property (weak, nonatomic) IBOutlet UITextField *satetextfield;
@property (weak, nonatomic) IBOutlet UITextField *citytextfield;
@property (weak, nonatomic) IBOutlet UITextField *postaltextfield;
@property (weak, nonatomic) IBOutlet UIButton *nextbtn;
@property (weak, nonatomic) IBOutlet UIButton *closesubviewbtn;
@property (weak, nonatomic) IBOutlet UIButton *nameofcountrybtn;
@property (weak, nonatomic) IBOutlet UILabel *countrydatashowlabel;
@property (weak, nonatomic) IBOutlet UITextField *nameOnAccount;
@property (weak, nonatomic) IBOutlet UITextField *accountNo;

@property (weak, nonatomic) IBOutlet UIButton *nextBtnAction;


@end
