//
//  FWProductDetailsViewController.m
//  FreeWilder
//
//  Created by koustov basu on 29/12/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "FWProductDetailsViewController.h"
#import "FW_JsonClass.h"
#import "reviewViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "Footer.h"
#import "ImageResize.h"
#import "YTPlayerView.h"
#import "DashboardViewController.h"
#import "accountsubview.h"
#import "profile.h"
#import "ServiceView.h"
#import "UserService.h"
#import "userBookingandRequestViewController.h"
#import "MyBooking & Request.h"
#import "PayoutPreferenceViewController.h"
#import "PaymentMethodViewController.h"
#import "notificationsettingsViewController.h"
#import "WishlistViewController.h"
#import "myfavouriteViewController.h"
#import "AppDelegate.h"
#import "PrivacyViewController.h"
#import "ChangePassword.h"
#import "SettingsViewController.h"
#import "LanguageViewController.h"
#import "Business Information ViewController.h"
#import "Photos & Videos ViewController.h"
#import "Trust And Verification ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "ViewController.h"
#import "BusinessProfileViewController.h"
#import "sideMenu.h"


@interface FWProductDetailsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,footerdelegate,UIScrollViewDelegate,UITextFieldDelegate,MKAnnotation,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,YTPlayerViewDelegate,UITableViewDataSource,UITableViewDelegate,sideMenu,UIGestureRecognizerDelegate>

{
    
    UIButton *closeBtn;
    
    UIImageView *scrollImageView,*zoomingImageView,*doubleTappedImageview;
    UIView *blackViewForZooming,*blackViewForImageSlider;
    UIScrollView *scrollViewForZooming;
    UIScrollView *imageScrollForSliding;
    UIButton *deleteImageBtn;
    BOOL deleteBtnVisible;
    int imageDeleteIndex;
    
    NSMutableArray *picarray;
    NSMutableArray *imagelinkArray;
    NSString *userid, *image_id;
    UIScrollView *imgscroll;
    BOOL dntCreate;
    
    
    
    
     sideMenu *leftMenu;
    
    CGRect askmeViewFrame,crossbtnFrame;
    IBOutlet UIImageView *loaderImageView;
    
    
    int orCoutn,i;
    
    IBOutlet UIView *blackOverlay;
    
    UITableViewCell *aminityCell;
    IBOutlet UILabel *aminityHeaderLbl;
    IBOutlet UIButton *moreAminitiesBtn;
    
    IBOutlet UIButton *reviewShowMoreBtn;
    AppDelegate *appDelegate;
    UIView *blackview ,*popview;
    UITextField *phoneText;

    IBOutlet UIActivityIndicatorView *loader;
    IBOutlet  YTPlayerView *youtubePlayerView;
    IBOutlet UIButton *playBtn;
    
  
    IBOutlet UILabel *nodataLbl;
    
    BOOL mapProcessOn;
    IBOutlet UILabel *topDescLbl;
    FW_JsonClass *global_obj;
    
    IBOutlet UIImageView *wishBtnImageView;
    
    IBOutlet UIView *overallReviewView;
    float updatedOrigin_y;
    
    Footer *footer;
    
    NSMutableDictionary *detailsDic;
    
    NSArray *imageArray;
    
    CGRect proImageFrame,galleryFrame,labelFrame,overlayFrame;
    
    UICollectionViewCell *imageCell;
    
    int bookingTapped;
    
    UIView *bookingView;
    
    UIView *bookingHeader;
    
    CGPoint scrollPrevPoint;
    
    // Dynamic changing value label
    
    UILabel *global_multiplicationLbl;
    
    NSMutableArray *quantityarray;
    
    double servicePercentValue,adminPercentValue;
    UILabel *serviceValueLbl,*adminValueLbl,*totalValueLbl;
    
    double serviceFee,adminFee,totalFee;
    
    
    UIView *datePickerView;
    UIButton *datePickOkBtn,*datePickCnclBtn;
    UIDatePicker *date_picker;
    
    UIButton *checkInBtn,*checkOutBtn;
    
    UIButton *tappedBtn;
    
    NSMutableArray *imageCollection;
    
    UILabel *mainPriceLabel;
    
    NSDate *checkinDate,*checkoutDate;
    
   // UIView *blackOverlayView;
    
    UIVisualEffectView *blackOverlayView;
    
    UIView *askMeView;
    UITextView *askMeTextView;
    
    
    CGFloat  fixedHeightForImageGalleryView,fixedWidthForImageGalleryView;
    
    UILabel *headerLbl;
    UILabel *subjectLbl;
    UILabel *subjectDescLbl;
    UILabel *msgLbl;
    UIButton *askBtn;
    IBOutlet UIButton *askQuestionBtn;
    UIButton *attachFileBtn;
    
    UILabel *filenameLbl;
    
    UIImagePickerController *imagePicker;
    
    UIImage *imageToUpload;
    
    NSData *pictureData;
    
    UIButton *crossBtn;
    
    BOOL tapchk,tapchk1,tapchk2;
    Side_menu *sidemenu;
    UIView *overlay;
    accountsubview *subview;
    profile *profileview;
     ServiceView *service;

    NSMutableArray *jsonArray;
   NSString *phoneno;
    
    IBOutlet UIImageView *reviewerImage;
    int langId;
    
    IBOutlet UIButton *rqstToBookBtn;
    
    UIButton *clearBtn1;
    
    UICollectionViewCell *animatedImageCell;
    
    IBOutlet UIButton *topaskBtn;
    
    IBOutlet UIButton *favBtn;
    
    IBOutlet UILabel *subDescLbl;
    
    IBOutlet UIButton *shareButton;
    
    IBOutlet UIImageView *favIcon;
    
    IBOutlet UIImageView *shareIcon;
    
    IBOutlet UIView *imageGalleryContainer;
    
    
    IBOutlet UIView *aminitiesView;
    
    IBOutlet UITableView *aminitiesTable;
    
    
    CGFloat scrollPoint;
    
    
    CGRect topAskFrame,favBtnFrame,favIconFrame,shareBtnFrame,shareIconFrame,subDescLblframe,backbtnFrame;
    
    
    
    // Aminities popup
    
    UITableView *tableForAminities;
    
    UIView *popUpAminitiesView;
    
    UIVisualEffectView *visualViewForAminities;
    
    UIButton *crossBtnForAminities;
    
    
    
    
}
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UIScrollView *scroll_view;

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

@property (strong, nonatomic) IBOutlet UILabel *topLabel;

@property (strong, nonatomic) IBOutlet UICollectionView *imageGallery;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UIImageView *overlayView;
@property (strong, nonatomic) IBOutlet UILabel *reviewTopLbl;

@end

@implementation FWProductDetailsViewController


@synthesize trStar1,trStar2,trStar3,trStar4,trStar5,mapView,myLocationManager,productId,UsrId;

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //EnableCollectionView
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    
    
    ///Side menu ends here

    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:)name:@"EnableCollectionView" object:nil];
    
    i=0;
    
    fixedHeightForImageGalleryView=imageGalleryContainer.frame.size.height;
    
    fixedHeightForImageGalleryView=_imageGallery.frame.size.height;
    
    fixedWidthForImageGalleryView=_imageGallery.frame.size.width;

    
   // self.scroll_view.backgroundColor=[UIColor yellowColor];
 
    aminitiesTable.delegate=self;
    aminitiesTable.dataSource=self;
    
    if([UIScreen mainScreen].bounds.size.height==568)
    {
        
        scrollPoint=self.view.bounds.size.height/3.22;
        
    }
    
    if ([UIScreen mainScreen].bounds.size.height==667) {
        scrollPoint=self.view.bounds.size.height/3.91202346;
    }
    

    
    
    topAskFrame=topaskBtn.frame;
    favBtnFrame=favBtn.frame;
    favIconFrame=favIcon.frame;
    shareBtnFrame=shareBtn.frame;
    shareIconFrame=shareIcon.frame;
    subDescLblframe=subDescLbl.frame;
    backbtnFrame=_backBtn.frame;
    
    
    
    reviewerImage.layer.cornerRadius=reviewerImage.bounds.size.width/2;
    reviewerImage.clipsToBounds=YES;
    
    NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
    
    NSString *currentLang=[userData objectForKey:@"language"];
    
    
    if([currentLang isEqualToString:@"en"])
    {
        
        langId=1;
        
    }
    else  if([currentLang isEqualToString:@"pl"])
    {
        
        langId=3;
        
    }
    
    else  if([currentLang isEqualToString:@"vi"])
    {
        
        langId=4;
        
    }


    
    loaderImageView.layer.shadowOffset=CGSizeMake(0, 1);
    loaderImageView.layer.shadowRadius=3.5;
    loaderImageView.layer.shadowColor=[UIColor blackColor].CGColor;
    loaderImageView.layer.shadowOpacity=0.4;
    loaderImageView.clipsToBounds=NO;
 
    
    [self runSpinAnimationOnView:loaderImageView duration:10 rotations:1 repeat:200];
    
    //[loader startAnimating];
    
    mapProcessOn=NO;
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else
    {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    
    youtubePlayerView.hidden=YES;
    youtubePlayerView.delegate=self;
    
    mapView=[[MKMapView alloc]init];
    locArray=[[NSMutableArray alloc]init];
    mapView.mapType=MKMapTypeStandard;
    mapView.delegate=self;
    mapView.showsUserLocation=YES;
    mapView.zoomEnabled=YES;
    imageCollection=[[NSMutableArray alloc]init];
    //mapView.scrollEnabled=NO;
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.delegate = self;
        [self.myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.myLocationManager setDesiredAccuracy:kCLDistanceFilterNone];
        [self.myLocationManager requestWhenInUseAuthorization];
        [self.myLocationManager startMonitoringSignificantLocationChanges];
        [self.myLocationManager startUpdatingLocation];
        
        
        
    } else {
        
       // NSLog(@"Location services are not enabled");
    }
    
    mapView.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overallReviewView.hidden=YES;
    
    //--->Creating date picker
    
    datePickerView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/2.5)];
    date_picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, datePickerView.bounds.size.width, datePickerView.bounds.size.height-50)];
    [datePickerView addSubview:date_picker];
    [datePickerView setBackgroundColor:[UIColor colorWithRed:242.0f/256 green:242.0f/256 blue:242.0f/256 alpha:1]];
    date_picker.datePickerMode=UIDatePickerModeDate;
    date_picker.minimumDate=[NSDate date];
    
    
    datePickOkBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, date_picker.frame.origin.y+date_picker.bounds.size.height, self.view.bounds.size.width/2, 50)];
    [datePickOkBtn setTitle:@"Okay" forState:UIControlStateNormal];
    datePickOkBtn.titleLabel.textColor=[UIColor whiteColor];
    datePickOkBtn.backgroundColor=[UIColor colorWithRed:0.0f/256 green:189.0f/256 blue:138.0f/256 alpha:1];
    [datePickOkBtn addTarget:self action:@selector(dateOk:) forControlEvents:UIControlEventTouchUpInside];
    
    datePickCnclBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2, date_picker.frame.origin.y+date_picker.bounds.size.height, self.view.bounds.size.width/2, 50)];
    [datePickCnclBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    datePickCnclBtn.titleLabel.textColor=[UIColor whiteColor];
    datePickCnclBtn.backgroundColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
    [datePickCnclBtn addTarget:self action:@selector(dateCncl:) forControlEvents:UIControlEventTouchUpInside];
    [datePickerView addSubview:datePickCnclBtn];
    [datePickerView addSubview:datePickOkBtn];
    [self.view addSubview:datePickerView];
    
    
    
    
    quantityarray=[[NSMutableArray alloc]init];
    
    bookingTapped=0;
    
    proImageFrame=_profileImage.frame;
    galleryFrame=_imageGallery.frame;
    labelFrame=_topLabel.frame;
    overlayFrame=_overlayView.frame;
    
    
    detailsDic=[[NSMutableDictionary alloc]init];
    
    imageArray=[NSArray new];
    
    _backBtn.alpha=0.8;
    
    _scroll_view.delegate=self;
    
    
    
    //Do any additional setup after loading the view.
    
    
    _imageGallery.backgroundColor=[UIColor blackColor];
    
    global_obj=[[FW_JsonClass alloc]init];
    
    [self getData];
    
    updatedOrigin_y=overallReviewView.frame.size.height+overallReviewView.frame.origin.y;
    
    _profileImage.layer.cornerRadius=_profileImage.bounds.size.width/2;
    _profileImage.clipsToBounds=YES;
    
    _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y);
    
    footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footerView.frame.size.width,_footerView.frame.size.height);
    footer.Delegate=self;
    [footer TapCheck:1];
    [_footerView addSubview:footer];
    
    
    //aminitiesView.backgroundColor=[UIColor blackColor];
    
    aminitiesTable.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    aminitiesTable.autoresizesSubviews=NO;
    aminitiesTable.frame=CGRectMake(_profileImage.frame.origin.x, aminityHeaderLbl.frame.size.height+aminityHeaderLbl.frame.origin.y, aminitiesTable.bounds.size.width, aminitiesView.bounds.size.height-(aminityHeaderLbl.frame.size.height+aminityHeaderLbl.frame.origin.y));
    aminitiesView.hidden=YES;
    aminitiesTable.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    
    aminitiesTable.backgroundColor=[UIColor clearColor];
    
    aminitiesView.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
    
    
}

-(void)receivedNotification:(id)sender
{

    _imageGallery.userInteractionEnabled=YES;

}

//-(void)AutoScroll
//{
//    if (i<[imageArray count])
//    {
//        NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        
// //       [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
//            
//            [self.imageGallery scrollToItemAtIndexPath:IndexPath
//                                      atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
//            
////        } completion:nil];
//        
//   
//        i++;
//        if (i==[imageArray count])
//        {
//            i=0;
//        }
//    }
//}


-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{

    i=(int)indexPath.row;
    
    animatedImageCell=cell;
    
   // NSLog(@"1st time cell......");

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    collectionView.userInteractionEnabled=NO;

    _slideImageViewController = [PEARImageSlideViewController new];
    
//    NSArray *imageLists = @[
//                            [UIImage imageNamed:@"placeholder_big.jpg"],
//                            [UIImage imageNamed:@"placeholder_big.jpg"],
//                            [UIImage imageNamed:@"placeholder_big.jpg"],
//                            [UIImage imageNamed:@"placeholder_big.jpg"],
//                            [UIImage imageNamed:@"placeholder_big.jpg"]
//                            ].copy;
    
    
//    [_slideImageViewController setImageLists:imageArray];//imageArray
//    
//    [_slideImageViewController showAtIndex:indexPath.row];
    
   // collectionView.userInteractionEnabled=YES;
    
    imagelinkArray=[[NSMutableArray alloc]init];
    imagelinkArray=[imageArray mutableCopy];
    [self imageSliderCreate];


}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([tableView isEqual:tableForAminities])
    {
    
        return [[detailsDic valueForKey:@"amenities"] count];
    
    }
    else
    {

    if([[detailsDic valueForKey:@"amenities"] count]>6)
     
        return 6;
        
    else
        
        return  [[detailsDic valueForKey:@"amenities"] count];//[[detailsDic valueForKey:@"amenities"] count];
        
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;

}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
//    UIView *tableHeader=[[UIView alloc]initWithFrame:CGRectMake(0, 0, popview.bounds.size.width, 35)];
//    tableHeader.backgroundColor=[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1];

    UILabel *headerLblForAminities=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, popview.bounds.size.width, 35)];
    
    headerLblForAminities.text=@"Aminities";
    
    headerLblForAminities.textAlignment=NSTextAlignmentCenter;
    
    headerLblForAminities.backgroundColor=[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1];
    
   // [tableHeader addSubview:headerLblForAminities];
    
    return headerLblForAminities;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:tableForAminities])
    {
      
           return 35;
    
    }
    else return 0;

 

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([tableView isEqual:tableForAminities])
    {
        
        return 35;
        
    }
    else
        
    return tableView.frame.size.width/6;
    

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    static NSString *cellId=@"cellId";
    
   aminityCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(aminityCell==nil)
    {
    
        aminityCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    }
    
   // tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

   // aminityCell.backgroundColor=[UIColor yellowColor];
    
    return aminityCell;

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

  if([tableView isEqual:tableForAminities])
  {
      
//      aminityCell.imageView.image=[UIImage imageNamed:@"hearticon"];
      
      for (id temp in aminityCell.contentView.subviews)
      {
          [temp removeFromSuperview];
      }
//      
      [aminityCell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[detailsDic valueForKey:@"amenities"] objectAtIndex:indexPath.row] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"Image File-64"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
      
      aminityCell.textLabel.text=[[[detailsDic valueForKey:@"amenities"] objectAtIndex:indexPath.row] valueForKey:@"text"];
  
  
      aminityCell.selectionStyle=UITableViewCellSelectionStyleNone;
      
      aminityCell.contentView.backgroundColor=[UIColor clearColor];
      
      aminityCell.backgroundColor=[UIColor clearColor];

  
  
  }
  else
  {
    
    UIImageView *cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    cellImageView.layer.cornerRadius=cellImageView.bounds.size.width/2;
    cellImageView.clipsToBounds=YES;
    
    
    
    cellImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    for (id temp in aminityCell.contentView.subviews)
    {
        [temp removeFromSuperview];
    }

    [aminityCell.contentView addSubview:cellImageView];
    
    cellImageView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    
    [cellImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[detailsDic valueForKey:@"amenities"] objectAtIndex:indexPath.row] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    
    
    //aminityCell.backgroundColor=[UIColor yellowColor];
    
    aminityCell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    aminityCell.contentView.backgroundColor=[UIColor clearColor];
    
    aminityCell.backgroundColor=[UIColor clearColor];
        
    }

}

//------Side menu methods Starts here

-(void)side
{
    [self.view addSubview:overlay];
    [self.view addSubview:leftMenu];
    
}


