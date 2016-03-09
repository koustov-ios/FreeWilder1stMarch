//
//  addpayoutmethod.m
//  FreeWilder
//
//  Created by subhajit ray on 17/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "addpayoutmethod.h"

@implementation addpayoutmethod

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"addpayoutmethod" owner:self options:nil]objectAtIndex:0];
        _nameofcountrybtn.layer.borderWidth=1.0f;
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    
    self.accountNo.delegate=self;
    
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"keyboard shown");
    
    keyBoardHeight=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if([self.accountNo isFirstResponder])
    {
        
        NSLog(@"M here....");
        
//        [UIView animateWithDuration:0.4 animations:^{
//            
//            _mainView.frame=CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y-keyBoardHeight, _mainView.frame.size.width, _mainView.frame.size.height);
//            
//        }];
        
    }
 }

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

   
  

}
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//
//    [textField resignFirstResponder];
//    
//    if(textField==self.accountNo)
//    {
//        
//        NSLog(@"M here");
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            
//            _mainView.frame=CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y+keyBoardHeight, _mainView.frame.size.width, _mainView.frame.size.height);
//            
//        }];
//        
//    }
//    
//    
//    return YES;
//
//}


@end
