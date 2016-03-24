//
//  FWServiceOrProductAddingViewController.m
//  FreeWilder
//
//  Created by Koustov Basu on 10/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import "FWServiceOrProductAddingViewController.h"
#import "FWServiceOrProductAddTableViewCell.h"
#import "specialButton.h"
#import "specialTable.h"
#import "ExampleCell.h"

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
#import "NSString+stringCategory.h"


@interface FWServiceOrProductAddingViewController ()<UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{

    
    
    NSString *iskeyWordTableOpen;
    
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
    
    CGPoint scrollPoint;
    
    UITableView *bookingtypeTable;
    
    NSArray *otherViewsArray;
    NSDictionary *otherViewsDic;
    
    NSArray *radioBtnListArray,*selectListArray,*checkListArray;
    
    specialButton *tappedButton_special;
    
    NSString *whichspecialButtonTapped;
    
    
#pragma mark--For creating dynamic URL
    
    NSMutableArray *radioBtnValues,*checkBoxValues,*subCatValues,*mainCategoryList;
    
    NSMutableDictionary *subCatDictionary,*selectListDic,*radioListDic,*textContainerDic,*checkboxDic;
    
    NSString *instantBooked;
    
    NSString *mainCategoryId;
    
    NSMutableArray *selectListvalues,*radioListValues,*motheridarr_selectlist,*motheridarr_radiolist,*textContainerArr,*motheridarr_textRelated;
    
    NSMutableArray *keywordArr,*aminitiesArr;
    NSDictionary *keywordDic;
    NSMutableDictionary *keyWordFragDic,*aminitiesFragDic;
    
#pragma mark--
    
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
    
    iskeyWordTableOpen=@"no";
    
    saveBtn.layer.cornerRadius=6.0f;
    saveBtn.clipsToBounds=YES;
    
    subCatDictionary=[[NSMutableDictionary alloc]init];
    
    catgoryBtnTags=[NSMutableArray new];
    
    scrollPoint=basic_scrollView.contentOffset;
    
    whichspecialButtonTapped=@"";
    
    keywordDic=[NSDictionary new];
    keywordArr=[NSMutableArray new];
    keyWordFragDic=[NSMutableDictionary new];
    
    aminitiesArr=[NSMutableArray new];
    aminitiesFragDic=[NSMutableDictionary new];
    
    checkBoxValues=[[NSMutableArray alloc]init];
    checkListArray=[[NSArray alloc]init];
    checkboxDic=[[NSMutableDictionary alloc]init];
    
    selectListArray=[[NSArray alloc]init];
    radioBtnListArray=[[NSArray alloc]init];
    
    selectListDic=[[NSMutableDictionary alloc]init];
    radioListDic=[[NSMutableDictionary alloc]init];
    
    selectListvalues=[[NSMutableArray alloc]init];
    radioListValues=[[NSMutableArray alloc]init];
    
    motheridarr_selectlist=[[NSMutableArray alloc]init];
    motheridarr_radiolist=[[NSMutableArray alloc]init];
    
    textContainerArr=[[NSMutableArray alloc]init];
    textContainerDic=[[NSMutableDictionary alloc]init];
    motheridarr_textRelated=[[NSMutableArray alloc]init];
    
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

    basic_quntityField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    
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
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
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
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
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
    whichspecialButtonTapped=@"";
    iskeyWordTableOpen=@"no";
    
    for (UITableView *v in popUpBaseView.subviews)
    {
//        [v removeFromSuperview];
        if ([v isKindOfClass:[UITableView class]])
        {
            [v setDelegate:nil];
            [v setDataSource:nil];
            [v removeFromSuperview];
        }
    }
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
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
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
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
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
            
            if(sender.tag<0)
            {
            
                mainCategoryList=[NSMutableArray new];
                mainCategoryList=[categoryListContainerArr mutableCopy];
            
            }
            else
            {
            
                subCatValues=[NSMutableArray new];
                subCatValues=[categoryListContainerArr mutableCopy];
            
            }
            
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

#pragma mark--Booking type choosing function

-(void)BookingTypeTapped:(UIButton *)sender
{
        
        
        blackOverLay=[UIView new];
        blackOverLay.frame=self.view.frame;
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
        [self.view addSubview:blackOverLay];
        
        popUpBaseView=[UIView new];
        popUpBaseView.frame=CGRectMake(basic_categoryBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2, basic_categoryBtn.frame.size.width, self.view.bounds.size.height/3.2);
        popUpBaseView.backgroundColor=[UIColor whiteColor];
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
        
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
        
        
        //bookingtypeTable=[UITableView new];
        basic_categoryTable.delegate=self;
        basic_categoryTable.dataSource=self;
        basic_categoryTable.tag=-420;
        
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
        [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
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


#pragma mark--


#pragma mark--TableView Delegates



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberofrows");
    //NSLog(@"Which special button? %@",whichspecialButtonTapped);

    if(tableView.tag==0)
    {
    
        // NSLog(@"Basic cat table numberofrows");
        if ([whichspecialButtonTapped isEqualToString:@""] && [iskeyWordTableOpen isEqualToString:@"yes"])
        {
        
            return keywordArr.count;
        
        }
        else if ([whichspecialButtonTapped isEqualToString:@"aminities"])
        {
            
            NSUInteger count;
            count = aminitiesArr.count;
             NSLog(@"Aminities ---> %ld",count);
            return count;
            
        }
        else if ([whichspecialButtonTapped isEqualToString:@"select"])
        {
            
            NSUInteger count;
            count = selectListArray.count;
            
            //NSLog(@"Hello ***---> %ld",count);
            return count;
            
        }
        else if ([whichspecialButtonTapped isEqualToString:@"radio"])
        {
            NSUInteger count;
            count = radioBtnListArray.count;
            
            //NSLog(@"Hello **---> %ld",count);
            return count;
            
        }
        else if ([whichspecialButtonTapped isEqualToString:@"check"])
        {
            NSUInteger count;
            count = checkListArray.count;
            return count;
        }
        else
        {
            //NSLog(@"Here....1");
            return 2;
        
        }
        
    
    }
    else if (tableView.tag==-420)
    {
    
        NSLog(@"Here 2");
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
       
       if ([whichspecialButtonTapped isEqualToString:@"select"] || [whichspecialButtonTapped isEqualToString:@"radio"] || [whichspecialButtonTapped isEqualToString:@"check"] || [iskeyWordTableOpen isEqualToString:@"yes"] || [whichspecialButtonTapped isEqualToString:@"aminities"])
       {
       
           return  30;
       
       }
       else
       {
         return basic_categoryTable.bounds.size.height/2;
       }
   }
   else if (tableView.tag==-420)
   {
       
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


    UITableViewCell *cell;

    cell=[tableView dequeueReusableCellWithIdentifier:@"ExampleCell"];


    if(tableView.tag==0)
    {
     
        if ([whichspecialButtonTapped isEqualToString:@"select"] || [whichspecialButtonTapped isEqualToString:@"radio"] || [whichspecialButtonTapped isEqualToString:@"check"] || [iskeyWordTableOpen isEqualToString:@"yes"] || [whichspecialButtonTapped isEqualToString:@"aminities"])
        {
            
            //specialTable *tableObj=(specialTable *)tableView;
            if([whichspecialButtonTapped isEqualToString:@""] && [iskeyWordTableOpen isEqualToString:@"yes"])
            {
            
                cell.accessoryType=UITableViewCellAccessoryNone;
                
                if([[[keywordArr objectAtIndex:indexPath.row] valueForKey:@"selected"] isEqualToString:@"no"])
                {
                    NSLog(@"here..no...");
                 cell.accessoryType=UITableViewCellAccessoryNone;
                }
                else if ([[[keywordArr objectAtIndex:indexPath.row] valueForKey:@"selected"] isEqualToString:@"yes"])
                {
                    NSLog(@"here..yes...");
                        cell.accessoryType=UITableViewCellAccessoryCheckmark;
                }
                
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[[keywordArr objectAtIndex:indexPath.row] valueForKey:@"name"]];
            
            }
           else if([whichspecialButtonTapped isEqualToString:@"aminities"])
            {
            
                cell.accessoryType=UITableViewCellAccessoryNone;
                
                if([[[aminitiesArr objectAtIndex:indexPath.row] valueForKey:@"checked"] isEqualToString:@"no"])
                {
                    NSLog(@"here..no...");
                    cell.accessoryType=UITableViewCellAccessoryNone;
                }
                else if ([[[aminitiesArr objectAtIndex:indexPath.row] valueForKey:@"checked"] isEqualToString:@"yes"])
                {
                    NSLog(@"here..yes...");
                    cell.accessoryType=UITableViewCellAccessoryCheckmark;
                }
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[aminitiesArr[indexPath.row] valueForKey:@"name"]];
            
            }
            else if([whichspecialButtonTapped isEqualToString:@"select"])
            {
                //NSLog(@"*****");
                cell.accessoryType=UITableViewCellAccessoryNone;
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[selectListArray[indexPath.row] valueForKey:@"name"]];
                
            }
            else if([whichspecialButtonTapped isEqualToString:@"radio"])
            {
                cell.accessoryType=UITableViewCellAccessoryNone;
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[radioBtnListArray[indexPath.row] valueForKey:@"name"]];
                
            }
            else if([whichspecialButtonTapped isEqualToString:@"check"])
            {
                
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[checkListArray[indexPath.row] valueForKey:@"name"]];
                cell.accessoryType=UITableViewCellAccessoryNone;
                
                if([checkBoxValues
                     containsObject:[NSString stringWithFormat:@"%@/%@",[checkListArray[indexPath.row] valueForKey:@"id"],[checkListArray[indexPath.row] valueForKey:@"option_id"]]])
                {
                
                    cell.accessoryType=UITableViewCellAccessoryCheckmark;
                
                }
                
            }
            
        }
        else
        {
        
         cell.accessoryType=UITableViewCellAccessoryNone;
          if (indexPath.row==0) {
            cell.textLabel.text=[NSString stringWithFormat:@"Service"];
           }
           else if (indexPath.row==1)
          {
            cell.textLabel.text=[NSString stringWithFormat:@"Product"];
          }
            
        }
        
    }
    else if (tableView.tag==-420)
    {
         cell.accessoryType=UITableViewCellAccessoryNone;
        if (indexPath.row==0) {
            cell.textLabel.text=[NSString stringWithFormat:@"Per Day"];
        }
        else if (indexPath.row==1)
        {
            cell.textLabel.text=[NSString stringWithFormat:@"Slot"];
        }
        
    }
    
   
    
    else
    {

         cell.accessoryType=UITableViewCellAccessoryNone;
        cell.textLabel.text= [NSString stringWithFormat:@"%@",[categoryListContainerArr[indexPath.row] valueForKey:@"cat_name"]];
        
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
     }
    

      return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   

    
