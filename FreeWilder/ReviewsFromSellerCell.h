//
//  ReviewsFromSellerCell.h
//  FreeWilder
//
//  Created by kausik on 05/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewsFromSellerCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *reviewdesc;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *reviewdate;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *star1;
@property (strong, nonatomic) IBOutlet UIImageView *star2;
@property (strong, nonatomic) IBOutlet UIImageView *star3;
@property (strong, nonatomic) IBOutlet UIImageView *star4;
@property (strong, nonatomic) IBOutlet UIImageView *star5;

@property (strong, nonatomic) IBOutlet UILabel *stateName;
@property (strong, nonatomic) IBOutlet UIImageView *pingImage;
@end
