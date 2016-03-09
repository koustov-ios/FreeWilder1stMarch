//
//  userServiceCell.h
//  FreeWilder
//
//  Created by kausik on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userServiceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImageview;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *Catgory_Detail;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UILabel *stepsLbl;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *cpyBtn;

@property (weak, nonatomic) IBOutlet UIButton *viewBookingBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIImageView *deleteicon;

@end