-(void)sideMenuAction:(int)tag
{
    
    NSLog(@"You have tapped menu %d",tag);
    
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    
    if(tag==0)
    {
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==1)
    {
        // Do Rate App related work here
        
    }
    if(tag==2)
    {
        
        userid=[prefs valueForKey:@"UserId"];
        
        BusinessProfileViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"busniessprofile"];
        
        obj.BusnessUserId = userid;
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==3)
    {
        EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==4)
    {
        Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==5)
    {
        
        blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [blackview addGestureRecognizer:tapGestureRecognize];
        
        
        
        
        popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
        
        
        UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview.bounds.origin.y+10, popview.frame.size.width-20, 40)];
        
        phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, header.frame.size.height+20, popview.frame.size.width-20, 45)];
        phoneText.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
        
        phoneText.delegate=self;
        phoneText.placeholder=@"Enter Phone Number";
        
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        phoneText.leftView = paddingView;
        phoneText.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+100, header.frame.size.height+phoneText.frame.size.height+40, phoneText.frame.size.width-180, 30)];
        
        submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:79/255.0 alpha:1];
        
        submit.layer.cornerRadius = 5;
        
        [submit setTitle:@"Save" forState:UIControlStateNormal];
        // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        phoneText.layer.cornerRadius=5;
        
        header.text = @"Phone Verification";
        
        //  header.backgroundColor = [UIColor redColor];
        
        [header setFont:[UIFont fontWithName:@"Lato" size:16]];
        [phoneText setFont:[UIFont fontWithName:@"Lato" size:14]];
        
        // header.textColor=[UIColor redColor];
        
        header.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:blackview];
        [popview addSubview:header];
        [popview addSubview:submit];
        [popview addSubview:phoneText];
        popview.backgroundColor=[UIColor whiteColor];
        popview.layer.cornerRadius =5;
        
        [self.view addSubview:popview];
        
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            phoneText.text=[prefs valueForKey:@"phone_no"];
            
            
        }];
        
    }
    if(tag==6)
    {
        Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==7)
    {
        
        rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==8)
    {
        Business_Information_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Business"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==9)
    {
        UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==10)
    {
        //Add product---//---service
    }
    if(tag==11)
    {
        
        userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==12)
    {
        MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==13)
    {
        WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==14)
    {
        myfavouriteViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    if(tag==15)
    {
        // Account....
        
    }
    
    if(tag==16)
    {
        LanguageViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"language"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==17)
    {
        // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [self deleteAllEntities:@"ProductList"];
        [self deleteAllEntities:@"WishList"];
        [self deleteAllEntities:@"CategoryFeatureList"];
        [self deleteAllEntities:@"CategoryList"];
        // [self deleteAllEntities:@"ContactList"];
        [self deleteAllEntities:@"ServiceList"];
        
        
        [[FBSession activeSession] closeAndClearTokenInformation];
        
        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        
        [userData removeObjectForKey:@"status"];
        
        [userData removeObjectForKey:@"logInCheck"];
        
        ViewController   *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    
    // accountSubArray=@[@"Notification",@"Payment Method",@"payout Preferences",@"Tansaction History",@"Privacy",@"Security",@"Settings"];
    
    if(tag==50)
    {
        
        notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==51)
    {
        PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==52)
    {
        PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==53)
    {
        NSLog(@"i am from transaction history");
        
        
    }
    if(tag==54)
    {
        PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    if(tag==55)
    {
        ChangePassword *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"changepass"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==56)
    {
        SettingsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    
    
}

-(void)Slide_menu_off
{
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            
                            
                            
                            leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                            
                        }
     
     
     
                     completion:^(BOOL finished)
     
     {
         
         [leftMenu removeFromSuperview];
         [overlay removeFromSuperview];
         
         
         
     }];
    
}

//------Side menu methods end here



//-(void)Slide_menu_off
//{
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    
//    [UIView animateWithDuration:.4 animations:^{
//        
//        
//        
//        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
//        
//        profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
//        
//        if(screenBounds.size.width == 320)
//        {
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
//            
//        }
//        else if(screenBounds.size.width == 375)
//        {
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
//        }
//        else
//        {
//            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
//        }
//        
//        
//        
//        
//    }
//     
//     
//                     completion:^(BOOL finished)
//     {
//         
//         [subview removeFromSuperview];
//         
//         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
//                             options:1 animations:^{
//                                 
//                                 
//                                 
//                                 
//                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//                                 
//                             }
//          
//          
//          
//                          completion:^(BOOL finished)
//          
//          {
//              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
//              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
//              [service removeFromSuperview];
//              [sidemenu removeFromSuperview];
//              [overlay removeFromSuperview];
//              // overlay.userInteractionEnabled=NO;
//              
//              
//          }];
//         
//         
//         
//         
//         
//         
//         
//     }];
//    
//    
//}
//
//
//-(void)side
//{
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    // overlay.hidden=YES;
//    //overlay.userInteractionEnabled=YES;
//    [self.view addSubview:overlay];
//    
//    
//    
//    
//    
//    
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
//    tapGesture.numberOfTapsRequired=1;
//    [overlay addGestureRecognizer:tapGesture];
//    
//    
//    sidemenu=[[Side_menu alloc]init];
//    
//    CGRect screenBounds=[[UIScreen mainScreen] bounds];
//    
//    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
//        
//    {
//        
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
//        
//        sidemenu.ProfileImage.frame = CGRectMake(46, 26, 77, 77);
//        
//        [sidemenu.lblUserName setFont:[UIFont fontWithName:@"Lato" size:16]];
//        
//        sidemenu.btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.5];
//        
//        sidemenu.btn5.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn6.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn7.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        sidemenu.btn8.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.0];
//        
//        sidemenu.btn9.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
//        
//        
//        
//        
//        
//        
//        
//    }
//    
//    else{
//        
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//        
//    }
//    
//    
//    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    
//    //  //(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
//    // sidemenu.hidden=YES;
//    
//    
//    userid=[prefs valueForKey:@"UserId"];
//    NSString *url= [NSString stringWithFormat:@"%@/app_phone_verification?userid=%@",App_Domain_Url,userid];
//    
//    
//    [global_obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
//        
//        if ([[result valueForKey:@"response" ]isEqualToString:@"success"])
//        {
//            jsonArray = [result valueForKey:@"infoarray"];
//            
//            phoneno = [jsonArray [0]valueForKey:@"phone_no"];
//            
//            
//        }
//        
//        
//        
//        
//        
//    }];
//    
//    
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
//    
//    
//    
//    
//    
//}
-(void)btn_action:(UIButton *)sender
{
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    [UIView animateWithDuration:.4 animations:^{
        
        
        
        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
        
        if(screenBounds.size.width == 320)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
            
        }
        else if(screenBounds.size.width == 375)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
        }
        else
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
        }
        
        
        
        
    }
     
     
                     completion:^(BOOL finished)
     {
         
         [subview removeFromSuperview];
         
         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                             options:1 animations:^{
                                 
                                 
                                 
                                 
                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                 
                             }
          
          
          
                          completion:^(BOOL finished)
          
          {
              
              [overlay removeFromSuperview];
              [sidemenu removeFromSuperview];
              
              
              if (sender.tag==0)
              {
                  //(@"0");
                  
                  
                  UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              
              else if (sender.tag==1)
              {
                  //(@"1");
              }
              else if (sender.tag==2)
              {
                  //(@"2");
                  
                  
                  userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              
              else if (sender.tag==3)
              {
                  //(@"3");
                  
                  
                  MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
                  
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
                  
                  
                  
                  
                  
                  
              }
              
              
              
              else if (sender.tag==4)
              {
                  //(@"4");
                  
                  WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              else if (sender.tag==5)
              {
                  //(@"5");
                  
                  
                  myfavouriteViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
                  [self.navigationController pushViewController:obj animated:NO];
                  // [self Slide_menu_off];
                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
              }
              
              
              
              
              
              
              
              
              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
              [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
              
              [service removeFromSuperview];
              [sidemenu removeFromSuperview];
              [overlay removeFromSuperview];
              
              // overlay.userInteractionEnabled=NO;
              
              
          }];
         
         
         
         
         
         
         
     }];
    
    
    
    
    
    
    
    
}
-(void)subviewclick:(UIButton *)sender
{
    //(@"tag%ld",(long)sender.tag);
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    [UIView animateWithDuration:.4 animations:^{
        
        
        
        service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
        
        if(screenBounds.size.width == 320)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
            
        }
        else if(screenBounds.size.width == 375)
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
        }
        else
        {
            subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
        }
        
        
        
        
    }
     
     
                     completion:^(BOOL finished)
     {
         
         [subview removeFromSuperview];
         
         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                             options:1 animations:^{
                                 
                                 
                                 
                                 
                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                 
                             }
          
          
          
                          completion:^(BOOL finished)
          
          {
              
              if (sender.tag==100) {
                  //(@"i am notification");
                  
                  
                  notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==101)
              {
                  //(@"i am  payment method");
                  
                  
                  
                  
                  PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==102)
              {
                  //(@"i am payout preferences");
                  
                  
                  
                  PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
                  
                  
                  
              }
              else if (sender.tag==103)
              {
                  //(@"i am from transaction history");
              }
              else if (sender.tag==104)
              {
                  //(@"i am from privacy");
                  
                  
                  
                  PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              else if (sender.tag==105)
              {
                  //(@"i am from security");
                  
                  ChangePassword *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"changepass"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
                  
                  
              }
              else if (sender.tag==106)
              {
                  
                  
                  SettingsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              
              
              
              [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
              [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
              [service removeFromSuperview];
              [sidemenu removeFromSuperview];
              [overlay removeFromSuperview];
              
              //  overlay.userInteractionEnabled=NO;
              
              
          }];
         
         
         
         
         
         
         
     }];
    
    
    
    
    
    
}

-(void)action_method:(UIButton *)sender
{
    //(@"##### test mode...%ld",(long)sender.tag);
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    //[service removeFromSuperview];
    
    if (sender.tag==6)
    {
        
        
        
        if (tapchk==false)
        {
            subview=[[accountsubview alloc] init];
            subview.accountsubviewdelegate=self;
            
            
            
            if(screenBounds.size.width == 320)
            {
                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 210,subview.frame.size.width, subview.frame.size.height)];
            }
            else if(screenBounds.size.width == 375)
            {
                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 300,subview.frame.size.width, subview.frame.size.height)];
            }
            else
            {
                [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width, 320,subview.frame.size.width, subview.frame.size.height)];
            }
            
            
            [overlay addSubview:subview];
            
            
            
            
            [UIView animateWithDuration:.4 animations:^{
                
                service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
                
                
                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
                
                
                [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn6 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
                
                
                if(screenBounds.size.width == 320)
                {
                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 210,subview.frame.size.width, subview.frame.size.height)];
                }
                else if(screenBounds.size.width == 375)
                {
                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 300,subview.frame.size.width, subview.frame.size.height)];
                    
                }
                else
                {
                    [subview setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-subview.frame.size.width, 320,subview.frame.size.width, subview.frame.size.height)];
                }
                
                
                
                
                
                
                
            }
             
             
             
                             completion:^(BOOL finished)
             {
                 
                 //  overlay.userInteractionEnabled=YES;
                 // [service removeFromSuperview];
                 
             }];
            
            tapchk=true;
            tapchk1=false;
            tapchk2=false;
        }
        
        
        
        
    }
    
    
    
    else if (sender.tag==5)
    {
        
        //             DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"ServiceListingViewControllersid"];
        //
        //             [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        if (tapchk1==false)
        {
            
            
            
            service = [[ServiceView alloc]init];
            CGRect screenBounds=[[UIScreen mainScreen] bounds];
            if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            {
                service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,240,service.frame.size.width,service.frame.size.height);
            }
            else
            {
                service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,240,service.frame.size.width,service.frame.size.height);
            }
            service.Serviceview_delegate=self;
            //[footer TapCheck:1];
            [overlay addSubview:service];
            
            
            
            [UIView animateWithDuration:.55f animations:^{
                
                
                [sidemenu.btn5 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
                [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn3 setBackgroundColor:[UIColor clearColor]];
                
                
                
                
                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
                
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                
                if(screenBounds.size.width == 320)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
                    
                }
                else if(screenBounds.size.width == 375)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
                }
                else
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
                }
                
                tapchk=false;
                
                
                
                tapchk1=true;
                
                tapchk2=false;
                
                
                
                
                // CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-155,240,155,service.frame.size.height);
                }
                else
                {
                    service.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-service.frame.size.width,240,service.frame.size.width,service.frame.size.height);
                }
                
                // service.Delegate=self;
                //[footer TapCheck:1];
                //[overlay addSubview:service];
                
                
                
                
            }
             
                             completion:^(BOOL finished)
             {
                 
                 //  overlay.userInteractionEnabled=YES;
                 
             }];
            
            
            
            
            
            
        }
        
        //[service removeFromSuperview];
        
        
        
        
        
        
        
        
        
    }
    
    else if (sender.tag==3)
    {
        //        [subview removeFromSuperview];
        //        [service removeFromSuperview];
        //
        //        EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
        //
        //        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
        if (tapchk2==false)
        {
            
            //[profileview removeFromSuperview];
            
            profileview = [[profile alloc]init];
            profileview.Profile_delegate=self;
            
            profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
            
            [overlay addSubview:profileview];
            
            
            
            
            [UIView animateWithDuration:.55f animations:^{
                
                
                profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width-profileview.frame.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
                
                
                [sidemenu.btn3 setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1]];
                [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
                [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
                
                
                tapchk=false;
                tapchk1=false;
                
                tapchk2=true;
                
                
                
                service.frame=CGRectMake(500,240,service.frame.size.width,service.frame.size.height);
                
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                
                if(screenBounds.size.width == 320)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,210,sidemenu.frame.size.width,subview.frame.size.height);
                    
                }
                else if(screenBounds.size.width == 375)
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,300,sidemenu.frame.size.width,subview.frame.size.height);
                }
                else
                {
                    subview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,320,sidemenu.frame.size.width,subview.frame.size.height);
                }
                
                
            }
                             completion:^(BOOL finished)
             {
                 
                 
                 
                 
             }];
            
            
            
            
            
        }
    }
    
    
    
    else
    {
        [subview removeFromSuperview];
        [service removeFromSuperview];
        [profileview removeFromSuperview];
        
        
        [UIView transitionWithView:sidemenu
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            
                            // overlay.hidden=YES;
                            sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                            
                        }
         
                        completion:^(BOOL finished)
         {
             
             [sidemenu removeFromSuperview];
             
             
             [overlay removeFromSuperview];
             
             
             [sidemenu.btn5 setBackgroundColor:[UIColor clearColor]];
             [sidemenu.btn6 setBackgroundColor:[UIColor clearColor]];
             
             
             if (sender.tag==1)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 
                 DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                 
                 
             }
             
             else if (sender.tag==8)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
                 [self deleteAllEntities:@"ProductList"];
                 [self deleteAllEntities:@"WishList"];
                 [self deleteAllEntities:@"CategoryFeatureList"];
                 [self deleteAllEntities:@"CategoryList"];
                 //   [self deleteAllEntities:@"ContactList"];
                 [self deleteAllEntities:@"ServiceList"];
                 
                 
                 
                 
                 [[FBSession activeSession] closeAndClearTokenInformation];
                 
                 NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
                 
                 [userData removeObjectForKey:@"status"];
                 
                 [userData removeObjectForKey:@"logInCheck"];
                 
                 ViewController   *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
                 
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
             }
             
             else if (sender.tag==4)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 
                 Business_Information_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Business"];
                 
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
             }
             
             
             
             
             
             else if (sender.tag == 9)
             {
                 [subview removeFromSuperview];
                 [service removeFromSuperview];
                 LanguageViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"language"];
                 
                 [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
             }
             
             
         }];
    }
}


- (void)deleteAllEntities:(NSString *)nameEntity
{
    NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [theContext deleteObject:object];
    }
    
    error = nil;
    [theContext save:&error];
}


-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.2f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}


-(void)Profile_BtnTap:(UIButton *)sender
{
    [UIView animateWithDuration:.4 animations:^{
        
        
        
        
        
        profileview.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,200,profileview.frame.size.width,profileview.frame.size.height);
        
        
        
        
    }
                     completion:^(BOOL finished)
     {
         
         
         [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                             options:1 animations:^{
                                 
                                 [profileview removeFromSuperview];
                                 
                                 
                                 
                                 sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                 
                             }
          
          
          
                          completion:^(BOOL finished)
          
          {
              [sidemenu removeFromSuperview];
              [overlay removeFromSuperview];
              
              if (sender.tag==0)
              {
                  //(@"I am viewProfile");
              }
              else if (sender.tag==1)
              {
                  //(@"I am EditProfile");
                  
                  
                  EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
              }
              else if (sender.tag==2)
              {
                  //(@"I am Photo & Video");
                  
                  
                  
                  Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
              }
              else if (sender.tag==3)
              {
                  //(@"I am Trust & verification");
                  
                  
                  Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
              }
              else if (sender.tag==4)
              {
                  //(@"I am review");
                  
                  
                  
                  
                  rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
                  
              }
              
              
              else if (sender.tag==5)
              {
                  //(@"I am phone Verification");
                  
                  
                  
                  
                  blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                  
                  blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
                  
                  
                  
                  UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
                  tapGestureRecognize.delegate = self;
                  tapGestureRecognize.numberOfTapsRequired = 1;
                  
                  [blackview addGestureRecognizer:tapGestureRecognize];
                  
                  
                  
                  
                  popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
                  
                  
                  UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview.bounds.origin.y+10, popview.frame.size.width-20, 40)];
                  
                  phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, header.frame.size.height+20, popview.frame.size.width-20, 45)];
                  phoneText.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
                  
                  phoneText.delegate=self;
                  phoneText.placeholder=@"Enter Phone Number";
                  
                  
                  UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                  phoneText.leftView = paddingView;
                  phoneText.leftViewMode = UITextFieldViewModeAlways;
                  
                  UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+100, header.frame.size.height+phoneText.frame.size.height+40, phoneText.frame.size.width-180, 30)];
                  
                  submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:79/255.0 alpha:1];
                  
                  submit.layer.cornerRadius = 5;
                  
                  [submit setTitle:@"Save" forState:UIControlStateNormal];
                  // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
                  [submit addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
                  
                  
                  
                  phoneText.layer.cornerRadius=5;
                  
                  header.text = @"Phone Verification";
                  
                  //  header.backgroundColor = [UIColor redColor];
                  
                  [header setFont:[UIFont fontWithName:@"Lato" size:16]];
                  [phoneText setFont:[UIFont fontWithName:@"Lato" size:14]];
                  
                  // header.textColor=[UIColor redColor];
                  
                  header.textAlignment = NSTextAlignmentCenter;
                  
                  [self.view addSubview:blackview];
                  [popview addSubview:header];
                  [popview addSubview:submit];
                  [popview addSubview:phoneText];
                  popview.backgroundColor=[UIColor whiteColor];
                  popview.layer.cornerRadius =5;
                  
                  [self.view addSubview:popview];
                  
                  
                  
                  
                  [UIView animateWithDuration:.3 animations:^{
                      
                      
                      
                      popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
                      
                      phoneText.text=phoneno;
                      
                      
                  }];
                  
                  
                  
              }
              
              
          }];
         
         
     }];
    
    
    
    
    
    
    
    
    
}

