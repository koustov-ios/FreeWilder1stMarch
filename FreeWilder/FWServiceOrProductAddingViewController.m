//
//  FWServiceOrProductAddingViewController.m
//  FreeWilder
//
//  Created by Koustov Basu on 10/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import "FWServiceOrProductAddingViewController.h"
#import "FWServiceOrProductAddTableViewCell.h"

#pragma mark - Footer related imports
#import "FW_JsonClass.h"
#import "Footer.h"
#import "ServiceView.h"
#import "profile.h"
#import "ProductDetailsViewController.h"
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
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
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "BusinessProfileViewController.h"
//#import "Product_Details_ViewController.h"
#import "accountsubview.h"
#import "WishlistViewController.h"
#import "ViewController.h"
#import "sideMenu.h"
#import <pop/POP.h>
#import "CircleLoader.h"


@interface FWServiceOrProductAddingViewController ()<UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{

    FWServiceOrProductAddTableViewCell *tableCell;
    
    BOOL basicSaved,calendarSaved,pricingSaved,overviewSaved,photosSaved,locationSaved;
    
    
    UIView *serviceBaseView,*productBaseView;
    
    CGFloat updatedY_product,updatedY_service;
    
    UIButton *mainCategoryBtn_product,*maninCategoryBtn_service,*service_bookingTypeBtn;
    
    NSArray *categoryListContainerArr;
    NSDictionary *categoryDetailsContainerDic;
    
    int tagForBtn_and_Table;
    
    NSString *subcatId;
    
    NSMutableArray *catgoryBtnTags;
    
    UIButton *currentlyTappedBtn;
    
#pragma mark - Footer variables

IBOutlet UIView *footer_base;
sideMenu *leftMenu;
UIView *overlay;
NSMutableArray *ArrProductList;
AppDelegate *appDelegate;
bool data;
UIView *loader_shadow_View;
BOOL tapchk,tapchk1,tapchk2;
NSMutableArray *jsonArray,*temp;
UIView *blackview ,*popview;
NSString *phoneno;
ServiceView *service;
profile *profileview;
UITextField *phoneText;
accountsubview *subview;
NSString *userid;
FW_JsonClass *globalobj;
    

    
}

@property(nonatomic,strong)UIStoryboard *story_board;

@end

@implementation FWServiceOrProductAddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    catgoryBtnTags=[NSMutableArray new];
    
    
    // Do any additional setup after loading the view.
    
    tagForBtn_and_Table=0;
    
    _story_board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIView *paddingView=[UIView new];
    paddingView.frame=CGRectMake(0, 0, 10, 6);

    UIView *paddingView1=[UIView new];
    paddingView1.frame=CGRectMake(0, 0, 10, 6);

    UIView *paddingView2=[UIView new];
    paddingView2.frame=CGRectMake(0, 0, 10, 6);

    UIView *paddingView3=[UIView new];
    paddingView3.frame=CGRectMake(0, 0, 10, 6);

    
    basic_nameField.leftViewMode = UITextFieldViewModeAlways;
    basic_quntityField.leftViewMode = UITextFieldViewModeAlways;
    basic_keywordField.leftViewMode = UITextFieldViewModeAlways;
    basic_videoField.leftViewMode = UITextFieldViewModeAlways;
    
     basic_nameField.leftView=paddingView;
     basic_quntityField.leftView=paddingView1;
     basic_keywordField.leftView=paddingView2;
     basic_videoField.leftView=paddingView3;

 
    basic_scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, basic_bottomView.frame.size.height+basic_bottomView.frame.origin.y);
  
    basic_categoryBtn.tag=tagForBtn_and_Table;
    
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer_base addSubview:footer];
    temp= [[NSMutableArray alloc]init];
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
#pragma mark--
    
}



#pragma mark--Choosing Category Between Service & Product

