//
//  FWProductDetailsViewController.h
//  FreeWilder
//
//  Created by koustov basu on 29/12/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PEARImageSlideViewController.h"



@interface FWProductDetailsViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>

{
    MKPlacemark *placemarkSource;
    
    NSMutableArray *locArray;
    
    MKCoordinateRegion *reg;
    
    MKCoordinateSpan *spn;
    
    IBOutlet UIButton *wishListBtn;
    
    IBOutlet UIButton *shareBtn;
    
    NSTimer *Timer;
}

@property(nonatomic,strong) NSString *productId,*UsrId;

@property (strong, nonatomic) IBOutlet UIImageView *trStar1;
@property (strong, nonatomic) IBOutlet UIImageView *trStar2;
@property (strong, nonatomic) IBOutlet UIImageView *trStar3;
@property (strong, nonatomic) IBOutlet UIImageView *trStar4;
@property (strong, nonatomic) IBOutlet UIImageView *trStar5;

@property (nonatomic,retain)PEARImageSlideViewController * slideImageViewController;

@property (strong, nonatomic)MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *myLocationManager;

@property (strong, nonatomic) IBOutlet UIButton *shareAction;

- (IBAction)shareAction:(UIButton *)sender;
- (IBAction)back:(id)sender;
@end
