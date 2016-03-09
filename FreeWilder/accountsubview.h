//
//  accountsubview.h
//  FreeWilder
//
//  Created by subhajit ray on 09/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol accountsubviewdelegate<NSObject>
@optional
-(void)subviewclick:(UIButton *)sender;
@end

@interface accountsubview : UIView


@property(assign)id<accountsubviewdelegate>accountsubviewdelegate;



@end
