//
//  Videos_ViewController.h
//  FreeWilder
//
//  Created by kausik on 16/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
@interface Videos_ViewController : UIViewController

@property (strong,nonatomic)NSString *videoCode;
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

- (IBAction)BackTap:(id)sender;

@end
