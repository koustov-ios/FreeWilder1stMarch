//
//  ProductDetailsViewController.h
//  FreeWilder
//
//  Created by Rahul Singha Roy on 01/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsViewController : UIViewController

@property (nonatomic,strong) NSMutableDictionary *detailsDict;
@property (nonatomic,strong) NSString *boolString;
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UITextView *desc;

@property (strong, nonatomic) IBOutlet UICollectionView *detailsCollectionView;

- (IBAction)back_button:(id)sender;
- (IBAction)ShareBtnTap:(id)sender;

@end
