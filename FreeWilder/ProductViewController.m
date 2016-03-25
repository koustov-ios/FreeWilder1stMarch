
#import "Reachability.h"
#import "ProductViewController.h"
#import "Productcell.h"
#import "Footer.h"
#import "Side_menu.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailsViewController.h"
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "ServiceView.h"
#import "accountsubview.h"
#import "notificationsettingsViewController.h"
#import "ChangePassword.h"
#import "LanguageViewController.h"
#import "UserService.h"
#import "MyBooking & Request.h"
#import "userBookingandRequestViewController.h"
#import "myfavouriteViewController.h"
#import "Business Information ViewController.h"
#import "SettingsViewController.h"
#import "PaymentMethodViewController.h"
#import "PrivacyViewController.h"
#import "WishlistViewController.h"
#import "profile.h"
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "ViewController.h"
#import "FW_JsonClass.h"
#import "BusinessProfileViewController.h"
//#import "Product_Details_ViewController.h"
#import "FWProductDetailsViewController.h"
#import "sideMenu.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <pop/POP.h>


@interface ProductViewController ()<footerdelegate,Slide_menu_delegate,accountsubviewdelegate,Serviceview_delegate,Profile_delegate,UITextFieldDelegate,UIGestureRecognizerDelegate,sideMenu,CLLocationManagerDelegate,MKMapViewDelegate>
{
    
     sideMenu *leftMenu;
    
    ServiceView *service;
    NSString *priceSign;
    
    // IBOutlet UIActivityIndicatorView *spinner;
    
    BOOL tapchk,tapchk1,tapchk2;
    accountsubview *subview;
    profile *profileview;
    
    NSMutableArray *jsonArray,*temp;
    
    UIView *blackview ,*popview;
    UITextField *phoneText;
    
    NSString *userid,*phoneno;
    Productcell *cell;
    
    //Lazy loading related variables
    
    int start_end;
    
    BOOL lazyLoadingGoingOn,internetConnected,nomoreData,insertionGoingOn,noLazyLoading;
    
    NSInteger lastRow;
    
    NSInteger rowToBeInsertedFrom;
    
    int langId;
    
    
    IBOutlet UIImageView *loaederImageView;
    IBOutlet UIView *loaderBackView;
    IBOutlet UIActivityIndicatorView *loader;
    
    float latitude,longitude;
    NSString *my_address;
    
    NSArray *productidArr_ldb;
    BOOL inThisPage,morbtn_appeared;
    UIButton *moreButton;
  
}

@property(nonatomic,strong)CLLocationManager *locationManager;
typedef void(^addressCompletion)(NSString *);

@end

@implementation ProductViewController
@synthesize CategoryId,lblCategoryName,ProductListingTable,lblPageTitle;
@synthesize cellindex,arrtotal;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

#pragma mark-Network Status change notification

- (void)reachabilityDidChange:(NSNotification *)notification {
    Reachability *reachability = (Reachability *)[notification object];
    
    if ([reachability isReachable])
    {
        NSLog(@"<---------Reachable--------->");
        
        if(inThisPage==YES)
        {
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            if (localNotif == nil) return;
            NSDate *fireTime = [NSDate dateWithTimeIntervalSinceNow:5]; // adds 10 secs
            localNotif.fireDate = fireTime;
            localNotif.alertBody = @"Product list Syncing";
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            
            [[NSNotificationCenter defaultCenter]removeObserver:self];
            //[self urlfire];
            
//            morbtn_appeared=YES;
//            
//            moreButton=[[UIButton alloc]initWithFrame:CGRectMake(150, self.view.bounds.size.height-50, self.view.bounds.size.width-300, 30)];
//            
//            
//            [moreButton setImage:[UIImage imageNamed:@"new_update"] forState:UIControlStateNormal];
//            
//            [moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.view addSubview:moreButton];
//            
//            [moreButton setHidden:NO];
//
//            
//            moreButton.layer.cornerRadius=6.0f;
//            moreButton.clipsToBounds=YES;
//            
//            
//            [UIView animateWithDuration:0.3f
//                                  delay:0.6f
//                                options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |UIViewAnimationOptionAllowUserInteraction
//                             animations:^{
//                                 [moreButton setFrame:CGRectMake(150, self.view.bounds.size.height-40, self.view.bounds.size.width-300, 30)];
//                             }
//                             completion:^(BOOL finished) {
// 
//             
//             }];

        }
    }
    else
    {
        NSLog(@"---------Unreachable---------");
        
        [moreButton setHidden:YES];
        
       // [[NSNotificationCenter defaultCenter]removeObserver:self];
        
        
    }
}

