//
//  MyAnnotation.m
//  Map Test
//
//  Created by IOS2 on 05/08/15.
//  Copyright (c) 2015 Koustov. All rights reserved.
//

#import "MyAnnotation.h"



@implementation MyAnnotation

@synthesize title,subtitle,coordinate;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                            subTitle:(NSString *)paramSubTitle;
{


    self = [super init];
    if (self != nil){
        coordinate = paramCoordinates;
        title = paramTitle;
        subtitle = paramSubTitle;
    }
    return self;

}

@end
