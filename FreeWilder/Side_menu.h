//
//  Side_menu.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Slide_menu_delegate<NSObject>
@optional
-(void)action_method:(UIButton *)sender;
@end

@interface Side_menu : UIView

- (IBAction)Slide_button_tap:(UIButton *)sender;

@property(assign)id<Slide_menu_delegate>SlideDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;

@property (strong, nonatomic) IBOutlet UIButton *btn7;
@property (strong, nonatomic) IBOutlet UIButton *btn8;
@property (strong, nonatomic) IBOutlet UIButton *btn9;

@end
