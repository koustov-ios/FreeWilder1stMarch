//
//  PayoutPreferenceViewController.m
//  FreeWilder
//
//  Created by subhajit ray on 17/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PayoutPreferenceViewController.h"
#import "addpayoutmethod.h"
#import "FW_JsonClass.h"
#import "payoutCell.h"
#import "payoutsecondpageViewController.h"
#import "payPalTableViewCell.h"
#import "NSString+stringCategory.h"

@interface PayoutPreferenceViewController ()<addpayoutdelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    addpayoutmethod *subview;
    UIScrollView *mainscroll;
    NSMutableArray *countrydata,*countryCode,*tempdata,*payoutdata,*stateNameArr,*stateCodeArr;
    NSMutableDictionary *tempdic;
    NSString *holddata;
    
    UIView *blackview1 ,*popview1;
    UITextField *text;
    
    payPalTableViewCell *payPalCell;
    payoutCell *cell;
    
    BOOL noPayPal,noDirectMethod,noMethodAdded;
    CGRect addPayoutPopupMainViewFrame;
       UIActionSheet *actionSheetNoMethod,*actionSheetPaypal,*actionSheetDirectMethod;
    
    NSString *country_code,*state_code;
}

@end

@implementation PayoutPreferenceViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"I am payout preferences....");
    
//    noMethodAdded=YES;
//    noPayPal=YES;
//    noDirectMethod=YES;
    
   
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer_base addSubview:footer];
    temp= [[NSMutableArray alloc]init];
    
    //-----For Side menu & Footer------//
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    //-----Side menu & Footer Ends Here------//
    
    
    
    countrydata=[[NSMutableArray alloc] init];
    countryCode=[[NSMutableArray alloc]init];
    
    stateNameArr=[[NSMutableArray alloc]init];
    stateCodeArr=[[NSMutableArray alloc]init];
    
    _mainpickerview.hidden=YES;
    _pickerviewmain.hidden=YES;
    
    _maintableview.delegate=self;
    _maintableview.dataSource=self;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    
    [self urlfire];
    
}

-(void)urlfire
{
    globalobj=[[FW_JsonClass alloc] init];
    tempdata=[[NSMutableArray alloc]init ];
    tempdic=[[NSMutableDictionary alloc] init];
    payoutdata=[[NSMutableArray alloc] init];
    
     NSString *urlstring=[NSString stringWithFormat:@"%@app_country",App_Domain_Url];
    
     NSString *urlstring2=[NSString stringWithFormat:@"%@app_payout_info?userid=%@",App_Domain_Url,userid];
    
    
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error){
        NSLog(@"here %@",result);
        
        tempdata=[[result valueForKey:@"infoarray"] mutableCopy];
        countrydata=[tempdata valueForKey:@"country_name"];
        countryCode=[tempdata valueForKey:@"country_id"];
        
        [globalobj GlobalDict:urlstring2 Globalstr:@"array" Withblock:^(id result, NSError *error){
            
            
            tempdic=[result mutableCopy];
            NSString *chkdata=[tempdic valueForKey:@"response"];
            if ([chkdata isEqualToString:@"success"])
            {
                payoutdata=[tempdic valueForKey:@"infoarray"];
                NSLog(@"payoutdata%@",payoutdata);
                _maintableview.hidden=NO;
                
                if(payoutdata.count==0)
                {
                
                    directArrow.hidden=YES;
                    directMethodBtn.hidden=YES;
                    payPalArrow.hidden=YES;
                    payPalmethodBtn.hidden=YES;
                    
                    noMethodAdded=YES;
                    noPayPal=YES;
                    noDirectMethod=YES;
                    
                    NSLog(@"table no data");
                
                }
                
                else if (payoutdata.count==2)
                {
                
                   // Keep both button visible
                    
                    paymentAddArrow.hidden=YES;
                    addPaymentBtn.hidden=YES;
                    addPaymentBtn.userInteractionEnabled=NO;
                    
                    noMethodAdded=NO;
                    noPayPal=NO;
                    noDirectMethod=NO;
                
                }
                
                else if (payoutdata.count==1)
                {
                
                    addPaymentBtn.userInteractionEnabled=YES;
                    paymentAddArrow.hidden=NO;
                    addPaymentBtn.hidden=NO;
                    
                   if([[[payoutdata objectAtIndex:0] valueForKey:@"method_type"] isEqualToString:@"Paypal"])
                   {
                   
                       payPalArrow.frame=directArrow.frame;
                       payPalmethodBtn.frame=directMethodBtn.frame;
                       directArrow.hidden=YES;
                       directMethodBtn.hidden=YES;
                       
                       noMethodAdded=NO;
                       noPayPal=NO;
                       noDirectMethod=YES;
                   
                   }
                    else
                    {
                    
                        payPalArrow.hidden=YES;
                        payPalmethodBtn.hidden=YES;
                        
                        noMethodAdded=NO;
                        noPayPal=YES;
                        noDirectMethod=NO;
                    
                    }
                
                }
                
                
                [_maintableview reloadData];
            }
            
            else if ([[tempdic valueForKey:@"message"] isEqualToString:@"no method to display"])
            {
            
            
                    
                    directArrow.hidden=YES;
                    directMethodBtn.hidden=YES;
                    payPalArrow.hidden=YES;
                    payPalmethodBtn.hidden=YES;
                
                _maintableview.hidden=YES;
                 noMethodAdded=YES;
                
                addPaymentBtn.userInteractionEnabled=YES;
                paymentAddArrow.hidden=NO;
                addPaymentBtn.hidden=NO;

                
                    
                    NSLog(@"no no no no no no no no no");
                    
                
            }
            
            
            
        }];
        
        
        
    }];
    
    
    
}



