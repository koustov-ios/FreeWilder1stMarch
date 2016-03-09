//
//  MybookingCell.h
//  FreeWilder
//
//  Created by kausik on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MybookingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *mainImageview;
@property (strong, nonatomic) IBOutlet UILabel *service_name;
@property (strong, nonatomic) IBOutlet UILabel *seller_name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@property (strong, nonatomic) IBOutlet UILabel *booking_date;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *payment_status;
@property (strong, nonatomic) IBOutlet UIView *subViewContainer;

@end
