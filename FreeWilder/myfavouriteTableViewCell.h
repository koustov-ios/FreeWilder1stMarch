//
//  myfavouriteTableViewCell.h
//  FreeWilder
//
//  Created by subhajit ray on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myfavouriteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *business_name;
@property (weak, nonatomic) IBOutlet UILabel *fav_user_name;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *business_desc;
@property (weak, nonatomic) IBOutlet UIImageView *fav_user_img;

@end