- (IBAction)addpayoutbtn:(id)sender
{
  //  noMethodAdded=YES;
   
    
    NSLog(@"Hello00000000");
    
  //  NSLog(@"Paypal---> %@ || Direct---> %@ || No method---> %@",noPayPal,noDirectMethod,noMethodAdded);
    
   if(noDirectMethod==YES)
   {
    
       
       actionSheetDirectMethod = [[UIActionSheet alloc] initWithTitle:@"Payout Method"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Direct Method",nil];
       
       [actionSheetDirectMethod showInView:self.view];

    

    
   }
   else if(noPayPal==YES)
   {
       
       actionSheetPaypal = [[UIActionSheet alloc] initWithTitle:@"Payout Method"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:@"Paypal",nil];
       
       [actionSheetPaypal showInView:self.view];


       
     }
    
    else if (noMethodAdded==YES)
    {
    
        actionSheetNoMethod = [[UIActionSheet alloc] initWithTitle:@"Payout Method"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"Paypal",@"Direct Method",nil];
        
          [actionSheetNoMethod showInView:self.view];
    
    }
    
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if(actionSheet==actionSheetNoMethod)
    {
    
      if(buttonIndex==0)
      {
          
          NSLog(@"remove action");
          
          
          blackview1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
          blackview1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
          
          
          
          UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap1)];
          tapGestureRecognize.delegate = self;
          tapGestureRecognize.numberOfTapsRequired = 1;
          
          [blackview1 addGestureRecognizer:tapGestureRecognize];
          
          
          
          
          popview1=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5)];
          
          
          UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+50, popview1.frame.size.width-20, popview1.frame.size.height*.42)];
          
          
          UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+20, popview1.frame.size.width-20, 40)];
          
          header.text = @"PAYPAL ACCOUNT DETAILS";
          [header setFont:[UIFont fontWithName:@"Lato" size:16]];
          
          
          
          header.textAlignment = NSTextAlignmentCenter;
          
          [popview1 addSubview:header];
          
          UIView *divider=[[UIView alloc]initWithFrame:CGRectMake(7, header.frame.origin.y+header.frame.size.height +5, popview1.bounds.size.width-14, 1)];
          
          divider.backgroundColor = [UIColor grayColor];
          [popview1 addSubview:divider];
          
          UIImageView *payPal=[[UIImageView alloc]initWithFrame:CGRectMake((popview1.frame.size.width-150)/2, divider.frame.origin.y+divider.frame.size.height +30, 150, 44)];
          payPal.image=[UIImage imageNamed:@"paypal"];
          payPal.alpha=0.2;
          [popview1 addSubview:payPal];
          
          
          [lbl setFont:[UIFont fontWithName:@"Lato" size:14]];
          lbl.numberOfLines =6;
          //lbl.backgroundColor=[UIColor yellowColor];
          
          
          
          lbl.text=@"PayPal is an online payment processing service that allows you to receive payments from Freewilder.To use PayPal with Freewilder, you must have an existing account with PayPal.\n\nEnter the email address associated with your existing PayPal account.";
          lbl.adjustsFontSizeToFitWidth=YES;
          
          
          [popview1 addSubview:lbl];
          
          text = [[UITextField alloc]initWithFrame:CGRectMake(10,lbl.frame.size.height+50, lbl.frame.size.width, 40)];
          
          text.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
          
          text.layer.cornerRadius=5;
          
          UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
          text.leftView = paddingView;
          text.leftViewMode = UITextFieldViewModeAlways;
          
          text.placeholder=@"Enter Email-Id";
          text.text=cell.detailslabel.text;
          
          
          
          UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview1.bounds.origin.x+100, lbl.frame.size.height+text.frame.size.height+80, lbl.frame.size.width-180, 30)];
          
          
          submit.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
          
          submit.layer.cornerRadius = 5;
          
          [submit setTitle:@"Save" forState:UIControlStateNormal];
          // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
          [submit addTarget:self action:@selector(submitPayPalDetails:) forControlEvents:UIControlEventTouchUpInside];
          
          
          [popview1 addSubview:submit];
          
          text.delegate=self;
          
          [text setFont:[UIFont fontWithName:@"Lato" size:14]];
          
          [popview1 addSubview:text];
          
          
          
          popview1.backgroundColor=[UIColor whiteColor];
          
          popview1.layer.cornerRadius = 10;
          
          [self.view addSubview:blackview1];
          
          [self.view addSubview:popview1];
          [UIView animateWithDuration:.3 animations:^{
              
              
              popview1.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
              
              
          }];
          
      }
        else if(buttonIndex==1)
        {
            
            
            [_mainview setHidden:YES];
            subview=[[addpayoutmethod alloc] init];
            CGRect screenBounds=[[UIScreen mainScreen] bounds];
            NSLog(@"width %f",screenBounds.size.width);
            NSLog(@"height %f",screenBounds.size.height);
            
            
            if (screenBounds.size.height==568 && screenBounds.size.width==320)
            {
                
                subview.frame=CGRectMake(0, 0, self.view.frame.size.width, subview.frame.size.height);
            }
            else
            {
                subview.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-48);
            }
            
            addPayoutPopupMainViewFrame=subview.mainView.frame;
            
            subview.accountNo.delegate=self;
            subview.nameOnAccount.delegate=self;
            subview.bankName.delegate=self;
            subview.addresstextfield.delegate=self;
            subview.satetextfield.delegate=self;
            subview.citytextfield.delegate=self;
            subview.nameOnAccount.delegate=self;
            subview.accountNo.delegate=self;
            subview.nameOnAccount.delegate=self;
            subview.accountNo.delegate=self;
            subview.postaltextfield.delegate=self;
            
            
            
            mainscroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-48)];
            [mainscroll setShowsVerticalScrollIndicator:NO];
            [mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, subview.frame.size.height)];
            [mainscroll addSubview:subview];
            [self.view addSubview:mainscroll];
            
            
            subview.addresstextfield.delegate=self;
            //subview.address2textfield.delegate=self;
            subview.satetextfield.delegate=self;
            subview.citytextfield.delegate=self;
            subview.postaltextfield.delegate=self;
            
            
            [subview.closesubviewbtn addTarget:self action:@selector(close2) forControlEvents:UIControlEventTouchUpInside];
            
            
            [subview.nameofcountrybtn addTarget:self action:@selector(countryname) forControlEvents:UIControlEventTouchUpInside];
            
            
            [subview.nextbtn addTarget:self action:@selector(nextbtntapped:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            
    
    }

    else  if(actionSheet==actionSheetPaypal)
    {
        
        if(buttonIndex==0)
        {
            
            NSLog(@"remove action");
            
            
            blackview1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            blackview1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
            
            
            
            UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap1)];
            tapGestureRecognize.delegate = self;
            tapGestureRecognize.numberOfTapsRequired = 1;
            
            [blackview1 addGestureRecognizer:tapGestureRecognize];
            
            
            
            
            popview1=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5)];
            
            
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+50, popview1.frame.size.width-20, popview1.frame.size.height*.42)];
            
            
            UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+20, popview1.frame.size.width-20, 40)];
            
            header.text = @"PAYPAL ACCOUNT DETAILS";
            [header setFont:[UIFont fontWithName:@"Lato" size:16]];
            
            
            
            header.textAlignment = NSTextAlignmentCenter;
            
            [popview1 addSubview:header];
            
            UIView *divider=[[UIView alloc]initWithFrame:CGRectMake(7, header.frame.origin.y+header.frame.size.height +5, popview1.bounds.size.width-14, 1)];
            
            divider.backgroundColor = [UIColor grayColor];
            [popview1 addSubview:divider];
            
            UIImageView *payPal=[[UIImageView alloc]initWithFrame:CGRectMake((popview1.frame.size.width-150)/2, divider.frame.origin.y+divider.frame.size.height +30, 150, 44)];
            payPal.image=[UIImage imageNamed:@"paypal"];
            payPal.alpha=0.2;
            [popview1 addSubview:payPal];
            
            
            [lbl setFont:[UIFont fontWithName:@"Lato" size:14]];
            lbl.numberOfLines =6;
            //lbl.backgroundColor=[UIColor yellowColor];
            
            
            
            lbl.text=@"PayPal is an online payment processing service that allows you to receive payments from Freewilder.To use PayPal with Freewilder, you must have an existing account with PayPal.\n\nEnter the email address associated with your existing PayPal account.";
            lbl.adjustsFontSizeToFitWidth=YES;
            
            
            [popview1 addSubview:lbl];
            
            text = [[UITextField alloc]initWithFrame:CGRectMake(10,lbl.frame.size.height+50, lbl.frame.size.width, 40)];
            
            text.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
            
            text.layer.cornerRadius=5;
            
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
            text.leftView = paddingView;
            text.leftViewMode = UITextFieldViewModeAlways;
            
            text.placeholder=@"Enter Email-Id";
            text.text=cell.detailslabel.text;
            
            
            
            UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview1.bounds.origin.x+100, lbl.frame.size.height+text.frame.size.height+80, lbl.frame.size.width-180, 30)];
            
            
            submit.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
            
            submit.layer.cornerRadius = 5;
            
            [submit setTitle:@"Save" forState:UIControlStateNormal];
            // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
            [submit addTarget:self action:@selector(submitPayPalDetails:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [popview1 addSubview:submit];
            
            text.delegate=self;
            
            [text setFont:[UIFont fontWithName:@"Lato" size:14]];
            
            [popview1 addSubview:text];
            
            
            
            popview1.backgroundColor=[UIColor whiteColor];
            
            popview1.layer.cornerRadius = 10;
            
            [self.view addSubview:blackview1];
            
            [self.view addSubview:popview1];
            [UIView animateWithDuration:.3 animations:^{
                
                
                popview1.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
                
                
            }];
            
        }
        
    }
    else  if(actionSheet==actionSheetDirectMethod)
    {
        
        if(buttonIndex==0)
        {
            
            
            [_mainview setHidden:YES];
            subview=[[addpayoutmethod alloc] init];
            CGRect screenBounds=[[UIScreen mainScreen] bounds];
            NSLog(@"width %f",screenBounds.size.width);
            NSLog(@"height %f",screenBounds.size.height);
            
            
            if (screenBounds.size.height==568 && screenBounds.size.width==320)
            {
                
                subview.frame=CGRectMake(0, 0, self.view.frame.size.width, subview.frame.size.height);
            }
            else
            {
                subview.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-48);
            }
            
            addPayoutPopupMainViewFrame=subview.mainView.frame;
            
            subview.accountNo.delegate=self;
            subview.nameOnAccount.delegate=self;
            subview.bankName.delegate=self;
            subview.addresstextfield.delegate=self;
            subview.satetextfield.delegate=self;
            subview.citytextfield.delegate=self;
            subview.nameOnAccount.delegate=self;
            subview.accountNo.delegate=self;
            subview.nameOnAccount.delegate=self;
            subview.accountNo.delegate=self;
            subview.postaltextfield.delegate=self;
            
            
            
            mainscroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-48)];
            [mainscroll setShowsVerticalScrollIndicator:NO];
            [mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, subview.frame.size.height)];
            [mainscroll addSubview:subview];
            [self.view addSubview:mainscroll];
            
            
            subview.addresstextfield.delegate=self;
            //subview.address2textfield.delegate=self;
            subview.satetextfield.delegate=self;
            subview.citytextfield.delegate=self;
            subview.postaltextfield.delegate=self;
            
            
            [subview.closesubviewbtn addTarget:self action:@selector(close2) forControlEvents:UIControlEventTouchUpInside];
            
            
            [subview.nameofcountrybtn addTarget:self action:@selector(countryname) forControlEvents:UIControlEventTouchUpInside];
            
            
            [subview.nextbtn addTarget:self action:@selector(nextbtntapped:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }

}


