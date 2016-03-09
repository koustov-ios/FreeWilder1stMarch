//
//  WishlistViewController.m
//  FreeWilder
//
//  Created by Priyanka ghosh on 13/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "WishlistViewController.h"
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "accountsubview.h"
#import "ServiceView.h"
#import "LanguageViewController.h"
#import "notificationsettingsViewController.h"
#import "ChangePassword.h"
#import "UserService.h"
#import "MyBooking & Request.h"
#import "userBookingandRequestViewController.h"
#import "myfavouriteViewController.h"
#import "SettingsViewController.h"
#import "Business Information ViewController.h"
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
#import "BusinessProfileViewController.h"
#import "sideMenu.h"
#import "Reachability.h"

@interface WishlistViewController ()<UITableViewDataSource,UITableViewDelegate,Slide_menu_delegate,footerdelegate,accountsubviewdelegate,Serviceview_delegate,Profile_delegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate,sideMenu>
{
    sideMenu *leftMenu;
    
    BOOL tapchk,tapchk1,tapchk2;
    
    accountsubview *subview;
    ServiceView *service;
    UIView *polygonView;
    profile *profileview;
    
    UIView *popview ,*blackview;
    
    NSMutableArray *jsonArray;
    NSString *userid,*phoneno;
    UITextField *phoneText;
    
    int removeIndex;
    
    NSMutableArray *productidarr_db;
    NSArray *productidarr_url;
    
    NSString *langId,*curId;
    
    int strtval;
    
    BOOL nolzyloading,nodata;
    
    int rowToBeInsertedFrom;
    
    BOOL inThisPage;
    
    NSArray *syncArray;
    
    UIButton *moreButton;
    BOOL morbtn_appeared,syncPurposeUrl;
    
}

@end

@implementation WishlistViewController
@synthesize lblWishlist,tblWishList,lblPageTitle;

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
            localNotif.alertBody = @"Wishlist Sync going on.";
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            
            [[NSNotificationCenter defaultCenter]removeObserver:self];
            
            
            [self urlfire];
            
 
        }
    }
    else
    {
        NSLog(@"---------Unreachable---------");
        
      
    }
}



-(void)more
{
    
    [moreButton setHidden:YES];
    
    morbtn_appeared=NO;
    
   //[tblWishList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [tblWishList setContentOffset:CGPointZero animated:YES];

    
 // ArrWishList=[[NSMutableArray alloc] init];
    
    strtval=0;
    syncPurposeUrl=YES;
    

    
    
}



#pragma mark-