-(void)cancelByTap
{
    [UIView animateWithDuration:.3 animations:^{
        
        
        
        popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        [phoneText resignFirstResponder];
        
    }
                     completion:^(BOOL finished)
     {
         
         
         
         [blackview removeFromSuperview];
         
     }];
    
}



-(void)pushmethod:(UIButton *)sender
{
    
    NSLog(@"Test_mode....%ld",(long)sender.tag);
    tapchk=false;
    tapchk1=false;
    tapchk2=false;
    
    
    
    
    
    if (sender.tag==5)
    {
        [self side];
        
        NSLog(@"Creating side menu.....");
        
        
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                            options:1 animations:^{
                                
                                
                                
                                
                                //                                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                                //                                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                                //                                {
                                //                                    sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
                                //
                                //                                }
                                //                                else
                                //                                {
                                //
                                //                                    sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-sidemenu.frame.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                //
                                //
                                //                                }
                                
                                leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-leftMenu.frame.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                
                                
                                
                            }
         
                         completion:^(BOOL finished)
         {
             
             // overlay.userInteractionEnabled=YES;
             
             // [service removeFromSuperview];
             
             
             
             
         }];
        
        
        
        
        
        
        
        
        
        
    }
    else if (sender.tag==4)
    {
        
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==3)
    {
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msg_page"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==2)
    {
        
        
        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchProductViewControllersid"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
        else if (sender.tag==1)
        {
            
            DashboardViewController *dashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
            [self PushViewController:dashVC WithAnimation:kCAMediaTimingFunctionEaseIn];
            
        }
    
    
    
    
    
    
    
}


-(void)getData
{
    
    //Unavailable
    // NSString *urlString=[NSString stringWithFormat:@"%@app_product_det?service_id=303&userid=100",App_Domain_Url];
    
    //Always Available service(per day basis)
    //NSString *urlString=[NSString stringWithFormat:@"%@app_product_det?service_id=245&userid=100",App_Domain_Url];
    
    //Specific Available service(per day basis)
     //NSString *urlString=[NSString stringWithFormat:@"%@app_product_det?service_id=295&userid=30",App_Domain_Url];
    
    //Slot service
    // NSString *urlString=[NSString stringWithFormat:@"%@app_product_det?service_id=477&userid=100",App_Domain_Url];
    
    
  //  productId=@"477";
    
    //    //Available product
    NSString *urlString=[NSString stringWithFormat:@"%@app_product_det?service_id=%@&userid=%@&lang_id=%d",App_Domain_Url,productId,UsrId,langId];
    
  //  NSLog(@"URL---------->>>>>> %@",urlString);
    
    [global_obj GlobalDict:urlString Globalstr:@"array" Withblock:^(id result, NSError *error) {
       
       //  NSLog(@"---------->>>>>> %@",result);
        
        if(result)
        {
            
          //  NSLog(@"---------->>>>>> %@",result);
            
            detailsDic=[[result valueForKey:@"infoarray"] mutableCopy];
            
         if([[detailsDic valueForKey:@"availability_status"] isEqualToString:@"not_available"])
         {
         
             [rqstToBookBtn setTitle:/*LocalizedString(@"Direct Book")*/@"CHECK NEXT AVAILABILITY" forState:UIControlStateNormal];
             rqstToBookBtn.hidden=NO;
             
         }
         else
         {
            if([[detailsDic valueForKey:@"instant_book_stat"] isEqualToString:@"yes"])
            {
                [rqstToBookBtn setTitle:/*LocalizedString(@"Direct Book")*/[appDelegate.currentLangDic valueForKey:@"Direct Book"] forState:UIControlStateNormal];
                rqstToBookBtn.hidden=NO;
            }
            else
            {
                [rqstToBookBtn setTitle:/*LocalizedString(@"Request To Book")*/[appDelegate.currentLangDic valueForKey:@"Request To Book"] forState:UIControlStateNormal];
                 rqstToBookBtn.hidden=NO;
                
            }
         }
            
            
            [_profileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[result valueForKey:@"infoarray"] valueForKey:@"service_desc"] valueForKey:@"product_user_image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            if([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"wishlist_stat"] isEqualToString:@"N"])
            {
                
                
                //                if(![UsrId isEqualToString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"user_id"]])
                //                {
                wishBtnImageView.image=[UIImage imageNamed:@"hearticon"];
                //}
                
            }
            
            _topLabel.text=[[NSString stringWithFormat:@"%@",[[[result valueForKey:@"infoarray"] valueForKey:@"service_desc"] valueForKey:@"service_product_name"]] uppercaseString];
            topDescLbl.text=[NSString stringWithFormat:@"%@",[[[result valueForKey:@"infoarray"] valueForKey:@"service_desc"] valueForKey:@"service_desc"]];
            topDescLbl.numberOfLines=2;
            [topDescLbl sizeToFit];
            
            NSArray *reviewDescArr=[detailsDic valueForKey:@"review_desc"];
            
            _reviewTopLbl.text=[NSString stringWithFormat:@"%@(%lu)",[appDelegate.currentLangDic valueForKey:@"Reviews"],(unsigned long)reviewDescArr.count];//LocalizedString(@"Reviews")
          
            
            NSLog(@"Details dic----> %@",detailsDic);
            
            if(reviewDescArr.count>0)
            {
            [reviewerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[detailsDic valueForKey:@"review_desc"] objectAtIndex:0] valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"Profile_image_placeholder"]];
                
                reviewShowMoreBtn.hidden=NO;
                [reviewShowMoreBtn addTarget:self action:@selector(showReview:) forControlEvents:UIControlEventTouchUpInside];
                
            }

            
            orCoutn=(int)(([[[detailsDic valueForKey:@"review_stars"] valueForKey:@"overall_review"]intValue]+[[[detailsDic valueForKey:@"review_stars"] valueForKey:@"quality_review"]intValue]+[[[detailsDic valueForKey:@"review_stars"] valueForKey:@"service_review"]intValue])/3);
            
            if(orCoutn>=1)
            {
                
                if(orCoutn==1)
                {
                    trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
                    
                }
                else   if(orCoutn==2)
                {
                    trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
                    
                }
                else  if(orCoutn==3)
                {
                    trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar3.image=[UIImage imageNamed:@"Star Filled-50"];
                    
                    
                }
                else if(orCoutn==4)
                {
                    
                    trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar3.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar4.image=[UIImage imageNamed:@"Star Filled-50"];
                }
                else  if(orCoutn==5)
                {
                    trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar3.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar4.image=[UIImage imageNamed:@"Star Filled-50"];
                    trStar5.image=[UIImage imageNamed:@"Star Filled-50"];
                }
                
            }
            
            overallReviewView.hidden=NO;
            
            
            imageArray=[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_images"];
            
            [_imageGallery reloadData];
            
            // Timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(AutoScroll) userInfo:nil repeats:YES];
            
            if([[detailsDic valueForKey:@"amenities"] count]>0)
            {
                
                
                [moreAminitiesBtn addTarget:self action:@selector(seeAminities:) forControlEvents:UIControlEventTouchUpInside];
                
                if([[detailsDic valueForKey:@"amenities"] count]>6)
                {
                
                    [moreAminitiesBtn setTitle:[NSString stringWithFormat:@"%lu+>",[[detailsDic valueForKey:@"amenities"] count]-6] forState:UIControlStateNormal];
                
                }
                else
                {
                
                    [moreAminitiesBtn setTitle:[NSString stringWithFormat:@"SHOW"] forState:UIControlStateNormal];
                
                }
            
               [aminitiesTable reloadData];
            
            }
            
           
            
            [self createViews];
            
            if(detailsDic.count>0)
            {
            
                //@ Working on
                
                //[loader stopAnimating];
                [blackOverlay removeFromSuperview];
                
                
            }
            
        }
        else
        {
        
            [blackOverlay removeFromSuperview];
            nodataLbl.hidden=NO;
           
        
        }
        
        
    }];
    
}