- (IBAction)basic_categoryTapped:(id)sender
{

   
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(basic_categoryBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2, basic_categoryBtn.frame.size.width, self.view.bounds.size.height/3.2);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"Choose Category"];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*8))/2, 7, tempStrHeading.length*8,self.view.bounds.size.height/19);
    categorHeadingLbl.textAlignment=NSTextAlignmentCenter;
    
    categorHeadingLbl.text=tempStrHeading;
    [popUpBaseView addSubview:categorHeadingLbl];
    
    UIImageView *dividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    
    dividerView.frame=CGRectMake(0, categorHeadingLbl.frame.size.height+categorHeadingLbl.frame.origin.y+5, popUpBaseView.bounds.size.width, 1);
    
    
    [popUpBaseView addSubview:dividerView];
    
    
   //basic_categoryTable=[UITableView new];
    basic_categoryTable.delegate=self;
    basic_categoryTable.dataSource=self;
    basic_categoryTable.tag=0;

    basic_categoryTable.frame=CGRectMake(5, dividerView.frame.size.height+dividerView.frame.origin.y+4, popUpBaseView.frame.size.width-10, popUpBaseView.frame.size.height-(dividerView.frame.size.height+dividerView.frame.origin.y+54));
    
    [popUpBaseView addSubview:basic_categoryTable];
    
    basic_categoryTable.hidden=YES;
    
    
    CircleLoader  *circleLoader = [[CircleLoader alloc] initWithFrame:
                    CGRectMake(0, 0, 30, 30)];
    //center the circle with respect to the view
    [circleLoader setCenter:CGPointMake(popUpBaseView.bounds.size.width / 2,
                                        popUpBaseView.bounds.size.height / 2)];
    //add the circle to the view
    [popUpBaseView addSubview:circleLoader];
    
    [circleLoader animateCircle];
    
  
    UIButton *closeBtn=[UIButton new];
    [closeBtn setTitleColor:[UIColor colorWithRed:16.0f/255 green:95.0f/255 blue:250.0f/255 alpha:1] forState:UIControlStateNormal];
    closeBtn.frame=CGRectMake((popUpBaseView.frame.size.width-150)/2, basic_categoryTable.frame.origin.y+basic_categoryTable.frame.size.height+8, 150, 40);
    [closeBtn setTitle:[NSString stringWithFormat:@"Cancel"] forState:UIControlStateNormal];
    closeBtn.backgroundColor=[UIColor clearColor];
    [popUpBaseView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeCatTable) forControlEvents:UIControlEventTouchUpInside];
    
    
    [blackOverLay addSubview:popUpBaseView];
    
      [basic_categoryTable reloadData];
    
    [circleLoader removeFromSuperview];
    [basic_categoryTable setHidden:NO];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.1];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.2];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
        
        
    }];

}


-(void)closeCatTable
{

    [popUpBaseView removeFromSuperview];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.2];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.0];
        
        [blackOverLay removeFromSuperview];
        
    }];

}


#pragma mark--


