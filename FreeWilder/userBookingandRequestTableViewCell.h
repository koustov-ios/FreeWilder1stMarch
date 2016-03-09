//
//  userBookingandRequestTableViewCell.h
//  FreeWilder
//
//  Created by subhajit ray on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userBookingandRequestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productnamelbl;
@property (weak, nonatomic) IBOutlet UILabel *buyer_namelbl;
@property (weak, nonatomic) IBOutlet UILabel *order_datelbl;
@property (weak, nonatomic) IBOutlet UILabel *pricelbl;
@property (weak, nonatomic) IBOutlet UILabel *quantity;
@property (weak, nonatomic) IBOutlet UILabel *total_amountlbl;
@property (weak, nonatomic) IBOutlet UILabel *statuslbl;
@property (weak, nonatomic) IBOutlet UILabel *payment_statuslbl;
@property (strong, nonatomic) IBOutlet UIImageView *bookindProductImage;

@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;

@property (strong, nonatomic) IBOutlet UILabel *bottomLbl;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIButton *bottomBtn;

@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@end
