//
//  ProductPaymentViewController.m
//  FreeWilder
//
//  Created by Prosenjit Kolay on 17/11/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "ProductPaymentViewController.h"

@interface ProductPaymentViewController ()

@end

@implementation ProductPaymentViewController
@synthesize lblAdress,lblBCountry,lblBFname,lblBLname,lblBPaytype,lblBPcode,lblCategory,lblPcountry,lblPPaytype,lblprice,lblQuantity,lblTotal,lblType,tvFirst,tvSecond,ImageScroll,ContentScroll,BtnBack,BtnRequest,BtnRate;


//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

-(IBAction)BtnRate:(id)sender
{

   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    ContentScroll.contentSize = CGSizeMake(0,_childView.frame.origin.y+_childView.frame.size.height+5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)BtnBack:(id)sender
{
    
}
-(IBAction)BtnRequest:(id)sender
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