-(void)nextbtntapped:(UIButton *)sender
{
    
    //@koustov

    if( [[NSString stringByTrimmingLeadingWhitespace:subview.bankName.text] length]<=0)
   {
   
       subview.bankName.text=@"";
       subview.bankName.placeholder=@"Bank Name";
       
       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please provide name of the bank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [alert show];
   
    }
    else if ([[NSString stringByTrimmingLeadingWhitespace:subview.addresstextfield.text] length]<=0)
    {
    
        subview.addresstextfield.text=@"";
        subview.addresstextfield.placeholder=@"Address";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please provide address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }
    else if ([[NSString stringByTrimmingLeadingWhitespace:subview.countrydatashowlabel.text]isEqualToString:@""] || [[NSString stringByTrimmingLeadingWhitespace:subview.countrydatashowlabel.text]isEqualToString:@"Name of country"])
    {
        
      subview.countrydatashowlabel.text=@"Name of country";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the coutry first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([[NSString stringByTrimmingLeadingWhitespace:subview.satetextfield.text]length]<=0)
    {
        
        subview.satetextfield.text=@"";
        subview.satetextfield.placeholder=@"State";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the state first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([[NSString stringByTrimmingLeadingWhitespace:subview.citytextfield.text]length]<=0)
    {
        
        subview.citytextfield.text=@"";
        subview.citytextfield.placeholder=@"City";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please provide name of the city first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([[NSString stringByTrimmingLeadingWhitespace:subview.postaltextfield.text]length]<=0)
    {
        
        subview.postaltextfield.text=@"";
        subview.postaltextfield.placeholder=@"Postal Code";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please provide postal code first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([[NSString stringByTrimmingLeadingWhitespace:subview.nameOnAccount.text]length]<=0)
    {
        
        subview.nameOnAccount.text=@"";
        subview.nameOnAccount.placeholder=@"Name On Account";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please provide the Name on the account first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([[NSString stringByTrimmingLeadingWhitespace:subview.accountNo.text]length]<=0)
    {
        
        subview.accountNo.text=@"";
        subview.accountNo.placeholder=@"Account No";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please provide the Account No. first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }


       
    else
    {
        
        
        NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_edit_direct?userid=%@&bank_name=%@&bank_address=%@&country=%@&state=%@&city=%@&name_acc=%@&acc_no=%@",App_Domain_Url,userid,subview.bankName.text,subview.addresstextfield.text,country_code,state_code,subview.citytextfield.text,subview.nameOnAccount.text,subview.accountNo.text];
        
        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            if([[result valueForKey:@"response"] isEqualToString:@"success"])
            {
                
                [ self urlfire];
                
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Payout Preference added successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

                
                [subview removeFromSuperview];
                [mainscroll removeFromSuperview];
                
                _mainview.hidden=NO;

                
            }
            
        }];

        
    
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag==1)
    {
      return [countrydata count];
    }
    else if (pickerView.tag==0)
    {    return stateNameArr.count;

    }
    else return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag==1)
    {
        return [countrydata objectAtIndex:row];
    }
    else if (pickerView.tag==0)
    {    return [stateNameArr objectAtIndex:row];
        
    }
    else return nil;
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(pickerView.tag==1)
    {
        holddata=[countrydata objectAtIndex:row];
        
        country_code=[countryCode objectAtIndex:row];
        
        NSLog(@"Country code--- %@",country_code);
        
        subview.countrydatashowlabel.text=[countrydata objectAtIndex:row];
        
    }
    else if (pickerView.tag==0)
    {
        state_code=[stateCodeArr objectAtIndex:row];
        
        subview.satetextfield.text=[stateNameArr objectAtIndex:row];
    }

}



-(void)countryname
{
    subview.nameofcountrybtn .enabled=NO;
    
    [subview.addresstextfield resignFirstResponder];
    //[subview.address2textfield resignFirstResponder];
    [subview.satetextfield resignFirstResponder];
    [subview.citytextfield resignFirstResponder];
    [subview.postaltextfield resignFirstResponder];
    
    
    _pickerviewmain.hidden=NO;
    _mainpickerview.hidden=NO;
    _pickerviewmain.delegate=self;
    _pickerviewmain.dataSource=self;
    _pickerviewmain.tag=1;
    

    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        _mainpickerview.frame=CGRectMake(_mainpickerview.frame.origin.x, self.view.frame.size.height-_mainpickerview.frame.size.height, _mainpickerview.frame.size.width, _mainpickerview.frame.size.height);
        
    }];
    
    
    
    [self.view addSubview:_mainpickerview];
    
    
    if (holddata.length>0)
    {
        
    }
    else
    {
    
    holddata=[countrydata objectAtIndex:0];
    }
    
    
    
}



