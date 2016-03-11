//
//  payPalTableViewCell.h
//  FreeWilder
//
//  Created by esolz1 on 24/02/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payPalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *accountNumber;
@property (weak, nonatomic) IBOutlet UILabel *headerLbl;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