-(void)productMainCategoryTapped:(UIButton *)sender
{
    currentlyTappedBtn=sender;
    
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(basic_categoryBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/1.5)/2, basic_categoryBtn.frame.size.width, self.view.bounds.size.height/1.5);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"Choose Category"];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*8))/2, 7, tempStrHeading.length*8,self.view.bounds.size.height/19);
    categorHeadingLbl.textAlignment=NSTextAlignmentCenter;
    
    categorHeadingLbl.text=tempStrHeading;
    [popUpBaseView addSubview:categorHeadingLbl];
    
    UIImageView *dividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    
    dividerView.frame=CGRectMake(0, categorHeadingLbl.frame.size.height+categorHeadingLbl.frame.origin.y+5, popUpBaseView.bounds.size.width, 1);
    
    
    [popUpBaseView addSubview:dividerView];
    
    
    //basic_categoryTable=[UITableView new];
    basic_categoryTable.delegate=self;
    basic_categoryTable.dataSource=self;
     basic_categoryTable.tag=1;
    
    basic_categoryTable.frame=CGRectMake(5, dividerView.frame.size.height+dividerView.frame.origin.y+4, popUpBaseView.frame.size.width-10, popUpBaseView.frame.size.height-(dividerView.frame.size.height+dividerView.frame.origin.y+54));
    
    [popUpBaseView addSubview:basic_categoryTable];
    
    basic_categoryTable.hidden=YES;
    
    
    CircleLoader  *circleLoader = [[CircleLoader alloc] initWithFrame:
                                   CGRectMake(0, 0, 30, 30)];
    //center the circle with respect to the view
    [circleLoader setCenter:CGPointMake(popUpBaseView.bounds.size.width / 2,
                                        popUpBaseView.bounds.size.height / 2)];
    //add the circle to the view
    [popUpBaseView addSubview:circleLoader];
    
    [circleLoader animateCircle];
    
    
    UIButton *closeBtn=[UIButton new];
    [closeBtn setTitleColor:[UIColor colorWithRed:16.0f/255 green:95.0f/255 blue:250.0f/255 alpha:1] forState:UIControlStateNormal];
    closeBtn.frame=CGRectMake((popUpBaseView.frame.size.width-150)/2, basic_categoryTable.frame.origin.y+basic_categoryTable.frame.size.height+8, 150, 40);
    [closeBtn setTitle:[NSString stringWithFormat:@"Cancel"] forState:UIControlStateNormal];
    closeBtn.backgroundColor=[UIColor clearColor];
    [popUpBaseView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeCatTable) forControlEvents:UIControlEventTouchUpInside];
    
    
    [blackOverLay addSubview:popUpBaseView];
    
    NSString *url;
    
    
    if(sender.tag<0)
    {
      url=[NSString stringWithFormat:@"%@app_sub_category?userid=%@&top_cat=%@",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],basic_categoryBtn.titleLabel.text];
    }
    else
    {
    
        url=[NSString stringWithFormat:@"%@app_sub_category?userid=%@&top_cat=%@&category_id=%ld",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],basic_categoryBtn.titleLabel.text,(long)sender.tag];
    
    }
    
    globalobj=[[FW_JsonClass alloc]init];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
       
        
        if ([[result valueForKey:@"response"] isEqualToString:@"success"]) {
            
            
            categoryListContainerArr=[NSArray new];
            categoryListContainerArr=[[[result valueForKey:@"infoarray"] objectAtIndex:0] valueForKey:@"option_value"];
            
             NSLog(@"Result >>> %@ ",categoryListContainerArr);
            
            categoryDetailsContainerDic=[NSDictionary new];
            categoryDetailsContainerDic=(NSDictionary *)result;
            
            [basic_categoryTable reloadData];
            
            [circleLoader removeFromSuperview];
            [basic_categoryTable setHidden:NO];


            
        }
        
        
    }];
    
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.1];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.2];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
        
        
    }];
    
}




