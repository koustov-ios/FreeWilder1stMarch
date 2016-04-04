//
//  FWCalendarViewController.m
//  FreeWilder
//
//  Created by Koustov Basu on 28/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import "FWCalendarViewController.h"
#import "calender_View.h"
#import "perDayCalendar.h"

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
#import "accountsubview.h"
#import "WishlistViewController.h"
#import "ViewController.h"
#import "sideMenu.h"
#import "FWManageHolidaysViewController.h"


@interface FWCalendarViewController ()<UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{

    perDayCalendar *perDayCalenderView;
    
    NSArray *slotArray,*timezoneArr;
    
    __weak IBOutlet UIButton *manageHolidaysBtn;
    __weak IBOutlet UIButton *saveBtn;
    __weak IBOutlet UIButton *calendarBtn;
    
    __weak IBOutlet UIView *mainView;
    
    __weak IBOutlet UIView *slottimeAndTimezoneView;
    
    __weak IBOutlet UIButton *slotTimeBtn;
    
    __weak IBOutlet UIButton *timeZoneBtn;
    
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

@implementation FWCalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    start_Date=@"";
    end_Date=@"";
    
    singleChecked=YES;
    slotValueSelected=NO;
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [timeZoneBtn setTitle:[timeZone name] forState:UIControlStateNormal];
    
    saveBtn.hidden=YES;
    manageHolidaysBtn.hidden=YES;
    manageHolidaysBtn.enabled=NO;
    
    globalobj=[FW_JsonClass new];
    
    timeSelected=@"00:00";
    whichTableOpen=@"";

    timezoneArr=[NSArray new];
    openCloseTimeDic=[NSMutableDictionary new];
    breaktimeCheckDic=[NSMutableDictionary new];
    breaktimeValuesDic=[NSMutableDictionary new];
    
    slotArray=[[NSArray alloc]initWithObjects:@"2 minute",@"15 minute",@"30 minute",@"45 minute",@"60 minute",nil];
    
