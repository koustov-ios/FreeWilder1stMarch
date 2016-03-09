//
//  ServiceView.m
//  FreeWilder
//
//  Created by kausik on 09/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ServiceView.h"

@implementation ServiceView

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"ServiceView" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

- (IBAction)btn_tap:(id)sender {
    [_Serviceview_delegate btn_action:sender];
}
@end
