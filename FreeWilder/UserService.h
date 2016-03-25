//
//  UserService.h
//  FreeWilder
//
//  Created by kausik on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "userServiceCell.h"
#import "UIImageView+WebCache.h"

@interface UserService : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    FW_JsonClass *obj;
    
    
    __weak IBOutlet UITableView *userServicetable;
    
    NSMutableArray *mainArray;
    
}
- (IBAction)BackTap:(id)sender;

@end