    hours = [[NSArray alloc]initWithObjects:@"00:00",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30", nil];
    
    
    
    weekDaysNameArr=[NSMutableArray new];
    weekDaysNameArr_fixed=[[NSMutableArray alloc]initWithArray:@[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"]];
    headerValuesDic=[NSMutableDictionary new];
    expandBtnDic=[NSMutableDictionary new];
    headerExpanded=NO;
    
    
    if([_productType isEqualToString:@"product"] || [_productType isEqualToString:@"slot"])
    {
        [self createDatePicker];
        [self createCalendarViewsForSlotOrProductType];
    }
    
    else if ([_productType isEqualToString:@"perday"])
    {
        perDayCalenderView=[perDayCalendar new];
        perDayCalenderView.frame=CGRectMake(0, calendarBtn.frame.origin.y+calendarBtn.bounds.size.height+8, self.view.bounds.size.width, manageHolidaysBtn.frame.origin.y-(slottimeAndTimezoneView.frame.origin.y+slottimeAndTimezoneView.frame.size.height+8));
        [mainView addSubview:perDayCalenderView];
        
        [perDayCalenderView.alwsCnfrmdBtn addTarget:self action:@selector(alwsCnfrmdtapped:) forControlEvents:UIControlEventTouchUpInside];
        [perDayCalenderView.specificCnfrmdBtn addTarget:self action:@selector(specificBtntapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    [manageHolidaysBtn addTarget:self action:@selector(manageHolidayTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    endDateBtn.userInteractionEnabled=NO;
    
   
    [self footerCreation];
    
   

}

-(void)alwsCnfrmdtapped:(UIButton *)sender
{

   // sender.enabled=NO;
    perDayCalenderView.specificCnfrmdBtn.enabled=YES;
    perDayCalenderView.alwsCnfrmdIcon.hidden=NO;
    perDayCalenderView.specificCnfrmdIcon.hidden=YES;
    
    saveBtn.hidden=NO;
    manageHolidaysBtn.hidden=NO;
    //[saveBtn addTarget:self action:@selector(saveCalendarDetails) forControlEvents:UIControlEventTouchUpInside];

}
-(void)specificBtntapped:(UIButton *)sender
{

   // sender.enabled=NO;
    perDayCalenderView.alwsCnfrmdBtn.enabled=YES;
    perDayCalenderView.alwsCnfrmdIcon.hidden=YES;
    perDayCalenderView.specificCnfrmdIcon.hidden=NO;
    
    [self createSpecificPopUp];


}

-(void)createSpecificPopUp
{
    
    
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(10, (self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2, self.view.bounds.size.width-20, self.view.bounds.size.height/3.2);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"Select Dates"];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*8))/2, 7, tempStrHeading.length*8,self.view.bounds.size.height/19);
    categorHeadingLbl.textAlignment=NSTextAlignmentCenter;
    
    categorHeadingLbl.text=tempStrHeading;
    [popUpBaseView addSubview:categorHeadingLbl];
    
    UIImageView *dividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    
    dividerView.frame=CGRectMake(0, categorHeadingLbl.frame.size.height+categorHeadingLbl.frame.origin.y+5, popUpBaseView.bounds.size.width, 1);
    
    
    [popUpBaseView addSubview:dividerView];
    
    

    startDateBtn=[UIButton new];
    startDateBtn.frame=CGRectMake(10, dividerView.frame.origin.y+dividerView.bounds.size.height+4,popUpBaseView.bounds.size.width-20, 45);
    if(start_Date.length>0)
    [startDateBtn setTitle:start_Date forState:UIControlStateNormal];
    else
       [startDateBtn setTitle:@"Start Date" forState:UIControlStateNormal];
    startDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    startDateBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
    startDateBtn.titleLabel.font=[UIFont fontWithName:@"Lato" size:15.0f];
    [startDateBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [startDateBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
    
    UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(10+startDateBtn.bounds.size.width-34, startDateBtn.frame.origin.y+8, 28, 29)];
    dropdownArrow.image=[UIImage imageNamed:@"Calendar-50"];
    dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
    
    [popUpBaseView addSubview:startDateBtn];
    [popUpBaseView addSubview:dropdownArrow];
    
    
    endDateBtn=[UIButton new];
    endDateBtn.frame=CGRectMake(10, startDateBtn.frame.origin.y+startDateBtn.bounds.size.height+8,popUpBaseView.bounds.size.width-20, 45);
  
    if(end_Date.length>0)
      [endDateBtn setTitle:end_Date forState:UIControlStateNormal];
    else
      [endDateBtn setTitle:@"End Date" forState:UIControlStateNormal];
    
    endDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    endDateBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
    endDateBtn.titleLabel.font=[UIFont fontWithName:@"Lato" size:15.0f];
    [endDateBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [endDateBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
    endDateBtn.userInteractionEnabled=NO;
    
    UIImageView *dropdownArrow1=[[UIImageView alloc]initWithFrame:CGRectMake(10+startDateBtn.bounds.size.width-34, endDateBtn.frame.origin.y+8, 28, 29)];
    dropdownArrow1.image=[UIImage imageNamed:@"Calendar-50"];
    dropdownArrow1.contentMode=UIViewContentModeScaleAspectFit;
    
    [popUpBaseView addSubview:endDateBtn];
    [popUpBaseView addSubview:dropdownArrow1];
    
    [startDateBtn addTarget:self action:@selector(openDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [endDateBtn addTarget:self action:@selector(openDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *closeBtn=[UIButton new];
    [closeBtn setTitleColor:[UIColor colorWithRed:16.0f/255 green:95.0f/255 blue:250.0f/255 alpha:1] forState:UIControlStateNormal];
    closeBtn.frame=CGRectMake((popUpBaseView.frame.size.width-150)/2, popUpBaseView.frame.size.height-54, 150, 40);
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
    closeBtn.backgroundColor=[UIColor clearColor];
    [popUpBaseView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeCatTable) forControlEvents:UIControlEventTouchUpInside];
    
    
    [blackOverLay addSubview:popUpBaseView];
    
    [break_Table reloadData];
    
    //[break_Table setHidden:NO];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.1];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.2];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
        
        
    }];
    
}


-(void)getthetimezones
{

   //app_category/app_time_zone
    
    NSString *url = [NSString stringWithFormat:@"%@app_category/app_time_zone",App_Domain_Url];
    NSString *encode = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [globalobj GlobalDict:encode Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         if(result)
         {
         
             
             timezoneArr=[result valueForKey:@"name"];
             if(timezoneArr.count>0)
             {
             
               [self createpicker];
             
             }
         
         }
         
     }];

}
- (IBAction)slotTimeClicked:(id)sender
{
    slotClicked=@"yes";
    tappedBtn=(UIButton *)sender;
    [self createpicker];
    
}
- (IBAction)timeZoneClicked:(id)sender
{
    timezoneClicked=@"yes";
    tappedBtn=(UIButton *)sender;
    
    if(timezoneArr.count>0)
    {
    
        [self createpicker];

    
    }
    else
    {
    
        [self getthetimezones];

    }
}

#pragma mark-- Calender creation 


-(void)createCalendarViewsForSlotOrProductType
{

    startDateBtn=[UIButton new];
    startDateBtn.frame=CGRectMake(10, calendarBtn.frame.origin.y+calendarBtn.bounds.size.height+8,self.view.bounds.size.width-20, 45);
    [startDateBtn setTitle:@"Start Date" forState:UIControlStateNormal];
    startDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    startDateBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
    startDateBtn.titleLabel.font=[UIFont fontWithName:@"Lato" size:15.0f];
    [startDateBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [startDateBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
    
    UIImageView *dropdownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(10+startDateBtn.bounds.size.width-34, startDateBtn.frame.origin.y+8, 28, 29)];
    dropdownArrow.image=[UIImage imageNamed:@"Calendar-50"];
    dropdownArrow.contentMode=UIViewContentModeScaleAspectFit;
    
    [mainView addSubview:startDateBtn];
    [mainView addSubview:dropdownArrow];
    
    
    endDateBtn=[UIButton new];
    endDateBtn.frame=CGRectMake(10, startDateBtn.frame.origin.y+startDateBtn.bounds.size.height+8,self.view.bounds.size.width-20, 45);
    [endDateBtn setTitle:@"End Date" forState:UIControlStateNormal];
    endDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    endDateBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 9, 0, 0);
    endDateBtn.titleLabel.font=[UIFont fontWithName:@"Lato" size:15.0f];
    [endDateBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [endDateBtn setBackgroundImage:[UIImage imageNamed:@"input_back"] forState:UIControlStateNormal];
    
    UIImageView *dropdownArrow1=[[UIImageView alloc]initWithFrame:CGRectMake(10+startDateBtn.bounds.size.width-34, endDateBtn.frame.origin.y+8, 28, 29)];
    dropdownArrow1.image=[UIImage imageNamed:@"Calendar-50"];
    dropdownArrow1.contentMode=UIViewContentModeScaleAspectFit;
    
    [mainView addSubview:endDateBtn];
    [mainView addSubview:dropdownArrow1];
    
    [startDateBtn addTarget:self action:@selector(openDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [endDateBtn addTarget:self action:@selector(openDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if([_productType isEqualToString:@"product"])
    {
    
        slottimeAndTimezoneView.frame=CGRectMake(0, endDateBtn.frame.origin.y+endDateBtn.frame.size.height+8, slottimeAndTimezoneView.bounds.size.width, 0);
        
        slottimeAndTimezoneView.hidden=YES;
    
    }
    else
    {
        slottimeAndTimezoneView.hidden=NO;
        slottimeAndTimezoneView.frame=CGRectMake(0, endDateBtn.frame.origin.y+endDateBtn.frame.size.height+8, slottimeAndTimezoneView.bounds.size.width, slottimeAndTimezoneView.bounds.size.height);
    }
    
    CalenderView=[calender_View new];
    CalenderView.frame=CGRectMake(0, slottimeAndTimezoneView.frame.origin.y+slottimeAndTimezoneView.frame.size.height+8, self.view.bounds.size.width, manageHolidaysBtn.frame.origin.y-(slottimeAndTimezoneView.frame.origin.y+slottimeAndTimezoneView.frame.size.height+8));
    CalenderView.tableview.delegate=self;
    CalenderView.tableview.dataSource=self;
    CalenderView.tableview.backgroundColor=[UIColor clearColor];
    CalenderView.tableview.separatorColor=[UIColor clearColor];
    if([_productType isEqualToString:@"product"])
    {
      CalenderView.ifBreakHeaderLbl.hidden=YES;
    }
    [mainView addSubview:CalenderView];
    
    CalenderView.tableview.alpha=0.45f;
    CalenderView.tableview.userInteractionEnabled=NO;

}


-(void)createDatePicker
{

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

}


-(void)openDatePicker:(UIButton *)sender
{
    
    
    tappedBtn=sender;
    
    if([_productType isEqualToString:@"perday"])
    {
      if(!(date_picker.bounds.size.height>0))
      {
      
          [self createDatePicker];

      
      }
      else
      {
        
          [self.view bringSubviewToFront:datePickerView];
        
      }
        sender.userInteractionEnabled=NO;
        
    
    }
    
    if([sender isEqual:startDateBtn])
    {
        
         date_picker.minimumDate=[NSDate date];
         [date_picker setDate:[NSDate date]];
        
    }
 
    
    [UIView animateWithDuration:0.2 animations:^{
        
        if([_productType isEqualToString:@"perday"])
        {
        
            popUpBaseView.frame=CGRectMake(popUpBaseView.frame.origin.x, ((self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2)-80, popUpBaseView.bounds.size.width, popUpBaseView.bounds.size.height);
        
        }
        
        datePickerView.frame=CGRectMake(0, self.view.bounds.size.height-(self.view.bounds.size.height/2.5), self.view.bounds.size.width, self.view.bounds.size.height/2.5);
        
        
    }];
    
    
}


-(void)dateOk:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        if([_productType isEqualToString:@"perday"])
        {
            startDateBtn.userInteractionEnabled=YES;
            endDateBtn.userInteractionEnabled=YES;
            popUpBaseView.frame=CGRectMake(popUpBaseView.frame.origin.x, popUpBaseView.frame.origin.y+80, popUpBaseView.bounds.size.width, popUpBaseView.bounds.size.height);
            
        }
        
        datePickerView.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
    }];
    
    NSDate *myDate = date_picker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"YYYY-MM-dd"];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    NSLog(@"date----> %@",prettyVersion);
    
    
    if(prettyVersion.length>0)
    {
        if([tappedBtn isEqual:startDateBtn])
        {
            startDate=date_picker.date;
            
            date_picker.minimumDate=[date_picker.date dateByAddingTimeInterval:(24*60*60)];
            
            [date_picker setDate:date_picker.minimumDate];
            endDateBtn.userInteractionEnabled=YES;
            
            start_Date=prettyVersion;
            
            
            [startDateBtn setTitle:prettyVersion forState:UIControlStateNormal];
            
           // checkinDate=date_picker.date;
        }
        else if([tappedBtn isEqual:endDateBtn])
        {
           // checkoutDate=date_picker.date;
           [endDateBtn setTitle:prettyVersion forState:UIControlStateNormal];
            
            end_Date=prettyVersion;
        
             endDate=date_picker.date;
            
          if([_productType isEqualToString:@"product"] || [_productType isEqualToString:@"slot"])
          {
          
              CalenderView.tableview.alpha=1.0f;
              CalenderView.tableview.userInteractionEnabled=YES;
              
              NSInteger interval=[endDate timeIntervalSinceDate:startDate]/(24*60*60);
              
              NSDate *fromDate=startDate;
              NSDate *toDate=endDate;
              
              
              NSCalendar *calendar = [NSCalendar currentCalendar];
              [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                           interval:NULL forDate:fromDate];
              [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                           interval:NULL forDate:toDate];
              NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                                         fromDate:startDate toDate:endDate options:0];
              interval=[difference day];
              
              NSLog(@"Days in between %ld    (%@ | %@)",(long)interval,startDate,endDate);
              
              
              [weekDaysNameArr removeAllObjects];
              weekDaysNameArr=[weekDaysNameArr_fixed mutableCopy];
              NSMutableArray *tempWeekDays=[NSMutableArray new];
              
              for(int i=0; i<interval+2; i++)
              {
                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                  dateFormatter.dateFormat=@"EEEE";
                  NSString * dayString = [[dateFormatter stringFromDate:[startDate dateByAddingTimeInterval:(24*60*60*i)]] capitalizedString];
                  NSLog(@"day---> : %@", dayString);
                  if(![tempWeekDays containsObject:dayString])
                  {
                      [tempWeekDays addObject:dayString];
                  }
                  
                  
              }
              
              [weekDaysNameArr removeObjectsInArray:tempWeekDays];
              [weekDaysNameArr_fixed removeObjectsInArray:weekDaysNameArr];
              weekDaysNameArr=weekDaysNameArr_fixed;
              weekDaysNameArr_fixed=[[NSMutableArray alloc]initWithArray:@[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"]];
              
              for(int j=0; j<weekDaysNameArr.count; j++)
              {
                  NSMutableDictionary *fragmentDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"0":@"00:00" , @"1":@"00:00"}];
                  
                  
                  [openCloseTimeDic setValue:fragmentDic forKey:[NSString stringWithFormat:@"%d",j]];
                  [breaktimeValuesDic setValue:fragmentDic forKey:[NSString stringWithFormat:@"%d",j]];
                  
              }
              
              
              
              [CalenderView.tableview reloadData];
              saveBtn.hidden=NO;
              manageHolidaysBtn.hidden=NO;
              [saveBtn addTarget:self action:@selector(saveCalendarDetails) forControlEvents:UIControlEventTouchUpInside];
          
          }
            
            
            
        }
        
    }
    
}

-(void)dateCncl:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        if([_productType isEqualToString:@"perday"])
        {
            startDateBtn.userInteractionEnabled=YES;
            endDateBtn.userInteractionEnabled=YES;
            popUpBaseView.frame=CGRectMake(popUpBaseView.frame.origin.x, popUpBaseView.frame.origin.y+80, popUpBaseView.bounds.size.width, popUpBaseView.bounds.size.height);
            
        }
        datePickerView.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
    }];
    
}


#pragma mark--

#pragma mark--Creating picker

-(void)createpicker
{
    
    pickerBackview = [[UIView alloc]initWithFrame:self.view.frame];
    
    pickerBackview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:pickerBackview];
    
    pickerBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height * .35)];
    
    //    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    pickerBaseView.backgroundColor = [UIColor colorWithRed:242.0f/256 green:242.0f/256 blue:242.0f/256 alpha:1];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, pickerBaseView.frame.size.height - 40, pickerBaseView.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerBaseView.frame.size.width/2, pickerBaseView.frame.size.height - 40, pickerBaseView.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=datePickCnclBtn.backgroundColor;
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [pickerBaseView addSubview:cancelbtn];
    [pickerBaseView addSubview:okbtn];
    okbtn.backgroundColor=datePickOkBtn.backgroundColor;
    [okbtn setTitle:@"OK" forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(pickerOkAction) forControlEvents:UIControlEventTouchUpInside];
   
    [cancelbtn addTarget:self action:@selector(pickeCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, pickerBaseView.frame.size.height - 40)];
    
    [pickerBaseView addSubview:picker];
    [self.view addSubview:pickerBaseView];
    //    [picker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    
    picker.delegate = self;
    picker.dataSource = self;
    [picker reloadAllComponents];
    
    [UIView animateWithDuration:0.3 animations:^{
        
           pickerBaseView.frame=CGRectMake(0, self.view.frame.size.height - self.view.frame.size.height * .35, self.view.frame.size.width, self.view.frame.size.height * .35);
        
        
        
    }];
 
}

#pragma mark--


#pragma mark--PickerView delegates


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    if([slotClicked isEqualToString:@"yes"])
    {
    
        return slotArray.count;
    
    }
    else if([timezoneClicked isEqualToString:@"yes"])
    {
        
        return timezoneArr.count;
        
    }
    else
    return hours.count;

}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if([slotClicked isEqualToString:@"yes"])
    {
        
        return slotArray[row];
        
    }
    else if([timezoneClicked isEqualToString:@"yes"])
    {
        
        return [timezoneArr[row] valueForKey:@"name"];
        
    }
    else
      return hours[row];

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if([slotClicked isEqualToString:@"yes"])
    {
        
        [tappedBtn setTitle:slotArray[row] forState:UIControlStateNormal];
        
        slotValueSelected=YES;
        
    }
    else if([timezoneClicked isEqualToString:@"yes"])
    {
        
        [tappedBtn setTitle:[timezoneArr[row] valueForKey:@"name"] forState:UIControlStateNormal];
        
    }
    else
    timeSelected=[hours objectAtIndex:row];

}



-(void)pickerOkAction
{

    if([whichTableOpen isEqualToString:@"openclosetable"])
    {
        
        if(row_val==1)
        {
            NSArray *tempArr=[NSArray new];
            
            NSString *openHr,*openMin,*closeHr,*closeMin,*tempStr;
            
            tempStr=[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%ld",section_val]] valueForKey:@"0"];
            
            tempArr=[tempStr componentsSeparatedByString:@":"];
            
            openHr=tempArr[0];
            openMin=tempArr[1];
            
            tempStr=timeSelected;
            tempArr=[tempStr componentsSeparatedByString:@":"];
            
            
            closeHr=tempArr[0];
            closeMin=tempArr[1];
            
            
            if([closeHr intValue]==[openHr intValue])
            {
                
                if([closeMin intValue]<[openMin intValue])
                {
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Closing time must be after opening time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                }
                else
                {
                    
                    [self setValueFromPicker];
                    
                }
                
                
            }
            else if([closeHr intValue]<[openHr intValue])
            {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Closing time must be after opening time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                
            }
            else
            {
                
                [self setValueFromPicker];
                
            }
            
        }
        if(row_val==0)
        {
            NSArray *tempArr=[NSArray new];
            
            NSString *openHr,*openMin,*closeHr,*closeMin,*tempStr;
            
            tempStr=[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%ld",section_val]] valueForKey:@"1"];
            
            tempArr=[tempStr componentsSeparatedByString:@":"];
            
            if(![tempStr isEqualToString:@"00:00"])
            {
                closeHr=tempArr[0];
                closeMin=tempArr[1];
                
                tempStr=timeSelected;
                tempArr=[tempStr componentsSeparatedByString:@":"];
                
                
                openHr=tempArr[0];
                openMin=tempArr[1];
                
                
                if([closeHr intValue]==[openHr intValue])
                {
                    
                    if([closeMin intValue]<[openMin intValue])
                    {
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Opening time must be before closing time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        
                    }
                    else
                    {
                        
                        [self setValueFromPicker];
                        
                    }
                    
                    
                }
                else if([closeHr intValue]<[openHr intValue])
                {
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Opening time must be before closing time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                    
                }
                else
                {
                    
                    [self setValueFromPicker];
                    
                }
                
            }
            else
            {
                
                [self setValueFromPicker];
                
            }
            
        }

        
        
    }
    else if ([whichTableOpen isEqualToString:@"breaktable"])
    {
    
        if(row_val==0)
        {
        
            
            NSString *brkOpenTime,*tempStr;
            
            NSString *opentime,*closeTime;
            
            tempStr=[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%ld",break_Table.tag]] valueForKey:@"0"];
            opentime=tempStr;
            opentime=[opentime stringByReplacingOccurrencesOfString:@":" withString:@"."];
            
            closeTime=tempStr=[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%ld",break_Table.tag]] valueForKey:@"1"];
            closeTime=[closeTime stringByReplacingOccurrencesOfString:@":" withString:@"."];
            
            tempStr=timeSelected;
            brkOpenTime=tempStr;
            brkOpenTime=[brkOpenTime stringByReplacingOccurrencesOfString:@":" withString:@"."];
            
            NSLog(@"brk %f | open %f | close %f",[brkOpenTime floatValue],[opentime floatValue],[closeTime floatValue]);
            
            if([brkOpenTime floatValue]>[opentime floatValue] && [brkOpenTime floatValue]<[closeTime floatValue])
            {
            
                [self setValueFromPicker];
            
            }
            else
            {
            
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Select a proper break open time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            
            }
            
        
        }
        else if (row_val==1)
        {
        
           NSString *brkCloseTime,*brkOpenTime,*closeTime;
            
            
            brkOpenTime=[[breaktimeValuesDic valueForKey:[NSString stringWithFormat:@"%ld",break_Table.tag]] valueForKey:@"0"];
            brkOpenTime=[brkOpenTime stringByReplacingOccurrencesOfString:@":" withString:@"."];
            
            closeTime=[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%ld",break_Table.tag]] valueForKey:@"1"];
            closeTime=[closeTime stringByReplacingOccurrencesOfString:@":" withString:@"."];
            
            brkCloseTime=timeSelected;
            brkCloseTime=[brkCloseTime stringByReplacingOccurrencesOfString:@":" withString:@"."];
            
            if([brkCloseTime floatValue]>[brkOpenTime floatValue] && [brkCloseTime floatValue]<[closeTime floatValue])
            {
            
               [self setValueFromPicker];
            
            }
            else
            {
            
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Select a proper break end time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            
            
            }
            
        
        }
    
    }
    else if([whichTableOpen isEqualToString:@""])
    {
    
        [UIView animateWithDuration:0.3 animations:^{
            
            pickerBaseView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height * .35);
            
        }completion:^(BOOL finished) {
            
            [pickerBackview removeFromSuperview];
            
        }];
    
    }
    
    picker.delegate=nil;
    picker.dataSource=nil;
    
    whichTableOpen=@"";
    slotClicked=@"";
    timezoneClicked=@"";
  
}

-(void)setValueFromPicker
{

  if([whichTableOpen isEqualToString:@"openclosetable"])
  {
    
    NSMutableDictionary *tempDic=[NSMutableDictionary new];
    tempDic=[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%ld",section_val]] mutableCopy];
    [tempDic setValue:timeSelected forKey:[NSString stringWithFormat:@"%ld",row_val]];
    [openCloseTimeDic setValue:tempDic forKey:[NSString stringWithFormat:@"%ld",section_val]];
    
    [CalenderView.tableview beginUpdates];
    [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:section_val] withRowAnimation:UITableViewRowAnimationFade];
    [CalenderView.tableview endUpdates];
    
  }
  else if([whichTableOpen isEqualToString:@"breaktable"])
  {
    
      NSMutableDictionary *tempDic=[NSMutableDictionary new];
      tempDic=[[breaktimeValuesDic valueForKey:[NSString stringWithFormat:@"%ld",break_Table.tag]] mutableCopy];
      [tempDic setValue:timeSelected forKey:[NSString stringWithFormat:@"%ld",row_val]];
      [breaktimeValuesDic setValue:tempDic forKey:[NSString stringWithFormat:@"%ld",break_Table.tag]];
      
      [break_Table beginUpdates];
      [break_Table reloadSections:[NSIndexSet indexSetWithIndex:section_val] withRowAnimation:UITableViewRowAnimationFade];
      [break_Table endUpdates];
      
      NSLog(@"Break dic---> %@",breaktimeValuesDic);
    
  }
    
    timeSelected=@"00:00";
    
    [UIView animateWithDuration:0.3 animations:^{
        
        pickerBaseView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height * .35);
        
    }completion:^(BOOL finished) {
        
        [pickerBackview removeFromSuperview];
        
    }];

}

-(void)pickeCancelAction
{

    picker.delegate=nil;
    picker.dataSource=nil;
    
   timeSelected=@"00:00";
   whichTableOpen=@"";
   slotClicked=@"";
   timezoneClicked=@"";
    
    [UIView animateWithDuration:0.3 animations:^{
        
        pickerBaseView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height * .35);
        
    }completion:^(BOOL finished) {
        
        [pickerBackview removeFromSuperview];
        
    }];
    
}

#pragma mark--

#pragma mark--Footer Creation

-(void)footerCreation
{

    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer TapCheck:4];
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

}

#pragma mark--


#pragma mark-- Tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if(tableView==CalenderView.tableview)
    return weekDaysNameArr.count;
    else
        return 1;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(tableView==CalenderView.tableview)
    {
        if([headerValuesDic valueForKey:[NSString stringWithFormat:@"%ld",section]] && [expandBtnDic valueForKey:[NSString stringWithFormat:@"%ld",section]])
            return 2;
        else
            return 0;
    }
    else if(tableView==break_Table)
    {
      // NSLog(@"numberOfRowsInSection");
        return 2;
    }
    else return 0;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if(tableView==CalenderView.tableview)
         return 43.0f;
    else
        return 0;
   

}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//    if(tableView==CalenderView.tableview)
//    {
//        if(weekDaysNameArr.count-1==section)
//        {
//                return 43.0f;
//
//        }
//        else return 0;
//    
//    }
//    else return 0;
//
//}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//    if(tableView==CalenderView.tableview)
//    {
//        NSLog(@"Section--> %ld",section);
//        
//        if(weekDaysNameArr.count-1==section)
//        {
//            
//            UIView *footerForTable=[[UIView alloc]initWithFrame:CGRectMake(0,0, tableView.frame.size.width, 40)];
//            UIButton *saveButton=[UIButton new];
//            saveButton.frame=footerForTable.frame;
//            [footerForTable addSubview:saveButton];
//            saveButton.backgroundColor=datePickOkBtn.backgroundColor;
//            [saveButton setTitle:@"Save" forState:UIControlStateNormal];
//            
//            
//            return footerForTable;
//            
//        }
//        else return nil;
//        
//    }
//    else return nil;
//    
//    
//}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if(tableView==CalenderView.tableview)
    {

        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CalenderView.tableview.frame.size.width, 40)];
        headerView.backgroundColor=[UIColor colorWithRed:242.0f/255 green:242.0f/255 blue:242.0f/255 alpha:1];
    
        UIImageView *sectionimg = [[UIImageView alloc]initWithFrame:CGRectMake (0, 0,[UIScreen mainScreen].bounds.size.width, 39)];
        sectionimg.image = [UIImage imageNamed:@"rowlbl"];
        
        headerView.tag=section;
        
        UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 40)];
        headLbl.textColor=[UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
        headLbl.font=[UIFont fontWithName:@"Lato" size:14.0f];
        headLbl.text=[weekDaysNameArr objectAtIndex:section];
    

        
        UIImageView *plusimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-35, (headerView.bounds.size.height-20)/2, 20, 20)];
    
    if([headerValuesDic valueForKey:[NSString stringWithFormat:@"%ld",section]] && [expandBtnDic valueForKey:[NSString stringWithFormat:@"%ld",section]])
    {
    
        plusimg.image = [UIImage imageNamed:@"minus_grey"];
    
    }
    else
    {
        plusimg.image = [UIImage imageNamed:@"plus_grey"];

    }
    
        checkimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-190, (headerView.bounds.size.height-20)/2, 20, 20)];//CGRectMake(headerView.bounds.size.width-90, (headerView.bounds.size.height-20)/2, 20, 20)
    
    
        if([_productType isEqualToString:@"slot"])
        {
            
            Breakcheckimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-90, (headerView.bounds.size.height-20)/2, 20, 20)];//CGRectMake(headerView.bounds.size.width-190, (headerView.bounds.size.height-20)/2, 20, 20)
            Breakcheckimg.tag=section;
            Breakcheckimg.image = [UIImage imageNamed:@"unchecked"];
            
            
            breaktimebtn = [[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-110, 0, 50, 39)];//CGRectMake(headerView.bounds.size.width-200, 0, 50, 39)
            [breaktimebtn addTarget:self action:@selector(breaktimebtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            breaktimebtn.tag=section;
            breaktimebtn.backgroundColor = [UIColor clearColor];
            breaktimebtn.enabled=NO;

            
        }
        
        
        ifOpenCheckButton = [[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-200, 0, 50, 39)];//CGRectMake(headerView.bounds.size.width-110, 0, 50, 39)
        ifOpenCheckButton.tag=section;
        ifOpenCheckButton.backgroundColor = [UIColor clearColor];
        [ifOpenCheckButton addTarget:self action:@selector(ifOpenCheckTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        headerPlusButton=[[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-60, 0, 60, 39)];
        headerPlusButton.backgroundColor = [UIColor clearColor];
        headerPlusButton.tag=section;
        [headerPlusButton addTarget:self action:@selector(headerPlusButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if(![headerValuesDic valueForKey:[NSString stringWithFormat:@"%ld",section]])
    {
        checkimg.image = [UIImage imageNamed:@"unchecked"];
        headerPlusButton.enabled=NO;
        breaktimebtn.enabled=NO;
    }
    else
    {
        
        checkimg.image = [UIImage imageNamed:@"checked"];
        
          headerPlusButton.enabled=YES;
          breaktimebtn.enabled=YES;
    }
    
    if(![breaktimeCheckDic valueForKey:[NSString stringWithFormat:@"%ld",section]])
    {
        
        Breakcheckimg.image=[UIImage imageNamed:@"unchecked"];
        
    }
    else
    {
        
        Breakcheckimg.image=[UIImage imageNamed:@"checked"];
        
    }

    
    
       // NSString *key1=[NSString stringWithFormat:@"%ld",(long)section];
    
        
        //[headerView addSubview:sectionimg];
        [headerView addSubview:checkimg];
        [headerView addSubview:Breakcheckimg];
        [headerView addSubview:plusimg];
        [headerView addSubview:headerPlusButton];
        [headerView addSubview:ifOpenCheckButton];
        [headerView addSubview:headLbl];
        [headerView addSubview:breaktimebtn];
        
    
        return headerView;
        
    }
    else return nil;
 
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // NSLog(@"cellForRowAtIndexPath");
    
    tableView.backgroundColor=[UIColor clearColor];

    UITableViewCell *cell1;
    

        static NSString *cellId = @"cellid";
        cell1 = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell1==nil)
    {
      cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
        UIImageView *divider = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
        divider.image = [UIImage imageNamed:@"divider-line"];
        
        CGFloat width = self.view.frame.size.width - 30;
        
        UIImageView *indicator = [[UIImageView alloc]initWithFrame:CGRectMake(width, 16, 11, 18)];
        indicator.contentMode = UIViewContentModeScaleAspectFit;
        indicator.image = [UIImage imageNamed:@"arrow"];
        
        UILabel *celllbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 49)];
        celllbl.text = [celllblarr objectAtIndex:indexPath.row];
        //celllbl.backgroundColor=[UIColor darkGrayColor];
        celllbl.font = [UIFont fontWithName:@"Lato" size:14.0f];
        celllbl.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
        if(indexPath.row==0)
        {
        
            celllbl.text=[NSString stringWithFormat:@"Opens at: "];
        
        }
        else if(indexPath.row==1)
        {
            
            celllbl.text=[NSString stringWithFormat:@"Closes at: "];
            
        }
        
        timelbl = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 150, 49)];
        timelbl.font = [UIFont fontWithName:@"Lato" size:14.0f];
        timelbl.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
    
      NSDictionary *dic=[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
    
    
    if(tableView==CalenderView.tableview)
    {
    
        timelbl.text =[NSString stringWithFormat:@"%@",[dic valueForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]];
    }
    else if (tableView == break_Table)
    {
    
        NSDictionary *dic=[breaktimeValuesDic valueForKey:[NSString stringWithFormat:@"%ld",tableView.tag]];
   
        timelbl.text =[NSString stringWithFormat:@"%@",[dic valueForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]];
        
        //timelbl.text=@"aaaaaaa";
    
    }
    //@"00:00";
    
    
        [cell1 addSubview:timelbl];
    
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell1 addSubview:indicator];
        [cell1 addSubview:celllbl];
    
        //    [cell addSubview:timelblstart];
        //    [cell addSubview:timelblend];
    
        [cell1 addSubview:divider];
        return  cell1;
        
 

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(tableView==CalenderView.tableview)
    {
    
        whichTableOpen=@"openclosetable";
    
    }
    else if (tableView==break_Table)
    {
    
        whichTableOpen=@"breaktable";
    
    }
    
    section_val=indexPath.section;
    row_val=indexPath.row;
    [self createpicker];

}

