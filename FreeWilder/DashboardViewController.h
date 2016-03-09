//
//  DashboardViewController.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 27/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "FW_JsonClass.h"
#import "ProductViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@interface DashboardViewController : UIViewController<Slide_menu_delegate>
{
    // Creating Side menu object
    
    Side_menu *sidemenu;
    UIView *overlay;
    
    IBOutlet UIImageView *ProfileImageView;
    
    //json class object
    
    FW_JsonClass *globalobj;
    AppDelegate *appDelegate;
    bool localdata;
}
@property (strong, nonatomic) IBOutlet UIView *footer_base;
- (IBAction)more_interests:(id)sender;
- (IBAction)get_started_button:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblhaveBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lblDummyText;
@property (weak, nonatomic) IBOutlet UIButton *btnGetStarted;
@property (weak, nonatomic) IBOutlet UILabel *lblOr;
@property (weak, nonatomic) IBOutlet UILabel *lblfindinterest;
@property (weak, nonatomic) IBOutlet UILabel *lbl2nddummyText;
@property(nonatomic) BOOL fromLangChangePage;

@end
