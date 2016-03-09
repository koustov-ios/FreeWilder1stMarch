//
//  ImageResize.h
//  MYPROPERTY
//
//  Created by soumyajit on 06/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageResize : UIImage
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
