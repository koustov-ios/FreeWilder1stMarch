//
//  carddetailsTableViewCell.h
//  FreeWilder
//
//  Created by subhajit ray on 14/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carddetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *cardtypelabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;

@end