if(tableView.tag==0)
{

    #pragma mark-- For the select list & radio button tableview
    
    if ([whichspecialButtonTapped isEqualToString:@"select"] || [whichspecialButtonTapped isEqualToString:@"radio"] || [whichspecialButtonTapped isEqualToString:@"check"] || [iskeyWordTableOpen isEqualToString:@"yes"] || [whichspecialButtonTapped isEqualToString:@"aminities"])
        
    {
    
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *cellText = selectedCell.textLabel.text;
       
        if(!([whichspecialButtonTapped isEqualToString:@"check"] || [whichspecialButtonTapped isEqualToString:@"aminities"]))
        {
         [tappedButton_special setTitle:cellText forState:UIControlStateNormal];
        }
        
         if([whichspecialButtonTapped isEqualToString:@""] && [iskeyWordTableOpen isEqualToString:@"yes"])
         {
         
         
             if([[[keywordArr objectAtIndex:indexPath.row] valueForKey:@"selected"] isEqualToString:@"yes"])
             {
             
                 [[keywordArr objectAtIndex:indexPath.row] setValue:@"no" forKey:@"selected"];
                 
                 [tableView beginUpdates];
                 
                 [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                 
                 [tableView endUpdates];
                 
                 NSLog(@"Dic--> %@",[keywordArr objectAtIndex:indexPath.row]);
             
             }
             else if([[[keywordArr objectAtIndex:indexPath.row] valueForKey:@"selected"] isEqualToString:@"no"])
             {
                 
                 [[keywordArr objectAtIndex:indexPath.row] setValue:@"yes" forKey:@"selected"];
                 
                 [tableView beginUpdates];
                 
                 [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                 
                 [tableView endUpdates];
                 
                  NSLog(@"Dic--> %@",[keywordArr objectAtIndex:indexPath.row]);
                 
             }
         
         }
       else if([whichspecialButtonTapped isEqualToString:@"aminities"])
        {
        
            if([[[aminitiesArr objectAtIndex:indexPath.row] valueForKey:@"checked"] isEqualToString:@"yes"])
            {
                
                [[aminitiesArr objectAtIndex:indexPath.row] setValue:@"no" forKey:@"checked"];
                
                [tableView beginUpdates];
                
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                [tableView endUpdates];
                
                NSLog(@"Dic--> %@",[aminitiesArr objectAtIndex:indexPath.row]);
                
            }
            else if([[[aminitiesArr objectAtIndex:indexPath.row] valueForKey:@"checked"] isEqualToString:@"no"])
            {
                
                [[aminitiesArr objectAtIndex:indexPath.row] setValue:@"yes" forKey:@"checked"];
                
                [tableView beginUpdates];
                
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                [tableView endUpdates];
                
                NSLog(@"Dic--> %@",[aminitiesArr objectAtIndex:indexPath.row]);
                
            }
        
        }
        else if([whichspecialButtonTapped isEqualToString:@"check"])
        {
        
             UIView *superView=tappedButton_special.superview;
            
            if(![checkBoxValues
                 containsObject:[NSString stringWithFormat:@"%@/%@",[checkListArray[indexPath.row] valueForKey:@"id"],[checkListArray[indexPath.row] valueForKey:@"option_id"]]])
            {
            
            
                [checkBoxValues addObject:[NSString stringWithFormat:@"%@/%@",[checkListArray[indexPath.row] valueForKey:@"id"],[checkListArray[indexPath.row] valueForKey:@"option_id"]]];
            
                 NSLog(@"Check BOX ---> %@",checkBoxValues);
            }
            else
            {
            
                [checkBoxValues removeObject:[NSString stringWithFormat:@"%@/%@",[checkListArray[indexPath.row] valueForKey:@"id"],[checkListArray[indexPath.row] valueForKey:@"option_id"]]];
            
                 NSLog(@"Check BOX ---> %@",checkBoxValues);
            
            }
            
            NSString *key = [NSString stringWithFormat:@"%ld",(long)superView.tag];
            [checkboxDic setValue:checkBoxValues forKey:key];
            
            [tableView beginUpdates];
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView endUpdates];
        
        }
        
       else if([whichspecialButtonTapped isEqualToString:@"select"])
        {
        
            NSLog(@"Here select....");
            UIView *superView=tappedButton_special.superview;
            
            if(![selectListvalues
               containsObject:[NSString stringWithFormat:@"%@/%@",[selectListArray[indexPath.row] valueForKey:@"id"],[selectListArray[indexPath.row] valueForKey:@"option_id"]]])
            {
            
                if(![motheridarr_selectlist containsObject:[selectListArray[indexPath.row] valueForKey:@"option_id"]])
                {
                  [motheridarr_selectlist addObject:[selectListArray[indexPath.row] valueForKey:@"option_id"]];
                    
                    [selectListvalues addObject:[NSString stringWithFormat:@"%@/%@",[selectListArray[indexPath.row] valueForKey:@"id"],[selectListArray[indexPath.row] valueForKey:@"option_id"]]];
                }
                else
                {
                
                   NSInteger anIndex=[motheridarr_selectlist indexOfObject:[selectListArray[indexPath.row] valueForKey:@"option_id"]];
                    
                    [selectListvalues replaceObjectAtIndex:anIndex withObject:[NSString stringWithFormat:@"%@/%@",[selectListArray[indexPath.row] valueForKey:@"id"],[selectListArray[indexPath.row] valueForKey:@"option_id"]]];
                
                
                }
               
                
            
            }
            
            NSString *key = [NSString stringWithFormat:@"%ld",(long)superView.tag];
            [selectListDic setValue:selectListvalues forKey:key];
            
            [self closeCatTable];
        
        }else if ([whichspecialButtonTapped isEqualToString:@"radio"])
        {
            NSLog(@"Here radio....");
        
            UIView *superView=tappedButton_special.superview;
            
//            if
//            
//            
            
            if(![radioBtnValues
                 containsObject:[NSString stringWithFormat:@"%@/%@",[radioBtnListArray[indexPath.row] valueForKey:@"id"],[radioBtnListArray[indexPath.row] valueForKey:@"option_id"]]])
            {
                
                if(![motheridarr_radiolist containsObject:[radioBtnListArray[indexPath.row] valueForKey:@"option_id"]])
                {
                    [motheridarr_radiolist addObject:[radioBtnListArray[indexPath.row] valueForKey:@"option_id"]];
                    
                    [radioBtnValues addObject:[NSString stringWithFormat:@"%@/%@",[radioBtnListArray[indexPath.row] valueForKey:@"id"],[radioBtnListArray[indexPath.row] valueForKey:@"option_id"]]];
                }
                else
                {
                    
                    NSInteger anIndex=[motheridarr_radiolist indexOfObject:[radioBtnListArray[indexPath.row] valueForKey:@"option_id"]];
                    
                    [radioBtnValues replaceObjectAtIndex:anIndex withObject:[NSString stringWithFormat:@"%@/%@",[radioBtnListArray[indexPath.row] valueForKey:@"id"],[radioBtnListArray[indexPath.row] valueForKey:@"option_id"]]];
                    
                    
                }
                
                
                
            }
//            {
//                
//                [radioBtnValues addObject:[NSString stringWithFormat:@"%@/%@",[radioBtnListArray[indexPath.row] valueForKey:@"id"],[radioBtnListArray[indexPath.row] valueForKey:@"option_id"]]];
//                
//            }
            
            NSString *key = [NSString stringWithFormat:@"%ld",(long)superView.tag];
            [radioListDic setValue:radioBtnValues forKey:key];
            
            [self closeCatTable];
        
        }
        
        
        
    
    }
    
    #pragma mark--
    
    #pragma mark--This part is mainly for when we choose between Product & Service from the basic table with tag 0 and it creates the main cat field for them.
    else
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
            [subCatDictionary removeAllObjects];
            
            updatedY_product=0;
            
            productBaseView=[[UIView alloc]initWithFrame:CGRectMake(0, basic_categoryBtn.frame.origin.y+basic_categoryBtn.frame.size.height+8, self.view.bounds.size.width, 0)];
            
            productBaseView.backgroundColor=basic_scrollView.backgroundColor;//[UIColor darkGrayColor];
            
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
            
            [subCatDictionary removeAllObjects];
            
            updatedY_service=0;
            
            serviceBaseView=[[UIView alloc]initWithFrame:CGRectMake(0, basic_categoryBtn.frame.origin.y+basic_categoryBtn.frame.size.height+8, self.view.bounds.size.width,0)];
            serviceBaseView.backgroundColor=basic_scrollView.backgroundColor;//[UIColor yellowColor];
            
            
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
#pragma mark--

}

   
#pragma mark-- This is for service type selection
    
   else if (tableView.tag==-420)
    {
    
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *cellText = selectedCell.textLabel.text;
        [service_bookingTypeBtn setTitle:cellText forState:UIControlStateNormal];
        [self closeCatTable];
    
    }
    
#pragma mark--
    

    
#pragma mark--This is for creating Sub category buttons by choosing from the same table but at this time the tag changes
    
else
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    

    NSString *tempstr=[NSString stringWithFormat:@"%d",(int)currentlyTappedBtn.tag];
    
#pragma mark-- When the button u tapped and the cell u selected are of same title,then no changes will happen to the bottom part--
    
          if([currentlyTappedBtn.titleLabel.text isEqualToString:cellText] )//&& [catgoryBtnTags lastObject]!=tempstr
          {
          
               // do nothing with the bottom part
              
              [currentlyTappedBtn setTitle:cellText forState:UIControlStateNormal];
              
              [self closeCatTable];
          
          }
    
#pragma mark--
    
 
#pragma mark-- This is when the button u tapped is not the first button & the title of the button is not the same as the title of the cell u selected...then remove the bottom part sub category buttons...and create new sub cat buttons or not based on the sub cat status
    
         else if ((![currentlyTappedBtn.titleLabel.text isEqualToString:cellText]) && ([catgoryBtnTags lastObject]!=tempstr && catgoryBtnTags.count!=0))
         {
             
//             NSLog(@"%@ || %@ --------- %@ || %@",currentlyTappedBtn.titleLabel.text,cellText,[catgoryBtnTags lastObject],tempstr);
//         
//             NSLog(@"Remove the buttom part here....");
             
             NSLog(@"Tapped view tag----> %@ ",tempstr);
             
             
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
             
             NSLog(@"My pos---> %ld & Array count---> %ld",myPos,catgoryBtnTags.count);
             
             NSLog(@"BC Array---> %@",catgoryBtnTags);
             
             
                 for (UIView *obj in subViews)
   
                 {
                     for (int i=(int)(myPos); i<catgoryBtnTags.count; i++)
                     {

                     
                     if([[NSString stringWithFormat:@"%d",(int) obj.tag] isEqualToString:catgoryBtnTags[i]])
                     {
                         
                          NSLog(@"Removing view  ----> %@ || %ld ",catgoryBtnTags[i],(long)obj.tag);
                         
                         NSString *subcatDicKey=[NSString stringWithFormat:@"%d",(int) obj.tag];
                         [subCatDictionary removeObjectForKey:subcatDicKey];
                         
                       //After deleting the sub-cat key value pairs replace the currently choosen pre existing key value pair...
                         
                         NSString *subcatDicKey_forReplacementOfValue=[NSString stringWithFormat:@"%ld",currentlyTappedBtn.tag];
                         [subCatDictionary setValue:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] forKey:subcatDicKey_forReplacementOfValue];
                       //----
                         
                         [radioListDic removeObjectForKey:subcatDicKey];
                         [selectListDic removeObjectForKey:subcatDicKey];
                         [selectListvalues removeAllObjects];
                         [radioListValues removeAllObjects];
                         [motheridarr_radiolist removeAllObjects];
                         [motheridarr_selectlist removeAllObjects];
                         [motheridarr_textRelated removeAllObjects];
                         [textContainerDic removeObjectForKey:subcatDicKey];
                         
                         [checkBoxValues removeAllObjects];
                         checkListArray=[[NSArray alloc]init];
                         [checkboxDic removeObjectForKey:subcatDicKey];
                         
//                          [catgoryBtnTags removeObjectAtIndex:i];
                         
                             [obj removeFromSuperview];
                         
                    }
                     
                     
                 }
             }
             
             NSLog(@"After remove sub cat dic---> %@",subCatDictionary);
             
             if([currentlyTappedBtn isEqual:mainCategoryBtn_product] || [currentlyTappedBtn isEqual:maninCategoryBtn_service])
             {
               [catgoryBtnTags removeAllObjects];
             }
             
             else
             {
             
                 NSRange r;
                 r.location = myPos;
                 r.length = [catgoryBtnTags count]-myPos;
                 
                 [catgoryBtnTags removeObjectsInRange:r];
                 
                 NSLog(@"BC array after range delete---> %@",catgoryBtnTags);
             
             }
             
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
             else if ([basic_categoryBtn.titleLabel.text isEqualToString:@"Service"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"N"])
             {
                 
                 NSLog(@"Now new type of views will be created for service...");
                 
                 [self createOtherViewsOnView:serviceBaseView withTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
                 
             }
             else if([basic_categoryBtn.titleLabel.text isEqualToString:@"Product"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"N"])
             {
                 
                 NSLog(@"Now new type of views will be created for product...");
                 
                  [self createOtherViewsOnView:productBaseView withTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
                 
             }


             
             
         }
    
#pragma mark--
    
    
#pragma mark-- This is the fresh part when fresh sub category buttons are being created based on the sub category status of previously tapped button title;i.e,the choosen sub category or main category
    
         else

         {
        

             //UIButton *tempBtn=(UIButton *)[basic_scrollView viewWithTag:tagForBtn_and_Table];
             [currentlyTappedBtn setTitle:cellText forState:UIControlStateNormal];
             NSLog(@"Now i should be here with title---> %@",cellText);
             
             if(currentlyTappedBtn.tag>0)
             {
             
             NSString *subcatDicKey=[NSString stringWithFormat:@"%ld",currentlyTappedBtn.tag];
             [subCatDictionary setValue:[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] forKey:subcatDicKey];
             
             NSLog(@"Now sub cat dic contains---> %@",subCatDictionary);
                 
             }

    
    
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
             
     else if ([basic_categoryBtn.titleLabel.text isEqualToString:@"Service"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"N"])
     {
     
         NSLog(@"Now new type of views will be created for service...");
         
          [self createOtherViewsOnView:serviceBaseView withTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
     
     }
    else if([basic_categoryBtn.titleLabel.text isEqualToString:@"Product"] && [[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"sub_category_status"] isEqualToString:@"N"])
    {
    
       NSLog(@"Now new type of views will be created for product...");
        
         [self createOtherViewsOnView:productBaseView withTag:[[[categoryListContainerArr objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
    
    }
    
 }
    
#pragma mark--
   
    
    // NSLog(@"i--------> %d",tagForBtn_and_Table);
    

   
}
    
#pragma mark--


}


-(void)textViewDidBeginEditing:(UITextView *)textView
{

     UIView *superView1=textView.superview.superview;
     UIView *superView2=textView.superview;
    
    scrollPoint=basic_scrollView.contentOffset;
    
    [UIView animateWithDuration:0.3 animations:^{
        
            basic_scrollView.contentOffset=CGPointMake(0, superView2.frame.origin.y+superView1.frame.origin.y+textView.frame.origin.y-(textView.frame.size.height));
        
    }];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
          basic_scrollView.contentOffset=scrollPoint;
        
        return NO;
    }
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    
    
    if(![motheridarr_textRelated containsObject:[NSString stringWithFormat:@"%ld",textView.tag]] && textView.tag!=0)
    {
       // NSLog(@".............");
        
        [motheridarr_textRelated addObject:[NSString stringWithFormat:@"%ld",textView.tag]];
        [textContainerArr addObject:[NSString stringWithFormat:@"%@@/%@",[NSString stringWithFormat:@"%ld",textView.tag],textView.text]];
    }
    else
    {
        if(textView.tag!=0)
        {
        
          [textContainerArr replaceObjectAtIndex:[motheridarr_textRelated indexOfObject:[NSString stringWithFormat:@"%ld",textView.tag]] withObject:[NSString stringWithFormat:@"%@@/%@",[NSString stringWithFormat:@"%ld",textView.tag],textView.text]];
            
        }
        
    }
    
    [textContainerDic setValue:textContainerArr forKey:[NSString stringWithFormat:@"%ld",textView.superview.tag]];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    UIView *superView=textField.superview;
    
    UIView *superView1=textField.superview.superview;
   
   
    
    scrollPoint=basic_scrollView.contentOffset;
    
    [UIView animateWithDuration:0.3 animations:^{
  
      if(textField!=basic_nameField)
      {
          
          if(textField==basic_quntityField)
          {
             if(productBaseView.bounds.size.height>0 || serviceBaseView.bounds.size.height>0)
                 basic_scrollView.contentOffset=CGPointMake(0, superView.frame.origin.y+textField.frame.origin.y-(textField.frame.size.height*4));
          
          }
        else
        {
            if(textField.tag>0)
            {
            
                 basic_scrollView.contentOffset=CGPointMake(0, superView1.frame.origin.y+superView.frame.origin.y+textField.frame.origin.y-(textField.frame.size.height));
                
                NSLog(@"here....>");
            
            }
            else
            {
         basic_scrollView.contentOffset=CGPointMake(0, superView.frame.origin.y+textField.frame.origin.y-(textField.frame.size.height*4));
            
//                if(textField==basic_keywordField)
//                {
//                    NSLog(@"here....");
//                    [self gettingAllKeyword];
//                    
//                }
//            
            
            }
            
            }
          
      }

    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
   
    [UIView animateWithDuration:0.3 animations:^{
        
         basic_scrollView.contentOffset=scrollPoint;
        
    }];
    
     return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{


    if(!(textField==basic_quntityField || textField==basic_nameField || textField==basic_videoField))
    {
        
        if(![motheridarr_textRelated containsObject:[NSString stringWithFormat:@"%ld",textField.tag]] && textField.tag!=0)
        {
            NSLog(@".............");
            [motheridarr_textRelated addObject:[NSString stringWithFormat:@"%ld",textField.tag]];
            [textContainerArr addObject:[NSString stringWithFormat:@"%@@/%@",[NSString stringWithFormat:@"%ld",textField.tag],textField.text]];
            [textContainerDic setValue:textContainerArr forKey:[NSString stringWithFormat:@"%ld",textField.superview.tag]];
        }
        else
        {
            if(textField.tag!=0)
            {
            
              [textContainerArr replaceObjectAtIndex:[motheridarr_textRelated indexOfObject:[NSString stringWithFormat:@"%ld",textField.tag]] withObject:[NSString stringWithFormat:@"%@@/%@",[NSString stringWithFormat:@"%ld",textField.tag],textField.text]];
                
                [textContainerDic setValue:textContainerArr forKey:[NSString stringWithFormat:@"%ld",textField.superview.tag]];
            }
            
        }
        
        
        
    }

    
    return YES;

}


#pragma mark--Creating other type of views

-(void)createOtherViewsOnView:(UIView *)baseview withTag:(int)tag
{

  NSString  *url=[NSString stringWithFormat:@"%@app_sub_category?userid=%@&top_cat=%@&category_id=%d",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],basic_categoryBtn.titleLabel.text,tag];
    
    globalobj=[[FW_JsonClass alloc]init];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"Other type of views dictionary.... %@",result);
        otherViewsArray=[result valueForKey:@"infoarray"];
        otherViewsDic=(NSDictionary *)result;
        
       // aminities_status
        
    if(otherViewsArray.count>0)
    {
        
        UIView *otherViewContainer=[UIView new];
        
        otherViewContainer.frame=CGRectMake(0, currentlyTappedBtn.frame.origin.y+currentlyTappedBtn.frame.size.height+8, self.view.bounds.size.width,0);
        [baseview addSubview:otherViewContainer];
        otherViewContainer.backgroundColor=[UIColor yellowColor];
        otherViewContainer.tag=tag;
        
        float updated_y=0;
        
        for (int i=0; i<otherViewsArray.count; i++)
        {
            
            NSDictionary *tempDic=otherViewsArray[i];
            
            NSString *typeCheck=[tempDic valueForKey:@"option_type"];
            
            if([typeCheck isEqualToString:@"textarea"])
            {
            
                UILabel *headingLabl=[UILabel new];
                headingLabl.frame=CGRectMake(basic_categoryBtn.frame.origin.x, updated_y, 200, 20);
                headingLabl.textColor=[UIColor darkGrayColor];
                headingLabl.text=[NSString stringWithFormat:@"%@ :",[tempDic valueForKey:@"option_name"]];
                headingLabl.font=[UIFont fontWithName:@"Lato" size:16];
                
                [otherViewContainer addSubview:headingLabl];
       
                
                UITextView *textArea=[UITextView new];
                textArea.tag=[[tempDic valueForKey:@"option_id"] intValue];
                textArea.frame=CGRectMake(basic_categoryBtn.frame.origin.x, headingLabl.frame.origin.y+headingLabl.frame.size.height+4, basic_categoryBtn.bounds.size.width, 100);
                textArea.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input_back"]];
                textArea.delegate=self;
                textArea.autocorrectionType=UITextAutocorrectionTypeNo;
                textArea.keyboardAppearance=UIKeyboardAppearanceDark;
                
                
                updated_y=textArea.bounds.size.height+textArea.frame.origin.y+4;
                
                otherViewContainer.frame=CGRectMake(otherViewContainer.frame.origin.x, otherViewContainer.frame.origin.y, otherViewContainer.bounds.size.width,updated_y);
                
                [otherViewContainer addSubview:textArea];
            
            }
           else if([typeCheck isEqualToString:@"text"])
            {
        
                UITextField *textField=[UITextField new];
                textField.tag=[[tempDic valueForKey:@"option_id"] intValue];
                textField.frame=CGRectMake(basic_categoryBtn.frame.origin.x, updated_y, basic_categoryBtn.bounds.size.width, basic_quntityField.bounds.size.height);
                textField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input_back"]];
                textField.font=basic_quntityField.font;
                textField.placeholder=[NSString stringWithFormat:@"%@",[tempDic valueForKey:@"option_name"]];
                textField.delegate=self;
                
                UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 6)];
                textField.leftView = paddingView;
                textField.leftViewMode = UITextFieldViewModeAlways;
                
                
                textField.autocorrectionType=UITextAutocorrectionTypeNo;
                textField.keyboardAppearance=UIKeyboardAppearanceDark;
                
                
                updated_y=textField.bounds.size.height+textField.frame.origin.y+8;
                
                otherViewContainer.frame=CGRectMake(otherViewContainer.frame.origin.x, otherViewContainer.frame.origin.y, otherViewContainer.bounds.size.width,updated_y);
                
                [otherViewContainer addSubview:textField];
                
            }
            
            
            else  if([typeCheck isEqualToString:@"select"] || [typeCheck isEqualToString:@"radio"])
            {
                
                specialButton *selectOrRadioBtnOpeningBtn=selectOrRadioBtnOpeningBtn=[[specialButton alloc]init];
                selectOrRadioBtnOpeningBtn.frame=CGRectMake(basic_categoryBtn.frame.origin.x, updated_y, basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
                [selectOrRadioBtnOpeningBtn setTitle:[NSString stringWithFormat:@"%@",[tempDic valueForKey:@"option_name"]] forState:UIControlStateNormal];
                selectOrRadioBtnOpeningBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                selectOrRadioBtnOpeningBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
                selectOrRadioBtnOpeningBtn.titleLabel.font=basic_categoryBtn.titleLabel.font;
                [selectOrRadioBtnOpeningBtn setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
                [selectOrRadioBtnOpeningBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
                
                [selectOrRadioBtnOpeningBtn addTarget:self action:@selector(openRadioBtnListOrSelectlist:) forControlEvents:UIControlEventTouchUpInside];
                
                selectOrRadioBtnOpeningBtn.tag=[[tempDic valueForKey:@"option_id"] intValue];
                
                if([typeCheck isEqualToString:@"select"])
                {
                  selectOrRadioBtnOpeningBtn.stringId=[NSString stringWithFormat:@"select"];
                    selectOrRadioBtnOpeningBtn.tag=[[tempDic valueForKey:@"option_id"] intValue];
                    
//                    selectListArray=[tempDic valueForKey:[NSString stringWithFormat:@"%ld",selectOrRadioBtnOpeningBtn.tag]];
                    
                }
                else  if([typeCheck isEqualToString:@"radio"])
                {
                
                    selectOrRadioBtnOpeningBtn.stringId=[NSString stringWithFormat:@"radio"];
                    
                     selectOrRadioBtnOpeningBtn.tag=[[tempDic valueForKey:@"option_id"] intValue];
                    
                    
//                    radioBtnListArray=[tempDic valueForKey:[NSString stringWithFormat:@"%ld",selectOrRadioBtnOpeningBtn.tag]];
                
                }
                
                
                [otherViewContainer addSubview:selectOrRadioBtnOpeningBtn];
                
                UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, selectOrRadioBtnOpeningBtn.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
                dropdownArrow.image=[UIImage imageNamed:@"downArrow"];
                dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
                
                
                dropdownArrow.tag=[[tempDic valueForKey:@"option_id"] intValue];
                
                [otherViewContainer addSubview:dropdownArrow];
                
                updated_y=selectOrRadioBtnOpeningBtn.bounds.size.height+selectOrRadioBtnOpeningBtn.frame.origin.y+8;
                
                otherViewContainer.frame=CGRectMake(otherViewContainer.frame.origin.x, otherViewContainer.frame.origin.y, otherViewContainer.bounds.size.width,updated_y);
                
            }
            
            else  if([typeCheck isEqualToString:@"checkbox"])
            {
                
                specialButton *checkboxOpeningBtn=checkboxOpeningBtn=[[specialButton alloc]init];
                
                checkboxOpeningBtn.frame=CGRectMake(basic_categoryBtn.frame.origin.x, updated_y, basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
                
                [checkboxOpeningBtn setTitle:[NSString stringWithFormat:@"%@",[tempDic valueForKey:@"option_name"]] forState:UIControlStateNormal];
                
                checkboxOpeningBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                checkboxOpeningBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
                checkboxOpeningBtn.titleLabel.font=basic_categoryBtn.titleLabel.font;
                [checkboxOpeningBtn setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
                [checkboxOpeningBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
                
                [checkboxOpeningBtn addTarget:self action:@selector(openCheckBoxList:) forControlEvents:UIControlEventTouchUpInside];
                
                checkboxOpeningBtn.tag=[[tempDic valueForKey:@"option_id"] intValue];
                
               
                    checkboxOpeningBtn.stringId=[NSString stringWithFormat:@"check"];
                    checkboxOpeningBtn.tag=[[tempDic valueForKey:@"option_id"] intValue];
                
                
                [otherViewContainer addSubview:checkboxOpeningBtn];
                
                UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, checkboxOpeningBtn.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
                dropdownArrow.image=[UIImage imageNamed:@"downArrow"];
                dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
                
                
                dropdownArrow.tag=[[tempDic valueForKey:@"option_id"] intValue];
                
                [otherViewContainer addSubview:dropdownArrow];
                
                updated_y=checkboxOpeningBtn.bounds.size.height+checkboxOpeningBtn.frame.origin.y+8;
                
                otherViewContainer.frame=CGRectMake(otherViewContainer.frame.origin.x, otherViewContainer.frame.origin.y, otherViewContainer.bounds.size.width,updated_y);
                
            }
            
           
            
            
            
            
        }
        if([[otherViewsDic valueForKey:@"aminities_status"] isEqualToString:@"Y"])
        {
            
            for(NSDictionary *dic in [otherViewsDic valueForKey:@"aminities"])
            {
                
                aminitiesFragDic=[NSMutableDictionary new];
                [aminitiesFragDic setValue:[dic valueForKey:@"aminities_id"] forKey:@"id"];
                [aminitiesFragDic setValue:[dic valueForKey:@"aminities_name"] forKey:@"name"];
                [aminitiesFragDic setValue:@"no" forKey:@"checked"];
                [aminitiesArr addObject:aminitiesFragDic];
                
            }
            
            
            
            specialButton *aminitiesOpeningBtn=[[specialButton alloc]init];
            
            aminitiesOpeningBtn.frame=CGRectMake(basic_categoryBtn.frame.origin.x, updated_y, basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
            
            [aminitiesOpeningBtn setTitle:[NSString stringWithFormat:@"Aminities"] forState:UIControlStateNormal];
            
            aminitiesOpeningBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            aminitiesOpeningBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
            aminitiesOpeningBtn.titleLabel.font=basic_categoryBtn.titleLabel.font;
            [aminitiesOpeningBtn setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
            [aminitiesOpeningBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
            
            [aminitiesOpeningBtn addTarget:self action:@selector(openAminitiesList:) forControlEvents:UIControlEventTouchUpInside];
            
            aminitiesOpeningBtn.stringId=[NSString stringWithFormat:@"aminities"];
            
            
            [otherViewContainer addSubview:aminitiesOpeningBtn];
            
            UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, aminitiesOpeningBtn.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
            dropdownArrow.image=[UIImage imageNamed:@"downArrow"];
            dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
            
            
           // dropdownArrow.tag=[[tempDic valueForKey:@"option_id"] intValue];
            
            [otherViewContainer addSubview:dropdownArrow];
            
            updated_y=aminitiesOpeningBtn.bounds.size.height+aminitiesOpeningBtn.frame.origin.y+8;
            
            otherViewContainer.frame=CGRectMake(otherViewContainer.frame.origin.x, otherViewContainer.frame.origin.y, otherViewContainer.bounds.size.width,updated_y);
            
            
        }
        
        
        baseview.frame=CGRectMake(baseview.frame.origin.x, baseview.frame.origin.y, baseview.frame.size.width, baseview.frame.size.height+otherViewContainer.frame.size.height+8);
        
        [catgoryBtnTags addObject:[NSString stringWithFormat:@"%d",tag]];
        
        basic_bottomView.frame=CGRectMake(basic_bottomView.frame.origin.x, baseview.frame.origin.y+baseview.frame.size.height+8, basic_bottomView.frame.size.width, basic_bottomView.frame.size.height);
        
        basic_scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, basic_bottomView.frame.size.height+basic_bottomView.frame.origin.y);
        
    
    }
    
    else
    {
    
       // Do nothing
    
    }
        
        
        
        
        
        }];
        
}

#pragma mark--


#pragma mark--Aminities list 

-(void)openAminitiesList:(specialButton *)sender
{
    
    whichspecialButtonTapped=sender.stringId;
    
    
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(basic_categoryBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2, basic_categoryBtn.frame.size.width, self.view.bounds.size.height/3.2);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"%@",[whichspecialButtonTapped capitalizedString]];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*12))/2, 7, tempStrHeading.length*12,self.view.bounds.size.height/19);
    categorHeadingLbl.textAlignment=NSTextAlignmentCenter;
    
    categorHeadingLbl.text=tempStrHeading;
    [popUpBaseView addSubview:categorHeadingLbl];
    
    UIImageView *dividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    
    dividerView.frame=CGRectMake(0, categorHeadingLbl.frame.size.height+categorHeadingLbl.frame.origin.y+5, popUpBaseView.bounds.size.width, 1);
    
    
    [popUpBaseView addSubview:dividerView];
    
    
    basic_categoryTable.delegate=self;
    basic_categoryTable.dataSource=self;
    basic_categoryTable.tag=0;
    
    basic_categoryTable.frame=CGRectMake(5, dividerView.frame.size.height+dividerView.frame.origin.y+4, popUpBaseView.frame.size.width-10, popUpBaseView.frame.size.height-(dividerView.frame.size.height+dividerView.frame.origin.y+54));
    
    [popUpBaseView addSubview:basic_categoryTable];
    
    
    
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
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
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

#pragma mark--

#pragma mark--Check box list opening function

-(void)openCheckBoxList:(specialButton *)sender
{
    
    tappedButton_special=sender;
    whichspecialButtonTapped=sender.stringId;
    
    //    NSLog(@"String ID---> %@",sender.stringId);
    //    NSLog(@"Select list Array count---> %ld",selectListArray.count);
    //    NSLog(@"Radio list Array count---> %ld",radioBtnListArray.count);
    
    
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(basic_categoryBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2, basic_categoryBtn.frame.size.width, self.view.bounds.size.height/3.2);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"%@",[whichspecialButtonTapped capitalizedString]];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*12))/2, 7, tempStrHeading.length*12,self.view.bounds.size.height/19);
    categorHeadingLbl.textAlignment=NSTextAlignmentCenter;
    
    categorHeadingLbl.text=tempStrHeading;
    [popUpBaseView addSubview:categorHeadingLbl];
    
    UIImageView *dividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    
    dividerView.frame=CGRectMake(0, categorHeadingLbl.frame.size.height+categorHeadingLbl.frame.origin.y+5, popUpBaseView.bounds.size.width, 1);
    
    
    [popUpBaseView addSubview:dividerView];
    
    
    
    for (int i=0; i<otherViewsArray.count; i++)
    {
        
        NSDictionary *tempDic=otherViewsArray[i];
        if([[tempDic valueForKey:@"option_id"] isEqualToString:[NSString stringWithFormat:@"%ld",sender.tag]])
        {
            if ([whichspecialButtonTapped isEqualToString:@"check"])
            {
                
                checkListArray=[tempDic valueForKey:@"option_value"];
                
            }
        }
        
    }
    
    
    //    UITableView *table_view=[[UITableView alloc]init];
    
    
    basic_categoryTable.delegate=self;
    basic_categoryTable.dataSource=self;
    basic_categoryTable.tag=0;
    
    basic_categoryTable.frame=CGRectMake(5, dividerView.frame.size.height+dividerView.frame.origin.y+4, popUpBaseView.frame.size.width-10, popUpBaseView.frame.size.height-(dividerView.frame.size.height+dividerView.frame.origin.y+54));
    
    [popUpBaseView addSubview:basic_categoryTable];
    
    // table_view.hidden=YES;
    
    
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
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
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

#pragma mark--

#pragma mark-- Radio Button / Select List opening Function

-(void)openRadioBtnListOrSelectlist:(specialButton *)sender
{
    
    tappedButton_special=sender;
    whichspecialButtonTapped=sender.stringId;
    
//    NSLog(@"String ID---> %@",sender.stringId);
//    NSLog(@"Select list Array count---> %ld",selectListArray.count);
//    NSLog(@"Radio list Array count---> %ld",radioBtnListArray.count);
    
    
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(basic_categoryBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2, basic_categoryBtn.frame.size.width, self.view.bounds.size.height/3.2);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"%@",[whichspecialButtonTapped capitalizedString]];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*8))/2, 7, tempStrHeading.length*8,self.view.bounds.size.height/19);
    categorHeadingLbl.textAlignment=NSTextAlignmentCenter;
    
    categorHeadingLbl.text=tempStrHeading;
    [popUpBaseView addSubview:categorHeadingLbl];
    
    UIImageView *dividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    
    dividerView.frame=CGRectMake(0, categorHeadingLbl.frame.size.height+categorHeadingLbl.frame.origin.y+5, popUpBaseView.bounds.size.width, 1);
    
    
    [popUpBaseView addSubview:dividerView];
 

    
        for (int i=0; i<otherViewsArray.count; i++)
        {
            
            NSDictionary *tempDic=otherViewsArray[i];
            if([[tempDic valueForKey:@"option_id"] isEqualToString:[NSString stringWithFormat:@"%ld",sender.tag]])
            {
                if ([whichspecialButtonTapped isEqualToString:@"select"])
                {
                 
                    selectListArray=[tempDic valueForKey:@"option_value"];
               
                }else if ([whichspecialButtonTapped isEqualToString:@"radio"])
                {
                    radioBtnListArray=[tempDic valueForKey:@"option_value"];
                }
            }
            
        }
    
    
