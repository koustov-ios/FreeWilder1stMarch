//
//  profile.h
//  FreeWilder
//
//  Created by kausik on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Profile_delegate<NSObject>

@optional

-(void)Profile_BtnTap:(UIButton *)sender;

@end




@interface profile : UIView
@property(assign)id<Profile_delegate>Profile_delegate;

- (IBAction)Profile_BtnTap:(id)sender;



@end