-(void)createViews
{
    
    
    UILabel *priceLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, updatedOrigin_y+8, self.view.bounds.size.width,self.view.bounds.size.height/19)];
    priceLbl.font=[UIFont fontWithName:@"lato" size:15];
    priceLbl.text=[[detailsDic valueForKey:@"service_desc"] valueForKey:@"main_price"];
    [_scroll_view addSubview:priceLbl];
    
    UIImageView *priceLblDividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    priceLblDividerView.frame=CGRectMake(0, priceLbl.frame.size.height+priceLbl.frame.origin.y+9, self.view.bounds.size.width, 1);
    [_scroll_view addSubview:priceLblDividerView];
    
    updatedOrigin_y=priceLblDividerView.frame.size.height+priceLblDividerView.frame.origin.y;
    
    
    NSArray *tempArray=[[NSArray alloc]init];
    
    tempArray=[detailsDic valueForKey:@"service_attribute"];
    
    for(int i=0; i<tempArray.count; i++)
    {
        NSString *key1=[NSString stringWithFormat:@"item_name%d",i+1];
        NSString *key2=[NSString stringWithFormat:@"item_text%d",i+1];
        
        NSString *tempStr1=[NSString stringWithFormat:@"%@:",[[tempArray objectAtIndex:i] valueForKey:key1] ];
        UILabel *nameLbl=[[UILabel alloc]init];
        nameLbl.font=[UIFont fontWithName:@"lato" size:15];;
        nameLbl.frame=CGRectMake(_profileImage.frame.origin.x, updatedOrigin_y+8, tempStr1.length*9,self.view.bounds.size.height/19);
        nameLbl.text=tempStr1;
        
        
       // NSLog(@"****** %@ ******",nameLbl.text);
        
        [_scroll_view addSubview:nameLbl];
        
        
        
        NSString *tempStr2;
        
        
        tempStr2=[NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:i] valueForKey:key2]];
        
        
        //      CGSize  constraint = CGSizeMake((self.view.bounds.size.width-_profileImage.frame.origin.x)-(nameLbl.frame.size.width+nameLbl.frame.origin.x +5), MAXFLOAT);
        
        CGSize  constraint = CGSizeMake((self.view.bounds.size.width-_profileImage.frame.origin.x*2), MAXFLOAT);
        
        CGRect textRect = [tempStr2 boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"lato" size:15]} context:nil];
        
        NSInteger heightComment = MAX(textRect.size.height, 21.0f);
        
        //----------->>>>>
        
        UILabel *descLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, nameLbl.frame.origin.y+nameLbl.frame.size.height+4, constraint.width, heightComment)];
        
        
        descLbl.text=tempStr2;
        
        
        
        descLbl.numberOfLines=0;
        
        descLbl.adjustsFontSizeToFitWidth=YES;
        descLbl.clipsToBounds=YES;
        descLbl.textAlignment=NSTextAlignmentLeft;
        descLbl.font= [UIFont fontWithName:@"lato" size:15];
        descLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
        descLbl.adjustsFontSizeToFitWidth=YES;
        // descLbl.backgroundColor=[UIColor redColor];
        
        [_scroll_view addSubview:descLbl];
        
        
        UIImageView *priceLblDividerView1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
        
        priceLblDividerView1.frame=CGRectMake(0, descLbl.frame.size.height+descLbl.frame.origin.y+9, self.view.bounds.size.width, 1);
        [_scroll_view addSubview:priceLblDividerView1];
        
        updatedOrigin_y=priceLblDividerView1.frame.size.height+priceLblDividerView1.frame.origin.y;
        
    }
    //service_details
    
    if([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_details"] length]>0)
    {
        NSString *tempStrDesc=[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_details"];
        
        NSString *tempStrHeading=[appDelegate.currentLangDic valueForKey:@"Details:"];//LocalizedString(@"Details:");//[NSString stringWithFormat:@"Details:"];
        
        UILabel *detailsHeadingLbl=[[UILabel alloc]init];
        
        detailsHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];;
        detailsHeadingLbl.frame=CGRectMake(_profileImage.frame.origin.x, updatedOrigin_y+1.5, tempStrHeading.length*8,self.view.bounds.size.height/19);
        detailsHeadingLbl.text=tempStrHeading;
        [_scroll_view addSubview:detailsHeadingLbl];
        
        
        CGSize  constraint = CGSizeMake(self.view.bounds.size.width-(detailsHeadingLbl.frame.origin.x*2), MAXFLOAT);
        
        CGRect textRect = [tempStrDesc boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"lato" size:15]} context:nil];
        
        NSInteger heightComment = MAX(textRect.size.height, 21.0f);
        
        UILabel *detailsDescLbl=[[UILabel alloc]initWithFrame:CGRectMake(detailsHeadingLbl.frame.origin.x , detailsHeadingLbl.frame.origin.y+detailsHeadingLbl.bounds.size.height+8, constraint.width, heightComment)];
        
        detailsDescLbl.text=tempStrDesc;
        
        detailsDescLbl.numberOfLines=0;
        
        detailsDescLbl.adjustsFontSizeToFitWidth=YES;
        detailsDescLbl.clipsToBounds=YES;
        detailsDescLbl.textAlignment=NSTextAlignmentLeft;
        detailsDescLbl.font= [UIFont fontWithName:@"lato" size:15];
        detailsDescLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
        detailsDescLbl.adjustsFontSizeToFitWidth=YES;
        // descLbl.backgroundColor=[UIColor redColor];
        
        [_scroll_view addSubview:detailsDescLbl];
        
        UIImageView *priceLblDividerView1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
        
        priceLblDividerView1.frame=CGRectMake(0, detailsDescLbl.frame.size.height+detailsDescLbl.frame.origin.y+9, self.view.bounds.size.width, 1);
        [_scroll_view addSubview:priceLblDividerView1];
        
        updatedOrigin_y=priceLblDividerView1.frame.size.height+priceLblDividerView1.frame.origin.y;
        
        
    }
    
    //@youtube
    if([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_video"] length]>0)
    {
        
        youtubePlayerView.hidden=NO;
        
        youtubePlayerView.frame=CGRectMake(0, updatedOrigin_y-5, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
        
        [youtubePlayerView loadWithVideoId:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_video"]];
        
        [_scroll_view addSubview:youtubePlayerView];
        
        updatedOrigin_y=youtubePlayerView.frame.size.height+youtubePlayerView.frame.origin.y+2;
        
        //youtubePlayerView.backgroundColor=[UIColor blackColor];
        
    }
    
    if([[detailsDic valueForKey:@"amenities"] count]>0)
    {
    
        aminitiesView.hidden=NO;
        
        CGRect newFrame=aminitiesView.frame;
        newFrame.origin.y=updatedOrigin_y;
        aminitiesView.frame=newFrame;
        updatedOrigin_y=aminitiesView.frame.size.height+aminitiesView.frame.origin.y+2;

    
    }
    
    
    //    mapView.frame=CGRectMake(0, updatedOrigin_y+2, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
    //    [_scroll_view addSubview:mapView];
    //
    //    updatedOrigin_y=mapView.frame.origin.y+mapView.frame.size.height+4;
    //
    //
    //    [mapView setCenterCoordinate:CLLocationCoordinate2DMake([latitude doubleValue],[longitude doubleValue]) animated:YES];
    //
    //    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake([latitude doubleValue],[longitude doubleValue]), 10000, 10000);
    //    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    //
    
    UIImageView *mapImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, updatedOrigin_y+.5, self.view.bounds.size.width, self.view.bounds.size.height/3)];
    [_scroll_view addSubview:mapImageView];
    updatedOrigin_y=mapImageView.frame.origin.y+mapImageView.frame.size.height+4;
    
    [mapImageView  sd_setImageWithURL:[NSURL URLWithString:[[detailsDic valueForKey:@"location"] valueForKey:@"location_image"]] placeholderImage:[UIImage imageNamed:@"placeholder_big"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    
    
    UIView *addressView=[[UIView alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, (mapImageView.frame.size.height/2)+10, mapImageView.frame.size.width-(_profileImage.frame.origin.x*2), 30)];
    addressView.backgroundColor=[UIColor whiteColor];
    [mapImageView addSubview:addressView];
    addressView.layer.cornerRadius=6.0f;
    addressView.clipsToBounds=YES;
    
    addressView.layer.shadowOffset=CGSizeMake(0, 1);
    addressView.layer.shadowRadius=3.5;
    addressView.layer.shadowColor=[UIColor blackColor].CGColor;
    addressView.layer.shadowOpacity=0.4;
    addressView.clipsToBounds=NO;
    
    

    
    UIImageView *locationPin=[[UIImageView alloc]initWithFrame:CGRectMake(4,2.5, 22, 25)];
    locationPin.image=[UIImage imageNamed:@"LocationBlack"];
    [addressView addSubview:locationPin];

    
    
    UILabel *addressLbl=[[UILabel alloc]initWithFrame:CGRectMake(locationPin.frame.origin.x+locationPin.bounds.size.width+2, locationPin.frame.origin.y,addressView.bounds.size.width-(locationPin.frame.origin.x+locationPin.bounds.size.width+2) , self.view.bounds.size.height/24)];
    addressLbl.font=[UIFont fontWithName:@"lato" size:12];
    addressLbl.text=[NSString stringWithFormat:@"From: %@",[[detailsDic valueForKey:@"location"] valueForKey:@"loc_addr"]];
    addressLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
    
    [addressView addSubview:addressLbl];
    
    
    
    UIButton *goToMapBtn=[[UIButton alloc]initWithFrame:CGRectMake(mapImageView.frame.origin.x, mapImageView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height/3)];
    [_scroll_view addSubview:goToMapBtn];
    goToMapBtn.backgroundColor=[UIColor clearColor];
    //goToMapBtn.alpha=0.6;
    [goToMapBtn addTarget:self action:@selector(goToMap) forControlEvents:UIControlEventTouchUpInside];


    
//    UIImageView *locationPin=[[UIImageView alloc]initWithFrame:CGRectMake(4, updatedOrigin_y, 22, 25)];
//    locationPin.image=[UIImage imageNamed:@"LocationBlack"];
//    [_scroll_view addSubview:locationPin];
//    
//    updatedOrigin_y=locationPin.frame.origin.y+locationPin.frame.size.height+4;
    
    
    
    //    MyAnnotation *annotation =[[MyAnnotation alloc] initWithCoordinates:CLLocationCoordinate2DMake([latitude doubleValue],[longitude doubleValue]) title:@"My Title" subTitle:@"My Sub Title"];
    //    [mapView addAnnotation:annotation];
    
    
//    UILabel *addressLbl=[[UILabel alloc]initWithFrame:CGRectMake(locationPin.frame.origin.x+locationPin.bounds.size.width+2, locationPin.frame.origin.y,self.view.bounds.size.width-(_profileImage.frame.origin.x+locationPin.frame.origin.x+locationPin.bounds.size.width+2) , self.view.bounds.size.height/24)];
//    addressLbl.font=[UIFont fontWithName:@"lato" size:12];
//    addressLbl.text=[NSString stringWithFormat:@"From: %@",[[detailsDic valueForKey:@"location"] valueForKey:@"loc_addr"]];
//    addressLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
//    
//    [_scroll_view addSubview:addressLbl];
//    
//    updatedOrigin_y=addressLbl.frame.origin.y+addressLbl.frame.size.height+4;
    
    
    
    
//    if([detailsDic valueForKey:@"review_stars"] || [detailsDic valueForKey:@"review_desc"])
//    {
//        
//        NSArray *reviewStars=[[NSArray alloc]init];
//        NSArray *reviewDesc=[[NSArray alloc]init];
//        
//        reviewStars=[detailsDic valueForKey:@"review_stars"];
//        reviewDesc=[detailsDic valueForKey:@"review_desc"];
//        
//        UIView *reviewHeader=[[UIView alloc]init];
//        reviewHeader.backgroundColor=[UIColor colorWithRed:240.0f/256 green:240.0f/256 blue:240.0f/256 alpha:1];
//        reviewHeader.frame=CGRectMake(0, updatedOrigin_y, self.view.bounds.size.width, self.view.bounds.size.height/14.72);
//        
//        UILabel *headerLbl1=[[UILabel alloc]init];
//        NSString *tempStrHeading=[appDelegate.currentLangDic valueForKey:@"Reviews"];//LocalizedString(@"Reviews");//@"Reviews";
//        headerLbl1.font=[UIFont fontWithName:@"lato" size:15];;
//        headerLbl1.frame=CGRectMake(_profileImage.frame.origin.x, (reviewHeader.bounds.size.height-(self.view.bounds.size.height/19))/2, tempStrHeading.length*8,self.view.bounds.size.height/19);
//        headerLbl1.text=tempStrHeading;
//        [reviewHeader addSubview:headerLbl1];
//        
//        UIImageView *arrowImage=[[UIImageView alloc]init];
//        arrowImage.image=[UIImage imageNamed:@"arrow"];
//        arrowImage.frame=CGRectMake(reviewHeader.frame.size.width-(20+_profileImage.frame.origin.x), (reviewHeader.frame.size.height-23)/2, 20, 23);
//        arrowImage.contentMode=UIViewContentModeScaleAspectFit;
//        [reviewHeader addSubview:arrowImage];
//        
//        UIButton *clearBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, reviewHeader.frame.size.width, reviewHeader.frame.size.height)];
//        [reviewHeader addSubview:clearBtn];
//        
//        [clearBtn addTarget:self action:@selector(showReview:) forControlEvents:UIControlEventTouchUpInside];
//        
//        updatedOrigin_y=reviewHeader.frame.origin.y+reviewHeader.frame.size.height+3;
//        
//        [_scroll_view addSubview:reviewHeader];
//        
//    }
    
    
    bookingHeader=[[UIView alloc]init];
    bookingHeader.backgroundColor=[UIColor colorWithRed:204.0f/256 green:204.0f/256 blue:204.0f/256 alpha:1];
    
    bookingHeader.backgroundColor=[UIColor colorWithRed:240.0f/256 green:240.0f/256 blue:240.0f/256 alpha:1];
    
    bookingHeader.frame=CGRectMake(0, updatedOrigin_y+2, self.view.bounds.size.width, self.view.bounds.size.height/14.72);
    
    UILabel *header_Lbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[appDelegate.currentLangDic valueForKey:@"Booking_details"];//LocalizedString(@"Booking_details");
    header_Lbl.font=[UIFont fontWithName:@"lato" size:15];;
    header_Lbl.frame=CGRectMake(_profileImage.frame.origin.x, (bookingHeader.bounds.size.height-(self.view.bounds.size.height/19))/2, tempStrHeading.length*8,self.view.bounds.size.height/19);
    header_Lbl.text=tempStrHeading;
    [bookingHeader addSubview:header_Lbl];
    
    UIImageView *arrowImage=[[UIImageView alloc]init];
    arrowImage.image=[UIImage imageNamed:@"arrow"];
    arrowImage.frame=CGRectMake(bookingHeader.frame.size.width-(20+_profileImage.frame.origin.x), (bookingHeader.frame.size.height-23)/2, 20, 23);
    arrowImage.contentMode=UIViewContentModeScaleAspectFit;
    [bookingHeader addSubview:arrowImage];
    
    clearBtn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, bookingHeader.frame.size.width, bookingHeader.frame.size.height)];
    [bookingHeader addSubview:clearBtn1];
    
    [clearBtn1 addTarget:self action:@selector(bookingDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    updatedOrigin_y=bookingHeader.frame.origin.y+bookingHeader.frame.size.height+3;
    
    [_scroll_view addSubview:bookingHeader];
    
    [rqstToBookBtn addTarget:self action:@selector(bookingDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //if([[[detailsDic valueForKey:@"product_avilability_status"] valueForKey:@"status"] isEqualToString:@""])
    
    
    _scroll_view.showsVerticalScrollIndicator=NO ;
    _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y+8);
    
    
}

-(void)goToMap
{
  //  NSLog(@"Find the location1...");
    
    NSString *latitude=[[detailsDic valueForKey:@"location"] valueForKey:@"loc_lat"];
    NSString *longitude=[[detailsDic valueForKey:@"location"] valueForKey:@"loc_long"];
    
    NSString* url = [NSString stringWithFormat:@"http://maps.apple.com/?q=%f,%f",[latitude floatValue],[longitude floatValue]];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    
  //  NSLog(@"Find the location1...");
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView1 viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else if ([annotation isKindOfClass:[MyAnnotation class]]) // use whatever annotation class you used when creating the annotation
    {
        static NSString * const identifier = @"MyCustomAnnotation";
        
        MKAnnotationView* annotationView = [mapView1 dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"locationPin"];
        
        return annotationView;
    }
    
    
    return nil;
}


-(void)mapView:(MKMapView *)mapView1 regionDidChangeAnimated:(BOOL)animated
{
    
    if(mapProcessOn==NO)
        [self applyMapViewMemoryHotFix];
    
    
    
}


- (void)applyMapViewMemoryHotFix{
    
    mapProcessOn=NO;
    
    switch (mapView.mapType) {
        case MKMapTypeHybrid:
        {
            mapView.mapType = MKMapTypeStandard;
            
        }
            break;
        case MKMapTypeStandard:
        {
            mapView.mapType = MKMapTypeHybrid;
        }
            break;
            
        default:
            break;
    }
    
    
    mapView.mapType = MKMapTypeStandard;
    
    
    // [self centerTheLocation];
    
    
}

//Center the location within the mapview

//-(void)centerTheLocation
//{
//
//    mapProcessOn=YES;
//
//    NSString *latitude=[[detailsDic valueForKey:@"location"] valueForKey:@"loc_lat"];
//    NSString *longitude=[[detailsDic valueForKey:@"location"] valueForKey:@"loc_long"];
//
//    [mapView setCenterCoordinate:CLLocationCoordinate2DMake([latitude doubleValue],[longitude doubleValue]) animated:YES];
//
//    NSLog(@"Center the location...");
//
//    mapProcessOn=NO;
//
//}


#pragma mark-Booking details button action

-(void)bookingDetails:(UIButton *)sender
{
    
    if(bookingTapped==0 )
    {
        bookingTapped=1;
        
        bookingView=[[UIView alloc]initWithFrame:CGRectMake(0, updatedOrigin_y, self.view.bounds.size.width, 0)];
        
        //bookingView.backgroundColor=[UIColor yellowColor];
        
        
        if([[detailsDic valueForKey:@"availability_status"] isEqualToString:@"not_available"])
        {
            
            NSString *tempStr1=[[NSString stringWithFormat:@"%@ %@",[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_type"],[appDelegate.currentLangDic valueForKey:@"is currently not available"]] uppercaseString];//LocalizedString(@"is currently not available")
            
            UILabel *statusLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, 6, self.view.bounds.size.width-(_profileImage.frame.origin.x*2) ,self.view.bounds.size.height/19)];//tempStr1.length*10,
            
            statusLbl.textAlignment=NSTextAlignmentCenter;
            
            statusLbl.font=[UIFont fontWithName:@"lato" size:15];
            
            statusLbl.text=tempStr1;
            
            
            NSString *tempStr2=[NSString stringWithFormat:@"%@: %@",[appDelegate.currentLangDic valueForKey:@"Next available date"]/*LocalizedString(@"Next available date")*/,[[detailsDic valueForKey:@"availability_details"] valueForKey:@"next_date"]];
            UILabel *nextDateLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, statusLbl.frame.origin.y+statusLbl.bounds.size.height+6,  self.view.bounds.size.width,self.view.bounds.size.height/14)];
            nextDateLbl.font=[UIFont fontWithName:@"lato" size:15];
            nextDateLbl.text=tempStr2;
            nextDateLbl.textAlignment=NSTextAlignmentCenter;
            
            NSMutableAttributedString *text2 =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: nextDateLbl.attributedText];
            [text2 addAttribute:NSForegroundColorAttributeName
                          value:[UIColor whiteColor]
                          range:NSMakeRange(0, tempStr2.length)];
            nextDateLbl.attributedText=text2;
            nextDateLbl.backgroundColor=[UIColor colorWithRed:0.0f/256 green:189.0f/256 blue:138.0f/256 alpha:1];
            
            
            
            
            
            NSString *tempStr3=[NSString stringWithFormat:@"%@: %@",[appDelegate.currentLangDic valueForKey:@"Last available date"]/*LocalizedString(@"Last available date")*/,[[detailsDic valueForKey:@"availability_details"] valueForKey:@"last_date"]];
            
            UILabel *lastDateLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, nextDateLbl.frame.origin.y+nextDateLbl.bounds.size.height+6,  self.view.bounds.size.width,self.view.bounds.size.height/14)];
            lastDateLbl.font=[UIFont fontWithName:@"lato" size:15];
            lastDateLbl.text=tempStr3;
            
            lastDateLbl.textAlignment=NSTextAlignmentCenter;
            
            NSMutableAttributedString *text3 =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: lastDateLbl.attributedText];
            
            [text3 addAttribute:NSForegroundColorAttributeName
                          value:[UIColor whiteColor]
                          range:NSMakeRange(0, tempStr3.length)];
            lastDateLbl.attributedText=text3;
            lastDateLbl.backgroundColor=[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1];
            
            
            
            [UIView animateWithDuration:.3 animations:^{
                
                [_scroll_view addSubview:bookingView];
                
                CGRect tempFrame=bookingView.frame;
                tempFrame.size.height+=lastDateLbl.frame.origin.y+lastDateLbl.frame.size.height+10;
                bookingView.frame=tempFrame;
                
               // NSLog(@"updated y---> %f",updatedOrigin_y);
                
                updatedOrigin_y+=bookingView.frame.size.height;
                
               // NSLog(@"updated y---> %f",updatedOrigin_y);
                
                [bookingView addSubview:statusLbl];
                [bookingView addSubview:nextDateLbl];
                [bookingView addSubview:lastDateLbl];
                
                _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y+8);
                
                float scrollExapndValue=_scroll_view.contentSize.height;
                
                [_scroll_view setContentOffset:CGPointMake(0,scrollExapndValue-_scroll_view.frame.size.height)];
                
               // NSLog(@"Y-----> %f",_scroll_view.contentOffset.y);
                
                
                
            } completion:nil];
            
            
            
        }
        
        else  if([[detailsDic valueForKey:@"availability_status"] isEqualToString:@"available"])
        {
            
            if([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_type"] isEqualToString:@"product"])
            {
                
                UILabel *quantityLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, 6,  [NSString stringWithFormat:@"%@:",/*LocalizedString(@"Quantity")*/[appDelegate.currentLangDic valueForKey:@"Quantity"]].length*7,self.view.bounds.size.height/19)];
                quantityLbl.textColor=[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1];
                quantityLbl.text=[appDelegate.currentLangDic valueForKey:@"Quantity"];//LocalizedString(@"Quantity");//@"Quantity:";
                quantityLbl.font=[UIFont fontWithName:@"lato" size:15];
                // quantityLbl.backgroundColor=[UIColor yellowColor];
                
                UITextField *quantityField=[[UITextField alloc]initWithFrame:CGRectMake(quantityLbl.frame.origin.x+quantityLbl.frame.size.width+4, quantityLbl.frame.origin.y, (self.view.bounds.size.width-_profileImage.frame.origin.x)-(quantityLbl.frame.size.width+quantityLbl.frame.origin.x +4), quantityLbl.frame.size.height)];
                quantityField.delegate=self;
                
                UIView *paddingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, quantityField.frame.size.height)];
                quantityField.leftView=paddingView;
                quantityField.leftViewMode=UITextFieldViewModeAlways;
                
                quantityField.layer.cornerRadius=6.0f;
                quantityField.layer.masksToBounds=YES;
                quantityField.layer.borderColor=[[UIColor lightGrayColor]CGColor];
                quantityField.layer.borderWidth= 1.0f;
                
                
                UIView *priceDetails=[[UIView alloc]init];
                priceDetails.backgroundColor=[UIColor colorWithRed:242.0f/256 green:242.0f/256 blue:242.0f/256 alpha:1];
                priceDetails.frame=CGRectMake(0, quantityLbl.frame.size.height+quantityLbl.frame.origin.y+10, self.view.bounds.size.width, self.view.bounds.size.height/14.72);
                
                UILabel *headerLbl2=[[UILabel alloc]init];
                NSString *tempStrHeading=[appDelegate.currentLangDic valueForKey:@"Price Details"];//LocalizedString(@"Price Details");//@"Price Details";
                headerLbl2.font=[UIFont fontWithName:@"lato" size:15];;
                headerLbl2.frame=CGRectMake(_profileImage.frame.origin.x, (priceDetails.bounds.size.height-(self.view.bounds.size.height/19))/2, priceDetails.frame.size.width-(_profileImage.frame.origin.x*2),self.view.bounds.size.height/19);
                headerLbl2.textAlignment=NSTextAlignmentCenter;
                headerLbl2.text=tempStrHeading;
                [priceDetails addSubview:headerLbl2];
                
                
                UIFont *currencyFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *currencyDict = [NSDictionary dictionaryWithObject: currencyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *currencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: currencyDict];
                NSString *lengthCheckingStr1=[currencyString string];
                [currencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr1.length))];
                
                
                UIFont *priceFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *priceDict = [NSDictionary dictionaryWithObject:priceFont forKey:NSFontAttributeName];
                NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %@  X ",[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] ] attributes:priceDict];
                NSString *lengthCheckingStr2=[priceString string];
                [priceString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr2.length))];
                
                [currencyString appendAttributedString:priceString];
                
                NSString *lengthCheckingStr3=[currencyString string];
                
                UILabel *basePriceLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, priceDetails.frame.origin.y+priceDetails.frame.size.height+6,  (lengthCheckingStr3.length+1)*7,self.view.bounds.size.height/19)];
                // basePriceLbl.backgroundColor=[UIColor grayColor];
                basePriceLbl.attributedText=currencyString;
                basePriceLbl.font=[UIFont fontWithName:@"lato" size:15];
                
                global_multiplicationLbl=[[UILabel alloc]initWithFrame:CGRectMake(basePriceLbl.frame.origin.x+basePriceLbl.frame.size.width, basePriceLbl.frame.origin.y, 100,self.view.bounds.size.height/19)];
                global_multiplicationLbl.text=@"1";
                global_multiplicationLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
                global_multiplicationLbl.textAlignment=NSTextAlignmentLeft;
                
                
                UIImageView *pricedetailDivider=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
                
                pricedetailDivider.frame=CGRectMake(0, global_multiplicationLbl.frame.size.height+global_multiplicationLbl.frame.origin.y+3, self.view.bounds.size.width, 1);
                ;
                
                //------->>>>>>>>>>
                UIFont *serviceFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *serviceDict = [NSDictionary dictionaryWithObject: serviceFont forKey:NSFontAttributeName];
                NSMutableAttributedString *serviceString = [[NSMutableAttributedString alloc] initWithString:[appDelegate.currentLangDic valueForKey:@"Service Fee"]/*LocalizedString(@"Service Fee")*/ attributes: serviceDict];
                
                NSString *lengthCheckingStr4=[serviceString string];
                
                [serviceString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr4.length))];
                
                
                UIFont *percentFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *percentDict = [NSDictionary dictionaryWithObject:percentFont forKey:NSFontAttributeName];
                NSMutableAttributedString *percentString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"(%@) ",[[detailsDic valueForKey:@"price_details"] valueForKey:@"service_fee"] ] attributes:percentDict];
                NSString *lengthCheckingStr5=[percentString string];
                [percentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr5.length))];
                
                [serviceString appendAttributedString:percentString];
                
                NSString *lengthCheckingStr6=[currencyString string];
                
                UILabel *serviceFeeLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, pricedetailDivider.frame.origin.y+pricedetailDivider.frame.size.height+4,  lengthCheckingStr6.length*13,self.view.bounds.size.height/19)];
                // basePriceLbl.backgroundColor=[UIColor grayColor];
                serviceFeeLbl.attributedText=serviceString;
                serviceFeeLbl.font=[UIFont fontWithName:@"lato" size:15];
                
                
                
                
                UIFont *serviceCurrencyFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *serviceCurrencyDict = [NSDictionary dictionaryWithObject: serviceCurrencyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *serviceCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: serviceCurrencyDict];
                NSString *lengthCheckingStr7=[serviceCurrencyString string];
                [serviceCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr7.length))];
                
                
                servicePercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"service_fee"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
                
                UIFont *serviceValueFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *serviceValueDict = [NSDictionary dictionaryWithObject:serviceValueFont forKey:NSFontAttributeName];
                NSMutableAttributedString *serviceValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(servicePercentValue/100))] attributes:serviceValueDict];
                serviceFee=[[serviceValueString string] doubleValue];
                
                NSString *lengthCheckingStr8=[serviceValueString string];
                [serviceValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr8.length))];
                
                [serviceCurrencyString appendAttributedString:serviceValueString];
                
                
                serviceValueLbl=[[UILabel alloc]initWithFrame:CGRectMake(serviceFeeLbl.frame.origin.x+serviceFeeLbl.bounds.size.width+3, pricedetailDivider.frame.origin.y+pricedetailDivider.frame.size.height+4,self.view.bounds.size.width-(serviceFeeLbl.frame.origin.x+serviceFeeLbl.bounds.size.width+3+_profileImage.frame.origin.x),self.view.bounds.size.height/19)];
                serviceValueLbl.textAlignment=NSTextAlignmentRight;
                serviceValueLbl.attributedText=serviceCurrencyString;
                serviceValueLbl.font=[UIFont fontWithName:@"lato" size:15];
                
                
                
                
                UIImageView *pricedetailDivider1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
                
                pricedetailDivider1.frame=CGRectMake(0, serviceValueLbl.frame.size.height+serviceValueLbl.frame.origin.y+3, self.view.bounds.size.width, 1);
                ;
                
                
                
                // ----------?
                UIFont *adminFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *adminDict = [NSDictionary dictionaryWithObject: adminFont forKey:NSFontAttributeName];
                NSMutableAttributedString *adminString = [[NSMutableAttributedString alloc] initWithString:[appDelegate.currentLangDic valueForKey:@"Admin Charge"]/*LocalizedString(@"Admin Charge")*/ attributes: adminDict];
                
                
                NSString *lengthCheckingStr9=[adminString string];
                [adminString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr9.length))];
                
                
                UIFont *percentFont1 = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *percentDict1 = [NSDictionary dictionaryWithObject:percentFont1 forKey:NSFontAttributeName];
                NSMutableAttributedString *percentString1 = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"(%@) ",[[detailsDic valueForKey:@"price_details"] valueForKey:@"admin_charge"] ] attributes:percentDict1];
                NSString *lengthCheckingStr10=[percentString1 string];
                [percentString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr10.length))];
                
                [adminString appendAttributedString:percentString1];
                
                NSString *lengthCheckingStr11=[adminString string];
                
                UILabel *adminFeeLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, pricedetailDivider1.frame.origin.y+pricedetailDivider1.frame.size.height+4,  lengthCheckingStr11.length*9,self.view.bounds.size.height/19)];
                // basePriceLbl.backgroundColor=[UIColor grayColor];
                adminFeeLbl.attributedText=adminString;
                adminFeeLbl.font=[UIFont fontWithName:@"lato" size:15];
                
                
                
                //--------?
                UIFont *adminCurrencyFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *adminCurrencyDict = [NSDictionary dictionaryWithObject: adminCurrencyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *adminCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: adminCurrencyDict];
                NSString *lengthCheckingStr12=[adminCurrencyString string];
                [adminCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr12.length))];
                
                
                adminPercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"admin_charge"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
                
                UIFont *adminValueFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *adminValueDict = [NSDictionary dictionaryWithObject:adminValueFont forKey:NSFontAttributeName];
                NSMutableAttributedString *adminValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(adminPercentValue/100))] attributes:adminValueDict];
                
                adminFee=[[adminValueString string] doubleValue];
                
                NSString *lengthCheckingStr13=[adminValueString string];
                [adminValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr13.length))];
                
                [adminCurrencyString appendAttributedString:adminValueString];
                
                
                adminValueLbl=[[UILabel alloc]initWithFrame:CGRectMake(adminFeeLbl.frame.origin.x+adminFeeLbl.bounds.size.width+3, pricedetailDivider1.frame.origin.y+pricedetailDivider1.frame.size.height+4,self.view.bounds.size.width-(adminFeeLbl.frame.origin.x+adminFeeLbl.bounds.size.width+3+_profileImage.frame.origin.x),self.view.bounds.size.height/19)];
                adminValueLbl.textAlignment=NSTextAlignmentRight;
                adminValueLbl.attributedText=adminCurrencyString;
                adminValueLbl.font=[UIFont fontWithName:@"lato" size:15];
                
                
                
                
                UIImageView *pricedetailDivider2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
                
                pricedetailDivider2.frame=CGRectMake(0, adminValueLbl.frame.size.height+adminValueLbl.frame.origin.y+3, self.view.bounds.size.width, 1);
                ;
                
                
                
                
                
                UILabel *totalSideLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, pricedetailDivider2.frame.origin.y+pricedetailDivider2.frame.size.height+4,  [NSString stringWithFormat:@"Total"].length*15,self.view.bounds.size.height/19)];
                // basePriceLbl.backgroundColor=[UIColor grayColor];
                totalSideLbl.text=[appDelegate.currentLangDic valueForKey:@"Total"];
                //LocalizedString(@"Total");//@"Total";
                
                totalSideLbl.font=[UIFont fontWithName:@"lato" size:15];
                
                
                
                UIFont *totalCurrencyFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *totalCurrencyDict = [NSDictionary dictionaryWithObject: totalCurrencyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *totalCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: totalCurrencyDict];
                NSString *lengthCheckingStr14=[totalCurrencyString string];
                [totalCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr14.length))];
                
                
                
                UIFont *totalValueFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *totalValueDict = [NSDictionary dictionaryWithObject:totalValueFont forKey:NSFontAttributeName];
                NSMutableAttributedString *totalValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",adminFee+serviceFee+[[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*[global_multiplicationLbl.text integerValue]] attributes:totalValueDict];
                
                totalFee=[[totalValueString string] doubleValue];
                
                NSString *lengthCheckingStr15=[totalValueString string];
                [totalValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr15.length))];
                
                [totalCurrencyString appendAttributedString:totalValueString];
                
                
                totalValueLbl=[[UILabel alloc]initWithFrame:CGRectMake(totalSideLbl.frame.origin.x+totalSideLbl.bounds.size.width+3, pricedetailDivider2.frame.origin.y+pricedetailDivider2.frame.size.height+4,self.view.bounds.size.width-(totalSideLbl.frame.origin.x+totalSideLbl.bounds.size.width+3+_profileImage.frame.origin.x),self.view.bounds.size.height/19)];
                totalValueLbl.textAlignment=NSTextAlignmentRight;
                totalValueLbl.attributedText=totalCurrencyString;
                totalValueLbl.font=[UIFont fontWithName:@"lato" size:15];
                
                
                UIButton *bookingBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, totalValueLbl.frame.origin.y+totalValueLbl.frame.size.height+4, self.view.bounds.size.width, 0)];//self.view.bounds.size.height/14.72
                
                bookingBtn.backgroundColor=[UIColor colorWithRed:255.0f/256 green:39.0f/256 blue:52.0f/256 alpha:1];
                
                if([[detailsDic valueForKey:@"instant_book_stat"] isEqualToString:@"yes"])
                {
                    
                    [bookingBtn setTitle:[appDelegate.currentLangDic valueForKey:@"Direct Book"]/*LocalizedString(@"Direct Book")*/ forState:UIControlStateNormal];
                    
                }
                else
                {
                    
                    [bookingBtn setTitle:[appDelegate.currentLangDic valueForKey:@"Request To Book"]/*LocalizedString(@"Request To Book")*/ forState:UIControlStateNormal];
                    
                    
                }
                
                
                UILabel *availableToLbl,*availableFromLbl,*availableLbl;
                UIView *seperatorView;
                
                if([[[detailsDic valueForKey:@"availability_details"] valueForKey:@"string_status"] isEqualToString:@"available_range"])
                {
                    
                    
                    availableLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, bookingBtn.frame.origin.y+bookingBtn.frame.size.height+5, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/19)];
                    availableLbl.font=[UIFont fontWithName:@"lato" size:15];
                    availableLbl.textAlignment=NSTextAlignmentCenter;
                    availableLbl.text=[appDelegate.currentLangDic valueForKey:@"Available"];//LocalizedString(@"Available");//@"Available";
                    
                    NSString *tempStrDate=[NSString stringWithFormat:@"From: %@",[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_from"]];
                    availableFromLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, availableLbl.frame.origin.y+availableLbl.frame.size.height+2,tempStrDate.length*7 , self.view.bounds.size.height/24)];
                    availableFromLbl.font=[UIFont fontWithName:@"lato" size:12];
                    availableFromLbl.text=[NSString stringWithFormat:@"%@: %@",[appDelegate.currentLangDic valueForKey:@"From"]/*LocalizedString(@"From")*/,[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_from"]];
                    
                    availableFromLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
                    
                    
                    
                    availableToLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x+availableFromLbl.bounds.size.width+3, availableFromLbl.frame.origin.y, self.view.bounds.size.width-(_profileImage.frame.origin.x+_profileImage.frame.origin.x+availableFromLbl.bounds.size.width+3), self.view.bounds.size.height/24)];
                    availableToLbl.font=[UIFont fontWithName:@"lato" size:12];
                    availableToLbl.text=[NSString stringWithFormat:@"%@: %@",/*LocalizedString(@"To")*/[appDelegate.currentLangDic valueForKey:@"To"],[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_to"]];
                    availableToLbl.textAlignment=NSTextAlignmentRight;
                    availableToLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
                    
                    
                    seperatorView=[[UIView alloc]init];
                    seperatorView.frame=CGRectMake(self.view.bounds.size.width/2-(1), availableLbl.frame.origin.y+availableLbl.bounds.size.height, 1, availableFromLbl.bounds.size.height);
                    seperatorView.backgroundColor=[UIColor lightGrayColor];
                    
                }
                
                
                
                
                if([[[detailsDic valueForKey:@"availability_details"] valueForKey:@"string_status"] isEqualToString:@"always"])
                {
                    
                    
                    availableLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, bookingBtn.frame.origin.y+bookingBtn.frame.size.height+5, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/19)];
                    availableLbl.font=[UIFont fontWithName:@"lato" size:15];
                    availableLbl.textAlignment=NSTextAlignmentCenter;
                    availableLbl.text=[appDelegate.currentLangDic valueForKey:@"Always available"];//LocalizedString(@"Always available");//@"Always available";
                    
                    
                    
                }
                
                
                
                [UIView animateWithDuration:.3 animations:^{
                    
                    [_scroll_view addSubview:bookingView];
                    
                    CGRect tempFrame=bookingView.frame;
                    tempFrame.size.height+=(availableLbl.frame.origin.y+availableLbl.frame.size.height+2)+availableToLbl.frame.size.height+10;
                    bookingView.frame=tempFrame;
                    
                    // NSLog(@"updated y---> %f",updatedOrigin_y);
                    
                    updatedOrigin_y+=bookingView.frame.size.height;
                    
                    // NSLog(@"updated y---> %f",updatedOrigin_y);
                    
                    [bookingView addSubview:quantityLbl];
                    [bookingView addSubview:quantityField];
                    [bookingView addSubview:priceDetails];
                    [bookingView addSubview:basePriceLbl];
                    [bookingView addSubview:pricedetailDivider];
                    [bookingView addSubview:global_multiplicationLbl];
                    [bookingView addSubview:serviceFeeLbl];
                    [bookingView addSubview:serviceValueLbl];
                    [bookingView addSubview:adminValueLbl];
                    [bookingView addSubview:adminFeeLbl];
                    [bookingView addSubview:pricedetailDivider1];
                    [bookingView addSubview:pricedetailDivider2];
                    [bookingView addSubview:totalSideLbl];
                    [bookingView addSubview:totalValueLbl];
                    [bookingView addSubview:bookingBtn];
                    [bookingView addSubview:availableLbl];
                    [bookingView addSubview:availableToLbl];
                    [bookingView addSubview:availableFromLbl];
                    [bookingView addSubview:seperatorView];
                    
                    
                    _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y+8);
                    
                    float scrollExapndValue=_scroll_view.contentSize.height;
                    
                    [_scroll_view setContentOffset:CGPointMake(0,scrollExapndValue-_scroll_view.frame.size.height)];
                    
                   // NSLog(@"Y-----> %f",_scroll_view.contentOffset.y);
                    
                    
                    
                } completion:nil];
                
                
                
                
            }
            
            else if([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"service_type"] isEqualToString:@"service"])
            {
                
  //@koustov
                if([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"booking_type"] isEqualToString:@"slot"])
                {
                    
                    UILabel *main_PriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, 4, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/14)];
                    main_PriceLabel.font=[UIFont fontWithName:@"lato-Bold" size:22];
                    main_PriceLabel.textAlignment=NSTextAlignmentCenter;
                    main_PriceLabel.text=[[detailsDic valueForKey:@"service_desc"] valueForKey:@"main_price"];
                    
                    
                    UIButton *bookingBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, main_PriceLabel.frame.origin.y+main_PriceLabel.frame.size.height+4, self.view.bounds.size.width, /*self.view.bounds.size.height/14.72*/0)];
                    bookingBtn.backgroundColor=[UIColor colorWithRed:255.0f/256 green:39.0f/256 blue:52.0f/256 alpha:1];
                    
                    if([[detailsDic valueForKey:@"instant_book_stat"] isEqualToString:@"yes"])
                    {
                        [bookingBtn setTitle:[appDelegate.currentLangDic valueForKey:@"Direct Book"]/*LocalizedString(@"Direct Book")*/ forState:UIControlStateNormal];
                    }
                    else
                    {
                        [bookingBtn setTitle:[appDelegate.currentLangDic valueForKey:@"Direct Book"]/*LocalizedString(@"Request To Book")*/ forState:UIControlStateNormal];
                        
                    }
                    
                    UILabel *availableToLbl,*availableFromLbl,*availableLbl;
                    UIView *seperatorView;
                    
                    
                    if([[[detailsDic valueForKey:@"availability_details"] valueForKey:@"string_status"] isEqualToString:@"available_range"])
                    {
                        
                        
                        availableLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, bookingBtn.frame.origin.y+bookingBtn.frame.size.height+5, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/19)];
                        availableLbl.font=[UIFont fontWithName:@"lato" size:15];
                        availableLbl.textAlignment=NSTextAlignmentCenter;
                        availableLbl.text=[appDelegate.currentLangDic valueForKey:@"Available"];//LocalizedString(@"Available");//@"Available";
                        
                        NSString *tempStrDate=[NSString stringWithFormat:@"From: %@",[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_from"]];
                        availableFromLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, availableLbl.frame.origin.y+availableLbl.frame.size.height+2,tempStrDate.length*7 , self.view.bounds.size.height/24)];
                        availableFromLbl.font=[UIFont fontWithName:@"lato" size:12];
                        availableFromLbl.text=[NSString stringWithFormat:@"%@: %@",/*LocalizedString(@"From")*/[appDelegate.currentLangDic valueForKey:@"From"],[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_from"]];
                        availableFromLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
                        
                        
                        
                        availableToLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x+availableFromLbl.bounds.size.width+3, availableFromLbl.frame.origin.y, self.view.bounds.size.width-(_profileImage.frame.origin.x+_profileImage.frame.origin.x+availableFromLbl.bounds.size.width+3), self.view.bounds.size.height/24)];
                        availableToLbl.font=[UIFont fontWithName:@"lato" size:12];
                        availableToLbl.text=[NSString stringWithFormat:@"%@: %@",[appDelegate.currentLangDic valueForKey:@"To"]/*LocalizedString(@"To")*/,[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_to"]];
                        availableToLbl.textAlignment=NSTextAlignmentRight;
                        availableToLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
                        
                        
                        seperatorView=[[UIView alloc]init];
                        seperatorView.frame=CGRectMake(self.view.bounds.size.width/2-(1), availableLbl.frame.origin.y+availableLbl.bounds.size.height, 1, availableFromLbl.bounds.size.height);
                        seperatorView.backgroundColor=[UIColor lightGrayColor];
                        
                    }
                    
                    
                    
                    
                    if([[[detailsDic valueForKey:@"availability_details"] valueForKey:@"string_status"] isEqualToString:@"always"])
                    {
                        
                        
                        availableLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, bookingBtn.frame.origin.y+bookingBtn.frame.size.height+5, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/19)];
                        availableLbl.font=[UIFont fontWithName:@"lato" size:15];
                        availableLbl.textAlignment=NSTextAlignmentCenter;
                        availableLbl.text=[appDelegate.currentLangDic valueForKey:@"Always available"];//LocalizedString(@"Always available");//@"Always available";
                        
                        
                        
                    }
                    
                    
                    
                    
                    [UIView animateWithDuration:.3 animations:^{
                        
                        [_scroll_view addSubview:bookingView];
                        
                        CGRect tempFrame=bookingView.frame;
                        tempFrame.size.height+=(availableLbl.frame.origin.y+availableLbl.frame.size.height+2)+availableToLbl.frame.size.height+8;
                        bookingView.frame=tempFrame;
                        updatedOrigin_y+=bookingView.frame.size.height;
                        
                        [bookingView addSubview:main_PriceLabel];
                        [bookingView addSubview:bookingBtn];
                        [bookingView addSubview:availableLbl];
                        [bookingView addSubview:availableToLbl];
                        [bookingView addSubview:availableFromLbl];
                        [bookingView addSubview:seperatorView];
                        
                        _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y+8);
                        float scrollExapndValue=_scroll_view.contentSize.height;
                        [_scroll_view setContentOffset:CGPointMake(0,scrollExapndValue-_scroll_view.frame.size.height)];
                       
                        //NSLog(@"Y-----> %f",_scroll_view.contentOffset.y);
                        
                        
                    } completion:nil];
                    
                    
                }
                
                if([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"booking_type"] isEqualToString:@"per_day"])
                {
                    
                    mainPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, 4, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/14)];
                    mainPriceLabel.font=[UIFont fontWithName:@"lato-Bold" size:22];
                    mainPriceLabel.textAlignment=NSTextAlignmentCenter;
                    mainPriceLabel.text=[[detailsDic valueForKey:@"service_desc"] valueForKey:@"main_price"];
                    
                    checkInBtn=[[UIButton alloc]init];
                    checkInBtn.backgroundColor=[UIColor colorWithRed:0.0f/256 green:189.0f/256 blue:138.0f/256 alpha:1];
                    checkInBtn.frame=CGRectMake(0, mainPriceLabel.frame.size.height+mainPriceLabel.frame.origin.y+4, self.view.bounds.size.width, self.view.bounds.size.height/14.72);
                    
                    
                    [checkInBtn setTitle:[appDelegate.currentLangDic valueForKey:@"Check In"]/*LocalizedString(@"Check In") */forState:UIControlStateNormal];//@"Check In"
                    
                    
                    [checkInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [checkInBtn addTarget:self action:@selector(openDatePicker:) forControlEvents:UIControlEventTouchUpInside];
                    
                    checkOutBtn=[[UIButton alloc]init];
                    checkOutBtn.backgroundColor=[UIColor colorWithRed:0.0f/256 green:189.0f/256 blue:138.0f/256 alpha:0.3];
                    checkOutBtn.frame=CGRectMake(0, checkInBtn.frame.size.height+checkInBtn.frame.origin.y+3, self.view.bounds.size.width, self.view.bounds.size.height/14.72);
                    [checkOutBtn setTitle:/*LocalizedString(@"Check Out")*/[appDelegate.currentLangDic valueForKey:@"Check Out"] forState:UIControlStateNormal];//@"Check Out"
                    checkOutBtn.userInteractionEnabled=NO;
                    [checkOutBtn addTarget:self action:@selector(openDatePicker:) forControlEvents:UIControlEventTouchUpInside];
                    [checkOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    
                    
                    UIButton *bookingBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, checkOutBtn.frame.origin.y+checkOutBtn.frame.size.height+4, self.view.bounds.size.width, /*self.view.bounds.size.height/14.72*/0)];
                    bookingBtn.backgroundColor=[UIColor colorWithRed:232.0f/256 green:122.0f/256 blue:86.0f/256 alpha:1];
                    
                    if([[detailsDic valueForKey:@"instant_book_stat"] isEqualToString:@"yes"])
                    {
                        [bookingBtn setTitle:/*LocalizedString(@"Direct Book")*/[appDelegate.currentLangDic valueForKey:@"Direct Book"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [bookingBtn setTitle:/*LocalizedString(@"Request To Book")*/[appDelegate.currentLangDic valueForKey:@"Request To Book"] forState:UIControlStateNormal];
                        
                    }
                    
                    UILabel *availableToLbl,*availableFromLbl,*availableLbl;
                    UIView *seperatorView;
                    
                    
                    if([[[detailsDic valueForKey:@"availability_details"] valueForKey:@"string_status"] isEqualToString:@"available_range"])
                    {
                        
                        
                        availableLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, bookingBtn.frame.origin.y+bookingBtn.frame.size.height+5, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/19)];
                        availableLbl.font=[UIFont fontWithName:@"lato" size:15];
                        availableLbl.textAlignment=NSTextAlignmentCenter;
                        availableLbl.text=[appDelegate.currentLangDic valueForKey:@"Available"];//LocalizedString(@"Available");//@"Available";
                        
                        NSString *tempStrDate=[NSString stringWithFormat:@"From: %@",[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_from"]];
                        availableFromLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, availableLbl.frame.origin.y+availableLbl.frame.size.height+2,tempStrDate.length*7 , self.view.bounds.size.height/24)];
                        availableFromLbl.font=[UIFont fontWithName:@"lato" size:12];
                        availableFromLbl.text=[NSString stringWithFormat:@"%@: %@",[appDelegate.currentLangDic valueForKey:@"From"]/*LocalizedString(@"From")*/,[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_from"]];
                        
                        availableFromLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
                        
                        
                        
                        availableToLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x+availableFromLbl.bounds.size.width+3, availableFromLbl.frame.origin.y, self.view.bounds.size.width-(_profileImage.frame.origin.x+_profileImage.frame.origin.x+availableFromLbl.bounds.size.width+3), self.view.bounds.size.height/24)];
                        availableToLbl.font=[UIFont fontWithName:@"lato" size:12];
                        availableToLbl.text=[NSString stringWithFormat:@"%@: %@",[appDelegate.currentLangDic valueForKey:@"To"]/*LocalizedString(@"To")*/,[[detailsDic valueForKey:@"availability_details"] valueForKey:@"avail_to"]];
                        availableToLbl.textAlignment=NSTextAlignmentRight;
                        availableToLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
                        
                        
                        seperatorView=[[UIView alloc]init];
                        seperatorView.frame=CGRectMake(self.view.bounds.size.width/2-(1), availableLbl.frame.origin.y+availableLbl.bounds.size.height, 1, availableFromLbl.bounds.size.height);
                        seperatorView.backgroundColor=[UIColor lightGrayColor];
                        
                    }
                    
                    
                    
                    
                    if([[[detailsDic valueForKey:@"availability_details"] valueForKey:@"string_status"] isEqualToString:@"always"])
                    {
                        
                        
                        availableLbl=[[UILabel alloc]initWithFrame:CGRectMake(_profileImage.frame.origin.x, bookingBtn.frame.origin.y+bookingBtn.frame.size.height+5, self.view.bounds.size.width-(_profileImage.frame.origin.x*2), self.view.bounds.size.height/19)];
                        availableLbl.font=[UIFont fontWithName:@"lato" size:15];
                        availableLbl.textAlignment=NSTextAlignmentCenter;
                        availableLbl.text=[appDelegate.currentLangDic valueForKey:@"Always available"];//LocalizedString(@"Always available");//@"Always available";
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    [UIView animateWithDuration:.3 animations:^{
                        
                        [_scroll_view addSubview:bookingView];
                        
                        CGRect tempFrame=bookingView.frame;
                        tempFrame.size.height+=(availableLbl.frame.origin.y+availableLbl.frame.size.height+2)+availableToLbl.frame.size.height+8;
                        bookingView.frame=tempFrame;
                        updatedOrigin_y+=bookingView.frame.size.height;
                        
                        [bookingView addSubview:mainPriceLabel];
                        [bookingView addSubview:checkInBtn];
                        [bookingView addSubview:checkOutBtn];
                        
                       // [bookingView addSubview:bookingBtn];
                        [bookingView addSubview:availableLbl];
                        [bookingView addSubview:availableToLbl];
                        [bookingView addSubview:availableFromLbl];
                        [bookingView addSubview:seperatorView];
                        
                        _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y+8);
                        float scrollExapndValue=_scroll_view.contentSize.height;
                        [_scroll_view setContentOffset:CGPointMake(0,scrollExapndValue-_scroll_view.frame.size.height)];
                       
                        //NSLog(@"Y-----> %f",_scroll_view.contentOffset.y);
                        
                        
                    } completion:nil];
                    
                    
                }
                
            }
            
            
            
        }
        
        
        
    }
    
    else if(bookingTapped==1 && [sender isEqual:clearBtn1])
    {
        bookingTapped=0;
        
        if([[detailsDic valueForKey:@"availability_status"] isEqualToString:@"not_available"])
        {
            
            [UIView animateWithDuration:.4 animations:^{
                
                CGRect tempFrame=bookingView.frame;
                tempFrame.size.height-=bookingView.frame.size.height;
                updatedOrigin_y-=bookingView.frame.size.height;
                bookingView.frame=tempFrame;
                _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y+5);
                
                
            } completion:^(BOOL finished) {
                
                [bookingView removeFromSuperview];
                
            }];
            
        }
        else if([[detailsDic valueForKey:@"availability_status"] isEqualToString:@"available"])
        {
            
            [UIView animateWithDuration:.4 animations:^{
                
                CGRect tempFrame=bookingView.frame;
                tempFrame.size.height-=bookingView.frame.size.height;
                updatedOrigin_y-=bookingView.frame.size.height;
                bookingView.frame=tempFrame;
                _scroll_view.contentSize=CGSizeMake(self.view.bounds.size.width, updatedOrigin_y+5);
                
                
            } completion:^(BOOL finished) {
                
                [bookingView removeFromSuperview];
                
            }];
            
        }
        
        
    }
    
}


