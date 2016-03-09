//
//  PrivacyViewController.h
//  FreeWilder
//
//  Created by subhajit ray on 12/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyViewController : UIViewController


{
    
    IBOutlet UISwitch *socialConnection;
    
    
    IBOutlet UISwitch *FacebookTimeline;
    
    
}
@property (weak, nonatomic) IBOutlet UITextView *sicialcontecttexview;
- (IBAction)backbtntapped:(id)sender;

@end
