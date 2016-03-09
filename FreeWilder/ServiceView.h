//
//  ServiceView.h
//  FreeWilder
//
//  Created by kausik on 09/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Serviceview_delegate<NSObject>

@optional
-(void)btn_action:(UIButton *)sender;

@end




@interface ServiceView : UIView
@property(assign)id<Serviceview_delegate>Serviceview_delegate;


- (IBAction)btn_tap:(id)sender;

@end
