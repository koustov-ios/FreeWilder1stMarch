//
//  sideMenu.h
//  Side Menu
//
//  Created by koustov basu on 11/02/16.
//  Copyright © 2016 koustov basu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol sideMenu <NSObject>

@optional

-(void)sideMenuAction:(int)tag;


@end


@interface sideMenu : UIView<UITableViewDataSource,UITableViewDelegate>

{

    NSMutableDictionary *expansionDic;
    
    CGFloat menuWidth;
    
    AppDelegate *appDelegate;
    
    NSArray *profileSubArray,*serviceSubArray,*accountSubArray;

}

@property(nonatomic,weak) id <sideMenu> delegate;
@property (strong, nonatomic) IBOutlet UITableView *sideTable;

@property (strong, nonatomic) IBOutlet UIImageView *profilePic;

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;

@end
