//
//  NotificationViewController.h
//  FreeWilder
//
//  Created by Soumen on 01/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "UIImageView+WebCache.h"
@interface NotificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,Slide_menu_delegate>
{
    // Creating Side menu object
    
    
    IBOutlet UIButton *tapStar;
    
    IBOutlet UIButton *srchBtn;
    IBOutlet UIImageView *topImage;
    IBOutlet UITableView *MsgTable;
    IBOutlet UILabel *TopbarLbl;
    IBOutlet UIImageView *srchImage;
    Side_menu *sidemenu;
    UIView *overlay;
}
@property (strong, nonatomic) IBOutlet UIView *footer_base;
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnnotification;
- (IBAction)MsgMenuTap:(id)sender;
- (IBAction)searchTap:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnStrar;


@end
