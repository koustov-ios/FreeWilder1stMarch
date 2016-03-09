//
//  ServiceListingViewController.h
//  FreeWilder
//
//  Created by Priyanka ghosh on 11/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "FW_JsonClass.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "ServiceListCell.h"
#import "Footer.h"
@interface ServiceListingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,Slide_menu_delegate,footerdelegate>
{
    // Creating Side menu object
    
    Side_menu *sidemenu;
    UIView *overlay;
    FW_JsonClass *globalobj;
    NSMutableArray *ArrServiceList;
    AppDelegate *appDelegate;
    bool data;
    NSString *UserId;
}
@property (weak, nonatomic) IBOutlet UITableView *tblService;
- (IBAction)BackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *footer_base;
- (IBAction)AddClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@end