-(void)openDatePicker:(UIButton *)sender
{
    
    tappedBtn=sender;
    
    if([sender isEqual:checkInBtn])
    {
        
        date_picker.minimumDate=[NSDate date];
        [date_picker setDate:[NSDate date]];
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        datePickerView.frame=CGRectMake(0, self.view.bounds.size.height-(self.view.bounds.size.height/2.5), self.view.bounds.size.width, self.view.bounds.size.height/2.5);
        
        
    }];
    
    
}

-(void)dateOk:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.2 animations:^{
        datePickerView.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
    }];
    
    NSDate *myDate = date_picker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
   
    NSLog(@"date----> %@",prettyVersion);
    
    NSArray *holidayArray=[[NSArray alloc]init];
    holidayArray=[detailsDic valueForKey:@"all_holidays"];
    
     NSLog(@"Holidays ~~~~~~~~~~~----------> %@",holidayArray);
    
    if(holidayArray.count>0)
    {
        if([holidayArray containsObject:prettyVersion])
        {
            
            prettyVersion=@"";
            UIAlertView *dateAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You can't select a holiday." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [dateAlert show];
            
        }
        
    }
    
    if(prettyVersion.length>0)
    {
        if([tappedBtn isEqual:checkInBtn])
        {
            date_picker.minimumDate=date_picker.date;
            checkOutBtn.userInteractionEnabled=YES;
            checkOutBtn.backgroundColor=[UIColor colorWithRed:0.0f/256 green:189.0f/256 blue:138.0f/256 alpha:1];
            [checkInBtn setTitle:prettyVersion forState:UIControlStateNormal];
            
            checkinDate=date_picker.date;
        }
        else if([tappedBtn isEqual:checkOutBtn])
        {
            
          //  NSLog(@"Checking out date--->");
            
            checkoutDate=date_picker.date;
            
           // NSLog(@"Checkin--> %@\nCheck out--> %@",checkinDate,checkoutDate);
            
            [checkOutBtn setTitle:prettyVersion forState:UIControlStateNormal];
            
            NSInteger interval=[checkoutDate timeIntervalSinceDate:checkinDate];
            
           // NSLog(@"Interval seconds----> %ld",interval);
            
            double days=(interval/24)/3600;
            
           // NSLog(@"no of days interval---> %f",days);
            
            if(days>=1)
            {
                mainPriceLabel.text=[NSString stringWithFormat:@"%@ %.2f",[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"],[[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*days];
                
               // NSLog(@"Checking out price---> %.2f",[[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*days);
            }
            
            else if(days<=1)
            {
                
                mainPriceLabel.text=[NSString stringWithFormat:@"%@ %.2f",[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"],[[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*1];
                
            }
            
        }
        
        
    }
    
}
-(void)dateCncl:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.2 animations:^{
        datePickerView.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
    }];
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    scrollPrevPoint=_scroll_view.contentOffset;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _scroll_view.contentOffset=CGPointMake(0, bookingHeader.frame.origin.y-bookingHeader.frame.size.height);
        
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _scroll_view.contentOffset=scrollPrevPoint;
        
    }];
    
    [textField resignFirstResponder];
    
    return YES;
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"string... %@",string);
    
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound)
    {
        return NO;
    }
    
    
    
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    if (isBackSpace == -8)
    {
        
        //NSLog(@"backspace...");
        
        if(quantityarray.count>0)
        {
            
            
            [quantityarray removeLastObject];
            
            //NSLog(@"Array--> %@",quantityarray);
            
            global_multiplicationLbl.text=[NSString stringWithFormat:@"%@",[quantityarray componentsJoinedByString:@""]];
            
            //---->
            UIFont *serviceCurrencyFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *serviceCurrencyDict = [NSDictionary dictionaryWithObject: serviceCurrencyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *serviceCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: serviceCurrencyDict];
            NSString *lengthCheckingStr7=[serviceCurrencyString string];
            [serviceCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr7.length))];
            
            
            servicePercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"service_fee"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
            
            UIFont *serviceValueFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *serviceValueDict = [NSDictionary dictionaryWithObject:serviceValueFont forKey:NSFontAttributeName];
            NSMutableAttributedString *serviceValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(servicePercentValue/100))] attributes:serviceValueDict];
            
            NSString *lengthCheckingStr8=[serviceValueString string];
            [serviceValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr8.length))];
            
            [serviceCurrencyString appendAttributedString:serviceValueString];
            
            serviceValueLbl.attributedText=serviceCurrencyString;
            
            //---->
            UIFont *adminCurrencyFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *adminCurrencyDict = [NSDictionary dictionaryWithObject: adminCurrencyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *adminCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: adminCurrencyDict];
            NSString *lengthCheckingStr12=[adminCurrencyString string];
            [adminCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr12.length))];
            
            
            adminPercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"admin_charge"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
            
            UIFont *adminValueFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *adminValueDict = [NSDictionary dictionaryWithObject:adminValueFont forKey:NSFontAttributeName];
            NSMutableAttributedString *adminValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(adminPercentValue/100))] attributes:adminValueDict];
            
            NSString *lengthCheckingStr13=[adminValueString string];
            [adminValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr13.length))];
            
            [adminCurrencyString appendAttributedString:adminValueString];
            
            adminValueLbl.attributedText=adminCurrencyString;
            
            serviceFee=[[serviceValueString string] doubleValue];
            adminFee=[[adminValueString string] doubleValue];
            
            //---->
            UIFont *totalCurrencyFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *totalCurrencyDict = [NSDictionary dictionaryWithObject: totalCurrencyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *totalCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: totalCurrencyDict];
            NSString *lengthCheckingStr14=[totalCurrencyString string];
            [totalCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr14.length))];
            
            
            
            UIFont *totalValueFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *totalValueDict = [NSDictionary dictionaryWithObject:totalValueFont forKey:NSFontAttributeName];
            NSMutableAttributedString *totalValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",adminFee+serviceFee+[[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*[global_multiplicationLbl.text integerValue]] attributes:totalValueDict];
            
            totalFee=[[totalValueString string] doubleValue];
            
            NSString *lengthCheckingStr15=[totalValueString string];
            [totalValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr15.length))];
            
            [totalCurrencyString appendAttributedString:totalValueString];
            
            totalValueLbl.attributedText=totalCurrencyString;
            
            
            
            if([global_multiplicationLbl.text isEqualToString:@""])
            {
                //NSLog(@"count---> %ld",quantityarray.count);
                
                [quantityarray removeAllObjects];
                global_multiplicationLbl.text=@"1";
                
                UIFont *serviceCurrencyFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *serviceCurrencyDict = [NSDictionary dictionaryWithObject: serviceCurrencyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *serviceCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: serviceCurrencyDict];
                NSString *lengthCheckingStr7=[serviceCurrencyString string];
                [serviceCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr7.length))];
                
                
                servicePercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"service_fee"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
                
                UIFont *serviceValueFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *serviceValueDict = [NSDictionary dictionaryWithObject:serviceValueFont forKey:NSFontAttributeName];
                NSMutableAttributedString *serviceValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(servicePercentValue/100))] attributes:serviceValueDict];
                
                NSString *lengthCheckingStr8=[serviceValueString string];
                [serviceValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr8.length))];
                
                [serviceCurrencyString appendAttributedString:serviceValueString];
                
                serviceValueLbl.attributedText=serviceCurrencyString;
                
                
                
                //---->
                UIFont *adminCurrencyFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *adminCurrencyDict = [NSDictionary dictionaryWithObject: adminCurrencyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *adminCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: adminCurrencyDict];
                NSString *lengthCheckingStr12=[adminCurrencyString string];
                [adminCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr12.length))];
                
                
                adminPercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"admin_charge"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
                
                UIFont *adminValueFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *adminValueDict = [NSDictionary dictionaryWithObject:adminValueFont forKey:NSFontAttributeName];
                NSMutableAttributedString *adminValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(adminPercentValue/100))] attributes:adminValueDict];
                
                NSString *lengthCheckingStr13=[adminValueString string];
                [adminValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr13.length))];
                
                [adminCurrencyString appendAttributedString:adminValueString];
                
                adminValueLbl.attributedText=adminCurrencyString;
                
                serviceFee=[[serviceValueString string] doubleValue];
                adminFee=[[adminValueString string] doubleValue];
                
                
                
                //---->
                UIFont *totalCurrencyFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *totalCurrencyDict = [NSDictionary dictionaryWithObject: totalCurrencyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *totalCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: totalCurrencyDict];
                NSString *lengthCheckingStr14=[totalCurrencyString string];
                [totalCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr14.length))];
                
                
                
                UIFont *totalValueFont = [UIFont fontWithName:@"lato" size:15];
                NSDictionary *totalValueDict = [NSDictionary dictionaryWithObject:totalValueFont forKey:NSFontAttributeName];
                NSMutableAttributedString *totalValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",adminFee+serviceFee+[[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*[global_multiplicationLbl.text integerValue]] attributes:totalValueDict];
                
                totalFee=[[totalValueString string] doubleValue];
                
                NSString *lengthCheckingStr15=[totalValueString string];
                [totalValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr15.length))];
                
                [totalCurrencyString appendAttributedString:totalValueString];
                
                totalValueLbl.attributedText=totalCurrencyString;
                
                
                
                
            }
            
        }
        
        
        
    }
    else
    {
        [quantityarray removeAllObjects];
        
        [quantityarray addObject:[NSString stringWithFormat:@"%@",string]];
        
        
        
        if([[detailsDic valueForKey:@"product_quantity"] intValue]>=[[quantityarray componentsJoinedByString:@""] intValue])
        {
            
            
            global_multiplicationLbl.text=[NSString stringWithFormat:@"%@",[quantityarray componentsJoinedByString:@""]];
            
            
            
            UIFont *serviceCurrencyFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *serviceCurrencyDict = [NSDictionary dictionaryWithObject: serviceCurrencyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *serviceCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: serviceCurrencyDict];
            NSString *lengthCheckingStr7=[serviceCurrencyString string];
            [serviceCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr7.length))];
            
            
            servicePercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"service_fee"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
            
            UIFont *serviceValueFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *serviceValueDict = [NSDictionary dictionaryWithObject:serviceValueFont forKey:NSFontAttributeName];
            NSMutableAttributedString *serviceValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(servicePercentValue/100))] attributes:serviceValueDict];
            
            NSString *lengthCheckingStr8=[serviceValueString string];
            [serviceValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr8.length))];
            
            [serviceCurrencyString appendAttributedString:serviceValueString];
            
            serviceValueLbl.attributedText=serviceCurrencyString;
            
            
            
            //---->
            UIFont *adminCurrencyFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *adminCurrencyDict = [NSDictionary dictionaryWithObject: adminCurrencyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *adminCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: adminCurrencyDict];
            NSString *lengthCheckingStr12=[adminCurrencyString string];
            [adminCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr12.length))];
            
            
            adminPercentValue=[[[[detailsDic valueForKey:@"price_details"] valueForKey:@"admin_charge"] stringByReplacingOccurrencesOfString:@"%" withString:@""]doubleValue];
            
            UIFont *adminValueFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *adminValueDict = [NSDictionary dictionaryWithObject:adminValueFont forKey:NSFontAttributeName];
            NSMutableAttributedString *adminValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",([[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*(adminPercentValue/100))] attributes:adminValueDict];
            
            NSString *lengthCheckingStr13=[adminValueString string];
            [adminValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr13.length))];
            
            [adminCurrencyString appendAttributedString:adminValueString];
            
            adminValueLbl.attributedText=adminCurrencyString;
            
            
            //---->
            UIFont *totalCurrencyFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *totalCurrencyDict = [NSDictionary dictionaryWithObject: totalCurrencyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *totalCurrencyString = [[NSMutableAttributedString alloc] initWithString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"currency"] attributes: totalCurrencyDict];
            NSString *lengthCheckingStr14=[totalCurrencyString string];
            [totalCurrencyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225.0f/256 green:62.0f/256 blue:89.0f/256 alpha:1] range:(NSMakeRange(0,lengthCheckingStr14.length))];
            
            
            
            UIFont *totalValueFont = [UIFont fontWithName:@"lato" size:15];
            NSDictionary *totalValueDict = [NSDictionary dictionaryWithObject:totalValueFont forKey:NSFontAttributeName];
            NSMutableAttributedString *totalValueString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@" %.2f",adminFee+serviceFee+[[[detailsDic valueForKey:@"service_desc"] valueForKey:@"only_mainprice"] doubleValue]*[global_multiplicationLbl.text integerValue]] attributes:totalValueDict];
            
            totalFee=[[totalValueString string] doubleValue];
            
            NSString *lengthCheckingStr15=[totalValueString string];
            [totalValueString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1] range:(NSMakeRange(0, lengthCheckingStr15.length))];
            
            [totalCurrencyString appendAttributedString:totalValueString];
            
            totalValueLbl.attributedText=totalCurrencyString;
            
            
            
            
            
            serviceFee=[[serviceValueString string] doubleValue];
            adminFee=[[adminValueString string] doubleValue];
            
        }
        else
        {
            UIAlertView *excessAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"You can't enter quantity above %@ currently.\n Thank You",[detailsDic valueForKey:@"product_quantity"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [excessAlert show];
            [quantityarray removeLastObject];
            //global_multiplicationLbl.text=@"1";
            return NO;
        }
        
        
        
    }
    
    
    return YES;
    
}



