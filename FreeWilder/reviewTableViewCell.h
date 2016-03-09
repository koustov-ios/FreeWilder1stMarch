//
//  reviewTableViewCell.h
//  FreeWilder
//
//  Created by koustov basu on 30/12/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reviewTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *descLbl;
@property (strong, nonatomic) IBOutlet UILabel *locationLbl;
@property (strong, nonatomic) IBOutlet UIImageView *locationIcon;

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *datetTimeIcon;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLbl;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UIView *divider;

@end