//    UITableView *table_view=[[UITableView alloc]init];
    
    
    basic_categoryTable.delegate=self;
    basic_categoryTable.dataSource=self;
    basic_categoryTable.tag=0;
    
    basic_categoryTable.frame=CGRectMake(5, dividerView.frame.size.height+dividerView.frame.origin.y+4, popUpBaseView.frame.size.width-10, popUpBaseView.frame.size.height-(dividerView.frame.size.height+dividerView.frame.origin.y+54));
    
    [popUpBaseView addSubview:basic_categoryTable];
    
   // table_view.hidden=YES;
    
    
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
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
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

#pragma mark--

#pragma mark--Sub category button creating function


-(void)createSubCategoryButtonOnView:(UIView *)baseview fromTag:(int)tag
{
    
    
    UIButton *subCategoryBtn=[UIButton new];
    
    if([baseview isEqual:productBaseView])
    {
    subCategoryBtn.frame=CGRectMake(basic_categoryBtn.frame.origin.x, baseview.frame.size.height+8,basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
    }
    else if ([baseview isEqual:serviceBaseView])
    {
        //NSLog(@"View height---> %f || Origin Y---> %f",);
    
        subCategoryBtn.frame=CGRectMake(basic_categoryBtn.frame.origin.x, currentlyTappedBtn.frame.origin.y+currentlyTappedBtn.bounds.size.height+8,basic_categoryBtn.frame.size.width, basic_categoryBtn.frame.size.height);
    
    }
    
    
    [subCategoryBtn setTitle:@"Other Category" forState:UIControlStateNormal];
    subCategoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    subCategoryBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
    subCategoryBtn.titleLabel.font=basic_categoryBtn.titleLabel.font;
    [subCategoryBtn setTitleColor:basic_categoryBtn.titleLabel.textColor forState:UIControlStateNormal];
    [subCategoryBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
    
   
    
     subCategoryBtn.tag=tag;
    
    tagForBtn_and_Table=tag;
    

    
    //NSLog(@"i--------> %d",tag);
    
    [baseview addSubview:subCategoryBtn];
    
    [subCategoryBtn addTarget:self action:@selector(productMainCategoryTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    updatedY_product+=subCategoryBtn.frame.size.height+8;
    updatedY_service+=subCategoryBtn.frame.size.height+8;
    
    UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(dropdownImageView.frame.origin.x, subCategoryBtn.frame.origin.y+8, dropdownImageView.frame.size.width, dropdownImageView.frame.size.height)];
    dropdownArrow.image=[UIImage imageNamed:@"downArrow"];
    dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
    
    
      dropdownArrow.tag=tag;
    
    [baseview addSubview:dropdownArrow];
    
    
    if([baseview isEqual:productBaseView])
    {
         baseview.frame=CGRectMake(baseview.frame.origin.x, baseview.frame.origin.y, baseview.frame.size.width, updatedY_product);
    }
    else if ([baseview isEqual:serviceBaseView])
    {
        
         baseview.frame=CGRectMake(baseview.frame.origin.x, baseview.frame.origin.y, baseview.frame.size.width, subCategoryBtn.frame.origin.y+subCategoryBtn.frame.size.height);
    }

    
   
    
    
    
    basic_bottomView.frame=CGRectMake(basic_bottomView.frame.origin.x, baseview.frame.origin.y+baseview.frame.size.height+8, basic_bottomView.frame.size.width, basic_bottomView.frame.size.height);
    
    basic_scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, basic_bottomView.frame.size.height+basic_bottomView.frame.origin.y);
    
    
}

#pragma mark--


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



- (IBAction)basic_instant_yesTapped:(id)sender
{
    

    if([[basic_instant_yes backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"check_off_category"]])
    {
        //NSLog(@"yes tapped");
        [basic_instant_yes setBackgroundImage:[UIImage imageNamed:@"check_on_category"] forState:UIControlStateNormal];
        [basic_instant_no setBackgroundImage:[UIImage imageNamed:@"check_off_category"] forState:UIControlStateNormal];
        
        instantBooked=@"yes";
    }

}
- (IBAction)basic_instant_noTapped:(id)sender
{

   
    
      if([[basic_instant_no backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"check_off_category"]])
    {
        // NSLog(@"no tapped");
        [basic_instant_no setBackgroundImage:[UIImage imageNamed:@"check_on_category"] forState:UIControlStateNormal];
        [basic_instant_yes setBackgroundImage:[UIImage imageNamed:@"check_off_category"] forState:UIControlStateNormal];
        
        instantBooked=@"no";
    }

}

#pragma mark-- Save Basic Details


-(IBAction)save:(UIButton *)sender
{
    
    NSLog(@"text container----> %@",textContainerDic);
    
    if(![[NSString stringByTrimmingLeadingWhitespace:basic_nameField.text] length]>0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enter a valid name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        
        if([basic_categoryBtn.titleLabel.text isEqualToString:@"Choose Category"])
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Select the Basic category." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
        else
        {
            
            
            if([basic_categoryBtn.titleLabel.text isEqualToString:@"Product"])
            {
                
                if([mainCategoryBtn_product.titleLabel.text isEqualToString:@"Main Category"])
                {
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Select the Main category." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                }
                else
                {
                    
                    if(![[NSString stringByTrimmingLeadingWhitespace:basic_quntityField.text] length]>0)
                    {
                        
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enter quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        
                    }
                    else
                    {
                        
                        NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
                        NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:basic_quntityField.text];
                        
                        if (![_NumericOnly isSupersetOfSet: myStringSet])
                        {
                            
                            
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enter proper quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            
                        }
                        else
                        {
                            
                            if([instantBooked length]>0)
                            {
                                
                                [self saveBasicDetails];
                                
                            }
                            else
                            {
                                
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please select instant booking type." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                [alert show];
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                }
                
            }
            else if([basic_categoryBtn.titleLabel.text isEqualToString:@"Service"])
            {
                
                if([maninCategoryBtn_service.titleLabel.text isEqualToString:@"Main Category"])
                {
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Select the Main category." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                }
                else
                {
                    
                    if(![[NSString stringByTrimmingLeadingWhitespace:basic_quntityField.text] length]>0)
                    {
                        
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enter quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        
                    }
                    else
                    {
                        
                        NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
                        NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:basic_quntityField.text];
                        
                        if (![_NumericOnly isSupersetOfSet: myStringSet])
                        {
                            
                            
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enter proper quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            
                        }
                        else
                        {
                            
                            if([instantBooked length]>0)
                            {
                                
                                [self saveBasicDetails];
                                
                            }
                            else
                            {
                                
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please select instant booking type." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                [alert show];
                                
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    
}



-(void)saveBasicDetails
{

    UIButton *whichMainCAtBtnIsThere;
    NSString *mainCatStr;
    
    if(productBaseView.bounds.size.height>0)
    {
        whichMainCAtBtnIsThere=mainCategoryBtn_product;
        mainCatStr=whichMainCAtBtnIsThere.titleLabel.text;
    }
    if(serviceBaseView.bounds.size.height>0)
    {
        whichMainCAtBtnIsThere=maninCategoryBtn_service;
        mainCatStr=whichMainCAtBtnIsThere.titleLabel.text;
    }
    
    for (int i=0; i<mainCategoryList.count; i++) {
        
        if([[[mainCategoryList objectAtIndex:i] valueForKey:@"cat_name"] isEqualToString:mainCatStr])
        {
            
            mainCategoryId=[[mainCategoryList objectAtIndex:i] valueForKey:@"id"];
            NSLog(@"%@ ----- %@",[[mainCategoryList objectAtIndex:i] valueForKey:@"cat_name"],mainCategoryId);
            
        }
        
        
    }

  
//    NSLog(@"text container----> %@",textContainerDic);
//    NSLog(@"Check BOX---> %@",checkboxDic);
//    NSLog(@"Sub cat details---> %@",subCatDictionary);
//    NSLog(@"select list details---> %@",selectListDic);
    
    NSArray *textParameterContainer=[NSArray new];
    NSString *textFieldsValue=@"";
    
    if([textContainerDic count]>0)
    {
        
        NSArray* keys_select = [textContainerDic allKeys];
        
        for(NSString* key in keys_select) {
            //NSLog(@"Select---> %@",[textContainerDic valueForKey:key]);
            textParameterContainer=[textContainerDic valueForKey:key];
        }
        if(textParameterContainer.count>0)
        {
         textFieldsValue=[textParameterContainer componentsJoinedByString:@"@@"];
        }
    }
    
    
    
    NSString *subcategory=@"";
    if([subCatDictionary count]>0)
    {
    
        NSArray* keys_select = [subCatDictionary allKeys];
        
        for(NSString* key in keys_select) {
           // NSLog(@"Select---> %@",[subCatDictionary valueForKey:key]);
            if(subcategory.length>0)
            {
            
               subcategory = [subcategory stringByAppendingString:[NSString stringWithFormat:@"/%@",[subCatDictionary valueForKey:key]]];
            
            }
            else
            {
            
            subcategory = [subcategory stringByAppendingString:[NSString stringWithFormat:@"%@",[subCatDictionary valueForKey:key]]];
            
            }
        }
    
    }
    
    NSString *checkBoxStr=@"";
    if([checkboxDic count]>0)
    {
        
        NSArray* keys_select = [checkboxDic allKeys];
        
        for(NSString* key in keys_select) {
           // NSLog(@"Select---> %@",[checkboxDic valueForKey:key]);
            
            checkBoxStr = [NSString stringWithFormat:@"%@",[[checkboxDic valueForKey:key] componentsJoinedByString:@","]];
//            if(checkBoxStr.length>0)
//            {
//                
//                checkBoxStr = [checkBoxStr stringByAppendingString:[NSString stringWithFormat:@",%@",[checkboxDic valueForKey:key]]];
//                
//            }
//            else
//            {
//                
//                checkBoxStr = [checkBoxStr stringByAppendingString:[NSString stringWithFormat:@"%@",[checkboxDic valueForKey:key]]];
//                
//            }
        }
        
    }
    
    NSString *radioStr=@"";
    if([radioListDic count]>0)
    {
        
        NSArray* keys_select = [radioListDic allKeys];
        
        for(NSString* key in keys_select) {
            NSLog(@"Select---> %@",[radioListDic valueForKey:key]);
            
               radioStr = [NSString stringWithFormat:@"%@",[[radioListDic valueForKey:key] componentsJoinedByString:@","]];
          
        }
        
    }
    
    NSString *selectStr=@"";
    if([selectListDic count]>0)
    {
        
        NSArray* keys_select = [selectListDic allKeys];
        
        for(NSString* key in keys_select) {
            //NSLog(@"Select---> %@",[selectListDic valueForKey:key]);
   
                selectStr = [NSString stringWithFormat:@"%@",[[selectListDic valueForKey:key] componentsJoinedByString:@","]];
  
        }
        
    }

    
    NSMutableArray *aminitiesID=[[NSMutableArray alloc]init];
    NSMutableArray *keywordID=[[NSMutableArray alloc]init];
    
    if(aminitiesArr.count>0)
    {
    
       for(NSDictionary *dic in aminitiesArr)
       {
       
         if([[dic valueForKey:@"checked"] isEqualToString:@"yes"])
         {
         
             [aminitiesID addObject:[dic valueForKey:@"id"]];
         
         }
       
       }
        
        NSLog(@"Aminities---> %@",[aminitiesID componentsJoinedByString:@","]);
    
    }
    if(keywordArr.count>0)
    {
        
        for(NSDictionary *dic in keywordArr)
        {
            
            if([[dic valueForKey:@"selected"] isEqualToString:@"yes"])
            {
                
                [keywordID addObject:[dic valueForKey:@"id"]];
                
            }
            
        }
        
         NSLog(@"Keyword---> %@",[keywordID componentsJoinedByString:@","]);
        
    }

    NSString *urlString=[NSString stringWithFormat:@"%@app_service_insert",App_Domain_Url];
    NSString *postData;
    
    if(productBaseView.bounds.size.height>0)
    {
    
        postData=[NSString stringWithFormat:@"userid=%@&srv_name=%@&cat_type=%@&book_type=&main_cat=%@&sub_cat=%@&quantity=%@&keyword=%@&video=%@&instant_book=%@&amen_arr=%@&option_value_chk=%@&option_value_radio=%@&option_value_select=%@&option_value_other=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],basic_nameField.text,basic_categoryBtn.titleLabel.text,mainCategoryId,subcategory,basic_quntityField.text,[keywordID componentsJoinedByString:@","],basic_videoField.text,instantBooked,[aminitiesID componentsJoinedByString:@","],checkBoxStr,radioStr,selectStr,textFieldsValue];

        NSLog(@"post data product---%@",postData);
    
    }
    else if(serviceBaseView.bounds.size.height>0)
    {
        NSLog(@"-----> %@ ",service_bookingTypeBtn.titleLabel.text);
        
        NSString *bookingType=@"";
        
        if(![service_bookingTypeBtn.titleLabel.text isEqualToString:@"Booking Type"])
        {
        
            if ([service_bookingTypeBtn.titleLabel.text isEqualToString:@"Per Day"])
            {
                bookingType=@"per_day";
            }
            else if([service_bookingTypeBtn.titleLabel.text isEqualToString:@"Slot"])
            {
                bookingType=@"slot";

            }
            
        }
        
        
          postData =[NSString stringWithFormat:@"userid=%@&srv_name=%@&cat_type=%@&book_type=%@&main_cat=%@&sub_cat=%@&quantity=%@&keyword=%@&video=%@&instant_book=%@&amen_arr=%@&option_value_chk=%@&option_value_radio=%@&option_value_select=%@&option_value_other=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],basic_nameField.text,[basic_categoryBtn.titleLabel.text lowercaseString],bookingType,mainCategoryId,subcategory,basic_quntityField.text,[keywordID componentsJoinedByString:@","],basic_videoField.text,instantBooked,[aminitiesID componentsJoinedByString:@","],checkBoxStr,radioStr,selectStr,textFieldsValue];
        
        NSLog(@"post data service---%@",postData);
        
    }

  NSLog(@"URL---> %@",urlString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"POST"];
    
    
   
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalobj GlobalDict_post:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
          NSLog(@"Save result----> %@",result);
        
        if([[result valueForKey:@"response"] isEqualToString:@"success"])
        {
        
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        
        }
        
    }];
    
    
}

#pragma mark--

#pragma mark-Getting Keyword List


- (IBAction)keywordBtnTapped:(id)sender
{
    if(keywordArr.count==0)
    {
        [self gettingAllKeyword];
    }
    else if (keywordArr.count>0)
    {
        
        [self openKeywordtable];
        
    }
    
}


-(void)gettingAllKeyword
{
    
    NSLog(@"clicked..");
    
    NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_keyword_list",App_Domain_Url];
    
    globalobj=[[FW_JsonClass alloc]init];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        if([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            
            NSMutableArray *infoarray = [[result valueForKey:@"info"] mutableCopy];
            
            if (infoarray.count>0)
            {
                if(keywordArr.count>0)
                {
                    [keywordArr removeAllObjects];
                
                }
                
                for (int i=0; i<infoarray.count; i++)
                {
                    
                    NSString *key_idTemp = [NSString stringWithFormat:@"%@",[infoarray[i]valueForKey:@"id"]];
                    NSString *key_nameTemp = [NSString stringWithFormat:@"%@",[infoarray[i]valueForKey:@"name"]];
                    
                    keyWordFragDic=[NSMutableDictionary new];
                    [keyWordFragDic setValue:key_idTemp forKey:@"id"];
                    [keyWordFragDic setValue:key_nameTemp forKey:@"name"];
                    [keyWordFragDic setValue:@"no" forKey:@"selected"];
                    [keywordArr addObject:keyWordFragDic];

                }
                NSLog(@"keywords---> %@",keywordArr);
                
                if(keywordArr.count>0)
                {
                
                    [self openKeywordtable];
                
                }

            }
         }
        
    }];
    
}

#pragma mark--

#pragma mark--Opening Keyword Listing

-(void)openKeywordtable
{
    iskeyWordTableOpen=@"yes";
    
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(basic_categoryBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/1.5)/2, basic_categoryBtn.frame.size.width, self.view.bounds.size.height/1.5);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"Keyword"];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*12))/2, 7, tempStrHeading.length*12,self.view.bounds.size.height/19);
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
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
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

#pragma mark--


@end