#pragma mark-review button action

-(void)showReview:(UIButton *)sender
{
    
   // NSLog(@"review btn tapped---->>>>");
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    reviewViewController *reviewVC=[storyBoard instantiateViewControllerWithIdentifier:@"details_reView"];
    
    reviewVC.imageArray=imageArray;
    reviewVC.ratingsDic=[detailsDic valueForKey:@"review_stars"];
    reviewVC.reviewDescArr=[detailsDic valueForKey:@"review_desc"];
    
    if(reviewVC.reviewDescArr.count>0)
        [self.navigationController pushViewController:reviewVC animated:YES];
    else
    {
        
        UIAlertView *reviewAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No reviews available currently." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [reviewAlert show];
        
        
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if(scrollView==_scroll_view)
    {
    
    
        if(scrollView.contentOffset.y<0)
        {
        
            
            
            // NSLog(@"scroll pos : %f",scrollView.contentOffset.y);
            
            //[self.view addSubview:_imageGallery];
            
            imageGalleryContainer.backgroundColor=[UIColor redColor];
            
            imageGalleryContainer.autoresizesSubviews=YES;
            
            imageGalleryContainer.frame =CGRectMake(0,scrollView.contentOffset.y, fixedWidthForImageGalleryView, fixedHeightForImageGalleryView-scrollView.contentOffset.y);
            
           // NSLog(@"scroll origin---> %f",_scroll_view.frame.origin.y);
            
           // [_imageGallery reloadItemsAtIndexPaths:@[[_imageGallery indexPathForCell:animatedImageCell]]];
            
            
             [_imageGallery reloadData];
            
            
        
        }
        
        else if(scrollView.contentOffset.y>=scrollPoint)//6.45454545
        {
            
            //6.45454545
            
            
            CGRect tempRect;
            
            if([UIScreen mainScreen].bounds.size.height==568)
            {
                
                tempRect=CGRectMake(_imageGallery.frame.origin.x, -self.view.bounds.size.height/3.3, _imageGallery.frame.size.width, _imageGallery.frame.size.height);
                
            }
            
            else
            {
                tempRect=CGRectMake(_imageGallery.frame.origin.x, -self.view.bounds.size.height/3.9, _imageGallery.frame.size.width, _imageGallery.frame.size.height);
            }
            
            _imageGallery.frame=tempRect;
            
            _overlayView.frame=CGRectMake(_overlayView.frame.origin.x, _imageGallery.frame.origin.y, _overlayView.frame.size.width, _imageGallery.frame.size.height);
            
            _overlayView.image = [UIImage imageWithCGImage: _overlayView.image.CGImage scale: 1.0f orientation: UIImageOrientationDownMirrored];
            
            //_overlayView.alpha=0.5;
            
            _profileImage.frame=CGRectMake(_profileImage.frame.origin.x, 20, _profileImage.frame.size.width, _profileImage.frame.size.height);
            
            
            _backBtn.frame=CGRectMake(_backBtn.frame.origin.x, 2, _backBtn.frame.size.width, _backBtn.frame.size.height);
            
           // _topLabel.frame=CGRectMake(_backBtn.frame.origin.x+_backBtn.frame.size.width+3, 10, _topLabel.frame.size.width, _topLabel.frame.size.height);
            
            
            
            
            //            [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            
            [self.view addSubview:_imageGallery];
            [self.view addSubview:_overlayView];
            
            
            
            
            [_overlayView addSubview:topaskBtn];
            [_overlayView addSubview:favBtn];
            [_overlayView addSubview:favIcon];
            [_overlayView addSubview:shareBtn];
            [_overlayView addSubview:shareIcon];
            //[_scroll_view addSubview:subDescLbl];
            
            [_overlayView bringSubviewToFront:topaskBtn];
            [_overlayView bringSubviewToFront:favBtn];
            [_overlayView bringSubviewToFront:favIcon];
            [_overlayView bringSubviewToFront:shareBtn];
            [_overlayView bringSubviewToFront:shareIcon];
            //[_overlayView bringSubviewToFront:_backBtn];
            
            
            [_overlayView setUserInteractionEnabled:YES];
            
            
            // [self.view addSubview:_profileImage];
            //[self.view addSubview:_topLabel];
            
            [self.view addSubview:_backBtn];
            
            
            
            //     } completion:nil];
            
            
            _imageGallery.userInteractionEnabled=NO;
            
        }
        
        else if(scrollView.contentOffset.y<=scrollPoint)//6.45454545
            
        {
            
            _overlayView.image = [UIImage imageWithCGImage: _overlayView.image.CGImage scale: 1.0f orientation: UIImageOrientationUpMirrored];
            
            _profileImage.frame=proImageFrame;
            _imageGallery.frame=galleryFrame;
           // _topLabel.frame=labelFrame;
            _overlayView.frame=overlayFrame;
            
            _backBtn.frame=backbtnFrame;
            
            topaskBtn.frame=topAskFrame;
            favBtn.frame=favBtnFrame;
            favIcon.frame=favIconFrame;
            shareBtn.frame=shareBtnFrame;
            shareIcon.frame=shareIconFrame;
            subDescLbl.frame=subDescLblframe;
            
            
            _overlayView.alpha=1;
            
            
            
            [imageGalleryContainer addSubview:_imageGallery];
            [_scroll_view addSubview:_overlayView];
            [_scroll_view addSubview:_profileImage];
           // [_scroll_view addSubview:_topLabel];
            [imageGalleryContainer addSubview:_backBtn];
            [imageGalleryContainer addSubview:_backBtn];
            
            [_scroll_view addSubview:topaskBtn];
            [_scroll_view addSubview:favBtn];
            [_scroll_view addSubview:favIcon];
            [_scroll_view addSubview:shareBtn];
            [_scroll_view addSubview:shareIcon];
            [_scroll_view addSubview:subDescLbl];
            
            
            imageGalleryContainer.autoresizesSubviews=YES;
            
            imageGalleryContainer.frame =CGRectMake(0,scrollView.contentOffset.y/2.75, fixedWidthForImageGalleryView, fixedHeightForImageGalleryView);

            
            _imageGallery.userInteractionEnabled=YES;
        }

 
     
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return imageArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId=@"cellID";
    
    
    imageCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if(imageCell==nil)
    {
        
        imageCell=[[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _imageGallery.frame.size.height)];
        
    }
    
    for (id temp in imageCell.contentView.subviews)
    {
        [temp removeFromSuperview];
    }
    
    UIImageView *cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _imageGallery.frame.size.height)];
    
    cellImageView.contentMode=UIViewContentModeScaleToFill;
    
    imageCell.backgroundColor=[UIColor greenColor];
    
     [imageCell.contentView addSubview:cellImageView];
    
  [cellImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray objectAtIndex:indexPath.row]]] placeholderImage:[UIImage imageNamed:@"placeholder_big"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
//    
//    [UIView animateWithDuration:5.0f animations:^{
//        cellImageView.alpha=0.0f;
//        
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:5.0f animations:^{
//            
//            cellImageView.alpha+=0.25f;
//            
//            cellImageView.alpha+=0.25f;
//            
//            cellImageView.alpha+=0.25f;
//            
//            cellImageView.alpha+=0.25f;
//            
//        }];
//    }];
//    
//
    
    
    
   //f cellImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    [imageCollection addObject:cellImageView.image];
    
    
    imageCell.backgroundColor=[UIColor blackColor];
    
    return imageCell;
    
    
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   // NSLog(@"kausik");
    
    return CGSizeMake(self.view.bounds.size.width, _imageGallery.frame.size.height);
}


- (IBAction)shareAction:(UIButton *)sender
{
  //  NSLog(@"share..");
    
    
    NSString *textToShare = [NSString stringWithFormat:@"%@\n%@",_topLabel.text,topDescLbl.text];
    NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray objectAtIndex:0]]];
    NSData *imageData=[NSData dataWithContentsOfURL:imageUrl];
    UIImage *imageToBeShared=[UIImage imageWithData:imageData];
    
    NSArray *objectsToShare = @[textToShare,imageToBeShared];
    
  //  NSLog(@"%@",imageToBeShared);
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
    
    
    
}



