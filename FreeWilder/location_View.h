//
//  location_View.h
//  FreeWilder
//
//  Created by kausik on 10/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface location_View : UIView

   @property(strong,nonatomic)IBOutlet UIScrollView *locationScroll;
@property (strong, nonatomic) IBOutlet UIButton *location_btn;
@property (strong, nonatomic) IBOutlet UIButton *Route_btn;
@property (strong, nonatomic) IBOutlet UIImageView *RouteImageview;
@property (strong, nonatomic) IBOutlet UIImageView *LocationImageview;
@property (strong, nonatomic) IBOutlet UIView *To_Addressview;
@property (strong, nonatomic) IBOutlet UILabel *First_Address_lbl;

@property(strong ,nonatomic)IBOutlet UITextField *nameTxt;
@property(strong ,nonatomic)IBOutlet UITextField *TypeAddressTxt;
@property(strong ,nonatomic)IBOutlet UITextField *DetailsTxt;

@property(strong ,nonatomic)IBOutlet UITextField *nameTxt2;
@property(strong ,nonatomic)IBOutlet UITextField *TypeAddressTxt2;
@property(strong ,nonatomic)IBOutlet UITextField *DetailsTxt2;


@property (strong, nonatomic) IBOutlet UIView *Addressview;

@property (strong, nonatomic) IBOutlet MKMapView *location_Map;





@end
