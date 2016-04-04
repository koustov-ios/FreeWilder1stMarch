//
//  FWCalendarViewController.h
//  FreeWilder
//
//  Created by Koustov Basu on 28/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calender_View.h"

@interface FWCalendarViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

{
    
    NSString *start_Date,*end_Date,*alwsOrSpecific;

    UIButton *startDateBtn,*endDateBtn;
    calender_View *CalenderView;
    UIView *datePickerView;
    UIDatePicker *date_picker;
    UIButton *datePickOkBtn,*tappedBtn;
    UIButton *datePickCnclBtn;
    NSDate *startDate,*endDate;
    NSArray *hours;
    UIView *pickerBackview,*pickerBaseView;
    UIPickerView *picker;
    
    NSString *whichTableOpen;
    
    UITableView *slottable,*timeZoneTable;
    
    NSString *slotClicked,*timezoneClicked;
    
    NSString *partOfUrl;
    
    UIButton *tappedButton;
    
    BOOL slotValueSelected,openCloseTimeOk;
    
    BOOL singleChecked;
    
    
    NSMutableDictionary *headerValuesDic,*expandBtnDic,*breaktimeCheckDic,*breaktimeValuesDic;
    UIButton *ifOpenCheckButton;
    UIImageView   *Breakcheckimg;
    UIButton    *breaktimebtn;
    UIButton *headerPlusButton;
    UIImageView *checkimg;
    BOOL headerExpanded;
    NSMutableArray *weekDaysNameArr;
    NSMutableArray *weekDaysNameArr_fixed;
    
    NSMutableDictionary *openCloseTimeDic;
    
    NSInteger section_val,row_val;
    NSString *timeSelected;
    
    //
    
    UIView  *blackOverLay;
    UIView *popUpBaseView;
    UITableView *break_Table;
    
    //
    
   
    NSMutableArray *breaktime;
    NSMutableArray *celllblarr;
    NSMutableSet *collapsedSections;
    NSMutableDictionary *dicTab;
    NSMutableDictionary *dicBtn;
    NSMutableDictionary *dicTab1,*dicTab10;
    NSMutableDictionary *dicBtn1,*dicBtn10;
    NSInteger prev;
    UIDatePicker *datepicker;
   
   
    UILabel *timelbl, *timelblend;
    NSInteger pickerflag;
    NSString *selecttime, *selecttimestart;
    
    NSInteger tapcheck,tickbool;
   
    NSMutableArray *selectedRows, *sectionar0, *sectionar1, *sectionar2, *sectionar3, *sectionar4,*sectionar5,*sectionar6 ;
    NSString *chkstring0;
    NSString *chkstring1;
    NSString *chkstring2;
    NSString *chkstring3;
    NSString *chkstring4;
    NSString *chkstring5;
    NSString *chkstring6;
    
    
    NSString *chkstring00;
    NSString *chkstring10;
    NSString *chkstring20;
    NSString *chkstring30;
    NSString *chkstring40;
    NSString *chkstring50;
    NSString *chkstring60;
    
    
    NSInteger sundaysrttimechk,sundayendtimechk,mondaysrttimechk,mondayendtimechk,tuesdaysrttime,tuesdayendtime,wednessdaysrttime,wednessdayendtime,thurdaysrttime,thurdayendime,fridaysrttime,fridayendtime,saturdaysrttimechk,saturdayendtimechk;
    BOOL finishtimetap,finishtimetap1,finishtimetap2,finishtimetap3,finishtimetap4,finishtimetap5,
    finishtimetap6,cellchk;

}

@property (nonatomic) NSString *productType,*productid;


@end