-(void)seeAminities:(UIButton *)sender
{
    
    moreAminitiesBtn.userInteractionEnabled=NO;
    

    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    visualViewForAminities=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualViewForAminities.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 0, 0);
    visualViewForAminities.alpha=0;
    [self.view addSubview:visualViewForAminities];
    

    popUpAminitiesView=[[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 0, 0)];
    popUpAminitiesView.backgroundColor=[UIColor whiteColor];
    popUpAminitiesView.alpha=0;
    [self.view addSubview:popUpAminitiesView];
    
    popUpAminitiesView.layer.cornerRadius=6;
    popUpAminitiesView.clipsToBounds=YES;

    
    tableForAminities=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, popUpAminitiesView.bounds.size.width,0)];
    tableForAminities.delegate=self;
    tableForAminities.dataSource=self;
    
    [popUpAminitiesView addSubview:tableForAminities];
    [tableForAminities setHidden:YES];
    
    visualViewForAminities.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height);

    
    
//    
//    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
//                        options:1 animations:^{
    
                            popUpAminitiesView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.14))/2,(self.view.bounds.size.height-(self.view.bounds.size.height/1.4))/2,self.view.bounds.size.width/1.14,self.view.bounds.size.height/1.4);
                            
                            tableForAminities.frame=CGRectMake(0,0 ,popUpAminitiesView.bounds.size.width, popUpAminitiesView.bounds.size.height);
                            
                            [tableForAminities setHidden:NO];
                            
                            visualViewForAminities.alpha+=0.35;
                            popUpAminitiesView.alpha+=0.5;
                            visualViewForAminities.alpha+=0.35;
                            visualViewForAminities.alpha=1;
                            popUpAminitiesView.alpha+=0.5;
                            
                            crossBtnForAminities=[[UIButton alloc]initWithFrame:CGRectMake(popUpAminitiesView.frame.origin.x-20, popUpAminitiesView.frame.origin.y-20, 40, 40)];
                            [crossBtnForAminities setImage:[UIImage imageNamed:@"close-128"] forState:UIControlStateNormal];
                            [crossBtnForAminities addTarget:self action:@selector(removeAminitiesView:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [self.view addSubview:crossBtnForAminities];
                            
//                            
//                        }completion:^(BOOL finished) {
//                            
//                            nil;
//                            
//                        } ];

    
    
    
}

-(void)removeAminitiesView:(UIButton *)sender
{

    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            [tableForAminities removeFromSuperview];

                            popUpAminitiesView.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 10, 10);
                            
                            visualViewForAminities.alpha-=0.5;
                            popUpAminitiesView.alpha-=0.5;
                            visualViewForAminities.alpha-=0.5;
                            popUpAminitiesView.alpha-=0.5;
                            sender.alpha-=.5;
                            sender.alpha-=.5;
                            
                            
                        } completion:^(BOOL finished) {
                            
                            [visualViewForAminities removeFromSuperview];
                            [sender removeFromSuperview];
                            [popUpAminitiesView removeFromSuperview];
                        }];
    
    moreAminitiesBtn.userInteractionEnabled=YES;


}

- (IBAction)askAQuestion:(id)sender {
    
    askQuestionBtn.userInteractionEnabled=NO;
    
    
//    blackOverlayView=[[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 0, 0)];
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
       blackOverlayView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blackOverlayView.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 0, 0);
    //blackOverlayView.backgroundColor=[UIColor blackColor];
    blackOverlayView.alpha=0;
    
    [self.view addSubview:blackOverlayView];
    
//    crossBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 20, 23, 23)];
//    [crossBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
//    [crossBtn addTarget:self action:@selector(removeAskMeView:) forControlEvents:UIControlEventTouchUpInside];
    
    askMeView=[[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.14))/2,-(self.view.bounds.size.height-(self.view.bounds.size.height/1.4))/2,self.view.bounds.size.width/1.14,self.view.bounds.size.height/1.4)];
    
    //(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 0, 0)
    
    askMeView.backgroundColor=[UIColor whiteColor];//self.view.bounds.size.height/2
    askMeView.alpha=0;
    [self.view addSubview:askMeView];
    
    askMeView.layer.cornerRadius=6;
    askMeView.clipsToBounds=YES;
    
    
    headerLbl=[[UILabel alloc]initWithFrame:CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2, askMeView.frame.size.width/8, 0,0)];
    headerLbl.font=[UIFont fontWithName:@"lato-Bold" size:15];
    headerLbl.textAlignment=NSTextAlignmentCenter;
    headerLbl.text=[[NSString stringWithFormat:@"%@",/*LocalizedString(@"ASK QUESTION")*/[appDelegate.currentLangDic valueForKey:@"ASK QUESTION"]] uppercaseString];
    
    subjectLbl=[[UILabel alloc]initWithFrame:CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,headerLbl.frame.origin.y+headerLbl.frame.size.height+5, 0,0)];
    subjectLbl.font=[UIFont fontWithName:@"lato" size:13];
    subjectLbl.textAlignment=NSTextAlignmentLeft;
    subjectLbl.text=[NSString stringWithFormat:@"%@:",[appDelegate.currentLangDic valueForKey:@"Subject"]];
    
    subjectDescLbl=[[UILabel alloc]initWithFrame:CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,subjectLbl.frame.origin.y+subjectLbl.frame.size.height+5, 0,0)];
    subjectDescLbl.font=[UIFont fontWithName:@"lato" size:13];
    subjectDescLbl.textAlignment=NSTextAlignmentLeft;
    subjectDescLbl.textColor=[UIColor lightGrayColor];
    subjectDescLbl.text=[NSString stringWithFormat:@"Question for %@",_topLabel.text];
    
    msgLbl=[[UILabel alloc]initWithFrame:CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,subjectDescLbl.frame.origin.y+subjectDescLbl.frame.size.height+5, 0,0)];
    msgLbl.font=[UIFont fontWithName:@"lato" size:13];
    msgLbl.textAlignment=NSTextAlignmentLeft;
    msgLbl.text=[NSString stringWithFormat:@"%@",[appDelegate.currentLangDic valueForKey:@"Message"]];
    
    
    askMeTextView=[[UITextView alloc]initWithFrame:CGRectMake(msgLbl.frame.origin.x, msgLbl.frame.origin.y+msgLbl.frame.size.height+5, 0, 0)];
    askMeTextView.delegate=self;
    askMeTextView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    askMeTextView.layer.borderWidth=1;
    askMeTextView.clipsToBounds=YES;
    
    //@koustov
    
    attachFileBtn=[[UIButton alloc]initWithFrame:CGRectMake(askMeTextView.frame.origin.x, askMeTextView.frame.origin.y+askMeTextView.frame.size.height+5, 0, 0)];
    [attachFileBtn setTitle:/*LocalizedString(@"Attach file")*/[appDelegate.currentLangDic valueForKey:@"Attach file"] forState:UIControlStateNormal];
    
    attachFileBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [attachFileBtn addTarget:self action:@selector(attachFile:) forControlEvents:UIControlEventTouchUpInside];
    [attachFileBtn setBackgroundColor:[UIColor lightGrayColor]];
    attachFileBtn.layer.cornerRadius=6;
    attachFileBtn.clipsToBounds=YES;
    
    filenameLbl=[[UILabel alloc]initWithFrame:CGRectMake(attachFileBtn.frame.origin.x+attachFileBtn.frame.size.width+3, askMeTextView.frame.origin.y+askMeTextView.frame.size.height+5+(attachFileBtn.frame.size.height/2), 0, 0)];
    filenameLbl.font=[UIFont fontWithName:@"lato" size:13];
    filenameLbl.textAlignment=NSTextAlignmentLeft;
    filenameLbl.textColor=[UIColor lightGrayColor];
    
    
    
    askBtn=[[UIButton alloc]initWithFrame:CGRectMake(askMeTextView.frame.origin.x, attachFileBtn.frame.origin.y+attachFileBtn.frame.size.height+12, 0,0)];
    [askBtn setTitle:[appDelegate.currentLangDic valueForKey:@"ASK QUESTION"] forState:UIControlStateNormal];
    [askBtn setBackgroundColor:[UIColor colorWithRed:250.0f/256 green:183.0f/256 blue:37.0f/256 alpha:1]];
    askBtn.layer.cornerRadius=6;
    askBtn.clipsToBounds=YES;
    
    [askBtn addTarget:self action:@selector(askQuestionUrl:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [askMeView addSubview:headerLbl];
    [askMeView addSubview:subjectLbl];
    [askMeView addSubview:subjectDescLbl];
    [askMeView addSubview:msgLbl];
    [askMeView addSubview:askMeTextView];
    [askMeView addSubview:askBtn];
    [askMeView addSubview:attachFileBtn];//filenameLbl
    [askMeView addSubview:filenameLbl];
    
    [headerLbl setHidden:YES];
    [subjectLbl setHidden:YES];
    [subjectDescLbl setHidden:YES];
    [msgLbl setHidden:YES];
    [askMeTextView setHidden:YES];
    [askBtn setHidden:YES];
    [attachFileBtn setHidden:YES];
    [filenameLbl setHidden:YES];
    
    
    
    headerLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2, askMeView.frame.size.width/8, askMeView.frame.size.width/1.3, askMeView.frame.size.width/8);
    subjectLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,headerLbl.frame.origin.y+headerLbl.frame.size.height+5, 150,askMeView.frame.size.width/10);
    subjectDescLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,subjectLbl.frame.origin.y+subjectLbl.frame.size.height+5, (askMeView.frame.size.width-(askMeView.frame.origin.x*2)),askMeView.frame.size.width/10);
    msgLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,subjectDescLbl.frame.origin.y+subjectDescLbl.frame.size.height+5, (askMeView.frame.size.width-(askMeView.frame.origin.x*2)),askMeView.frame.size.width/10);
    askMeTextView.frame=CGRectMake(askMeView.frame.origin.x, msgLbl.frame.origin.y+msgLbl.frame.size.height+5,(askMeView.frame.size.width-(askMeView.frame.origin.x*2)) , askMeView.frame.size.height/4);
    attachFileBtn.frame=CGRectMake(askMeTextView.frame.origin.x, askMeTextView.frame.origin.y+askMeTextView.frame.size.height+5, 100, 30);
    
    filenameLbl.frame=CGRectMake(attachFileBtn.frame.origin.x+attachFileBtn.frame.size.width+3,(attachFileBtn.frame.origin.y), askMeView.frame.size.width-(attachFileBtn.frame.origin.x+attachFileBtn.frame.size.width+3)-attachFileBtn.frame.origin.x, 23);
    
    askBtn.frame=CGRectMake(askMeTextView.frame.origin.x, attachFileBtn.frame.origin.y+attachFileBtn.frame.size.height+5, (askMeView.frame.size.width-(askMeView.frame.origin.x*2)), 45);
    
    [headerLbl setHidden:NO];
    [subjectLbl setHidden:NO];
    [subjectDescLbl setHidden:NO];
    [msgLbl setHidden:NO];
    [askMeTextView setHidden:NO];
    [askBtn setHidden:NO];
    [attachFileBtn setHidden:NO];
    [filenameLbl setHidden:NO];
    
    blackOverlayView.alpha+=0.35;
    askMeView.alpha+=0.5;
    blackOverlayView.alpha+=0.35;
    
    //@kbasu
    
    blackOverlayView.alpha=1;
    
    
    askMeView.alpha+=0.5;
    
  

    
    
    blackOverlayView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height);
    
