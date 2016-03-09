//
//  BusinessReviewDetails.h
//  FreeWilder
//
//  Created by kausik on 05/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessReviewDetails : UIViewController
{
    
    IBOutlet UITableView *mainTableView;
}
@property (strong, nonatomic) IBOutlet UILabel *topbarlbl;

@property(strong,nonatomic) NSMutableArray *serviceArray, *ReviewMe ,*reviews_from_seller;
@property(strong,nonatomic )NSString *service;
- (IBAction)BackTap:(id)sender;

@end