#pragma mark--TableView Delegates



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(tableView.tag==0)
    {
    
        //NSLog(@"Basic cat table numberofrows");
        
        return 2;
    
    }
    
    else
    {
    
        return categoryListContainerArr.count;
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

   if(tableView.tag==0)
   {
   
       // NSLog(@"Basic cat table Height for rows");
       
       return basic_categoryTable.bounds.size.height/2;
   
   }
   else return 30;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.0f;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //static NSString *cellid=@"cellID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ExampleCell"];
    
  /*  {
    
//    if(cell==nil)
//    {
//    
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExampleCell"];
//    
//    }
    } */
    
    if(tableView.tag==0)
    {
     
        if (indexPath.row==0) {
            cell.textLabel.text=[NSString stringWithFormat:@"Service"];
        }
       else if (indexPath.row==1)
       {
            cell.textLabel.text=[NSString stringWithFormat:@"Product"];
        }
        
    }
    else
    {
    
       cell.textLabel.text= [NSString stringWithFormat:@"%@",[categoryListContainerArr[indexPath.row] valueForKey:@"cat_name"]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
      
    
    }
    
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   

if(tableView.tag==0)
{
     tagForBtn_and_Table=0-(int)(indexPath.row+1);

    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    
    [basic_categoryBtn setTitle:cellText forState:UIControlStateNormal];
    
    [self closeCatTable];
    
    if([cellText isEqualToString:@"Product"])
    {
        
        [productBaseView removeFromSuperview];
        [serviceBaseView removeFromSuperview];
        
        updatedY_product=0;
        
        productBaseView=[[UIView alloc]initWithFrame:CGRectMake(0, basic_categoryBtn.frame.origin.y+basic_categoryBtn.frame.size.height+8, self.view.bounds.size.width, 0)];
        
        productBaseView.backgroundColor=[UIColor darkGrayColor];//basic_scrollView.backgroundColor;
        
        [basic_scrollView addSubview:productBaseView];
        
        mainCategoryBtn_product=[UIButton new];
        mainCategoryBtn_product.frame=CGRectMake(basic_categoryBtn.frame.origin.x, 0, basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
        [mainCategoryBtn_product setTitle:@"Main Category" forState:UIControlStateNormal];
        mainCategoryBtn_product.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        mainCategoryBtn_product.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
        mainCategoryBtn_product.titleLabel.font=basic_categoryBtn.titleLabel.font;
        [mainCategoryBtn_product setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
        [mainCategoryBtn_product setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
        
        mainCategoryBtn_product.tag=tagForBtn_and_Table;
        

      // Commented code
        
       /* {

//    if(categoryListContainerArr.count>0)
//    {
//        if([[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] isKindOfClass:[NSString class]])
//        {
//                           NSLog(@"Does not Contains id--> %@",[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"]);
//                [catgoryBtnTags addObject:[NSString stringWithFormat:@"%d",tagForBtn_and_Table]];
//        }
//            
//    }
//
        } */
        
    //--
        
        [productBaseView addSubview:mainCategoryBtn_product];
        
        [mainCategoryBtn_product addTarget:self action:@selector(productMainCategoryTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        updatedY_product+=mainCategoryBtn_product.frame.size.height+8;
        
        UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, mainCategoryBtn_product.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
        dropdownArrow.image=[UIImage imageNamed:@"downArrow"];
        dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
        
        
        dropdownArrow.tag=tagForBtn_and_Table;
        
        [productBaseView addSubview:dropdownArrow];
        
        productBaseView.frame=CGRectMake(productBaseView.frame.origin.x, productBaseView.frame.origin.y, productBaseView.frame.size.width, updatedY_product-8);
        
        
        
        basic_bottomView.frame=CGRectMake(basic_bottomView.frame.origin.x, productBaseView.frame.origin.y+productBaseView.frame.size.height+8, basic_bottomView.frame.size.width, basic_bottomView.frame.size.height);
        
        basic_scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, basic_bottomView.frame.size.height+basic_bottomView.frame.origin.y);
        
        updatedY_product=productBaseView.frame.size.height;
        
    
    }
    else if ([cellText isEqualToString:@"Service"])
    {
    
        [serviceBaseView removeFromSuperview];
        [productBaseView removeFromSuperview];
        
        updatedY_service=0;
        
        serviceBaseView=[[UIView alloc]initWithFrame:CGRectMake(0, basic_categoryBtn.frame.origin.y+basic_categoryBtn.frame.size.height+8, self.view.bounds.size.width,0)];
        serviceBaseView.backgroundColor=[UIColor yellowColor];
        
        
        [basic_scrollView addSubview:serviceBaseView];
        
        
        
        service_bookingTypeBtn=[UIButton new];
        
        service_bookingTypeBtn=[UIButton new];
        service_bookingTypeBtn.frame=CGRectMake(basic_categoryBtn.frame.origin.x, updatedY_service, basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
        [service_bookingTypeBtn setTitle:@"Booking Type" forState:UIControlStateNormal];
        service_bookingTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        service_bookingTypeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
        service_bookingTypeBtn.titleLabel.font=basic_categoryBtn.titleLabel.font;
        [service_bookingTypeBtn setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
        [service_bookingTypeBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
        
       // service_bookingTypeBtn.tag=tagForBtn_and_Table;
        
        [serviceBaseView addSubview:service_bookingTypeBtn];
        
        [service_bookingTypeBtn addTarget:self action:@selector(BookingTypeTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        updatedY_service+=service_bookingTypeBtn.frame.size.height+8;
        
        UIImageView *dropdown_Arrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, service_bookingTypeBtn.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
        dropdown_Arrow.image=[UIImage imageNamed:@"downArrow"];
        dropdown_Arrow.contentMode=UIViewContentModeScaleAspectFit;
       // dropdownArrow.tag=tagForBtn_and_Table;
        [serviceBaseView addSubview:dropdown_Arrow];
        
        
        
        
        
        maninCategoryBtn_service=[UIButton new];
        maninCategoryBtn_service.frame=CGRectMake(basic_categoryBtn.frame.origin.x, updatedY_service, basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
        [maninCategoryBtn_service setTitle:@"Main Category" forState:UIControlStateNormal];
        maninCategoryBtn_service.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        maninCategoryBtn_service.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
        maninCategoryBtn_service.titleLabel.font=basic_categoryBtn.titleLabel.font;
        [maninCategoryBtn_service setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
        [maninCategoryBtn_service setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
        
        maninCategoryBtn_service.tag=tagForBtn_and_Table;
        
        [serviceBaseView addSubview:maninCategoryBtn_service];
        
        [maninCategoryBtn_service addTarget:self action:@selector(productMainCategoryTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        updatedY_service+=maninCategoryBtn_service.frame.size.height+8;
        
        UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, maninCategoryBtn_service.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
        dropdownArrow.image=[UIImage imageNamed:@"downArrow"];
        dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
        
        
        dropdownArrow.tag=tagForBtn_and_Table;
        
        [serviceBaseView addSubview:dropdownArrow];
        
        serviceBaseView.frame=CGRectMake(serviceBaseView.frame.origin.x, serviceBaseView.frame.origin.y, serviceBaseView.frame.size.width, updatedY_service-8);
        
        
        
        basic_bottomView.frame=CGRectMake(basic_bottomView.frame.origin.x, serviceBaseView.frame.origin.y+serviceBaseView.frame.size.height+8, basic_bottomView.frame.size.width, basic_bottomView.frame.size.height);
        
        basic_scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, basic_bottomView.frame.size.height+basic_bottomView.frame.origin.y);
        
        updatedY_service=serviceBaseView.frame.size.height;

        
        
        
        
        
    
    
    }

}
else
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    

    NSString *tempstr=[NSString stringWithFormat:@"%d",(int)currentlyTappedBtn.tag];
    
          if([currentlyTappedBtn.titleLabel.text isEqualToString:cellText] && [catgoryBtnTags lastObject]!=tempstr)
          {
          
               // do nothing with the bottom part
              
              [currentlyTappedBtn setTitle:cellText forState:UIControlStateNormal];
              
              [self closeCatTable];
          
          }
         else if ((![currentlyTappedBtn.titleLabel.text isEqualToString:cellText])  && [catgoryBtnTags lastObject]!=tempstr)
         {
             
//             NSLog(@"%@ || %@ --------- %@ || %@",currentlyTappedBtn.titleLabel.text,cellText,[catgoryBtnTags lastObject],tempstr);
//         
//             NSLog(@"Remove the buttom part here....");
             
           //  NSLog(@"Tapped view tag----> %@ ",tempstr);
             
             
             NSArray *subViews=[[NSArray alloc]init];
             
             UIView *viewToBeModified;
             
             if([basic_categoryBtn.titleLabel.text isEqualToString:@"Product"])
             {
                 
                 subViews=[productBaseView subviews];
                 
                 viewToBeModified=productBaseView;
                 
             }
             else if([basic_categoryBtn.titleLabel.text isEqualToString:@"Service"])
             {
                 
                 subViews=[serviceBaseView subviews];
                 
                 viewToBeModified=serviceBaseView;
                 
             }

             
             
             
             NSInteger myPos=(NSInteger)([catgoryBtnTags indexOfObject:tempstr]+1);
             
             
             
             for (int i=(int)(myPos+1); i<=catgoryBtnTags.count; i++)
             {
                 
                 for (UIView *obj in subViews)
   
                 {
                     
                     if([[NSString stringWithFormat:@"%d",(int) obj.tag] isEqualToString:catgoryBtnTags[i-1]])
                     {
                         
                          NSLog(@"Tapped view  ----> %@ || Removing view  ----> %ld ",tempstr,(long)obj.tag);
                         
                         [obj removeFromSuperview];
                         
                         
                     }
                     
                     
                 }
             }
             
             
             if([currentlyTappedBtn isEqual:mainCategoryBtn_product] || [currentlyTappedBtn isEqual:maninCategoryBtn_service])
             [catgoryBtnTags removeAllObjects];
             
             
             viewToBeModified.frame=CGRectMake(viewToBeModified.frame.origin.x, viewToBeModified.frame.origin.y, viewToBeModified.bounds.size.width, currentlyTappedBtn.frame.size.height+currentlyTappedBtn.frame.origin.y);
             
             updatedY_product=viewToBeModified.frame.size.height;
             
             basic_bottomView.frame=CGRectMake(basic_bottomView.frame.origin.x, viewToBeModified.frame.origin.y+viewToBeModified.frame.size.height+8, basic_bottomView.frame.size.width, basic_bottomView.frame.size.height);
             
             basic_scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, basic_bottomView.frame.size.height+basic_bottomView.frame.origin.y);
             
             [currentlyTappedBtn setTitle:cellText forState:UIControlStateNormal];
             
             [self closeCatTable];
             
           
             
             if([basic_categoryBtn.titleLabel.text isEqualToString:@"Product"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"Y"])
             {
                 
                 if([[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] isKindOfClass:[NSString class]])
                 {
                      [catgoryBtnTags addObject:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"]];
                 }

                 
                 
                   subcatId=[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"];
                 
                 [self createSubCategoryButtonOnView:productBaseView fromTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
                 
                 
                 
             }
             else  if([basic_categoryBtn.titleLabel.text isEqualToString:@"Service"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"Y"])
             {
                 
                 if([[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] isKindOfClass:[NSString class]])
                 {
                     [catgoryBtnTags addObject:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"]];
                 }

                 
                 
                   subcatId=[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"];
                 
                 [self createSubCategoryButtonOnView:serviceBaseView fromTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
                 
             }

             
             
         }
    
         else

         {
        

    UIButton *tempBtn=(UIButton *)[basic_scrollView viewWithTag:tagForBtn_and_Table];
    [tempBtn setTitle:cellText forState:UIControlStateNormal];
    
    
    
    [self closeCatTable];
    
    subcatId=[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    if([basic_categoryBtn.titleLabel.text isEqualToString:@"Product"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"Y"])
    {
    
      
        
        
        if (![catgoryBtnTags containsObject:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"]])
        {
            if([[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] isKindOfClass:[NSString class]])
            {
                [catgoryBtnTags addObject:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"]];
            }
        }
        
             subcatId=[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"];

             [self createSubCategoryButtonOnView:productBaseView fromTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
        
        
    
    }
    else  if([basic_categoryBtn.titleLabel.text isEqualToString:@"Service"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"Y"])
    {
        
        if (![catgoryBtnTags containsObject:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"]])
        {
            if([[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] isKindOfClass:[NSString class]])
            {
                [catgoryBtnTags addObject:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"]];
            }
        }
        
        
        subcatId=[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        [self createSubCategoryButtonOnView:serviceBaseView fromTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
        
    }
    
 }
   
    
     NSLog(@"i--------> %d",tagForBtn_and_Table);
    

   
}


}

#pragma mark--


-(void)createSubCategoryButtonOnView:(UIView *)baseview fromTag:(int)tag
{
    
    
    UIButton *subCategoryBtn=[UIButton new];
    subCategoryBtn.frame=CGRectMake(basic_categoryBtn.frame.origin.x, baseview.frame.size.height+8,basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
    [subCategoryBtn setTitle:@"Other Category" forState:UIControlStateNormal];
    subCategoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    subCategoryBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
    subCategoryBtn.titleLabel.font=basic_categoryBtn.titleLabel.font;
    [subCategoryBtn setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
    [subCategoryBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
    
   
    
     subCategoryBtn.tag=tag;
    
    tagForBtn_and_Table=tag;
    

    
    NSLog(@"i--------> %d",tag);
    
    [baseview addSubview:subCategoryBtn];
    
    [subCategoryBtn addTarget:self action:@selector(productMainCategoryTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    updatedY_product+=subCategoryBtn.frame.size.height+8;
    
    UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, subCategoryBtn.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
    dropdownArrow.image=[UIImage imageNamed:@"downArrow"];
    dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
    
    
      dropdownArrow.tag=tag;
    
    [baseview addSubview:dropdownArrow];
    
    baseview.frame=CGRectMake(baseview.frame.origin.x, baseview.frame.origin.y, baseview.frame.size.width, updatedY_product);
    
    
    
    basic_bottomView.frame=CGRectMake(basic_bottomView.frame.origin.x, baseview.frame.origin.y+baseview.frame.size.height+8, basic_bottomView.frame.size.width, basic_bottomView.frame.size.height);
    
    basic_scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, basic_bottomView.frame.size.height+basic_bottomView.frame.origin.y);
    
    
}




#pragma mark - Footer related methods


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
        
        DashboardViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"Invite_Friend"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==1)
    {
        // Do Rate App related work here
        
    }
    if(tag==2)
    {
        
        userid=[prefs valueForKey:@"UserId"];
        
        BusinessProfileViewController *obj = [self.story_board instantiateViewControllerWithIdentifier:@"busniessprofile"];
        
        obj.BusnessUserId = userid;
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==3)
    {
        EditProfileViewController    *obj=[self.story_board instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==4)
    {
        Photos___Videos_ViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"photo"];
        
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
        Trust_And_Verification_ViewController  *obj=[self.story_board instantiateViewControllerWithIdentifier:@"trust"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==7)
    {
        
        rvwViewController  *obj=[self.story_board instantiateViewControllerWithIdentifier:@"review_vc"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==8)
    {
        Business_Information_ViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"Business"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==9)
    {
        UserService *obj=[self.story_board instantiateViewControllerWithIdentifier:@"myservice"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==10)
    {
        //Add product---//---service
    }
    if(tag==11)
    {
        
        userBookingandRequestViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==12)
    {
        MyBooking___Request *obj=[self.story_board instantiateViewControllerWithIdentifier:@"Mybooking_page"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==13)
    {
        WishlistViewController    *obj=[self.story_board instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==14)
    {
        myfavouriteViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    if(tag==15)
    {
        // Account....
        
    }
    
    if(tag==16)
    {
        LanguageViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"language"];
        
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
        
        ViewController   *obj=[self.story_board instantiateViewControllerWithIdentifier:@"Login_Page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    
    // accountSubArray=@[@"Notification",@"Payment Method",@"payout Preferences",@"Tansaction History",@"Privacy",@"Security",@"Settings"];
    
    if(tag==50)
    {
        
        notificationsettingsViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"settingsfornotification"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==51)
    {
        PaymentMethodViewController *obj =[self.story_board instantiateViewControllerWithIdentifier:@"payment"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==52)
    {
        PayoutPreferenceViewController *obj =[self.story_board instantiateViewControllerWithIdentifier:@"payout"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    if(tag==53)
    {
        NSLog(@"i am from transaction history");
        
        
    }
    if(tag==54)
    {
        PrivacyViewController *obj =[self.story_board instantiateViewControllerWithIdentifier:@"privacy"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    if(tag==55)
    {
        ChangePassword *obj =[self.story_board instantiateViewControllerWithIdentifier:@"changepass"];
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    if(tag==56)
    {
        SettingsViewController *obj =[self.story_board instantiateViewControllerWithIdentifier:@"settings"];
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
        
        
//        DashboardViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==3)
    {
        
        DashboardViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"msg_page"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==2)
    {
        
        
        DashboardViewController *obj=[self.story_board instantiateViewControllerWithIdentifier:@"SearchProductViewControllersid"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==1)
    {
        
        NSLog(@"I am here dashboard...");
        
        DashboardViewController *dashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
        [self PushViewController:dashVC WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    
    
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


// ------- FOOTER METHOD ENDS HERE --------

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
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



- (IBAction)basic_instant_yestapped:(id)sender {
}
- (IBAction)basic_instantNoTapped:(id)sender {
}
@end
