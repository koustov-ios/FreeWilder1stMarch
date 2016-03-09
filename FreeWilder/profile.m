//
//  profile.m
//  FreeWilder
//
//  Created by kausik on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "profile.h"

@implementation profile

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"profile" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

- (IBAction)Profile_BtnTap:(id)sender
{
    [_Profile_delegate Profile_BtnTap:sender];
}
@end
