//
//  PEARSlideImageViewController.m
//  ImageSlideViewer
//
//  Created by hirokiumatani on 2015/12/01.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "PEARImageSlideViewController.h"
#import "AutoLayout.h"
#import "UIImageView+WebCache.h"

@interface PEARImageSlideViewController ()<UIGestureRecognizerDelegate>

{
    PEARZoomView *zoomView1;
}
@property (nonatomic,strong) UIWindow      * window;
@property (nonatomic,strong) PEARSlideView * slideView;
@property(nonatomic,strong)NSMutableArray *subViewsArr;



@end

@implementation PEARImageSlideViewController

#pragma mark - public
- (void)showAtIndex:(NSInteger)index
{
    if (!_window)
    {
        _window = [PEARUtility getWindow];
        [AutoLayout baseView:_window addSubView:_slideView];
    }

    
    [self moveSlideViewAtIndex:index];
    [UIView animateWithDuration:0.3
                     animations:^
     {
         _slideView.alpha = 1.0;
         _slideView.transform = CGAffineTransformIdentity;
     }completion:nil];
    
    
}

- (void)setImageLists:(NSArray *)imageLists;
{
    [self setSlideViewWithImageCount:imageLists.count];
    [self setZoomViewWithImageLists:imageLists];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    static NSInteger IMAGE_VIEW_TAG = 1;
    PEARZoomView *zoomView = [PEARZoomView new];
    zoomView.scrollView = scrollView;
    zoomView.scrollView.bouncesZoom=NO;
    UIImageView * imageView = [zoomView.scrollView viewWithTag:IMAGE_VIEW_TAG];
    
    return imageView;
}

#pragma mark - PEARslideViewDelegate
- (void)tapCloseButton
{
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         _slideView.alpha = 0.0;
         _slideView.transform = CGAffineTransformMakeScale(10.0, 0.1);
     }
                     completion:^(BOOL finished)
     {
         [_slideView removeFromSuperview];
         _slideView = nil;
     }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableCollectionView" object:self];
}

#pragma mark - private

#define screenWitdh  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define imageTopMargin 64

- (void)moveSlideViewAtIndex:(NSInteger)index
{
    CGPoint offset;
    
    offset.x = screenWitdh * index;
    offset.y = 0.0f;
    
    [_slideView.scrollView setContentOffset:offset animated:NO];
}
- (void)setSlideViewWithImageCount:(NSInteger)imageCount
{
    _slideView = [PEARSlideView new];
    _slideView.delegate = self;
    _slideView.scrollViewWidth.constant = screenWitdh * imageCount;
}

- (void)setZoomViewWithImageLists:(NSArray *)imageLists
{
    if (!imageLists)return;
    
    for (NSInteger i =0; i < imageLists.count; i++)
    {
         zoomView1 = [PEARZoomView new];
        zoomView1.scrollView.delegate = self;
        zoomView1.frame = CGRectMake(screenWitdh *i,
                                     -imageTopMargin,
                                     screenWitdh,
                                     screenHeight);
        
        
         [_slideView.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        
        [zoomView1.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageLists objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"Image File-64"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
        [_slideView.contentView addSubview:zoomView1];
        
    
        
    }
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.delegate=self;
    tap.numberOfTapsRequired=2;
    tap.numberOfTouchesRequired=1;
    zoomView1.imageView.gestureRecognizers=@[tap];
    
    
    
    _subViewsArr=[[NSMutableArray alloc]init];
    _subViewsArr=[[_slideView.contentView subviews] mutableCopy];
    _slideView.scrollView.delegate=self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

  
      _slideView.deleteBtn.tag=(int)(scrollView.contentOffset.x/self.view.bounds.size.width);

}

- (void)scrollViewDidZoom:(UIScrollView *)sv
{
    UIView* zoomView = [sv.delegate viewForZoomingInScrollView:sv];
    
   
    
    CGRect zvf = zoomView.frame;
    
    if(zvf.size.width < sv.bounds.size.width)
    {
        zvf.origin.x = (sv.bounds.size.width - zvf.size.width) / 2.0;
    }
    else
    {
        zvf.origin.x = 0.0;
    }
    if(zvf.size.height < sv.bounds.size.height)
    {
      // zvf.origin.y = (sv.bounds.size.height - zvf.size.height) / 2.0;
        
        zvf.origin.y =(sv.bounds.size.height - zvf.size.height);
        
        NSLog(@"------%f",zvf.origin.y);
    }
    else
    {
         zvf.origin.y = 0.0;
        
         zvf.origin.y =(sv.bounds.size.height - zvf.size.height)/2;
        
        
         NSLog(@"%f",zvf.origin.y);
    }
    zoomView.frame = zvf;

}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{

    NSLog(@"Zoom ends at scale... %f",scale);
    
     UIView* zoomView = [scrollView.delegate viewForZoomingInScrollView:scrollView];
    
   //  zoomView.contentMode=UIViewContentModeScaleAspectFill;
    
    if(scale==1.0)
    {
    
        zoomView.contentMode=UIViewContentModeScaleAspectFit;
    
    }
    
    

}


-(void)tapped:(UITapGestureRecognizer *)tap
{

   NSLog(@">>>>>>>>");

}

//-(void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//
//        NSLog(@">>>>>>>>");
//    
//    _slideView.scrollView.scrollEnabled=NO;
//    
//    
//    if(scrollView==zoomView1.scrollView)
//    {
//    
//        NSLog(@"Helloooooooooo");
//    
//    }
//    
//    
////    if (scrollView.zoomBouncing) {
////        if (scrollView.zoomScale == scrollView.maximumZoomScale) {
////            NSLog(@"Bouncing back from maximum zoom");
////        }
////        else
////            if (scrollView.zoomScale == scrollView.minimumZoomScale) {
////                NSLog(@"Bouncing back from minimum zoom");
////            }
////    }
//    
//    
//       // zoomView1.scrollView.contentSize=CGSizeMake(zoomView1.scrollView.contentSize.width, self.view.frame.size.height);
//        
//    zoomView1.imageView.frame=zoomView1.scrollView.frame;
//    
//        
//        NSLog(@"height--->%f",zoomView1.scrollView.frame.size.height );
//        
//        zoomView1.scrollView.backgroundColor = [UIColor redColor];
//        
//    
//    
//    
//
//}

-(void)delete:(UIButton *)sender
{
     NSLog(@"SENDER tag--- :> %lu",sender.tag);
    
    UIView *tempView=[_subViewsArr objectAtIndex:sender.tag];
    
    [tempView removeFromSuperview];
    
    
}


@end
