//
//  MyAnnotation.h
//  Map Test
//
//  Created by IOS2 on 05/08/15.
//  Copyright (c) 2015 Koustov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                            subTitle:(NSString *)paramSubTitle;

@end
