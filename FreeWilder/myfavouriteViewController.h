//
//  myfavouriteViewController.h
//  FreeWilder
//
//  Created by subhajit ray on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myfavouriteViewController : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableviewmain;
@property (weak, nonatomic) IBOutlet UIButton *backbtntap;
- (IBAction)backbtntap:(id)sender;

@end
