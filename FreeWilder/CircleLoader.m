#import "CircleLoader.h"
#import <pop/POP.h>

@interface CircleLoader (){
    CAShapeLayer *circle;
}

@end
@implementation CircleLoader

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //set the width of the circle
        CGFloat lineWidth = 4.0f;
        
        //the radius of the circle is equal to half the width of
        //the CircleLoader view minus half the circle line width
        CGFloat radius = CGRectGetWidth(self.bounds) /2-lineWidth / 2;
        
        //initialize the circle layer, make the frame fit
        //within the view and set the path accordingly
        circle = [CAShapeLayer layer];
        CGRect rect = CGRectMake(lineWidth / 2, lineWidth / 2,
                                 radius * 2, radius * 2);
        circle.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                 cornerRadius:radius].CGPath;
        
        //customize the view of the circle as you see fit
        circle.strokeColor = [UIColor colorWithRed:24.0f/255 green:181.0f/255 blue:124.0f/255 alpha:1].CGColor;
        circle.fillColor = [UIColor clearColor].CGColor;
        circle.lineWidth = lineWidth;
        circle.strokeEnd = 0.0;
        
        //finally add the circle to the view
        [self.layer addSublayer:circle];
    }
    return self;
}

//animates the circle to 100% completion over a set time
-(void)animateCircle{
    //create the basic animation and customize it
    POPBasicAnimation *draw = [POPBasicAnimation
                               animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    draw.fromValue = @(0.0);
    draw.toValue = @(1.0);
    draw.duration = 0.3; //time to draw circle (s)
    draw.timingFunction = [CAMediaTimingFunction functionWithName:
                           kCAMediaTimingFunctionEaseInEaseOut];//kCAMediaTimingFunctionEaseInEaseOut
   draw.repeatForever = YES;
    
    [circle pop_addAnimation:draw forKey:@"draw"];
}

@end