#pragma mark-If open check tapped

-(void)ifOpenCheckTapped:(UIButton *)sender
{

  if([headerValuesDic valueForKey:[NSString stringWithFormat:@"%ld",sender.tag]])
  {
  
        [headerValuesDic removeObjectForKey:[NSString stringWithFormat:@"%ld",sender.tag]];
      
        [expandBtnDic removeObjectForKey:[NSString stringWithFormat:@"%ld",sender.tag]];
      
        [breaktimeCheckDic removeObjectForKey:[NSString stringWithFormat:@"%ld",sender.tag]];
      
      NSMutableDictionary *fragmentDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"0":@"00:00" , @"1":@"00:00"}];
      
//      NSMutableDictionary *fragmentDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"0":[hours firstObject] , @"1":[hours lastObject]}];
      
        [openCloseTimeDic setValue:fragmentDic forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
      
        [breaktimeValuesDic setValue:fragmentDic forKey:[NSString stringWithFormat:@"%ld",sender.tag]];

  
  }
  else
  {
    
        [headerValuesDic  setValue:@"y" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
      
        //[expandBtnDic setValue:@"y" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
  }
    
    [CalenderView.tableview beginUpdates];
    [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
    [CalenderView.tableview endUpdates];
    
   

}

#pragma mark--

#pragma mark--Break time tapped

-(void)breaktimebtnTapped:(UIButton *)sender
{

    if([breaktimeCheckDic valueForKey:[NSString stringWithFormat:@"%ld",sender.tag]])
    {
        [breaktimeCheckDic removeObjectForKey:[NSString stringWithFormat:@"%ld",sender.tag]];
        
        NSMutableDictionary *fragmentDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"0":@"00:00" , @"1":@"00:00"}];
        
        [breaktimeValuesDic setValue:fragmentDic forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
        
        [CalenderView.tableview beginUpdates];
        [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
        [CalenderView.tableview endUpdates];
        
    }
    else
    {
        [breaktimeCheckDic  setValue:@"y" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
        
        [CalenderView.tableview beginUpdates];
        [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
        [CalenderView.tableview endUpdates];
        
        [self createBreakTableWith:sender.tag];
   
    }
    
   

}

#pragma mark--


- (void)createBreakTableWith:(NSInteger)tag
{
    
    
    blackOverLay=[UIView new];
    blackOverLay.frame=self.view.frame;
    blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
    [self.view addSubview:blackOverLay];
    
    popUpBaseView=[UIView new];
    popUpBaseView.frame=CGRectMake(startDateBtn.frame.origin.x, (self.view.bounds.size.height-self.view.bounds.size.height/3.2)/2, startDateBtn.frame.size.width, self.view.bounds.size.height/3.2);
    popUpBaseView.backgroundColor=[UIColor whiteColor];
    popUpBaseView.layer.cornerRadius=6.0f;
    popUpBaseView.clipsToBounds=YES;
    
    UILabel *categorHeadingLbl=[[UILabel alloc]init];
    NSString *tempStrHeading=[NSString stringWithFormat:@"Break Time"];
    categorHeadingLbl.font=[UIFont fontWithName:@"lato" size:15];
    
    categorHeadingLbl.frame=CGRectMake((popUpBaseView.frame.size.width-(tempStrHeading.length*8))/2, 7, tempStrHeading.length*8,self.view.bounds.size.height/19);
    categorHeadingLbl.textAlignment=NSTextAlignmentCenter;
    
    categorHeadingLbl.text=tempStrHeading;
    [popUpBaseView addSubview:categorHeadingLbl];
    
    UIImageView *dividerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dividerline"]];
    
    dividerView.frame=CGRectMake(0, categorHeadingLbl.frame.size.height+categorHeadingLbl.frame.origin.y+5, popUpBaseView.bounds.size.width, 1);
    
    
    [popUpBaseView addSubview:dividerView];
    
    
    break_Table=[[UITableView alloc]init];
     break_Table.frame=CGRectMake(5, dividerView.frame.size.height+dividerView.frame.origin.y+4, popUpBaseView.frame.size.width-10, popUpBaseView.frame.size.height-(dividerView.frame.size.height+dividerView.frame.origin.y+54));
    break_Table.backgroundColor=[UIColor redColor];
    break_Table.delegate=self;
    break_Table.dataSource=self;
    break_Table.tag=tag;
    
   
    
    [popUpBaseView addSubview:break_Table];
    
    //break_Table.hidden=YES;
    
    
//    CircleLoader  *circleLoader = [[CircleLoader alloc] initWithFrame:
//                                   CGRectMake(0, 0, 30, 30)];
//    //center the circle with respect to the view
//    [circleLoader setCenter:CGPointMake(popUpBaseView.bounds.size.width / 2,
//                                        popUpBaseView.bounds.size.height / 2)];
//    //add the circle to the view
//    [popUpBaseView addSubview:circleLoader];
//    
//    [circleLoader animateCircle];
    
    
    UIButton *closeBtn=[UIButton new];
    [closeBtn setTitleColor:[UIColor colorWithRed:16.0f/255 green:95.0f/255 blue:250.0f/255 alpha:1] forState:UIControlStateNormal];
    closeBtn.frame=CGRectMake((popUpBaseView.frame.size.width-150)/2, popUpBaseView.frame.size.height-54, 150, 40);
    [closeBtn setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
    closeBtn.backgroundColor=[UIColor clearColor];
    [popUpBaseView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeCatTable) forControlEvents:UIControlEventTouchUpInside];
    
    
    [blackOverLay addSubview:popUpBaseView];
    
    [break_Table reloadData];
    
    //[break_Table setHidden:NO];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.1];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.2];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
        
        
    }];
    
}


-(void)closeCatTable
{
    
//    for (UITableView *v in popUpBaseView.subviews)
//    {
//        //        [v removeFromSuperview];
//        if ([v isKindOfClass:[UITableView class]])
//        {
//            [v setDelegate:nil];
//            [v setDataSource:nil];
//            [v removeFromSuperview];
//        }
//    }
    
    [popUpBaseView removeFromSuperview];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.2];
        blackOverLay.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.0];
        
        [blackOverLay removeFromSuperview];
        
    }];
    
}



