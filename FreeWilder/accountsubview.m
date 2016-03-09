//
//  accountsubview.m
//  FreeWilder
//
//  Created by subhajit ray on 09/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "accountsubview.h"

@implementation accountsubview

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"accountsubview" owner:self options:nil]objectAtIndex:0];
    }
    
    
    
    
    return self;
}
- (IBAction)btntapped:(id)sender
{
    [_accountsubviewdelegate subviewclick:sender];
}

@end
