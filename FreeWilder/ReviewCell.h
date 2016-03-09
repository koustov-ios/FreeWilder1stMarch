//
//  ReviewCell.h
//  FreeWilder
//
//  Created by subhajit ray on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *service_name;
@property (weak, nonatomic) IBOutlet UILabel *typedata;
@property (weak, nonatomic) IBOutlet UILabel *review_user_name;
@property (weak, nonatomic) IBOutlet UILabel *posted_bylabel;
@property (weak, nonatomic) IBOutlet UIImageView *service_image;
@property (strong, nonatomic) IBOutlet UIView *cellContainerView;
@property (strong, nonatomic) IBOutlet UIButton *reviewBtn;

@end