-(void)close2
{
    [mainscroll removeFromSuperview];
    [_mainview setHidden:NO];
    _mainpickerview.hidden=YES;
    _pickerviewmain.hidden=YES;
    
}


- (IBAction)pickercancelbtn:(id)sender
{
    subview.nameofcountrybtn .enabled=YES;
    
    if(holddata.length>0)
    {
        
    }
    else
    {
        subview.countrydatashowlabel.text=@"Name of country";
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _mainpickerview.frame=CGRectMake(_mainpickerview.frame.origin.x, [UIScreen mainScreen].bounds.size.height, _mainpickerview.frame.size.width, _mainpickerview.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        _mainpickerview.hidden=YES;
        _pickerviewmain.hidden=YES;
        
    }];
    [mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, subview.frame.size.height)];
    
}
- (IBAction)pickersubmitbtn:(id)sender
{

    if(_pickerviewmain.tag==1)
    {
    
        subview.nameofcountrybtn.enabled=YES;
        
        subview.countrydatashowlabel.text=holddata;
        
        if(countryCode.count>0)
        {
            
            if(![country_code isKindOfClass:[NSString class]])
            {
                
                country_code=[countryCode objectAtIndex:0];
                
            }
            
        }
        
        subview.satetextfield.userInteractionEnabled=YES;
    
    
    }
    else if (_pickerviewmain.tag==0)
    {
    
        subview.nameofcountrybtn.enabled=YES;

       if( [subview.satetextfield.text length]==0)
       {
       
           subview.satetextfield.text=[stateNameArr objectAtIndex:0];
       
       
       }
    
    
    }
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _mainpickerview.frame=CGRectMake(_mainpickerview.frame.origin.x, [UIScreen mainScreen].bounds.size.height, _mainpickerview.frame.size.width, _mainpickerview.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        _mainpickerview.hidden=YES;
        _pickerviewmain.hidden=YES;
    }];
    
    [mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, subview.frame.size.height)];
}




