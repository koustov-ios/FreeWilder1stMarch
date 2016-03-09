//
//  price_View.h
//  FreeWilder
//
//  Created by kausik on 10/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface price_View : UIView
@property (strong, nonatomic) IBOutlet UIView *Per_Day_Pricing_view;
@property (strong, nonatomic) IBOutlet UIView *Slot_Pricing_view;
@property (strong, nonatomic) IBOutlet UIScrollView *Per_day_pricing_Scroll;
@property (strong, nonatomic) IBOutlet UIButton *CurrencyBtn;

@end
