//
//  WishlistViewController.h
//  FreeWilder
//
//  Created by Priyanka ghosh on 13/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "FW_JsonClass.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "ServiceListCell.h"
#import "Footer.h"
@interface WishlistViewController : UIViewController
{
    
    
    Side_menu *sidemenu;
    UIView *overlay;
    FW_JsonClass *globalobj;
    NSMutableArray *ArrWishList;
    AppDelegate *appDelegate;
    bool data;
    NSString *UserId;
}
- (IBAction)BackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblWishlist;
@property (weak, nonatomic) IBOutlet UITableView *tblWishList;
@property (weak, nonatomic) IBOutlet UIView *footer_base;
@property (weak, nonatomic) IBOutlet UILabel *lblPageTitle;

@end
