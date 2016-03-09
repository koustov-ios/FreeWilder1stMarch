//
//  verifyView.h
//  FreeWilder
//
//  Created by kausik on 17/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol verify_menu_delegate<NSObject>
@optional
-(void)btn_method:(UIButton *)sender;
@end

@interface verifyView : UIView


- (IBAction)button_tap:(UIButton *)sender;
@property(assign)id<verify_menu_delegate>verifyDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *passportRight;

@property (strong, nonatomic) IBOutlet UIImageView *IdentyRight;
@property (strong, nonatomic) IBOutlet UIImageView *driverRight;
@property (strong, nonatomic) IBOutlet UIImageView *VatidRight;
@property (strong, nonatomic) IBOutlet UIImageView *taxidCardRight;
@property (strong, nonatomic) IBOutlet UIImageView *otherRight;


@end
