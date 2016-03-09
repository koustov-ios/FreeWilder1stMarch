//
//  Footer.m
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Footer.h"

@implementation Footer
@synthesize Delegate;
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
        self=[[[NSBundle mainBundle] loadNibNamed:@"App_Footer" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

-(void)TapCheck:(int)Buttontag
{
    if (Buttontag==1)
    {
        [_mark_line setFrame:CGRectMake(_button1.frame.origin.x, _mark_line.frame.origin.y, _button1.frame.size.width, _mark_line.frame.size.height)];
        
    }
    if (Buttontag==2)
    {
        
            
    [_mark_line setFrame:CGRectMake(_button2.frame.origin.x, _mark_line.frame.origin.y, _button2.frame.size.width, _mark_line.frame.size.height)];
        
    }
    if (Buttontag==3)
    {
        
        
        [_mark_line setFrame:CGRectMake(_button3.frame.origin.x, _mark_line.frame.origin.y, _button3.frame.size.width, _mark_line.frame.size.height)];
        
    }
    if (Buttontag==4)
    {
        
        
        [_mark_line setFrame:CGRectMake(_button4.frame.origin.x, _mark_line.frame.origin.y, _button4.frame.size.width, _mark_line.frame.size.height)];
        
    }
}

- (IBAction)Footer_button_action:(UIButton *)sender
{
    if ([Delegate respondsToSelector:@selector(pushmethod:)])
    {
        
        [Delegate pushmethod:sender];
        
    }

}

@end
