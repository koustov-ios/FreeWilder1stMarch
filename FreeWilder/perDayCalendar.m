//
//  perDayCalendar.m
//  FreeWilder
//
//  Created by Koustov Basu on 04/04/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import "perDayCalendar.h"

@implementation perDayCalendar

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"perDayCelendar" owner:self options:nil]objectAtIndex:0];
        
    }
    
    return self;
}

@end
