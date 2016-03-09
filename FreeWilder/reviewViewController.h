//
//  reviewViewController.h
//  FreeWilder
//
//  Created by koustov basu on 30/12/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reviewViewController : UIViewController

{
    
    //Star outlets
    
    
    IBOutlet UIImageView *trStar1;
    IBOutlet UIImageView *trStar2;
    IBOutlet UIImageView *trStar3;
    IBOutlet UIImageView *trStar4;
    IBOutlet UIImageView *trStar5;
    
    IBOutlet UIImageView *orStar1;
    IBOutlet UIImageView *orStar2;
    IBOutlet UIImageView *orStar3;
    IBOutlet UIImageView *orStar4;
    IBOutlet UIImageView *orStar5;
    
    IBOutlet UIImageView *qrStar1;
    IBOutlet UIImageView *qrStar2;
    IBOutlet UIImageView *qrStar3;
    IBOutlet UIImageView *qrStar4;
    IBOutlet UIImageView *qrStar5;
    
    IBOutlet UIImageView *srStar1;
    IBOutlet UIImageView *srStar2;
    IBOutlet UIImageView *srStar3;
    IBOutlet UIImageView *srStar4;
    IBOutlet UIImageView *srStar5;
    
    
    
    
}


@property(nonatomic,strong)NSDictionary *ratingsDic;
@property(nonatomic,strong)NSArray *imageArray,*reviewDescArr;
@property (strong, nonatomic) IBOutlet UICollectionView *imageGallery;
- (IBAction)back:(id)sender;

@end
