//
//  SearchResult.h
//  FreeWilder
//
//  Created by kausik on 30/09/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResult : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    IBOutlet UIView *pview;
    IBOutlet UILabel *startingrange;
    
    IBOutlet UIPickerView *picker;
    IBOutlet UIButton *categorybtn;
    IBOutlet UILabel *endingrange;
    IBOutlet UILabel *pricerange;
    IBOutlet UIImageView *topbar;

     IBOutlet UIButton *filterBtn;
    
    IBOutlet UILabel *amount1;
    IBOutlet UILabel *amount2;
    
    NSMutableArray *testArray;
}
@property(strong,nonatomic)NSString *producrname,*location,*start_date,*end_date,*urlString,*prevStartValue,*partofUrl;

- (IBAction)SelectCategoryTap:(id)sender;
- (IBAction)pickerCancelBtn:(id)sender;
- (IBAction)PickerDoneTap:(id)sender;



@property (strong, nonatomic) IBOutlet UITableView *Search_Table;
@property (strong,nonatomic)NSMutableArray *ArrSearchList;
@property(strong,nonatomic) NSMutableArray *cellindex;
@property(strong,nonatomic) NSMutableArray *arrtotal;
- (IBAction)BackTap:(id)sender;
@end