-(void)more
{
    
    [moreButton setHidden:YES];
    
    morbtn_appeared=NO;
    
    [ProductListingTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}


#pragma mark-


- (void)viewDidLoad {
    [super viewDidLoad];
    
    inThisPage=YES;
    
    productidArr_ldb=[[NSArray alloc]init];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
    
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here

      
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

    
 
    
    start_end=0;
    lazyLoadingGoingOn=NO;
    internetConnected=YES;
    nomoreData=NO;
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    cellindex=[[NSMutableArray alloc]init];
    arrtotal=[[NSMutableArray alloc]init];
    
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
    footer.Delegate=self;
    [_footer_base addSubview:footer];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    
    temp= [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectCD:) name:@"no_internet" object:nil];
    
    netcheck=1;
    
    /// Getting side from Xib & creating a black overlay
    
    
    //(@"category id=%@",CategoryId);
    globalobj=[[FW_JsonClass alloc]init];
    ArrProductList=[[NSMutableArray alloc] init];
    
    
    lblPageTitle.text=_headerTitle;
    
    //[[appDelegate.currentLangDic valueForKey:@"Product_Listing"] uppercaseString];//LocalizedString(@"Product_Listing") ;

    
    //    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    //    {
    //        //connection unavailable
    //
    //        NSLog(@"No connection----|||");
    //
    //        noLazyLoading=YES;
    //
    //        NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
    //
    //        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductList"];
    //        fetchRequest.predicate=[NSPredicate predicateWithFormat:@"user_id==%@ AND categoryId==%@",userid,CategoryId];
    //        NSError *error;
    //        NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
    //        if(fetchedObjects.count>0)
    //        {
    //            for (NSManagedObject *object in fetchedObjects)
    //            {
    //
    //                [ArrProductList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[object valueForKey:@"product"]]];
    //
    //            }
    //            //_processview.hidden=YES;
    //            [ProductListingTable reloadData];
    //
    //            error = nil;
    //            [theContext save:&error];
    //        }
    //
    //
    //    }
    //    else
    //    {
    //        //connection available
    //
    //        // Deleteing preexisting property data from database
    //
    //        noLazyLoading=NO;
    //
    //        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //
    //        NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
    //
    //        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductList"];
    //       fetchRequest.predicate=[NSPredicate predicateWithFormat:@"user_id==%@ AND categoryId==%@",userid,CategoryId];
    //        NSError *error;
    //        NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
    //
    //        NSLog(@"No of property data in database is: %ld",fetchedObjects.count);
    //
    //        if(fetchedObjects.count>0)
    //        {
    //            for (NSManagedObject *object in fetchedObjects)
    //            {
    //                [theContext deleteObject:object];
    //            }
    //
    //            error = nil;
    //            [theContext save:&error];
    //        }
    //
    //
    //
    //        [self ProductDetailUrl];
    //
    //    }
    
    
}


