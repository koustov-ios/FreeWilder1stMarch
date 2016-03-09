//
//  PrivacyViewController.m
//  FreeWilder
//
//  Created by subhajit ray on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PrivacyViewController.h"
#import "FW_JsonClass.h"

@interface PrivacyViewController ()<UITextViewDelegate>
{
    FW_JsonClass *obj;
    NSString *userid;
    NSString *ON1,*ON2;
    
}

@end

@implementation PrivacyViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    obj =[[FW_JsonClass alloc]init];
    _sicialcontecttexview.delegate=self;
    _sicialcontecttexview.editable=NO;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
       userid=[prefs valueForKey:@"UserId"];
    
    
    NSString *url= [NSString stringWithFormat:@"%@app_privacy?userid=%@",App_Domain_Url,userid];
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
       
        
        NSMutableDictionary *dic = [result valueForKey:@"infoarray"];
        
        
        ON1 = [dic valueForKey:@"field_one"];
        ON2=[dic valueForKey:@"field_two"];
        
        
        
        if ([[dic valueForKey:@"field_one"]isEqualToString:@"Y"])
        {
           [socialConnection setOn:YES animated:YES];
        }
        if ([[dic valueForKey:@"field_two"]isEqualToString:@"Y"])
       
        {
            [FacebookTimeline setOn:YES animated:YES];
        }
        
        
        
        
        
        
        
    }];
    
    
    
    
    
    
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [textView setSelectedRange:NSMakeRange(NSNotFound, 0)];
}

- (IBAction)backbtntapped:(id)sender
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)first:(id)sender
{
     if([sender isOn])
     {
         ON1=@"Y";
         
         
     
     }
    
    else
    {
        ON1=@"N";

    }
     
}

- (IBAction)second:(id)sender
{
    if([sender isOn])
    {
        ON2=@"Y";
        
        
        
    }
    
    else
    {
        ON2=@"N";
        
    }
}



- (IBAction)SaveTap:(id)sender
{
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@app_privacy_update?userid=%@&field_one=%@&field_two=%@",App_Domain_Url,userid,ON1,ON2];
    
    
    NSLog(@"URL----%@",url);
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
       
        
        
        UIAlertView *alrt =[[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
        
        [alrt show];
        
        
    }];
    
    
    
    
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
