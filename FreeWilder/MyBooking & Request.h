//
//  MyBooking & Request.h
//  FreeWilder
//
//  Created by kausik on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FW_JsonClass.h"
#import "MybookingCell.h"
#import "UIImageView+WebCache.h"

@interface MyBooking___Request : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    
    __weak IBOutlet UITableView *bookingTableview;
    
    FW_JsonClass *obj;
    
    
    NSMutableArray *mainArray;
    
    NSString *userid;
    
}

- (IBAction)BackTap:(id)sender;

@end