-(void)getTheProductList
{

   
    //[loader startAnimating];
    
    self.automaticallyAdjustsScrollViewInsets=NO ;
    
//     loaderBackView.hidden=NO;
//    loaederImageView.layer.shadowOffset=CGSizeMake(0, 1);
//    loaederImageView.layer.shadowRadius=3.5;
//    loaederImageView.layer.shadowColor=[UIColor blackColor].CGColor;
//    loaederImageView.layer.shadowOpacity=0.4;
//    loaederImageView.clipsToBounds=NO;
//    
//    
//    [self runSpinAnimationOnView:loaederImageView duration:10 rotations:1 repeat:200];
    
    
    start_end=0;
    
    ArrProductList=[[NSMutableArray alloc]init];
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        //connection unavailable
        
        NSLog(@"No connection----|||");
        
        noLazyLoading=YES;
        
        NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductList"];
        fetchRequest.predicate=[NSPredicate predicateWithFormat:@"user_id==%@ AND categoryId==%@",userid,CategoryId];
        NSError *error;
        NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
        if(fetchedObjects.count>0)
        {
            
            productidArr_ldb=[fetchedObjects valueForKey:@"productid"];
            
            NSLog(@"Product id------>\n [\n %@ \n]",productidArr_ldb);
            
            for (NSManagedObject *object in fetchedObjects)
            {
                
                [ArrProductList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[object valueForKey:@"product"]]];
                
            }
            //_processview.hidden=YES;
            [ProductListingTable reloadData];
            
            error = nil;
            [theContext save:&error];
            
            _noDataFoundLbl.hidden=YES;
        }
        else
        {
            
            _noDataFoundLbl.hidden=NO;
            
        }
        
        loaderBackView.hidden=YES;
        [loader stopAnimating];
        
    }
    else
    {
        //connection available
        
        // Deleteing preexisting property data from database
        
        noLazyLoading=NO;
        
        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductList"];
        fetchRequest.predicate=[NSPredicate predicateWithFormat:@"user_id==%@ AND categoryId==%@",userid,CategoryId];
        NSError *error;
        NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
        
        NSLog(@"No of property data in database is: %ld",fetchedObjects.count);
        
        if(fetchedObjects.count>0)
        {
            for (NSManagedObject *object in fetchedObjects)
            {
                [theContext deleteObject:object];
            }
            
            error = nil;
            [theContext save:&error];
        }
        
        
        [self ProductDetailUrl];
        
    }



}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
 
    NSLog(@"calling......");
    
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    
    
    [self.locationManager stopUpdatingLocation];
    
    CLLocation* eventLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [self getAddressFromLocation:eventLocation complationBlock:^(NSString * address) {
        if(address) {
            
            NSLog(@"Address----> %@",address);
            my_address=address;
            
            if(my_address.length>0)
            {
                
                [self getTheProductList];
                
            }
            

            
        }
    }];
    
   }


-(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock
{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@, %@ %@", placemark.name, placemark.postalCode, placemark.locality];
             completionBlock(address);
             
         }
     }];
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



