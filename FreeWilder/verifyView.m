//
//  verifyView.m
//  FreeWilder
//
//  Created by kausik on 17/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "verifyView.h"

@implementation verifyView
@synthesize verifyDelegate;

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"verifyView" owner:self options:nil]objectAtIndex:0];
    }
        return self;
}

-(IBAction)button_tap:(UIButton *)sender
{
    [verifyDelegate btn_method:sender];
}

@end
