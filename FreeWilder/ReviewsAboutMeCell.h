//
//  ReviewsAboutMeCell.h
//  FreeWilder
//
//  Created by kausik on 05/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewsAboutMeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileImageview;
@property (strong, nonatomic) IBOutlet UILabel *serviceName;
@property (strong, nonatomic) IBOutlet UILabel *ReviewDesc;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIImageView *star1;
@property (strong, nonatomic) IBOutlet UIImageView *star2;
@property (strong, nonatomic) IBOutlet UIImageView *star3;
@property (strong, nonatomic) IBOutlet UIImageView *star4;
@property (strong, nonatomic) IBOutlet UIImageView *star5;
@property (strong, nonatomic) IBOutlet UILabel *ReviewDate;
@property (strong, nonatomic) IBOutlet UILabel *state_name;

@property (strong, nonatomic) IBOutlet UIImageView *pinImage;

@end
