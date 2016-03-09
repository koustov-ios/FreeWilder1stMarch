//
//  ProductDetailsCollectionViewCell.m
//  FreeWilder
//
//  Created by Prosenjit Kolay on 13/08/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ProductDetailsCollectionViewCell.h"

@implementation ProductDetailsCollectionViewCell

@synthesize itemImage,overlay;

- (void)awakeFromNib {
    // Initialization code
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // WRONG:
        // _imageView = [[UIImageView alloc] initWithFrame:frame];
        
        // RIGHT:
        itemImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:itemImage];
        
        overlay = [[UIImageView alloc] initWithFrame:CGRectMake(overlay.frame.origin.x,self.frame.origin.y+self.frame.size.height-100,640,100)];//overlay.frame.size.width,overlay.frame.size.height)];
        overlay.image = [UIImage imageNamed:@"Imageoverlay"];
//
        [self addSubview:overlay];
    }
    return self;
}


@end