- (void)viewDidLoad {
    [super viewDidLoad];
    
    inThisPage=YES;
    
    nolzyloading=NO;
    nodata=NO;
    syncPurposeUrl=NO;
    
    syncArray=[[NSArray alloc]init];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
    
    NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
    
    NSString *currentLang=[userData objectForKey:@"language"];
    
    
  //  NSLog(@"languageeeeeeeeee.......... %@",currentLang);
    
    if([currentLang isEqualToString:@"en"])
    {
        
        langId=@"1";
        
    }
    else  if([currentLang isEqualToString:@"pl"])
    {
        
        langId=@"3";
        
    }
    
    else  if([currentLang isEqualToString:@"vi"])
    {
        
        langId=@"4";
        
    }

    curId=[userData valueForKey:@"curr_id"];
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here
    
    // Do any additional setup after loading the view.
    
    /// initializing app footer view
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,_footer_base.frame.size.width,_footer_base.frame.size.height);
    footer.Delegate=self;
    [_footer_base addSubview:footer];
    
    
    /// Getting side from Xiv & creating a black overlay
    
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    overlay.hidden=YES;
//    overlay.userInteractionEnabled=YES;
//    [self.view addSubview:overlay];
//    
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
//    tapGesture.numberOfTapsRequired=1;
//    [overlay addGestureRecognizer:tapGesture];
    
    
    sidemenu=[[Side_menu alloc]init];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,160,[UIScreen mainScreen].bounds.size.height);
        sidemenu.ProfileImage.frame = CGRectMake(46, 26, 77, 77);
        [sidemenu.lblUserName setFont:[UIFont fontWithName:@"Lato" size:16]];
        sidemenu.btn1.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        sidemenu.btn2.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        sidemenu.btn3.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        sidemenu.btn4.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        sidemenu.btn5.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        sidemenu.btn6.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        sidemenu.btn7.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        sidemenu.btn8.titleLabel.font = [UIFont fontWithName:@"Lato" size:13.0];
        sidemenu.btn9.titleLabel.font = [UIFont fontWithName:@"Lato" size:14.0];
        
        
        
    }
    else{
        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
    }
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
    
    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFill;
    
    sidemenu.hidden=YES;
    sidemenu.SlideDelegate=self;
    [self.view addSubview:sidemenu];
    
    
    globalobj=[[FW_JsonClass alloc]init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserId=[prefs valueForKey:@"UserId"];
    NSLog(@"User Id=%@",UserId);
    
    lblPageTitle.text=@"My Wishlist";
    
    
   if([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
   {
   
       NSLog(@"Internet not connected...");
       
       nolzyloading=YES;
       
       ArrWishList=[[NSMutableArray alloc] init];
       NSManagedObjectContext *context_fetch=[appDelegate managedObjectContext];
       NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"WishList"];
       NSPredicate *fetchPredicate=[NSPredicate predicateWithFormat:@"userid== %@",UserId];
       request.predicate=fetchPredicate;
       NSArray *fetchResult=[context_fetch executeFetchRequest:request error:nil];
       NSInteger CoreDataCount=[fetchResult count];
       if(CoreDataCount==0)
       {
           tblWishList.hidden=YES;
           
           lblWishlist.text=@"No Data Found";
           
       }
       else
       {
           polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
           polygonView.backgroundColor=[UIColor blackColor];
           polygonView.alpha=0.3;
           [self.view addSubview:polygonView];
           UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
           spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
           
           [polygonView addSubview:spinner];
           [spinner startAnimating];
           
           for (NSManagedObject *obj in fetchResult)
           {
               
               
               [ArrWishList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[obj valueForKey:@"product"]]];
               
               
           }
           
           tblWishList.hidden=NO;
           lblWishlist.text=@"";
           
           [tblWishList reloadData];
           
           [spinner stopAnimating];
           [spinner removeFromSuperview];
           [polygonView removeFromSuperview];
           
           
       }
   
   }
   else
   {
      ArrWishList=[[NSMutableArray alloc] init];
       
      [self urlfire_lzyloading];
   }
    
    
    
    
    // [self WishDetailUrl];
}


