//
//  ForgotpasswordViewController.m
//  FreeWilder
//
//  Created by soumyajit on 01/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ForgotpasswordViewController.h"

@interface ForgotpasswordViewController ()

@end

@implementation ForgotpasswordViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    forgotArray = [[NSMutableArray alloc]init];
    fwobj =[[FW_JsonClass alloc]init];
    
    [submit setBackgroundColor:[UIColor colorWithRed:102/255.f green:82/255.f blue:99/255.f alpha:1]];
    
    forgot_Password.placeholder=@"Email ID";
    submit.text=@"SUBMIT";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Back_button:(id)sender
{
    [self POPViewController];
}
-(void)POPViewController
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submit:(id)sender {
    
    
    if (![self validateEmail:[forgot_Password text]])
        {
            
        }

    else{
    
        NSString *urlForgot=[NSString stringWithFormat:@"%@verify_app_forgot?email=%@",App_Domain_Url,forgot_Password.text];
         [fwobj GlobalDict:urlForgot Globalstr:@"array" Withblock:^(id result, NSError *error) {
    
             forgotArray = [result mutableCopy];
             NSLog(@"ForgotArray%@",forgotArray);
             if ([[forgotArray valueForKey:@"response"] isEqualToString:@"success"])
             {
                 [self POPViewController];
                 UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:[forgotArray valueForKey:@"email"] message:[forgotArray valueForKey:@"message"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
                 [objAlert show];
                 
             }
             
             else
             {
                 
                 forgot_Password.text = @"";
                 UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:[forgotArray valueForKey:@"response"] message:[forgotArray valueForKey:@"message"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                 [objAlert show];
             }
    
        }];
    }
    
}

- (BOOL)validateEmail:(NSString *)emailStr{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if(![emailTest evaluateWithObject:forgot_Password.text])
    {
        ////NSLog(@"Invalid email address found");
//        UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:@"Mail alert" message:@"Please enter valid Emailid." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
//        [objAlert show];
        
        
        forgot_Password.placeholder=@"Enter valid email id";
        
        return FALSE;
    }
    return TRUE;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}


@end
