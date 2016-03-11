//
//  Videos_ViewController.m
//  FreeWilder
//
//  Created by kausik on 16/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "Videos_ViewController.h"

@interface Videos_ViewController ()



@end

@implementation Videos_ViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    
    if (self.videoCode.length>0  || self.videoCode !=NULL)
    {
       // [self.playerView loadWithVideoId:self.videoCode];
    }
    
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackTap:(id)sender
{
    
    self.playerView=Nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