-(void)urlfire_lzyloading
{
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    

    if(syncPurposeUrl==YES)
    {
    
        ArrWishList=[[NSMutableArray alloc]init];
    
    }
   
    NSString *urlstring=[NSString stringWithFormat:@"%@app_user_wishlist?userid=%@&start_from=%d&per_page=10&lang_id=%@&cur_id=%@",App_Domain_Url,[UserId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],strtval,langId,curId];
    
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        NSMutableArray *tempArray=[[NSMutableArray alloc]init];
        
        if([[result valueForKey:@"response"] isEqualToString:@"success"])
            
        {
            
            
           // NSLog(@"result=%@",[result valueForKey:@"details"]);
            
            
                        for ( NSDictionary *tempDict1 in  [result objectForKey:@"my_wishlist"])
                        {
                            [tempArray addObject:tempDict1];
            
                        }
            
            NSLog(@"Temp array------->>>>>>>>> %@",tempArray);
            
            [ArrWishList addObjectsFromArray:tempArray];
            
            //    lblCategoryName.text=[[ArrProductList objectAtIndex:0] valueForKey:@"category_name"];
            
            
            //[tblWishList reloadData];
            
            NSLog(@"Wishlist count----> %ld",ArrWishList.count);
            
            
            if (ArrWishList.count==0)
            {
                
                tblWishList.hidden=YES;
                
                lblWishlist.text=@"No Data Found";
                NSLog(@"no service");
            }
            else
            {
                tblWishList.hidden=NO;
                lblWishlist.text=@"";
                
                if(tempArray.count==0)
                {
                    
                    nodata=YES;
                    nolzyloading=YES;
                    
                    [spinner stopAnimating];
                    [spinner removeFromSuperview];
                    [polygonView removeFromSuperview];
                    
                }
                else
                {
                    
                    
                    nolzyloading=NO;
                    nodata=NO;
                    
#pragma mark-Inserting and updating coredata
                    //
                    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
                    [myQueue addOperationWithBlock:^{
                        
                        // Background work
                        NSManagedObjectContext *context=[appDelegate managedObjectContext];
                        NSManagedObjectContext *context_fetch=[appDelegate managedObjectContext];
                        NSManagedObjectContext *context_wishupdate=[appDelegate managedObjectContext];
                        
                        
                        NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"Wishlistupdate" inManagedObjectContext:context];
                        [manageobject setValue:[NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]]forKey:@"timestamp"];
                        [manageobject setValue:UserId forKey:@"userid"];
                        NSError *error=nil;
                        [context_wishupdate save:&error];
                        
                        // for (NSDictionary *dic in ArrWishList)
                        
                        
                        for (int i=0; i<tempArray.count; i++)
                            
                        {
                            NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"WishList"];
                            NSPredicate *fetchPredicate=[NSPredicate predicateWithFormat:@"userid== %@ AND productid== %@",UserId,[tempArray[i] valueForKey:@"wishlist_id"]];
                            request.predicate=fetchPredicate;
                            NSArray *fetchResult=[context_fetch executeFetchRequest:request error:nil];
                            NSInteger CoreDataCount=[fetchResult count];
                            
                            if(CoreDataCount==0)
                            {
                                
                                NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"WishList" inManagedObjectContext:context];
                                [manageobject setValue:UserId forKey:@"userid"];
                                [manageobject setValue:[NSKeyedArchiver archivedDataWithRootObject:tempArray[i]] forKey:@"product"];
                                [manageobject setValue:[tempArray[i] valueForKey:@"wishlist_id"] forKey:@"productid"];
                                 NSError *error=nil;
                                [context save:&error];
                                
                            }
                            else
                            {
                                
                                NSManagedObject *object = [fetchResult objectAtIndex:0];
                                [object setValue:[NSKeyedArchiver archivedDataWithRootObject:tempArray[i]] forKey:@"product"];
                                NSError *error=nil;
                                [context_fetch save:&error];
                            }
                            
                            
                        }
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            // Main thread work (UI usually)
                            
                            
                            [spinner stopAnimating];
                            [spinner removeFromSuperview];
                            [polygonView removeFromSuperview];
                            
                            
                            
                            
                            if(strtval==0)
                            {
                               syncPurposeUrl=NO;
                              [tblWishList reloadData];
                            }
                            else
                            {
                            
                                [tblWishList beginUpdates];
                                
                                for(int i=(int)rowToBeInsertedFrom; i<ArrWishList.count; i++)
                                {
                                    
                                    
                                    NSIndexPath *indexPathForNextRow=[NSIndexPath indexPathForRow:i inSection:0];
                                    
                                    NSLog(@"Row to be inserted at pos:---> %d",i);
                                    
                                    [tblWishList insertRowsAtIndexPaths:@[indexPathForNextRow] withRowAnimation:UITableViewRowAnimationRight];
                                    
                                    
                                }
                                
                                [tblWishList endUpdates];
                            
                            }
                            
                            nolzyloading=NO;
                        }];
                    }];
                    
                    
                }
                
