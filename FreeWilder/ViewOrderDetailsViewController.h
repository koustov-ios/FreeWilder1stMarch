//
//  ViewOrderDetailsViewController.h
//  FreeWilder
//
//  Created by subhajit ray on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewOrderDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscrollview;
@property (weak, nonatomic) IBOutlet UIButton *cancelbtn;
@property (weak, nonatomic) IBOutlet UILabel *paymentstatuslabel;
- (IBAction)backbtntapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *buyernamelabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerlabel;
@property (weak, nonatomic) IBOutlet UILabel *productnamelabel;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *quantitylabel;
@property (weak, nonatomic) IBOutlet UILabel *totalamountlabel;
@property (weak, nonatomic) IBOutlet UILabel *orderdatelabel;
@property (weak, nonatomic) IBOutlet UILabel *paymenttypelabel;
@property (weak, nonatomic) IBOutlet UILabel *statuslabel;

@property (strong,nonatomic) NSMutableDictionary *holddata;
@property(nonatomic)BOOL fromManageButtnAction;

@end
