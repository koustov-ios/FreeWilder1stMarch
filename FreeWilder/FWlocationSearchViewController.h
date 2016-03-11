//
//  FWlocationSearchViewController.h
//  FreeWilder
//
//  Created by esolz1 on 18/02/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWlocationSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLSessionDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *locationTextBox;
@property (weak, nonatomic) IBOutlet UIView *locationTableTopSeperator;

@property (weak, nonatomic) IBOutlet UITableView *locationTable;

@end