#pragma mark-
                
            }

        }
        else
        {
        
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Something went wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            nolzyloading=YES;
            [spinner stopAnimating];
            [spinner removeFromSuperview];
            [polygonView removeFromSuperview];

            
    
        }
        
        
        
        
    }];
}




-(void)urlfire
{
    nolzyloading=YES;
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    UILabel *syncing = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-200)/2, spinner.frame.origin.y+spinner.bounds.size.height + 6, 200, 30)];
    syncing.text=@"Syncing...";
    syncing.textColor=[UIColor whiteColor];
    syncing.font=[UIFont fontWithName:@"Helvetica" size:14.0f];
    //syncing.backgroundColor=[UIColor redColor];
    syncing.textAlignment=NSTextAlignmentCenter;
    
    [polygonView addSubview:spinner];
    [polygonView addSubview:syncing];
    [spinner startAnimating];
    
    
    NSManagedObjectContext *context_fetch=[appDelegate managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"Wishlistupdate"];
    NSPredicate *fetchPredicate=[NSPredicate predicateWithFormat:@"userid== %@ ",UserId];
    request.predicate=fetchPredicate;
    NSArray *fetchResult=[context_fetch executeFetchRequest:request error:nil];
    
    
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@app_user_wishlist?userid=%@&last_updt_time=%@&current_time=%@",App_Domain_Url,[UserId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[fetchResult lastObject] valueForKey:@"timestamp"],[NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]]];
    
    
    NSLog(@"time stamp url.......=%@",urlstring);
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        if([[result valueForKey:@"response"] isEqualToString:@"success"])
            
        {
            

            
            syncArray=[result valueForKey:@"my_wishlist"];
        
            if (syncArray.count>0) {
                
                
#pragma mark-Inserting and updating coredata
                
                NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
                [myQueue addOperationWithBlock:^{
                    
                    
                    NSManagedObjectContext *context_fetch=[appDelegate managedObjectContext];
                    
                    
                    for (int i=0; i<syncArray.count; i++)
                        
                    {
                        NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"WishList"];
                        NSPredicate *fetchPredicate=[NSPredicate predicateWithFormat:@"userid== %@ AND productid== %@",UserId,[syncArray[i] valueForKey:@"wishlist_id"]];
                        request.predicate=fetchPredicate;
                        NSArray *fetchResult=[context_fetch executeFetchRequest:request error:nil];
                        NSInteger CoreDataCount=[fetchResult count];
                        
                        if(CoreDataCount==0)
                        {
                            
                            NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"WishList" inManagedObjectContext:context_fetch];
                            [manageobject setValue:UserId forKey:@"userid"];
                            [manageobject setValue:[NSKeyedArchiver archivedDataWithRootObject:syncArray[i]] forKey:@"product"];
                            [manageobject setValue:[syncArray[i] valueForKey:@"wishlist_id"] forKey:@"productid"];
                            NSError *error=nil;
                            [context_fetch save:&error];
                            
                        }
                        else
                        {
                            
                            NSManagedObject *object = [fetchResult objectAtIndex:0];
                            [object setValue:[NSKeyedArchiver archivedDataWithRootObject:syncArray[i]] forKey:@"product"];
                            NSError *error=nil;
                            [context_fetch save:&error];
                        }
                        
                        
                    }
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        
                        [spinner stopAnimating];
                        [spinner removeFromSuperview];
                        [syncing removeFromSuperview];
                        [polygonView removeFromSuperview];
                        
                        morbtn_appeared=YES;
                        
                        moreButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2.5, _footer_base.frame.origin.y-50, tblWishList.bounds.size.width-((self.view.bounds.size.width/2.5)*2), 30)];
                        
                        
                        [moreButton setImage:[UIImage imageNamed:@"new_update"] forState:UIControlStateNormal];
                        
                        [moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
                        
                        [self.view addSubview:moreButton];
                        
                        [moreButton setHidden:NO];
                        
                        
                        moreButton.layer.cornerRadius=6.0f;
                        moreButton.clipsToBounds=YES;
                        
                        
                        [UIView animateWithDuration:0.3f
                                              delay:0.6f
                                            options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |UIViewAnimationOptionAllowUserInteraction
                                         animations:^{
                                             [moreButton setFrame:CGRectMake(self.view.bounds.size.width/2.5, _footer_base.frame.origin.y-45, self.view.bounds.size.width-((self.view.bounds.size.width/2.5)*2), 30)];
                                         }
                                         completion:^(BOOL finished) {
                                             
                                             
                                         }];
                        
                        
                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
                        
                    }];
                }];
                