-(void)viewWillAppear:(BOOL)animated
{
   // [ArrProductList removeAllObjects];
    
    my_address=@"";
    
    
    loaderBackView.hidden=NO;
    loaederImageView.hidden=NO;
    loaederImageView.layer.shadowOffset=CGSizeMake(0, 1);
    loaederImageView.layer.shadowRadius=3.5;
    loaederImageView.layer.shadowColor=[UIColor blackColor].CGColor;
    loaederImageView.layer.shadowOpacity=0.4;
    loaederImageView.clipsToBounds=NO;
    
    
    [self runSpinAnimationOnView:loaederImageView duration:10 rotations:1 repeat:200];
    

    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    
    
    
    
//    loaderBackView.hidden=NO;
//    //[loader startAnimating];
//    
//     self.automaticallyAdjustsScrollViewInsets=NO ;
//    
//    loaederImageView.layer.shadowOffset=CGSizeMake(0, 1);
//    loaederImageView.layer.shadowRadius=3.5;
//    loaederImageView.layer.shadowColor=[UIColor blackColor].CGColor;
//    loaederImageView.layer.shadowOpacity=0.4;
//    loaederImageView.clipsToBounds=NO;
//    
//    
//    [self runSpinAnimationOnView:loaederImageView duration:10 rotations:1 repeat:200];
//
//    
//    start_end=0;
//    
//    ArrProductList=[[NSMutableArray alloc]init];
//
//    
//    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
//    {
//        //connection unavailable
//        
//        NSLog(@"No connection----|||");
//        
//        noLazyLoading=YES;
//        
//        NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
//        
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductList"];
//        fetchRequest.predicate=[NSPredicate predicateWithFormat:@"user_id==%@ AND categoryId==%@",userid,CategoryId];
//        NSError *error;
//        NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
//        if(fetchedObjects.count>0)
//        {
//            
//            productidArr_ldb=[fetchedObjects valueForKey:@"productid"];
//            
//            NSLog(@"Product id------>\n [\n %@ \n]",productidArr_ldb);
//            
//            for (NSManagedObject *object in fetchedObjects)
//            {
//                
//                [ArrProductList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[object valueForKey:@"product"]]];
//                
//            }
//            //_processview.hidden=YES;
//            [ProductListingTable reloadData];
//            
//            error = nil;
//            [theContext save:&error];
//            
//            _noDataFoundLbl.hidden=YES;
//        }
//        else
//        {
//        
//            _noDataFoundLbl.hidden=NO;
//        
//        }
//        
//        loaderBackView.hidden=YES;
//        [loader stopAnimating];
//        
//    }
//    else
//    {
//        //connection available
//        
//        // Deleteing preexisting property data from database
//        
//        noLazyLoading=NO;
//        
//        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//        
//        NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
//        
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductList"];
//        fetchRequest.predicate=[NSPredicate predicateWithFormat:@"user_id==%@ AND categoryId==%@",userid,CategoryId];
//        NSError *error;
//        NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
//        
//        NSLog(@"No of property data in database is: %ld",fetchedObjects.count);
//        
//        if(fetchedObjects.count>0)
//        {
//            for (NSManagedObject *object in fetchedObjects)
//            {
//                [theContext deleteObject:object];
//            }
//            
//            error = nil;
//            [theContext save:&error];
//        }
//        
//        
//        [self ProductDetailUrl];
//        
//    }
    
    
    
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
//    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
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

-(void)connectCD:(NSNotification *)note
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"   message:@"Connection Faild!" delegate:nil  cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
    [alert show];
    internetConnected=NO;
    
    netcheck=0;
    
}

-(void)insertInCoreData:(NSArray *)propertyArray
{
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *cntxt=[appDelegate managedObjectContext];
    
    if(propertyArray.count>0)
    {
        
        
        for (int i=0; i<propertyArray.count; i++) {
            
            
            NSManagedObject *entityOBJ=[NSEntityDescription insertNewObjectForEntityForName:@"ProductList" inManagedObjectContext:cntxt];
            
            NSData *propertyData=[[NSData alloc]init];
            propertyData=[NSKeyedArchiver archivedDataWithRootObject:[propertyArray objectAtIndex:i]];
            [entityOBJ setValue:userid forKey:@"user_id"]; //@"user_id==%@ AND categoryId==%@"
            [entityOBJ setValue:propertyData forKey:@"product"];
            [entityOBJ setValue:[[propertyArray objectAtIndex:i] valueForKey:@"service_id"] forKey:@"productid"];
            [entityOBJ setValue:CategoryId forKey:@"categoryId"];
            
            NSError *error=nil;
            
            if([cntxt save:&error])
            {
                NSLog(@"Saved successfully....");
            }
            
            
            
        }
        
        
        
        
    }
    
    
}




-(void)ProductDetailUrl
{
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@app_product_details_cat?catid=%@&userid=%@&start_from=%d&per_page=10&lang_id=%d&serviceplae=%@&srch_lat=%@&srch_lon=%@&cur_id=%@",App_Domain_Url,[CategoryId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"],start_end,langId,my_address,[NSString stringWithFormat:@"%f",latitude],[NSString stringWithFormat:@"%f",longitude],[[NSUserDefaults standardUserDefaults]valueForKey:@"curr_id"]];
    
    urlstring=[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"URL str--------=>>>> %@",urlstring);
    
    
    //urlstring = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlstring] encoding:NSISOLatin1StringEncoding error:nil];
    
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"What I got in product list ----> %@",result);
        
        if([[result valueForKey:@"next_data"] isEqualToString:@"0"])
        {
        
            nomoreData=YES;
            noLazyLoading=YES;
        
        }
        
