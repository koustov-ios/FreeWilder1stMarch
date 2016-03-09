//
//  ServiceListingViewController.m
//  FreeWilder
//
//  Created by Priyanka ghosh on 11/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ServiceListingViewController.h"
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "ServiceView.h"
#import "accountsubview.h"
#import "LanguageViewController.h"
#import "notificationsettingsViewController.h"

#import "ChangePassword.h"
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
#import "BusinessProfileViewController.h"
#import "sideMenu.h"

@interface ServiceListingViewController ()<accountsubviewdelegate,Serviceview_delegate,Profile_delegate,UITextFieldDelegate,UIGestureRecognizerDelegate,sideMenu>

{
    sideMenu *leftMenu;
    
    ServiceView *service;
    BOOL tapchk,tapchk1,tapchk2;
    accountsubview *subview;
    profile *profileview;
    
    UIView *popview ,*blackview;
    
    NSMutableArray *jsonArray;
    NSString *userid,*phoneno;
    UITextField *phoneText;
    
    
}
@end

@implementation ServiceListingViewController
@synthesize tblService,lblServiceName,lblPageTitle,btnAdd;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here
    
    
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
    ArrServiceList=[[NSMutableArray alloc] init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserId=[prefs valueForKey:@"UserId"];
    NSLog(@"User Id=%@",UserId);
    
    lblPageTitle.text=@"Service Listing";
    [btnAdd setTitle:@"Add" forState:UIControlStateNormal];
    [self ServiceDetailUrl];
}
-(void)ServiceDetailUrl
{
    
    NSManagedObjectContext *context1=[appDelegate managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"ServiceList"];
    NSMutableArray *fetchrequest=[[context1 executeFetchRequest:request error:nil] mutableCopy];
    NSInteger CoreDataCount=[fetchrequest count];
    NSLog(@"core data count=%ld",(long)CoreDataCount);
    data=0;
    
    //if data for this category present in core data or not
    for (NSManagedObject *obj1 in fetchrequest)
    {
        
        //  NSLog(@"category=%@",[obj1 valueForKey:@"categoryId"]);
        if ([[obj1 valueForKey:@"userId"] isEqualToString:UserId])
        {
            data=1;
            //  NSLog(@"data present");
            break;
        }
    }
    
    
    if (data)
    {
        [ArrServiceList removeAllObjects];
        // data present in core data so show data from core data
        NSLog(@"data from local db");
      //  NSInteger datacount;
        for (NSManagedObject *obj1 in fetchrequest)
        {
            
            //   NSLog(@"category id1=%@",[obj1 valueForKey:@"categoryId"]);
            if ([[obj1 valueForKey:@"userId"] isEqualToString:UserId])
            {
                // datacount++;
                [ArrServiceList addObject:obj1];
               // lblCategoryName.text=[[ArrProductList objectAtIndex:0] valueForKey:@"categoryname"];
            }
        }
        //   NSLog(@"arr count=%lu",(unsigned long)[ArrProductList count]);
        [tblService reloadData];
        
        //check local data and url data same or not
        //fire url
        NSString *urlstring=[NSString stringWithFormat:@"%@app_user_service?userid=%@",App_Domain_Url,[UserId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"str=%@",urlstring);
        
        
        
        [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            NSLog(@"result=%@",result);
            if([[result valueForKey:@"response"] isEqualToString:@"success"])
                
            {
                //           NSOperationQueue *myQueue2 = [[NSOperationQueue alloc] init];
                //           [myQueue2 addOperationWithBlock:^{
                NSMutableArray *tempArr=[[NSMutableArray alloc]init];
                NSInteger urldatacount;
                //  NSLog(@"result=%@",[result valueForKey:@"details"]);
                NSLog(@"result=%@",[result objectForKey:@"service_details"]);
                for ( NSDictionary *tempDict1 in  [result objectForKey:@"service_details"])
                {
                    urldatacount++;
                    [tempArr addObject:tempDict1];
                    
                }
                NSLog(@"core data count=%ld",(long)ArrServiceList.count);
                NSLog(@"url data count=%ld",(long)tempArr.count);
                
                // local data and url data same
                if (ArrServiceList.count==tempArr.count)
                {
                    //do nothing but if edit option is avaliable so...
                    
                    //delete the particular user data from core data
                    NSLog(@"delete the particular user id data from core data");
                    NSManagedObjectContext *context3=[appDelegate managedObjectContext];
                    NSEntityDescription *productEntity=[NSEntityDescription entityForName:@"ServiceList" inManagedObjectContext:context3];
                    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
                    [fetch setEntity:productEntity];
                    NSPredicate *p=[NSPredicate predicateWithFormat:@"userId == %@", UserId];
                    [fetch setPredicate:p];
                    //... add sorts if you want them
                    NSError *fetchError;
                    NSError *error;
                    NSArray *fetchedProducts=[context3 executeFetchRequest:fetch error:&fetchError];
                    for (NSManagedObject *product in fetchedProducts)
                    {
                        [context3 deleteObject:product];
                    }
                    [context3 save:&error];
                    
                    // put url data in core data
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"service_details"])
                    {
                        NSLog(@"putting data in core data.");
                        NSManagedObjectContext *context=[appDelegate managedObjectContext];
                        NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"ServiceList" inManagedObjectContext:context];
                        NSLog(@"user id=%@",UserId);
                        [manageobject setValue:UserId forKey:@"userId"];
                        [manageobject setValue:[tempDict1 valueForKey:@"service_id"] forKey:@"serviceId"];
                        [manageobject setValue:[tempDict1 valueForKey:@"service_name"] forKey:@"serviceName"];
                        [manageobject setValue:[tempDict1 valueForKey:@"category_details"] forKey:@"categoryDetail"];
                        [manageobject setValue:[tempDict1 valueForKey:@"location"] forKey:@"location"];
                        [manageobject setValue:[tempDict1 valueForKey:@"step_to_list"] forKey:@"stepToList"];
                        [manageobject setValue:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"image"]]]] forKey:@"image"];
                        //     UIImageView *productimgview=[[UIImageView alloc]init];
                        //    [productimgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"product_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                        
                        //   NSLog(@"image=%@",productimgview.image);
                        //   NSData *imgData= UIImagePNGRepresentation(productimgview.image);
                        //   [manageobject setValue:imgData forKey:@"productimage"];
                        
                        //    UIImageView *userimgview=[[UIImageView alloc]init];
                        //     [userimgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"Profile_image_placeholder"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                        //     NSLog(@"image=%@",productimgview.image);
                        //     NSData *imgData1= UIImagePNGRepresentation(userimgview.image);
                        //      [manageobject setValue:imgData1 forKey:@"userimage"];
                        
                        
                        [appDelegate saveContext];
                    }
                    
                    // data show from core data
                    [ArrServiceList removeAllObjects];
                    NSManagedObjectContext *context5=[appDelegate managedObjectContext];
                    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"ServiceList"];
                    NSMutableArray *fetchrequest=[[context5 executeFetchRequest:request error:nil] mutableCopy];
                    for (NSManagedObject *obj1 in fetchrequest)
                    {
                        
                        
                        if ([[obj1 valueForKey:@"userId"] isEqualToString:UserId])
                        {
                            
                            [ArrServiceList addObject:obj1];
                            //   lblCategoryName.text=[[ArrProductList objectAtIndex:0] valueForKey:@"categoryname"];
                        }
                    }
                    
                    [tblService reloadData];
                }
                else
                {
                    //delete the particular user data from core data
                    NSLog(@"delete the particular user id data from core data");
                    NSManagedObjectContext *context3=[appDelegate managedObjectContext];
                    NSEntityDescription *productEntity=[NSEntityDescription entityForName:@"ServiceList" inManagedObjectContext:context3];
                    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
                    [fetch setEntity:productEntity];
                    NSPredicate *p=[NSPredicate predicateWithFormat:@"userId == %@", UserId];
                    [fetch setPredicate:p];
                    //... add sorts if you want them
                    NSError *fetchError;
                    NSError *error;
                    NSArray *fetchedProducts=[context3 executeFetchRequest:fetch error:&fetchError];
                    for (NSManagedObject *product in fetchedProducts)
                    {
                        [context3 deleteObject:product];
                    }
                    [context3 save:&error];
                    
                    // put url data in core data
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"service_details"])
                    {
                        NSLog(@"putting data in core data.");
                        NSManagedObjectContext *context=[appDelegate managedObjectContext];
                        NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"ServiceList" inManagedObjectContext:context];
                        NSLog(@"user id=%@",UserId);
                        [manageobject setValue:UserId forKey:@"userId"];
                        [manageobject setValue:[tempDict1 valueForKey:@"service_id"] forKey:@"serviceId"];
                        [manageobject setValue:[tempDict1 valueForKey:@"service_name"] forKey:@"serviceName"];
                        [manageobject setValue:[tempDict1 valueForKey:@"category_details"] forKey:@"categoryDetail"];
                        [manageobject setValue:[tempDict1 valueForKey:@"location"] forKey:@"location"];
                        [manageobject setValue:[tempDict1 valueForKey:@"step_to_list"] forKey:@"stepToList"];
                        [manageobject setValue:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"image"]]]] forKey:@"image"];
                        //     UIImageView *productimgview=[[UIImageView alloc]init];
                        //    [productimgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"product_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                        
                        //   NSLog(@"image=%@",productimgview.image);
                        //   NSData *imgData= UIImagePNGRepresentation(productimgview.image);
                        //   [manageobject setValue:imgData forKey:@"productimage"];
                        
                        //    UIImageView *userimgview=[[UIImageView alloc]init];
                        //     [userimgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"Profile_image_placeholder"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                        //     NSLog(@"image=%@",productimgview.image);
                        //     NSData *imgData1= UIImagePNGRepresentation(userimgview.image);
                        //      [manageobject setValue:imgData1 forKey:@"userimage"];
                        
                       
                        [appDelegate saveContext];
                    }
                    
                    // data show from core data
                    [ArrServiceList removeAllObjects];
                    NSManagedObjectContext *context5=[appDelegate managedObjectContext];
                    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"ServiceList"];
                    NSMutableArray *fetchrequest=[[context5 executeFetchRequest:request error:nil] mutableCopy];
                    for (NSManagedObject *obj1 in fetchrequest)
                    {
                        
                        
                        if ([[obj1 valueForKey:@"userId"] isEqualToString:UserId])
                        {
                            
                            [ArrServiceList addObject:obj1];
                         //   lblCategoryName.text=[[ArrProductList objectAtIndex:0] valueForKey:@"categoryname"];
                        }
                    }
                    
                    [tblService reloadData];
                    
                    
                    
                    
                }
                //           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //            }];
                //        }];
                
            }
        }];
        
        if (ArrServiceList.count==0)
        {
            lblServiceName.text=@"No Service Found";
            NSLog(@"no service");
        }
        else
        {
            lblServiceName.text=@"";
        }
        
    }
    else
    {
        // core data empty
        //fire url
        [ArrServiceList removeAllObjects];
        NSLog(@"data from url");
        
        NSString *urlstring=[NSString stringWithFormat:@"%@app_user_service?userid=%@",App_Domain_Url,[UserId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"str=%@",urlstring);
        [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            //   NSLog(@"result=%@",result);
            if([[result valueForKey:@"response"] isEqualToString:@"success"])
                
            {
                
                //  NSLog(@"result=%@",[result valueForKey:@"details"]);
                
                for ( NSDictionary *tempDict1 in  [result objectForKey:@"service_details"])
                {
                    [ArrServiceList addObject:tempDict1];
                    
                }
            //    lblCategoryName.text=[[ArrProductList objectAtIndex:0] valueForKey:@"category_name"];
                
                [tblService reloadData];
                
                //put data from url to core data in back ground thread
                NSOperationQueue *myQueue11 = [[NSOperationQueue alloc] init];
                [myQueue11 addOperationWithBlock:^{
                    
                    
                    
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"service_details"])
                    {
                        NSLog(@"putting image data in core data.");
                        NSManagedObjectContext *context=[appDelegate managedObjectContext];
                        NSManagedObject *manageobject=[NSEntityDescription insertNewObjectForEntityForName:@"ServiceList" inManagedObjectContext:context];
                        NSLog(@"user id=%@",UserId);
                        [manageobject setValue:UserId forKey:@"userId"];
                        [manageobject setValue:[tempDict1 valueForKey:@"service_id"] forKey:@"serviceId"];
                        [manageobject setValue:[tempDict1 valueForKey:@"service_name"] forKey:@"serviceName"];
                        [manageobject setValue:[tempDict1 valueForKey:@"category_details"] forKey:@"categoryDetail"];
                        [manageobject setValue:[tempDict1 valueForKey:@"location"] forKey:@"location"];
                        [manageobject setValue:[tempDict1 valueForKey:@"step_to_list"] forKey:@"stepToList"];
                        [manageobject setValue:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"image"]]]] forKey:@"image"];
                        //     UIImageView *productimgview=[[UIImageView alloc]init];
                        //    [productimgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"product_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                        
                        //   NSLog(@"image=%@",productimgview.image);
                        //   NSData *imgData= UIImagePNGRepresentation(productimgview.image);
                        //   [manageobject setValue:imgData forKey:@"productimage"];
                        
                        //    UIImageView *userimgview=[[UIImageView alloc]init];
                        //     [userimgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"Profile_image_placeholder"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                        //     NSLog(@"image=%@",productimgview.image);
                        //     NSData *imgData1= UIImagePNGRepresentation(userimgview.image);
                        //      [manageobject setValue:imgData1 forKey:@"userimage"];
                        
                       
                        [appDelegate saveContext];
                    }
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    }];
                }];
            }
            else
            {
                lblServiceName.text=@"No Service Found";
                NSLog(@"no service");
                //  UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[result valueForKey:@"message" ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //  [loginAlert show];
                
            }
            
            
            
            
        }];
        
        if (ArrServiceList.count==0)
        {
            lblServiceName.text=@"No Service Found";
            NSLog(@"no service");
        }
        else
        {
            lblServiceName.text=@"";
        }
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    return [ArrServiceList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceListCell *cell=(ServiceListCell *)[tableView dequeueReusableCellWithIdentifier:@"ServiceListCell"];
    cell.btnBooking.layer.cornerRadius=15.0f;
    cell.btnEdit.layer.cornerRadius=15.0f;
    cell.lblLocation.text=[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"location"];
    [cell.btnBooking setTitle:@"View Booking" forState:UIControlStateNormal];
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
        cell.ServiceName.text=[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"serviceName"];
        cell.CategoryDetail.text=[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"categoryDetail"];
        
        //product image
        NSData *dataBytes = [[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"image"];
        cell.ServiceImg.image=[UIImage imageWithData:dataBytes];
        
        cell.ServiceImg.contentMode=UIViewContentModeScaleAspectFill;
        cell.ServiceImg.clipsToBounds = YES;

        if ([[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"stepToList"] isEqualToString:@"0  "])
        {
            [cell.btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnEdit setTitle:[[[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"stepToList"] substringWithRange:NSMakeRange(0, 2)] stringByAppendingString:@"Step to list"] forState:UIControlStateNormal];
            
        }
        
    }
    else
    {
        cell.ServiceName.text=[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"service_name"];
        cell.CategoryDetail.text=[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"category_details"];
        
        [cell.ServiceImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        cell.ServiceImg.contentMode=UIViewContentModeScaleAspectFill;
        cell.ServiceImg.clipsToBounds = YES;
        
        if ([[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"step_to_list"] isEqualToString:@"0  "])
        {
            [cell.btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnEdit setTitle:[[[[ArrServiceList objectAtIndex:indexPath.row] valueForKey:@"step_to_list"] substringWithRange:NSMakeRange(0, 2)] stringByAppendingString:@"Step to list"] forState:UIControlStateNormal];
            
        }
        
    }
    return cell;
}
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



//
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
                  NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                 NSLog(@"Appdomain-----> %@",appDomain);
                // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                 
                 
                 
                 
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
- (IBAction)AddClick:(id)sender
{
    ServiceListingViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
    [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
}
@end
