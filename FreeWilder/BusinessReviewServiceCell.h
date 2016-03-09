//
//  BusinessReviewServiceCell.h
//  FreeWilder
//
//  Created by kausik on 05/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessReviewServiceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *servicename;
@property (strong, nonatomic) IBOutlet UILabel *serviceLocation;
@property (strong, nonatomic) IBOutlet UIImageView *star1;
@property (strong, nonatomic) IBOutlet UIImageView *star2;
@property (strong, nonatomic) IBOutlet UIImageView *star3;
@property (strong, nonatomic) IBOutlet UIImageView *star4;
@property (strong, nonatomic) IBOutlet UIImageView *star5;
@property (strong, nonatomic) IBOutlet UIButton *viewnowBtn;

@end
