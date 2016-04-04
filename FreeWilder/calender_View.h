//
//  calender_View.h
//  FreeWilder
//
//  Created by kausik on 10/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calender_View : UIView


@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic)IBOutlet UIView *productview;
@property (strong,nonatomic)IBOutlet UIView *serviceview;

@property (weak, nonatomic) IBOutlet UILabel *ifOpenHeaderLbl;
@property (weak, nonatomic) IBOutlet UILabel *ifBreakHeaderLbl;
@property (weak, nonatomic) IBOutlet UILabel *daysHeaderLbl;

@end
