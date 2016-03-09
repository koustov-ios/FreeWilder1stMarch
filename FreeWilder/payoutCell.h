//
//  payoutCell.h
//  FreeWilder
//
//  Created by subhajit ray on 18/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payoutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *methodslabel;
@property (weak, nonatomic) IBOutlet UILabel *detailslabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLbl;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@end
