//
//  AddPayMentmethodView.m
//  FreeWilder
//
//  Created by subhajit ray on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "AddPayMentmethodView.h"

@implementation AddPayMentmethodView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"AddPaymentMethodview" owner:self options:nil]objectAtIndex:0];
        

        
    }
    
    
    
    
    return self;
}





@end
