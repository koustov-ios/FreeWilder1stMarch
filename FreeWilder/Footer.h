//
//  Footer.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol footerdelegate<NSObject>
@optional
-(void)pushmethod:(UIButton *)sender;
@end

@interface Footer : UIView


-(void)TapCheck:(int)Buttontag;

@property(assign)id<footerdelegate>Delegate;


- (IBAction)Footer_button_action:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *mark_line;

@property (weak, nonatomic) IBOutlet UIButton *button1;

@property (weak, nonatomic) IBOutlet UIButton *button2;

@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (weak, nonatomic) IBOutlet UIButton *button4;

@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (strong, nonatomic) IBOutlet UIView *greenline;

@end
