//
//  ServiceListCell.h
//  FreeWilder
//
//  Created by Priyanka ghosh on 11/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ServiceImg;
@property (weak, nonatomic) IBOutlet UILabel *ServiceName;
@property (weak, nonatomic) IBOutlet UILabel *CategoryDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnBooking;
@property (weak, nonatomic) IBOutlet UIImageView *locationImg;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@end
