//
//  FWManageHolidaysViewController.m
//  FreeWilder
//
//  Created by Koustov Basu on 31/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import "FWManageHolidaysViewController.h"
#import "FW_JsonClass.h"
#import "NSString+stringCategory.h"

@interface FWManageHolidaysViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *datePickerView;
    UIDatePicker *date_picker;
    UIButton *datePickOkBtn,*datePickCnclBtn,*tappedBtn;
    NSDate *startDate,*endDate;
    FW_JsonClass *globalobj;
    NSMutableArray *holidayList;
    
  
    __weak IBOutlet UIImageView *endDateCalender;
    __weak IBOutlet UIButton *endDateBtn;
    __weak IBOutlet UIButton *startDateBtn;
    __weak IBOutlet UITableView *manageHolidayTable;

    __weak IBOutlet UISegmentedControl *segMentCntrl;
    
    __weak IBOutlet UITextField *reasonTxtBox;
}

@end

@implementation FWManageHolidaysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    globalobj=[FW_JsonClass new];
    holidayList=[NSMutableArray new];
    _singleMode=YES;
    
    [self getTheHolidayList];
    [self createDatePicker];
}

-(void)getTheHolidayList
{

    NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_details_calender_holiday_service?userid=%@&service_id=%@",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"],_productId];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        holidayList=[[result valueForKey:@"calender_holiday_list"] mutableCopy];
        
        if(holidayList.count>0)
        {
            [manageHolidayTable reloadData];
        
        }
        else
        {
        
            manageHolidayTable.hidden=YES;
        
        }
        
    }];


}

#pragma mark-- Craete date picker

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

#pragma mark--

-(void)openDatePicker:(UIButton *)sender
{
    
    tappedBtn=sender;
    
    if([sender isEqual:startDateBtn])
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
            [startDateBtn setTitle:prettyVersion forState:UIControlStateNormal];
            
            _startDateSelected=YES;
            
            // checkinDate=date_picker.date;
        }
        else if([tappedBtn isEqual:endDateBtn])
        {
            // checkoutDate=date_picker.date;
            [endDateBtn setTitle:prettyVersion forState:UIControlStateNormal];
            
            endDate=date_picker.date;
            
            NSInteger interval=[endDate timeIntervalSinceDate:startDate]/(24*60*60);
            
            NSLog(@"Interval: %ld",interval);
            
            _endDateSelected=YES;
            
            
        }
        
    }
    
}

-(void)dateCncl:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.2 animations:^{
        datePickerView.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
    }];
    
}

#pragma mark-- Tableview Delegates

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

   return  1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 43.0f;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *headerView=[UIView new];
    headerView.frame=CGRectMake(0, 0, tableView.bounds.size.width, 43);
    headerView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input_back"]];
    
    
    UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 40)];
    headLbl.textColor=[UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
    headLbl.font=[UIFont fontWithName:@"Lato" size:14.0f];
    headLbl.text=@"Listed Holidays";
    
    [headerView addSubview:headLbl];
    
    return headerView;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return holidayList.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return  43.0f;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    
    static NSString *cellid=@"manageHolidayCell";
    
    cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell==nil)
    {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[holidayList[indexPath.row] valueForKey:@"holiday_date"]];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[holidayList[indexPath.row] valueForKey:@"holiday_reason"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;



}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [reasonTxtBox resignFirstResponder];
    
    return YES;


}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
}

#pragma mark--Switching between Single | Multiple mode

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        
        endDate=nil;
        [endDateBtn setTitle:[NSString stringWithFormat:@"End Date"] forState:UIControlStateNormal];
        endDateBtn.alpha=0.4f;
        endDateBtn.enabled=NO;
        endDateCalender.alpha=0.4f;
        _singleMode=YES;
        _endDateSelected=NO;
        
    }
    else{
 
        endDateBtn.alpha=1.0f;
        endDateBtn.enabled=YES;
        endDateCalender.alpha=1.0f;
        _singleMode=NO;
        
    }
}

#pragma mark--


#pragma mark-- Start Date Button action

- (IBAction)startDateBtn:(id)sender {
    
    [self openDatePicker:startDateBtn];
}

#pragma mark--


#pragma mark-- End Date Button action

- (IBAction)endDateBtn:(id)sender {
    
    [self openDatePicker:endDateBtn];
}

- (IBAction)saveHolidays:(id)sender
{
  
    
    if(_singleMode==YES)
    {
    
       if(_startDateSelected==YES)
       {
       
          if([[NSString stringByTrimmingLeadingWhitespace:reasonTxtBox.text] length]>0)
          {
          
             
              
              NSString *postData=@"";
              postData=[NSString stringWithFormat:@"%@&holi_start_date=%@&holi_end_date=&holi_reason=%@",_partOfUrl,startDateBtn.titleLabel.text,reasonTxtBox.text];
              [self saveDetailsWithData:postData];
          
          }
           else
           {
           
               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Provide a reason for Holiday." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alert show];
           
           }
       
       }
        else
        {
        
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Provide a start date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        
        }
    
    }
    if(_singleMode==NO)
    {
    
        if(_startDateSelected==YES)
        {
           if(_endDateSelected==YES)
           {
           
               if([[NSString stringByTrimmingLeadingWhitespace:reasonTxtBox.text] length]>0)
               {
                   
                   
                   
                   NSString *postData=@"";
                   postData=[NSString stringWithFormat:@"%@&holi_start_date=%@&holi_end_date=%@&holi_reason=%@",_partOfUrl,startDateBtn.titleLabel.text,endDateBtn.titleLabel.text,reasonTxtBox.text];
                   [self saveDetailsWithData:postData];
                   
               }
               else
               {
                   
                   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Provide a reason for Holiday." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                   [alert show];
                   
               }
           
           }
           else
           {
               
               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Provide a end date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alert show];
               
           }
            
            
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Provide a start date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
    
    }
    
    
}

-(void)saveDetailsWithData:(NSString *)postData
{

   NSString *urlString=[NSString stringWithFormat:@"%@app_category/app_calender_insert?",App_Domain_Url];
    
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
            
            
        }
        
    }];

}

#pragma mark--

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
