//
//  photos_View.m
//  FreeWilder
//
//  Created by kausik on 10/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "photos_View.h"

@implementation photos_View

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"photo_View" owner:self options:nil]objectAtIndex:0];
        
    }
    
    return self;
}


@end
