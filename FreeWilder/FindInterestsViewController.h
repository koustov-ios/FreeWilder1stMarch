//
//  FindInterestsViewController.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 01/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "FW_JsonClass.h"
#import "ProductViewController.h"
#import "AppDelegate.h"
@interface FindInterestsViewController : UIViewController<Slide_menu_delegate>

{
    // Creating Side menu object
    
    Side_menu *sidemenu;
    UIView *overlay;
     AppDelegate *appDelegate;
    bool localdata;
    FW_JsonClass *jsonObj;
}
@property (strong, nonatomic) IBOutlet UIView *footer_base;
@property (weak, nonatomic) IBOutlet UIScrollView *findscrollview;
- (IBAction)back_button:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *home;
@property (weak, nonatomic) IBOutlet UIButton *video;
@property (weak, nonatomic) IBOutlet UILabel *lblPageTitle;

@end
