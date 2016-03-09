//
//  Side_menu.m
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Side_menu.h"
#import "LocalizeHelper.h"

@implementation Side_menu
@synthesize SlideDelegate;

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"Side_menu" owner:self options:nil]objectAtIndex:0];
    }
    self.ProfileImage.layer.cornerRadius=self.ProfileImage.frame.size.height/2.0;
    self.ProfileImage.contentMode=UIViewContentModeScaleAspectFill;
     self.ProfileImage.clipsToBounds = YES;
    
    //Localizing button titles....
    
    [_btn9 setTitle:LocalizedString(@"Log out") forState:UIControlStateNormal];
    
    [_btn8 setTitle:LocalizedString(@"Language & Currency") forState:UIControlStateNormal];
    
    [_btn6 setTitle:LocalizedString(@"Account") forState:UIControlStateNormal];
    
    [_btn5 setTitle:LocalizedString(@"Service") forState:UIControlStateNormal];
    
    [_btn4 setTitle:LocalizedString(@"Business Information") forState:UIControlStateNormal];
    
    [_btn3 setTitle:LocalizedString(@"Profile") forState:UIControlStateNormal];
    
    [_btn2 setTitle:LocalizedString(@"Rate App") forState:UIControlStateNormal];
    
    [_btn1 setTitle:LocalizedString(@"Invite Friends") forState:UIControlStateNormal];
    
    
    
    
    return self;
}

- (IBAction)Slide_button_tap:(UIButton *)sender
{
    
   // if ([SlideDelegate respondsToSelector:@selector(action_method:)])
  //  {
        NSLog(@"##### %ld",(long)sender.tag);
        
        [SlideDelegate action_method:sender];
        
  //  }

}
@end
