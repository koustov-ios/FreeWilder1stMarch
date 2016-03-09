//
//  MsgSideMenu.m
//  FreeWilder
//
//  Created by kausik on 29/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "MsgSideMenu.h"

@implementation MsgSideMenu

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"MsgSideMenu" owner:self options:nil]objectAtIndex:0];
        
    }
    
    return self;
}

@end
