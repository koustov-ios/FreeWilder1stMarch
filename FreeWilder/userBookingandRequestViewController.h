//
//  userBookingandRequestViewController.h
//  FreeWilder
//
//  Created by subhajit ray on 10/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface userBookingandRequestViewController : UIViewController
{
    AppDelegate *appDelegate;
    bool data1;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableviewmain;
@property (strong, nonatomic) NSString *booking_id;
- (IBAction)backbtntapped:(id)sender;

@end