//    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
//                        options:1 animations:^{
    
    [UIView animateWithDuration:0.4 animations:^{
        
     
                            askMeView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.14))/2,(self.view.bounds.size.height-(self.view.bounds.size.height/1.4))/2,self.view.bounds.size.width/1.14,self.view.bounds.size.height/1.4);
        
        
        
//                            headerLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2, askMeView.frame.size.width/8, askMeView.frame.size.width/1.3, askMeView.frame.size.width/8);
//                            subjectLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,headerLbl.frame.origin.y+headerLbl.frame.size.height+5, 150,askMeView.frame.size.width/10);
//                            subjectDescLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,subjectLbl.frame.origin.y+subjectLbl.frame.size.height+5, (askMeView.frame.size.width-(askMeView.frame.origin.x*2)),askMeView.frame.size.width/10);
//                            msgLbl.frame=CGRectMake((askMeView.frame.size.width-(askMeView.frame.size.width/1.3))/2,subjectDescLbl.frame.origin.y+subjectDescLbl.frame.size.height+5, (askMeView.frame.size.width-(askMeView.frame.origin.x*2)),askMeView.frame.size.width/10);
//                            askMeTextView.frame=CGRectMake(askMeView.frame.origin.x, msgLbl.frame.origin.y+msgLbl.frame.size.height+5,(askMeView.frame.size.width-(askMeView.frame.origin.x*2)) , askMeView.frame.size.height/4);
//                            attachFileBtn.frame=CGRectMake(askMeTextView.frame.origin.x, askMeTextView.frame.origin.y+askMeTextView.frame.size.height+5, 100, 30);
//                            
//                            filenameLbl.frame=CGRectMake(attachFileBtn.frame.origin.x+attachFileBtn.frame.size.width+3,(attachFileBtn.frame.origin.y), askMeView.frame.size.width-(attachFileBtn.frame.origin.x+attachFileBtn.frame.size.width+3)-attachFileBtn.frame.origin.x, 23);
//                            
//                            askBtn.frame=CGRectMake(askMeTextView.frame.origin.x, attachFileBtn.frame.origin.y+attachFileBtn.frame.size.height+5, (askMeView.frame.size.width-(askMeView.frame.origin.x*2)), 45);
//                            
//                            [headerLbl setHidden:NO];
//                            [subjectLbl setHidden:NO];
//                            [subjectDescLbl setHidden:NO];
//                            [msgLbl setHidden:NO];
//                            [askMeTextView setHidden:NO];
//                            [askBtn setHidden:NO];
//                            [attachFileBtn setHidden:NO];
//                            [filenameLbl setHidden:NO];
//                            
//                            blackOverlayView.alpha+=0.35;
//                            askMeView.alpha+=0.5;
//                            blackOverlayView.alpha+=0.35;
//                            
//                            //@kbasu
//                            
//                            blackOverlayView.alpha=1;
//                            
//                            
//                            askMeView.alpha+=0.5;
//                            
//                            crossBtn=[[UIButton alloc]initWithFrame:CGRectMake(askMeView.frame.origin.x-20, askMeView.frame.origin.y-20, 40, 40)];
//                            [crossBtn setImage:[UIImage imageNamed:@"close-128"] forState:UIControlStateNormal];
//                            [crossBtn addTarget:self action:@selector(removeAskMeView:) forControlEvents:UIControlEventTouchUpInside];
//
//
//                            
//                            [self.view addSubview:crossBtn];
//                            
//                            askmeViewFrame=askMeView.frame;
//                            crossbtnFrame=crossBtn.frame;
        
                            
                        }completion:^(BOOL finished) {
                            
                            crossBtn=[[UIButton alloc]initWithFrame:CGRectMake(askMeView.frame.origin.x-20, askMeView.frame.origin.y-20, 40, 40)];
                            [crossBtn setImage:[UIImage imageNamed:@"close-128"] forState:UIControlStateNormal];
                            [crossBtn addTarget:self action:@selector(removeAskMeView:) forControlEvents:UIControlEventTouchUpInside];
                            
                            
                            
                            [self.view addSubview:crossBtn];
                            
                            askmeViewFrame=askMeView.frame;
                            crossbtnFrame=crossBtn.frame;

                            
                        } ];
    
    
    
    
    
}

-(void)askQuestionUrl:(UIButton *)sender
{
    
    // sender.userInteractionEnabled=NO;
    
    if([[askMeTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]>0)
    {
        NSString *messageStr=[askMeTextView.text stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *url = [NSString stringWithFormat:@"%@app_category/app_ask_question?userid=%@&service_id=%@&message=%@",App_Domain_Url,UsrId,productId,messageStr];
        NSString *encode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      //  NSLog(@"url %@\n%@",url,encode);
        
        [askMeTextView resignFirstResponder];
        sender.userInteractionEnabled=NO;
        
      //  NSLog(@"%@",pictureData);
        
        [askBtn setTitle:@"Sending Question..." forState:UIControlStateNormal];
        
        UIActivityIndicatorView *loader=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(askBtn.frame.size.width-60, (askBtn.frame.size.height-30)/2, 30, 30)];
        [askBtn addSubview:loader];
        [loader startAnimating];
        askMeView.userInteractionEnabled=NO;
        
        
        [global_obj GlobalDict_imageFile:encode Globalstr_image:@"array" globalimage:pictureData Withblock:^(id result, NSError *error) {
            
          //  NSLog(@"REsult---->%@",result);
            
            
            if ([[result valueForKey:@"response"] isEqualToString:@"success"])
            {
                sender.userInteractionEnabled=YES;
                
                [UIView animateWithDuration:.2f animations:^{
                    
                    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                                        options:1 animations:^{
                                            
                                            [headerLbl removeFromSuperview];
                                            [subjectLbl removeFromSuperview];
                                            [subjectDescLbl removeFromSuperview];
                                            [msgLbl removeFromSuperview];
                                            [askMeTextView removeFromSuperview];
                                            [askBtn removeFromSuperview];
                                            [attachFileBtn removeFromSuperview];
                                            [filenameLbl removeFromSuperview];
                                            
                                            askMeView.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 10, 10);
                                            
                                            blackOverlayView.alpha-=0.35;
                                            askMeView.alpha-=0.5;
                                            blackOverlayView.alpha-=0.35;
                                            askMeView.alpha-=0.5;
                                            
                                            
                                        } completion:^(BOOL finished) {
                                            
                                            [blackOverlayView removeFromSuperview];
                                            [crossBtn removeFromSuperview];
                                            [askMeView removeFromSuperview];
                                        }];
                    
                    askQuestionBtn.userInteractionEnabled=YES;
                    
                    
                    
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully posted a question." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alrt show];
                    
                }];
                
                
            }
            
            
            else
            {
                
                //NSLog(@"Error----> %@",error);
                
                [askBtn setTitle:@"Ask Question" forState:UIControlStateNormal];
                
                [askBtn setUserInteractionEnabled:YES];
                
                [loader removeFromSuperview];
                
                askMeView.userInteractionEnabled=YES;
                
                
            }
            
            
            
            
        }];
        
        
    }
    else
    {
        
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[appDelegate.currentLangDic valueForKey:@"Message"] message:[appDelegate.currentLangDic valueForKey:@"Please enter a message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alrt show];
        
    }
    
}


-(void)attachFile:(UIButton *)sender
{
    imagePicker=[[UIImagePickerController alloc]init];
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    
    [popup showInView:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        askMeView.frame=askmeViewFrame;
        crossBtn.frame=crossbtnFrame;
        
    }];
    
    [askMeTextView resignFirstResponder];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageToUpload = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 150)];
    
   // NSLog(@"image--->%@",imageToUpload);
    
    pictureData = UIImagePNGRepresentation(imageToUpload);
    
    
    filenameLbl.text=[NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}



- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0)
    {
        imagePicker.delegate=self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    else if(buttonIndex==1)
    {
        imagePicker.delegate=self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
    }
}


-(void)removeAskMeView:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            [headerLbl removeFromSuperview];
                            [subjectLbl removeFromSuperview];
                            [subjectDescLbl removeFromSuperview];
                            [msgLbl removeFromSuperview];
                            [askMeTextView removeFromSuperview];
                            [askBtn removeFromSuperview];
                            [attachFileBtn removeFromSuperview];
                            [filenameLbl removeFromSuperview];
                            
                            
                            //        blackOverlayView.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 20, 20);
                            askMeView.frame=CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 10, 10);
                            
                            blackOverlayView.alpha-=0.5;
                            askMeView.alpha-=0.5;
                            blackOverlayView.alpha-=0.5;
                            askMeView.alpha-=0.5;
                            sender.alpha-=.5;
                            sender.alpha-=.5;
                            
                            
                        } completion:^(BOOL finished) {
                            
                            [blackOverlayView removeFromSuperview];
                            [sender removeFromSuperview];
                            [askMeView removeFromSuperview];
                        }];
    
    askQuestionBtn.userInteractionEnabled=YES;
    
    
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        askMeView.frame=CGRectMake(askMeView.frame.origin.x, askMeView.frame.origin.y-50, askMeView.frame.size.width, askMeView.frame.size.height);
        
        crossBtn.frame=CGRectMake(crossBtn.frame.origin.x, crossBtn.frame.origin.y-50, crossBtn.frame.size.width, crossBtn.frame.size.height);
        
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            askMeView.frame=CGRectMake(askMeView.frame.origin.x, askMeView.frame.origin.y+50, askMeView.frame.size.width, askMeView.frame.size.height);
            
            crossBtn.frame=CGRectMake(crossBtn.frame.origin.x, crossBtn.frame.origin.y+50, crossBtn.frame.size.width, crossBtn.frame.size.height);
            
        }];
        
        
        return NO;
    }
    
    return YES;
}

- (IBAction)addToWishList:(id)sender {
    
  //  NSLog(@"My id---> %@",UsrId);
    
    if([UsrId isEqualToString:[[detailsDic valueForKey:@"service_desc"] valueForKey:@"user_id"]])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You can't add your own product in wish list." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        
        NSString *urlString;
        
        urlString=[NSString stringWithFormat:@"%@app_json_site/app_wish_add_remove?userid=%@&service_id=%@",App_Domain_Url,UsrId,productId];
        
      //  NSLog(@"Wishlist url----> %@",urlString);
        
        [global_obj GlobalDict:urlString Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            if(result)
            {
               // NSLog(@"Wishlist stat----> %@",result);
                
                if([[result valueForKey:@"message"] isEqualToString:@"product deleted from wishlist successfully"])
                {
                    
                    wishBtnImageView.image=[UIImage imageNamed:@"unfilled_heart"];
                    
                    NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
                    tempDic=[[detailsDic valueForKey:@"service_desc"] mutableCopy];
                    [tempDic setValue:@"N" forKey:@"wishlist_stat"];
                    [detailsDic setValue:tempDic forKey:@"service_desc"];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Messagae" message:@"Product deleted from wishlist successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                    
                    
                }
                else if([[result valueForKey:@"message"] isEqualToString:@"product added in wishlist successfully"])
                {
                    
                    wishBtnImageView.image=[UIImage imageNamed:@"hearticon"];
                    
                    NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
                    tempDic=[[detailsDic valueForKey:@"service_desc"] mutableCopy];
                    [tempDic setValue:@"Y" forKey:@"wishlist_stat"];
                    [detailsDic setValue:tempDic forKey:@"service_desc"];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Messagae" message:@"Product added in wishlist successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                    
                    
                }
                
            }
            
            
        }];
        
    }
    
    
}


#pragma mark--image slider creation

- (void)imageSliderCreate
{
    
    NSLog(@"Imagelink array-----> %@",imagelinkArray);
    
    if(imagelinkArray.count>0)
    {
        
        
        
        //    _slideImageViewController = [PEARImageSlideViewController new];
        //
        //    [_slideImageViewController setImageLists:[imagelinkArray valueForKey:@"link"]];//imageArray
        //
        //    [_slideImageViewController showAtIndex:0];
        
        
        
        blackViewForImageSlider=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        blackViewForImageSlider.backgroundColor=[UIColor blackColor];
        [self.view addSubview:blackViewForImageSlider];
        
        imageScrollForSliding=[[UIScrollView alloc]initWithFrame:blackViewForImageSlider.frame];
        imageScrollForSliding.pagingEnabled=YES;
        imageScrollForSliding.delegate=self;
        
        [blackViewForImageSlider addSubview:imageScrollForSliding];
        
        float updatedXValue=0;
        
        int j=1;
        
        for (int i=0; i<imagelinkArray.count; i++) {
            
            
            
            scrollImageView=[[UIImageView alloc]initWithFrame:CGRectMake(updatedXValue, (imageScrollForSliding.frame.size.height-(self.view.bounds.size.height/1.3))/2, imageScrollForSliding.frame.size.width, self.view.bounds.size.height/1.3)];
            
            
            scrollImageView.tag=i;
            
            scrollImageView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
            
            tapGestureRecognize.delegate = self;
            tapGestureRecognize.numberOfTapsRequired = 2;
            
            [scrollImageView addGestureRecognizer:tapGestureRecognize];
            
          
                   scrollImageView.contentMode=UIViewContentModeScaleAspectFit;
            
            
            [scrollImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagelinkArray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"Image File-64"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            [imageScrollForSliding addSubview:scrollImageView];
            
            updatedXValue+=scrollImageView.frame.size.width;
            
            imageScrollForSliding.contentSize=CGSizeMake(j*scrollImageView.frame.size.width, scrollImageView.frame.size.height);
            
            
            
            j=j+1;
            
        }
        
        closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, 20, 40, 40)];
        [closeBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeImageSlider:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        [self.view addSubview:deleteImageBtn];
        
        [self.view addSubview:closeBtn];
        
    }
    else
    {
        
        UIAlertView *noImageAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"No imges to display." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noImageAlert show];
        
    }
    
}




-(void)closeImageSlider:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         blackViewForImageSlider.alpha = 0.0;
         blackViewForImageSlider.transform = CGAffineTransformMakeScale(10.0, 0.1);
     }
                     completion:^(BOOL finished)
     {
         [blackViewForImageSlider removeFromSuperview];
         [closeBtn removeFromSuperview];
         //view = nil;
     }];
    
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return zoomingImageView;
    
}

-(void)tapped:(UITapGestureRecognizer *)tapGesture
{
    
    blackViewForZooming=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    blackViewForZooming.backgroundColor=[UIColor blackColor];
    [self.view addSubview:blackViewForZooming];
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelZoomingView:)];
    
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 2;
    [blackViewForZooming addGestureRecognizer:tapGestureRecognize];
    
    scrollViewForZooming.showsHorizontalScrollIndicator=NO;
    scrollViewForZooming.showsVerticalScrollIndicator=NO;
    scrollViewForZooming=[[UIScrollView alloc]initWithFrame:blackViewForZooming.frame];
    scrollViewForZooming.bounces=YES;
    scrollViewForZooming.pagingEnabled=NO;
    
    scrollViewForZooming.minimumZoomScale=1.0;
    scrollViewForZooming.maximumZoomScale=4.0;
    
    scrollViewForZooming.delegate=self;
    
    [blackViewForZooming addSubview:scrollViewForZooming];
    
    UIImageView *imageView=(UIImageView *)tapGesture.view;
    
    doubleTappedImageview=(UIImageView *)tapGesture.view;
    
    //    zoomingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, (scrollViewForZooming.frame.size.height-(self.view.bounds.size.height/1.3))/2, scrollViewForZooming.frame.size.width, self.view.bounds.size.height/1.3)];
    
    zoomingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, (scrollViewForZooming.frame.size.height-(self.view.bounds.size.height/1.3))/2, scrollViewForZooming.frame.size.height/1.3, self.view.bounds.size.height/1.3)];
    
    scrollViewForZooming.contentSize=CGSizeMake(scrollViewForZooming.frame.size.height/1.3, scrollViewForZooming.frame.size.height);
    
    scrollViewForZooming.contentOffset=CGPointMake((scrollViewForZooming.frame.size.height/1.3)/5, scrollViewForZooming.contentOffset.y);
    
    zoomingImageView.image=imageView.image;
    
    [scrollViewForZooming addSubview:zoomingImageView];
    
}

-(void)cancelZoomingView:(UITapGestureRecognizer *)tapGesture
{
    
    UIView *view=tapGesture.view;
    
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         view.alpha = 0.0;
         view.transform = CGAffineTransformMakeScale(10.0, 0.1);
     }
                     completion:^(BOOL finished)
     {
         [view removeFromSuperview];
         //view = nil;
     }];
    
    
}




-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
    NSLog(@"Zoom ends at scale... %f",scale);
    
    
}



#pragma mark--





-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}

- (IBAction)takeMeToTheProfile:(id)sender

{
    //(@"profile btn      %d",(int)sender.tag);
    
    
    NSString *BusnessUserId = [[detailsDic valueForKey:@"service_desc"] valueForKey:@"user_id"];
    
    
    
    BusinessProfileViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"busniessprofile"];
    
    
    obj.BusnessUserId = BusnessUserId;
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
