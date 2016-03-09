//
//  DetailReviewViewController.h
//  FreeWilder
//
//  Created by Prosenjit Kolay on 30/11/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailReviewViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) IBOutlet UITableView *Rtableview;
@property(nonatomic,strong) NSString *serviceIde;
@property(nonatomic,strong) NSString *UserIde;
@end
