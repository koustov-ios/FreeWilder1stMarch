//
//  rvwViewController.h
//  FreeWilder
//
//  Created by koustov basu on 07/01/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewCell.h"
#import "FW_JsonClass.h"
#import "UIImageView+WebCache.h"

@interface rvwViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UITableView *maintableview;

- (IBAction)review_by_youbtn:(id)sender;

- (IBAction)reviews_about_youbtn:(id)sender;


- (IBAction)BackTap:(id)sender;



@end