#pragma mark--Header expansion

-(void)headerPlusButton:(UIButton *)sender
{
    if([expandBtnDic valueForKey:[NSString stringWithFormat:@"%ld",sender.tag]])
    {
        [expandBtnDic removeObjectForKey:[NSString stringWithFormat:@"%ld",sender.tag]];
    
    }
    else
    {
    
        [expandBtnDic setValue:@"y" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
    
    }

    [CalenderView.tableview beginUpdates];
    [CalenderView.tableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
    [CalenderView.tableview endUpdates];

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark--Saving calender details for service slot type

-(void)saveCalendarDetails
{
    
    NSMutableArray *dayDetailsArr=[NSMutableArray new];
    
    if(slotValueSelected==YES)
    {
    
        if(headerValuesDic.count>0)
        {
            
            NSLog(@"header values:-> %@",headerValuesDic);
            
            NSArray *keys_openclosedic=[headerValuesDic allKeys];
            NSArray *keys_breakCheckdDic=[breaktimeCheckDic allKeys];
            
            for(int i=0; i<keys_openclosedic.count; i++)
            {
                
                if([[[openCloseTimeDic valueForKey:keys_openclosedic[i]] valueForKey:@"0"] isEqualToString:[[openCloseTimeDic valueForKey:keys_openclosedic[i]] valueForKey:@"1"]])
                {
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"Open close time are same for %@",weekDaysNameArr[[keys_openclosedic[i] intValue]]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                    openCloseTimeOk=NO;
                    
                    break;
                    
                }
                else
                {
                    
                    openCloseTimeOk=YES;
                    
                }
                
            }
            
            if(openCloseTimeOk==YES)
            {
            
                for (int i=0; i<keys_openclosedic.count; i++)
                {
                    
                    if([keys_breakCheckdDic containsObject:keys_openclosedic[i]])
                    {
                        
                        NSLog(@"[%@-%@-%@-%@-%@]",weekDaysNameArr[[keys_openclosedic[i] intValue]],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"0"],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"1"],[[breaktimeValuesDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"0"],[[breaktimeValuesDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"1"]);
                        
                        [dayDetailsArr addObject:[NSString stringWithFormat:@"[%@-%@-%@-%@-%@]",weekDaysNameArr[[keys_openclosedic[i] intValue]],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"0"],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"1"],[[breaktimeValuesDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"0"],[[breaktimeValuesDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"1"]]];
                        
                    }
                    else
                    {
                        NSLog(@"[%@-%@-%@--]",weekDaysNameArr[[keys_openclosedic[i] intValue]],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"0"],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"1"]);
                        
                        
                        [dayDetailsArr addObject:[NSString stringWithFormat:@"[%@-%@-%@--]",weekDaysNameArr[[keys_openclosedic[i] intValue]],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"0"],[[openCloseTimeDic valueForKey:[NSString stringWithFormat:@"%@",keys_openclosedic[i]]] valueForKey:@"1"]]];
                        
                        
                        
                    }
                }
            
                [self saveCalenderDataWithArray:dayDetailsArr];
                
            }
           
            
            
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please check at least one day" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }

    
    }
    else
    {
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please select the slot time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }

    
}


-(void)saveCalenderDataWithArray:(NSArray *)dayDetailsData
{


    
    NSString *urlString=[NSString stringWithFormat:@"%@app_category/app_calender_insert?",App_Domain_Url];
    
    NSString *postData;
    NSString *slotType=@"";
    NSString *productType=@"";
    
    if([_productType isEqualToString:@"product"] || [_productType isEqualToString:@"slot"])
    {
        
        slotType=@"3";
        if([_productType isEqualToString:@"product"])
        {
            
            productType=@"product";
            
        }
        else if([_productType isEqualToString:@"slot"])
        {
            
            productType=@"service";
            
        }
        
    }
    if([_productType isEqualToString:@"perday"])
    {
        // Check between always available & specific available
        
    }
    
    
    postData =[NSString stringWithFormat:@"userid=%@&service_id=%@&type=%@&slot_type=%@&start_date=%@&end_date=%@&slot_time=&name_timezone=%@&day_det=%@&holi_start_date=&holi_end_date=&holi_reason=",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],_productid,productType,slotType,startDateBtn.titleLabel.text,endDateBtn.titleLabel.text,timeZoneBtn.titleLabel.text,[dayDetailsData componentsJoinedByString:@","]];
    
    partOfUrl=[NSString stringWithFormat:@"userid=%@&service_id=%@&type=%@&slot_type=%@&start_date=%@&end_date=%@&slot_time=&name_timezone=%@&day_det=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],_productid,productType,slotType,startDateBtn.titleLabel.text,endDateBtn.titleLabel.text,timeZoneBtn.titleLabel.text,[dayDetailsData componentsJoinedByString:@","]];
    
    NSLog(@"Url string : %@",urlString);
    NSLog(@"Post data : %@",postData);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalobj GlobalDict_post:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"Save result----> %@",result);
        
        if([[result valueForKey:@"response"] isEqualToString:@"success"])
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            manageHolidaysBtn.enabled=YES;
            manageHolidaysBtn.alpha=1.0f;
            
            //            FWCalendarViewController *vcObj=[self.storyboard instantiateViewControllerWithIdentifier:@"fwcalendar"];
            //
            //            vcObj.productType=productType;
            //
            //            [self PushViewController:vcObj WithAnimation:kCAMediaTimingFunctionEaseIn];
            
        }
        
    }];


}


#pragma mark -


#pragma mark-Manage Holiday

-(void)manageHolidayTapped:(UIButton *)sender
{

    FWManageHolidaysViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"manageholidays"];
    
    obj.productId=_productid;
    obj.partOfUrl=partOfUrl;
    
    [self.navigationController presentViewController:obj animated:YES completion:^{
        
        
        NSLog(@"Presnted..");
        
    }];
    
  //  [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];

}

- (IBAction)backAction:(id)sender
{
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}
//*/

@end
