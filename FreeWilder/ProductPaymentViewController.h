//
//  ProductPaymentViewController.h
//  FreeWilder
//
//  Created by Prosenjit Kolay on 17/11/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductPaymentViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong) IBOutlet UIScrollView *ImageScroll;
@property(nonatomic,strong) IBOutlet UIScrollView *ContentScroll;

@property(nonatomic,strong) IBOutlet UILabel *lblAdress;
@property(nonatomic,strong) IBOutlet UILabel *lblCategory;
@property(nonatomic,strong) IBOutlet UILabel *lblType;
@property(nonatomic,strong) IBOutlet UILabel *lblprice;
@property(nonatomic,strong) IBOutlet UILabel *lblQuantity;
@property(nonatomic,strong) IBOutlet UILabel *lblTotal;
@property(nonatomic,strong) IBOutlet UILabel *lblPcountry;
@property(nonatomic,strong) IBOutlet UILabel *lblPPaytype;
@property(nonatomic,strong) IBOutlet UILabel *lblBCountry;
@property(nonatomic,strong) IBOutlet UILabel *lblBPaytype;
@property(nonatomic,strong) IBOutlet UILabel *lblBFname;
@property(nonatomic,strong) IBOutlet UILabel *lblBLname;
@property(nonatomic,strong) IBOutlet UILabel *lblBPcode;

@property(nonatomic,strong) IBOutlet UITextView *tvFirst;
@property(nonatomic,strong) IBOutlet UITextView *tvSecond;

@property(nonatomic,strong) IBOutlet UIButton *BtnRequest;
@property(nonatomic,strong) IBOutlet UIButton *BtnBack;
@property(nonatomic,strong) IBOutlet UIButton *BtnRate;

@property(nonatomic,strong) IBOutlet UIView *childView;

@property(nonatomic,strong) IBOutlet UIImageView *ImgView;
-(IBAction)BtnBack:(id)sender;
-(IBAction)BtnRequest:(id)sender;
-(IBAction)BtnRate:(id)sender;
@end