#pragma mark-
                
                
            }
            else
            {
            
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [syncing removeFromSuperview];
                [polygonView removeFromSuperview];
   
            
            }
            

        
        
    }
     
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
     ProductViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Product_details"];
     
     [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
     */
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 290;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  NSLog(@"arr count1=%lu",(unsigned long)[ArrProductList count]);
    return [ArrWishList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceListCell *cell=(ServiceListCell *)[tableView dequeueReusableCellWithIdentifier:@"ServiceListCell"];
    cell.btnBooking.layer.cornerRadius=15.0f;
    cell.btnEdit.layer.cornerRadius=15.0f;
    cell.btnEdit.hidden=YES;
    [cell.btnBooking setTitle:@"Remove" forState:UIControlStateNormal];
    cell.btnBooking.tag=indexPath.row;
    [cell.btnBooking addTarget:self action:@selector(removeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //NSLog(@"hi hi hi...... %ld \n %@",(long)indexPath.row,ArrWishList);
    
    cell.lblLocation.text=[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"location"];
    if (cell.lblLocation.text.length==0)
    {
        cell.locationImg.hidden=YES;
    }
    else
    {
        cell.locationImg.hidden=NO;
    }
    if (data)
    {
        //showing data from core data
        cell.ServiceName.text=[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"name"];
        cell.CategoryDetail.text=[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"category"];
        cell.lblPrice.hidden=NO;
        cell.lblPrice.text=[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"price"];
        //product image
        NSData *dataBytes = [[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"image"];
        cell.ServiceImg.image=[UIImage imageWithData:dataBytes];
        
        cell.ServiceImg.contentMode=UIViewContentModeScaleAspectFill;
        cell.ServiceImg.clipsToBounds = YES;
        /*
         if ([[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"stepToList"] isEqualToString:@"0  "])
         {
         [cell.btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
         }
         else
         {
         [cell.btnEdit setTitle:[[[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"stepToList"] substringWithRange:NSMakeRange(0, 2)] stringByAppendingString:@"Step to list"] forState:UIControlStateNormal];
         
         }
         */
        
    }
    else
    {
        cell.ServiceName.text=[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"name"];
        cell.CategoryDetail.text=[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"category"];
        cell.lblPrice.hidden=NO;
        cell.lblPrice.text=[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"price"];
        //product image
        [cell.ServiceImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[ArrWishList objectAtIndex:indexPath.row] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        cell.ServiceImg.contentMode=UIViewContentModeScaleAspectFill;
        cell.ServiceImg.clipsToBounds = YES;
        //product image
        //    NSData *dataBytes = [[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"image"];
        //    cell.ServiceImg.image=[UIImage imageWithData:dataBytes];
        
        //     cell.ServiceImg.contentMode=UIViewContentModeScaleAspectFill;
        //     cell.ServiceImg.clipsToBounds = YES;
        /*
         if ([[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"stepToList"] isEqualToString:@"0  "])
         {
         [cell.btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
         }
         else
         {
         [cell.btnEdit setTitle:[[[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"stepToList"] substringWithRange:NSMakeRange(0, 2)] stringByAppendingString:@"Step to list"] forState:UIControlStateNormal];
         
         }
         */
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(syncPurposeUrl==YES && indexPath.row==0)
    {
     
        [self urlfire_lzyloading];
    
    }
    
    
    if(indexPath.row==ArrWishList.count-1 && nodata==NO && nolzyloading==NO)
    {
    
        strtval=(int)ArrWishList.count;
        
        rowToBeInsertedFrom=(int)indexPath.row+1;
        
        [self urlfire_lzyloading];
    
    
    }


}



-(void)removeButtonTapped:(UIButton *)sender
{
    NSLog(@"tag is-----%ld",(long)sender.tag);
    
    removeIndex=(int)sender.tag;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remove"  message:@"Do You want to Remove" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    
    alert.tag=sender.tag;
    
    
    [alert show];
    
    
//    NSLog(@"%@",[[ArrWishList objectAtIndex:sender.tag] valueForKey:@"wishlist_id"]);
//    
//    NSString *urlstring=[NSString stringWithFormat:@"%@app_wishlist_remove?wishlist_id=%@",App_Domain_Url,[[ArrWishList objectAtIndex:sender.tag] valueForKey:@"wishlist_id"]];
//    NSLog(@"str=%@",urlstring);
//    
//    
//    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error)
//     {
//         NSLog(@"resuldata %@",result);
//         NSString *chkdata=[result valueForKey:@"response"];
//         
//         
//         if ([chkdata isEqualToString:@"success"])
//         {
//             
//             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[result valueForKey:@"response"]
//                                                             message:[result valueForKey:@"message"]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"OK"
//                                                   otherButtonTitles:nil];
//             
//             [self urlfire];
//             
//             [alert show];
//             
//             
//         }
//         else
//         {
//             
//             
//             
//             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[result valueForKey:@"response"]
//                                                             message:[result valueForKey:@"message"]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"OK"
//                                                   otherButtonTitles:nil];
//             
//             
//             
//             
//             
//             [alert show];
//             
//         }
//         
//         
//     }];
//    
    
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1)
    {
        
        NSLog(@"%@",[[ArrWishList objectAtIndex:removeIndex] valueForKey:@"wishlist_id"]);
    
        NSString *urlstring=[NSString stringWithFormat:@"%@app_wishlist_remove?wishlist_id=%@",App_Domain_Url,[[ArrWishList objectAtIndex:removeIndex] valueForKey:@"wishlist_id"]];
        NSLog(@"str=%@",urlstring);
    
    
        [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             NSLog(@"resuldata %@",result);
             NSString *chkdata=[result valueForKey:@"response"];
    
    
             if ([chkdata isEqualToString:@"success"])
             {
    
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[result valueForKey:@"response"]
                                                                 message:[result valueForKey:@"message"]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 
                 NSManagedObjectContext *context_delete=[appDelegate managedObjectContext];
                 
                 NSPredicate * delete_predicate = [NSPredicate predicateWithFormat:@"userid==%@ AND productid==%@",UserId,[[ArrWishList objectAtIndex:alertView.tag] valueForKey:@"wishlist_id"]];
                 
                 
                 NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"WishList"];
                 request.predicate=delete_predicate;
                 NSArray *fetchResult=[context_delete executeFetchRequest:request error:nil];
                 
                 
                 if(fetchResult.count>0)
                 {
                     
                     
                     for (NSManagedObject *obj in fetchResult) {
                         
                         
                         [context_delete deleteObject:obj];
                         
                         
                     }
                     NSError *error=nil;
                     [context_delete save:&error];
                     
                 }

                 
                 [ArrWishList removeObjectAtIndex:alertView.tag];
                 
                 [tblWishList beginUpdates];
                 
                 NSIndexPath *index_path=[NSIndexPath indexPathForRow:alertView.tag inSection:0];
                 
                 [tblWishList deleteRowsAtIndexPaths:@[index_path] withRowAnimation:UITableViewRowAnimationLeft];
                 
                 [tblWishList endUpdates];
    
                 [alert show];
    
    
             }
             else
             {
    
    
    
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[result valueForKey:@"response"]
                                                                 message:[result valueForKey:@"message"]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
    
    
                 
                 
                 
                 [alert show];
                 
             }
             
             
         }];
        
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)BackClick:(id)sender
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


//-(void)side
//{
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    //    overlay.hidden=YES;
//    //    overlay.userInteractionEnabled=YES;
//    [self.view addSubview:overlay];
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
//    
//    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    //  NSLog(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//    //  sidemenu.ProfileImage.contentMode=UIViewContentModeScaleAspectFit;
//    // sidemenu.hidden=YES;
//    
//    userid=[prefs valueForKey:@"UserId"];
//    
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
//        }
//        
//        
//        NSLog(@"phone----%@",phoneno);
//        
//        
//    }];
//    
//    
//    
//    
//    
//
//    
//    
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
//}
//
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
//              sidemenu.hidden=YES;
//              overlay.hidden=YES;
//              overlay.userInteractionEnabled=NO;
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
                  NSLog(@"0");
                  
                  
                  UserService *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              
              else if (sender.tag==1)
              {
                  NSLog(@"1");
              }
              else if (sender.tag==2)
              {
                  NSLog(@"2");
                  
                  
                  userBookingandRequestViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              
              else if (sender.tag==3)
              {
                  NSLog(@"3");
                  
                  
                  MyBooking___Request *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
                  
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  // [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
                  
                  
                  
                  
                  
                  
              }
              
              
              
              else if (sender.tag==4)
              {
                  NSLog(@"4");
                  
                  WishlistViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
                  
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
              }
              else if (sender.tag==5)
              {
                  NSLog(@"5");
                  
                  
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
    NSLog(@"tag%ld",(long)sender.tag);
    
    
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
                  NSLog(@"i am notification");
                  
                  
                  notificationsettingsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==101)
              {
                  NSLog(@"i am  payment method");
                  
                  
                  
                  
                  PaymentMethodViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
              }
              else if (sender.tag==102)
              {
                  NSLog(@"i am payout preferences");
                  
                  
                  
                  PayoutPreferenceViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
                  
                  
                  
              }
              else if (sender.tag==103)
              {
                  NSLog(@"i am from transaction history");
              }
              else if (sender.tag==104)
              {
                  NSLog(@"i am from privacy");
                  
                  
                  
                  PrivacyViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
                  [self.navigationController pushViewController:obj animated:NO];
                  
                  
                  
                  
              }
              else if (sender.tag==105)
              {
                  NSLog(@"i am from security");
                  
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
    NSLog(@"##### test mode...%ld",(long)sender.tag);
    
    
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
                // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
               //  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
                 [self deleteAllEntities:@"ProductList"];
                 [self deleteAllEntities:@"WishList"];
                 [self deleteAllEntities:@"CategoryFeatureList"];
                 [self deleteAllEntities:@"CategoryList"];
               //  [self deleteAllEntities:@"ContactList"];
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
                  NSLog(@"I am viewProfile");
              }
              else if (sender.tag==1)
              {
                  NSLog(@"I am EditProfile");
                  
                  
                  EditProfileViewController    *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
              }
              else if (sender.tag==2)
              {
                  NSLog(@"I am Photo & Video");
                  
                  
                  
                  Photos___Videos_ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
              }
              else if (sender.tag==3)
              {
                  NSLog(@"I am Trust & verification");
                  
                  
                  Trust_And_Verification_ViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
              }
              else if (sender.tag==4)
              {
                  NSLog(@"I am review");
                  
                  
                  
                  
                  rvwViewController  *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
                  
                  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
                  
                  
                  
                  
                  
                  
              }
              
              
              else if (sender.tag==5)
              {
                  NSLog(@"I am phone Verification");
                  
                  
                  
                  
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
        NSLog(@"url");
        
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


-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    inThisPage=NO;
    [self Slide_menu_off];
    
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
@end