if(result)
{


    if([[result valueForKey:@"response"] isEqualToString:@"success"])
        
    {
        
        
        NSMutableArray *tempArr=[[NSMutableArray alloc]init];
        NSInteger urldatacount;
        
        for ( NSDictionary *tempDict1 in  [result objectForKey:@"details"])
        {
            urldatacount++;
            [tempArr addObject:tempDict1];
            
        }
        
        if(lblCategoryName.text.length==0)
        {
            if(tempArr.count>0)
            {
                
                //                    NSString *encoded_string = [[tempArr objectAtIndex:0] valueForKey:@"category_name"] ;
                //                    const char *ch = [encoded_string cStringUsingEncoding:NSISOLatin1StringEncoding];
                //                    NSString *decode_string = [[NSString alloc]initWithCString:ch encoding:NSUTF8StringEncoding];
                
                
                // lblCategoryName.text=decode_string;
                
                lblCategoryName.text=[NSString stringWithCString:[[[tempArr objectAtIndex:0] valueForKey:@"category_name"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding  ];
                
                
                
                
            }
            //                    lblCategoryName.text=[[tempArr objectAtIndex:0] valueForKey:@"category_name"];
            lblCategoryName.textAlignment=NSTextAlignmentCenter;
        }
        
        
        [ArrProductList addObjectsFromArray:tempArr];
        
        if(tempArr.count>0)
        {
            [self insertInCoreData:tempArr];
            
            UIView   *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,0, self.view.frame.size.width,self.view.frame.size.height )];
            
            polygonView.backgroundColor=[UIColor blackColor];
            
            polygonView.alpha=0.7;
            
            [self.view addSubview:polygonView];
            
            UIActivityIndicatorView    *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            
            
            [polygonView addSubview:spinner];
            
            [spinner startAnimating];
            
            
            if(start_end==0)
            {
                NSLog(@"reloading table.... ");
                [ProductListingTable reloadData];
            }
            else if (start_end>0)
            {
                
                
                [ProductListingTable beginUpdates];
                
                for(int i=(int)rowToBeInsertedFrom; i<ArrProductList.count; i++)
                {
                    
                    
                    NSIndexPath *indexPathForNextRow=[NSIndexPath indexPathForRow:i inSection:0];
                    
                    NSLog(@"Row to be inserted at pos:---> %d",i);
                    
                    [ProductListingTable insertRowsAtIndexPaths:@[indexPathForNextRow] withRowAnimation:UITableViewRowAnimationRight];
                    
                    
                }
                
                [ProductListingTable endUpdates];
                
            }
            
            [polygonView removeFromSuperview];
            
            NSLog(@"allproduct list count----> %ld",ArrProductList.count);
            
        }
        else
        {
            
            nomoreData=YES;
            noLazyLoading=YES;
            
        }
        
        
    }
    
    else
    {
        
        //            NSLog(@"NO PRODUCT FOUND");
        //            ProductListingTable.hidden=YES;
        
        ProductListingTable.hidden=YES;
        _noDataFoundLbl.hidden=NO;
        
    }


}
else
{
            ProductListingTable.hidden=YES;
}
    
    
        loaderBackView.hidden=YES;
        [loader stopAnimating];
        
        
    }];
}





//-(void)checkLoader
//{
//    
//    if([self.view.subviews containsObject:loader_shadow_View])
//    {
//        
//        [loader_shadow_View removeFromSuperview];
//        [self.view setUserInteractionEnabled:YES];
//    }
//    else
//    {
//        loader_shadow_View = [[UIView alloc] initWithFrame:self.view.frame];
//        //   loader_shadow_View = [[UIView alloc] initWithFrame:ProductListingTable.frame];
//        [loader_shadow_View setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.56f]];
//        [loader_shadow_View setUserInteractionEnabled:NO];
//        [[loader_shadow_View layer] setZPosition:2];
//        [self.view setUserInteractionEnabled:NO];
//        UIActivityIndicatorView *loader =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        
//        [loader setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
//        
//        [loader startAnimating];
//        
//        
//        [loader_shadow_View addSubview:loader];
//        [self.view addSubview:loader_shadow_View];
//    }
//}


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
                 //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
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