//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    _mainpickerview.hidden=YES;
//    _pickerviewmain.hidden=YES;
//    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    
//    
//    if (textField==text)
//    {
//        [UIView animateWithDuration:.3 animations:^{
//       
//             popview.frame =CGRectMake(10, self.view.frame.size.height * .10, self.view.frame.size.width-20, self.view.frame.size.height * .5);
//        
//        
//        }];
//        
//       
//    }
//    
//    
//    NSLog(@"tapped1");
//    return YES;
//}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        subview.mainView.frame=addPayoutPopupMainViewFrame;
        
    }];
    
    
    if (textField==text)
    {
        [UIView animateWithDuration:.3 animations:^{
            
            
            
            popview1.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
            
        }];
 
    }
    
    
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField==subview.postaltextfield || textField==subview.nameOnAccount || textField==subview.accountNo)
    
    [UIView animateWithDuration:0.4 animations:^{
        
        subview.mainView.frame=CGRectMake(subview.mainView.frame.origin.x,textField.frame.origin.y-textField.frame.size.height*10, subview.mainView.frame.size.width, subview.mainView.frame.size.height);
        
    }];
    
    
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//
//   if(textField==subview.postaltextfield || textField==subview.accountNo)
//   {
//   
//       NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//       NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:textField.text];
//       
//       BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
//       
//       if(stringIsValid==NO)
//       {
//            string=@"";
//       
//       }
//       
//       
//       return stringIsValid;
//   
//   
//   }
//   else
//       return YES;
//
//}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"method_type"] isEqualToString:@"Paypal"])
    {
    
        return 64.0f;
        
    
    }
    
    else return 98.0f;


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [payoutdata count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if([[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"method_type"] isEqualToString:@"Paypal"])
    {
      cell =(payoutCell *)[tableView dequeueReusableCellWithIdentifier:@"payout"];
      cell.detailslabel.text=[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"payout_details"] ;
      cell.methodslabel.text=[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"method_type"] ;
      cell.headerLbl.text=[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"method_type"] ;
        
        if([[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"payment_status"] isEqualToString:@"0"])
        {
            cell.statusImageView.image=[UIImage imageNamed:@"pending"];
        
        }
        
        cell.editBtn.tag=indexPath.row;
        cell.deleteBtn.tag=indexPath.row;
        
        [cell.editBtn addTarget:self action:@selector(editPaypal:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBtn addTarget:self action:@selector(deletePaypal:) forControlEvents:UIControlEventTouchUpInside];
   
    
    return cell;

    }
    else if([[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"method_type"] isEqualToString:@"Direct Method"])
    {
        payPalCell=[tableView dequeueReusableCellWithIdentifier:@"paypal"];
        payPalCell.bankName.text=[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"bank_name"];
        payPalCell.customerName.text=[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"payout_details"];
        payPalCell.accountNumber.text=[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"acc_no"];
        payPalCell.headerLbl.text=[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"method_type"];
        
        
        if([[[payoutdata objectAtIndex:indexPath.row]valueForKey:@"payment_status"] isEqualToString:@"0"])
        {
            payPalCell.statusImageView.image=[UIImage imageNamed:@"pending"];
            
        }
        
        payPalCell.editBtn.tag=indexPath.row;
        payPalCell.deleteBtn.tag=indexPath.row;
        
        [payPalCell.editBtn addTarget:self action:@selector(editDirectMethod:) forControlEvents:UIControlEventTouchUpInside];
        [payPalCell.deleteBtn addTarget:self action:@selector(deleteDirectMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        return payPalCell;
    }
    
    else return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
        
    {
        
    }
    
    
    
}

#pragma mark-Editing & Deleting Payout Methods

-(void)editPaypal:(UIButton *)sender
{

    
    {
        
        NSLog(@"remove action");
        
        
        blackview1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        blackview1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap1)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [blackview1 addGestureRecognizer:tapGestureRecognize];
        
        
        
        
        popview1=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .5)];
        
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+50, popview1.frame.size.width-20, popview1.frame.size.height*.42)];
        
        
        UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview1.bounds.origin.y+20, popview1.frame.size.width-20, 40)];
        
        header.text = @"PAYPAL ACCOUNT DETAILS";
        [header setFont:[UIFont fontWithName:@"Lato" size:16]];
        
        
        
        header.textAlignment = NSTextAlignmentCenter;
        
        [popview1 addSubview:header];
        
        UIView *divider=[[UIView alloc]initWithFrame:CGRectMake(7, header.frame.origin.y+header.frame.size.height +5, popview1.bounds.size.width-14, 1)];
        
         divider.backgroundColor = [UIColor grayColor];
        [popview1 addSubview:divider];
        
        UIImageView *payPal=[[UIImageView alloc]initWithFrame:CGRectMake((popview1.frame.size.width-150)/2, divider.frame.origin.y+divider.frame.size.height +30, 150, 44)];
        payPal.image=[UIImage imageNamed:@"paypal"];
        payPal.alpha=0.2;
        [popview1 addSubview:payPal];
        
        
        [lbl setFont:[UIFont fontWithName:@"Lato" size:14]];
        lbl.numberOfLines =6;
        //lbl.backgroundColor=[UIColor yellowColor];
        
        
        
        lbl.text=@"PayPal is an online payment processing service that allows you to receive payments from Freewilder.To use PayPal with Freewilder, you must have an existing account with PayPal.\n\nEnter the email address associated with your existing PayPal account.";
        lbl.adjustsFontSizeToFitWidth=YES;
        
        
        [popview1 addSubview:lbl];
        
        text = [[UITextField alloc]initWithFrame:CGRectMake(10,lbl.frame.size.height+50, lbl.frame.size.width, 40)];
        
        text.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
        
        text.layer.cornerRadius=5;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        text.leftView = paddingView;
        text.leftViewMode = UITextFieldViewModeAlways;
        
        text.placeholder=@"Enter Email-Id";
        text.text=cell.detailslabel.text;
        
        
        
        UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview1.bounds.origin.x+100, lbl.frame.size.height+text.frame.size.height+80, lbl.frame.size.width-180, 30)];
        
        
        submit.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:173.0/255.0f blue:79.0/255.0f alpha:1.0];
        
        submit.layer.cornerRadius = 5;
        
        [submit setTitle:@"Save" forState:UIControlStateNormal];
        // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(submitPayPalDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [popview1 addSubview:submit];
        
        text.delegate=self;
        
        [text setFont:[UIFont fontWithName:@"Lato" size:14]];
        
        [popview1 addSubview:text];
        
        
        
        popview1.backgroundColor=[UIColor whiteColor];
        
        popview1.layer.cornerRadius = 10;
        
        [self.view addSubview:blackview1];
        
        [self.view addSubview:popview1];
        [UIView animateWithDuration:.3 animations:^{
            
            
            
            popview1.frame =CGRectMake(10, self.view.frame.size.height * .25, self.view.frame.size.width-20, self.view.frame.size.height * .5);
            
            
            
            
        }];
        
        
        
        
        
        
        
    }

}
-(void)deletePaypal:(UIButton *)sender
{
    NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_payout_del_paypal?userid=%@&payout_id=%@",App_Domain_Url,userid,[[payoutdata objectAtIndex:sender.tag]valueForKey:@"id"]];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        if([[result valueForKey:@"response"] isEqualToString:@"success"])
        {
            
            noPayPal=nil;
            noDirectMethod=nil;
            noMethodAdded=nil;
            
            [self urlfire];
            
        }
        
    }];
    

    
}
-(void)editDirectMethod:(UIButton *)sender
{
    
    
}
-(void)deleteDirectMethod:(UIButton *)sender
{
    NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_payout_del_bank?userid=%@&payout_id=%@",App_Domain_Url,userid,[[payoutdata objectAtIndex:sender.tag]valueForKey:@"id"]];
    
    [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        if([[result valueForKey:@"response"] isEqualToString:@"success"])
        {
            noPayPal=nil;
            noDirectMethod=nil;
            noMethodAdded=nil;
            
            [self urlfire];
            
        }
        
    }];
    
}