-(void)save
{
    
    if (phoneText.text.length==0)
    {
        phoneText.placeholder = @"Please Enter Phone Number";
    }
    else
    {
        //(@"url");
        
        NSString *url = [NSString stringWithFormat:@"%@/app_phone_verify_add?userid=%@&phone_no=%@",App_Domain_Url,userid,[phoneText text]];
        
        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            
            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
            {
                phoneno=phoneText.text;
                
                
                [UIView animateWithDuration:.3 animations:^{
                    
                    
                    
                    popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
                    [phoneText resignFirstResponder];
                    
                }
                                 completion:^(BOOL finished)
                 {
                     
                     
                     
                     [blackview removeFromSuperview];
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     
                 }];
                
            }
            
            
        }];
        
        
    }
    
}


-(void)doneWithNumberPad{
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        [phoneText resignFirstResponder];
        
    }];
    
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
    
    
    if (textField==phoneText)
    {
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        phoneText.inputAccessoryView = numberToolbar;
        
        
        phoneText.keyboardType =UIKeyboardTypePhonePad;
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .12, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            
        }];
        
        
    }
    
    
    
    return YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"product listing  array-------%@",ArrProductList);
    
    
    
    FWProductDetailsViewController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"fw_productdetails"];
    if(ArrProductList.count>0)
    {
        nav.productId=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"service_id"];
    nav.UsrId=[[NSUserDefaults standardUserDefaults ]valueForKey:@"UserId"];
    
    NSLog(@"Service id---? %@",[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"service_id"]);
    
    [self.navigationController pushViewController:nav animated:NO];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [ArrProductList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Productcell *cell=(Productcell *)[tableView dequeueReusableCellWithIdentifier:@"productcell"];
    
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"productcell"];
    
    
    cell.lblProductName.text=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.lblProductDesc.text=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"description"];
    
    [cell.ProductImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"product_image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    //product cost
    
    if ([[[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"EUR"])
    {
        priceSign=@"€";
        
    }
    else if ([[[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"INR"])
    {
        priceSign=@"₹";
        
    }
    else if ([[[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"USD"])
    {
        priceSign=@"$";
    }
    else if ([[[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"price"] substringToIndex:3] isEqualToString:@"PLN"])
    {
        priceSign=@"zł";
        
    }
    NSString *price=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"price"];
   
    NSInteger len=price.length;
    
    cell.lblProductCost.text=price ;
    
    //[priceSign stringByAppendingString:[[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"price"] substringWithRange:NSMakeRange(4, len-4)]];
    
    //user image
    cell.UserImage.layer.cornerRadius = cell.UserImage.frame.size.width/2;
    cell.UserImage.clipsToBounds = YES;
    cell.UserImage.userInteractionEnabled=YES;
    cell.UserImage.layer.borderColor=[UIColor whiteColor].CGColor;
    cell.UserImage.layer.borderWidth=1.5;
    cell.UserImage.contentMode=UIViewContentModeScaleAspectFill;
    [cell.UserImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"Profile_image_placeholder"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    cell.lblDate.text=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"date"];
    if ([[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"start_time"] isEqualToString:@""])
    {
        cell.lblStartTime.hidden=YES;
    }
    else
    {
        cell.lblStartTime.hidden=NO;
        cell.lblStartTime.text=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"start_time"];
    }
    
    cell.lblDate.text=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"date"];
    if ([[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"close_time"] isEqualToString:@""])
    {
        cell.lblEndTime.hidden=YES;
    }
    else
    {
        cell.lblEndTime.hidden=NO;
        cell.lblEndTime.text=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"close_time"];
    }
    cell.lblDate.text=[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"date"];
    
    
    cell.profileBtn.tag=indexPath.row;
    [cell.profileBtn addTarget:self action:@selector(profileImageTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell.Btn_Like.tag=indexPath.row;
    [cell.Btn_Like addTarget:self action:@selector(syncButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *str4=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"TestIndex__%@",str4);
    
    
    
    if([[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"wishlist_stat"] isEqualToString:@"Y"])
    {
        NSLog(@"Light");
        
        [cell.Btn_Like setImage:[UIImage imageNamed:@"hearticon"] forState:UIControlStateNormal];
        
        
        //user_id
        if([[[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"user_id"] isEqualToString:userid])
        {
            
            [cell.Btn_Like setImage:[UIImage imageNamed:@"unfilled_heart"] forState:UIControlStateNormal];
            
        }
    }
    else
    {
        NSLog(@"Unlight");
        
        [cell.Btn_Like setImage:[UIImage imageNamed:@"unfilled_heart"] forState:UIControlStateNormal];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        noLazyLoading=YES;
        
    }
    
    if((ArrProductList.count-1)==indexPath.row && nomoreData==NO && noLazyLoading==NO)
    {
        start_end+=10;
        
        rowToBeInsertedFrom=indexPath.row+1;
        
        [self ProductDetailUrl];
        
    }
    
    
}






-(void)syncButtonAction:(UIButton*)sender
{
    NSLog(@"Wishlist btn tapped...");
    
    if([userid isEqualToString:[[ArrProductList objectAtIndex:sender.tag] valueForKey:@"user_id"]])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You can't add your own product in wish list." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        
        NSString *urlString;
        
        urlString=[NSString stringWithFormat:@"%@app_json_site/app_wish_add_remove?userid=%@&service_id=%@",App_Domain_Url,userid,[[ArrProductList objectAtIndex:sender.tag] valueForKey:@"service_id"]];
        
        NSLog(@"Wishlist url----> %@",urlString);
        
        [globalobj GlobalDict:urlString Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            if(result)
            {
                NSLog(@"Wishlist stat----> %@",result);
                
                if([[result valueForKey:@"message"] isEqualToString:@"product deleted from wishlist successfully"])
                {
                    
                    [sender setImage:[UIImage imageNamed:@"unfilled_heart"] forState:UIControlStateNormal];
                    
                    NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
                    tempDic=[[ArrProductList objectAtIndex:sender.tag] mutableCopy];
                    [tempDic setValue:@"N" forKey:@"wishlist_stat"];
                    [ArrProductList removeObjectAtIndex:sender.tag];
                    [ArrProductList insertObject:tempDic atIndex:sender.tag];
                    [self coreDataValueUpdateWithProduct:tempDic forIndex:sender.tag];
                    
                    
//                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Messagae" message:@"Product deleted from wishlist successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alert show];
                    
                    
                }
                else if([[result valueForKey:@"message"] isEqualToString:@"product added in wishlist successfully"])
                {
                    
                    [sender setImage:[UIImage imageNamed:@"hearticon"] forState:UIControlStateNormal];
                    
                    NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
                    tempDic=[[ArrProductList objectAtIndex:sender.tag] mutableCopy];
                    [tempDic setValue:@"Y" forKey:@"wishlist_stat"];
                    [ArrProductList removeObjectAtIndex:sender.tag];
                    [ArrProductList insertObject:tempDic atIndex:sender.tag];
                    [self coreDataValueUpdateWithProduct:tempDic forIndex:sender.tag];
                    
                    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                    
                    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
                    sprintAnimation.springBounciness = 20.f;
                    [sender pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
                    
                    
//                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Messagae" message:@"Product added in wishlist successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alert show];
                    
                    
                }
                
            }
            
            
        }];
        
    }
    
    
}



#pragma mark-Updating coredata value

- (void)coreDataValueUpdateWithProduct:(NSMutableDictionary *)dict forIndex:(NSInteger)index
{
    
    if (![[NSThread currentThread] isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self coreDataValueUpdateWithProduct:dict forIndex:index];
            
        });
        
        return;
    }
    
    
    
    // Now on the Main Thread. Work with Core Data safely.
    
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    [myQueue addOperationWithBlock:^{
        
        // Background work
        
        
        
        NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductList"];
        fetchRequest.predicate=[NSPredicate predicateWithFormat:@"user_id==%@ AND categoryId==%@",userid,CategoryId];
        NSError *error;
        NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
        if(fetchedObjects.count>0)
        {
            for (NSManagedObject *object in fetchedObjects)
            {
                
                if([[[NSKeyedUnarchiver unarchiveObjectWithData:[object valueForKey:@"product"]] valueForKey:@"service_id"] isEqualToString:[dict valueForKey:@"service_id"]])
                {
                    
                    [ArrProductList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[object valueForKey:@"product"]]];
                    NSData *propertyData=[[NSData alloc]init];
                    propertyData=[NSKeyedArchiver archivedDataWithRootObject:dict];
                    [object setValue:propertyData forKey:@"product"];
                    
                }
                
            }
            // [ProductListingTable reloadData];
            
            error = nil;
            [theContext save:&error];
        }
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"<< Data resetting successfull >>");
            
        }];
    }];
    
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