#pragma mark-


#pragma mark-Payment Method Details button action

-(IBAction)directPayementDetails:(id)sender
{

   

}

-(IBAction)payPalPayementDetails:(id)sender
{
    
    
    
}


#pragma mark-


-(void)cancelByTap1
{
    
    
    
   
    
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        popview1.frame= CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .4);
        
        [text resignFirstResponder];
        
    }
     
                     completion:^(BOOL finished)
     {
         
         
         
         [blackview1 removeFromSuperview];
         [popview1 removeFromSuperview];
         
         
         
         
     }];
    
}


-(void)submitPayPalDetails:(id)sender
{
    NSLog(@"Paypal Submit");
    
    if([NSString isEmailAddress:text.text])
    {
    
        NSLog(@"Yes it's a valid email address....");
        
        
        NSString *url = [NSString stringWithFormat:@"%@app_user_service/app_edit_paypal?userid=%@&paypal_email=%@",App_Domain_Url,userid,text.text];
        
        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
              if([[result valueForKey:@"response"] isEqualToString:@"success"])
              {
              
                  [ self urlfire];
                  
                  [self cancelByTap1];
              
              }
    
        }];
        
    }
    
}


#pragma mark - Footer related methods

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
    else  if(textField==subview.satetextfield)
    {
        // textField.inputView=_mainpickerview;
        
        
        
        if([subview.countrydatashowlabel.text isEqualToString:@"Name of country"])
        {
        
        
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the coutry first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        
        }
        else
        {
        
            _pickerviewmain.hidden=NO;
            _mainpickerview.hidden=NO;
            
            _pickerviewmain.delegate=self;
            _pickerviewmain.dataSource=self;
            
            _pickerviewmain.tag=0;
            
            
            [self.view addSubview:_mainpickerview];
            
            
            [self getAllTheStates];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                _mainpickerview.frame=CGRectMake(_mainpickerview.frame.origin.x, self.view.frame.size.height-_mainpickerview.frame.size.height, _mainpickerview.frame.size.width, _mainpickerview.frame.size.height);
                
            }];

        
        }
        
        return NO;
    }

    
    
    
    return YES;
}


-(void)getAllTheStates
{

    NSString *urlstring=[NSString stringWithFormat:@"%@app_user_service/app_state?country_id=%@",App_Domain_Url,country_code];
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error){
        NSLog(@"states------>\n %@",result);
        
        tempdata=[[result valueForKey:@"infoarray"] mutableCopy];
        stateNameArr=[tempdata valueForKey:@"state_name"];
        stateCodeArr=[tempdata valueForKey:@"state_id"];
        
        [_pickerviewmain reloadAllComponents];
        
    }];

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

#pragma mark-


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



- (IBAction)backTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