-(void)profileImageTap:(UIButton *)sender
{
    //(@"profile btn      %d",(int)sender.tag);
    
    
    NSString *BusnessUserId = [[ArrProductList objectAtIndex:sender.tag]valueForKey:@"user_id"];
    
    
    BusinessProfileViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"busniessprofile"];
    obj.BusnessUserId = BusnessUserId;
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


- (IBAction)back_button:(id)sender
{
    [self POPViewController];
}
-(void)POPViewController
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}

-(void)urlcall
{
    
    
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Test"inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDesc];
    
    
    
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:request
                        
                                              error:&error];
    
    
    
    if (objects.count>0)
    {
        objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data"]];
        
        
        
        [ArrProductList addObjectsFromArray:objects];
        
        
        lblCategoryName.text=[NSString stringWithCString:[[[ArrProductList objectAtIndex:0] valueForKey:@"category_name"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding  ];
        
        [ProductListingTable reloadData];
    }
    
     else
    {
        
        
        
        NSString *urlstring=[NSString stringWithFormat:@"%@app_product_details_cat?catid=%@",App_Domain_Url,[CategoryId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        //(@"str=%@",urlstring);
        
        
        
        [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            //(@"result=%@",result);
            if([[result valueForKey:@"response"] isEqualToString:@"success"])
                
            {
                
                //           NSOperationQueue *myQueue2 = [[NSOperationQueue alloc] init];
                //           [myQueue2 addOperationWithBlock:^{
                
                ArrProductList= [result objectForKey:@"details"];
                
               // lblCategoryName.text=[[ArrProductList objectAtIndex:0] valueForKey:@"category_name"];
                
                 lblCategoryName.text=[NSString stringWithCString:[[[ArrProductList objectAtIndex:0] valueForKey:@"category_name"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding  ];
                
                [ProductListingTable reloadData];
                
                
                
                NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:ArrProductList];
                
                
                
                NSManagedObjectContext *context=[appDelegate managedObjectContext];
                
                
                
                NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"Test" inManagedObjectContext:context];
                
                [newUser setValue:data1 forKey:@"data"];
                [appDelegate saveContext];
                
                
                
                
                
            }
        }];
    }
    
}
-(BOOL)checkingInternetConnection
{
    
    NSURL *scriptUrl = [NSURL URLWithString:@"http://apps.wegenerlabs.com/hi.html"];
    NSData *webData = [NSData dataWithContentsOfURL:scriptUrl];
    if (webData)
    {
        NSLog(@"Device is connected to the internet");
        return YES;
    }
    else
    {
        NSLog(@"Device is not connected to the internet");
        
        return NO;
        
    }
    
    
    
}



@end
