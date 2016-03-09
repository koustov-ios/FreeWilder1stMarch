//
//  ViewOrderDetailsViewController.m
//  FreeWilder
//
//  Created by subhajit ray on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ViewOrderDetailsViewController.h"

#pragma mark - Footer related imports

#import "FW_JsonClass.h"
#import "Side_menu.h"
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
#import "BusinessProfileViewController.h"
#import "sideMenu.h"


@interface ViewOrderDetailsViewController ()<UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,UITextViewDelegate,sideMenu,UITextFieldDelegate>

{
    
    sideMenu *leftMenu;
    
    IBOutlet UIButton *confirmBtn;
    IBOutlet UIButton *cancelBtn;
    UIView *blackOverlayView,*commentBoxView;
    UITextView *commentBox;
    CGRect commentboxFrame,crossbtnframe;
    UIButton *crossbtn;


#pragma mark - Footer variables
    
    Side_menu *sidemenu;
    UIView *overlay;
    NSMutableArray *ArrProductList;
    AppDelegate *appDelegate;
    bool data;
    UIView *loader_shadow_View;
    IBOutlet UIView *footer_base;
    BOOL tapchk,tapchk1,tapchk2;
    NSMutableArray *jsonArray,*temp;
    UIView *blackview ,*popview;
    NSString *phoneno;
    ServiceView *service;
    profile *profileview;
    UITextField *phoneText;
    accountsubview *subview;
    FW_JsonClass *globalobj;
    NSString *userid;


}

@end

@implementation ViewOrderDetailsViewController

@synthesize fromManageButtnAction;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    ///Side menu ends here

    
    _mainscrollview.contentSize=CGSizeMake(0, 714);
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    NSLog(@"seceen%f",screenBounds.size.width);
    NSLog(@"seceen%f",screenBounds.size.height);
    
    confirmBtn.layer.cornerRadius=6.0f;
    confirmBtn.clipsToBounds=YES;
    
    cancelBtn.layer.cornerRadius=6.0f;
    cancelBtn.clipsToBounds=YES;
    
    [_cancelbtn addTarget:self action:@selector(backToPrevViewController) forControlEvents:UIControlEventTouchUpInside];
    
    if(fromManageButtnAction==YES)
    {
    
        cancelBtn.frame=CGRectMake(cancelBtn.frame.origin.x, cancelBtn.frame.origin.y, cancelBtn.frame.size.width,0);
        confirmBtn.frame=CGRectMake(confirmBtn.frame.origin.x, confirmBtn.frame.origin.y, confirmBtn.frame.size.width,0);
    
    }
    else
    {
    
        [cancelBtn addTarget:self action:@selector(statusChangeCancelTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [confirmBtn addTarget:self action:@selector(statusChangeConfirmTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    
    if (screenBounds.size.width==414 && screenBounds.size.height==736 )
    {
        [_cancelbtn setFrame:CGRectMake(_paymentstatuslabel.frame.origin.x, confirmBtn.frame.origin.y+confirmBtn.frame.size.height +4,_paymentstatuslabel.frame.size.width, 34)];
        
        _cancelbtn.layer.cornerRadius=6.0f;
        _cancelbtn.clipsToBounds=YES;
    }
    else
    {
        [_cancelbtn setFrame:CGRectMake(_paymentstatuslabel.frame.origin.x, confirmBtn.frame.origin.y+confirmBtn.frame.size.height +4,_paymentstatuslabel.frame.size.width, 34)];
        
        _cancelbtn.layer.cornerRadius=6.0f;
        _cancelbtn.clipsToBounds=YES;
    }
    
    
    NSLog(@"next page data %@",_holddata);
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer_base addSubview:footer];
    temp= [[NSMutableArray alloc]init];
    
    
    //------>
    
    
    
    NSString *yourString = [NSString stringWithFormat:@"Buyer Name:   %@",[_holddata valueForKey:@"buyer_name"]];
    NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
    NSString *boldString =@"Buyer Name:";
    NSRange boldRange = [yourString rangeOfString:boldString];
    
    [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange];
    [_buyernamelabel setAttributedText:yourAttributedString];
    
    
    
    
    
    NSString *yourString3 = [NSString stringWithFormat:@"Product Name:   %@",[_holddata valueForKey:@"service_name"]];
    NSMutableAttributedString *yourAttributedString3 = [[NSMutableAttributedString alloc] initWithString:yourString3];
    NSString *boldString3 =@"Product Name:";
    NSRange boldRange3 = [yourString3 rangeOfString:boldString3];
    
    [yourAttributedString3 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange3];
    [_productnamelabel setAttributedText:yourAttributedString3];
    
    
    
    
    NSString *yourString4 = [NSString stringWithFormat:@"Price:   %@",[_holddata valueForKey:@"price"]];
    NSMutableAttributedString *yourAttributedString4 = [[NSMutableAttributedString alloc] initWithString:yourString4];
    NSString *boldString4 =@"Price:";
    NSRange boldRange4 = [yourString4 rangeOfString:boldString4];
    
    [yourAttributedString4 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange4];
    [_pricelabel setAttributedText:yourAttributedString4];
    
    
    
    
    
    NSString *yourString5 = [NSString stringWithFormat:@"Quantity:   %@",[_holddata valueForKey:@"quantity"]];
    NSMutableAttributedString *yourAttributedString5 = [[NSMutableAttributedString alloc] initWithString:yourString5];
    NSString *boldString5 =@"Quantity:";
    NSRange boldRange5 = [yourString5 rangeOfString:boldString5];
    
    [yourAttributedString5 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange5];
    [_quantitylabel setAttributedText:yourAttributedString5];
    
    
    
    
    
    NSString *yourString6 = [NSString stringWithFormat:@"Total Amount:   %@",[_holddata valueForKey:@"total_amount"]];
    NSMutableAttributedString *yourAttributedString6 = [[NSMutableAttributedString alloc] initWithString:yourString6];
    NSString *boldString6=@"Total Amount:";
    NSRange boldRange6 = [yourString6 rangeOfString:boldString6];
    
    [yourAttributedString6 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange6];
    [_totalamountlabel setAttributedText:yourAttributedString6];
    
    
    
    
    
    
    NSString *yourString7 = [NSString stringWithFormat:@"Order date:   %@",[_holddata valueForKey:@"order_date"]];
    NSMutableAttributedString *yourAttributedString7 = [[NSMutableAttributedString alloc] initWithString:yourString7];
    NSString *boldString7=@"Order date:";
    NSRange boldRange7 = [yourString7 rangeOfString:boldString7];
    
    [yourAttributedString7 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange7];
    [_orderdatelabel setAttributedText:yourAttributedString7];
    
    
    NSString *yourString0 = [NSString stringWithFormat:@"Seller Name:   %@",[_holddata valueForKey:@"seller_name"]];
    NSMutableAttributedString *yourAttributedString0 = [[NSMutableAttributedString alloc] initWithString:yourString0];
    NSString *boldString0=@"Seller Name:";
    NSRange boldRange0 = [yourString0 rangeOfString:boldString0];
    
    [yourAttributedString0 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange0];
    [_sellerlabel setAttributedText:yourAttributedString0];
    
    
    
    
    NSString *yourString8 = [NSString stringWithFormat:@"Payment Type:   %@",[_holddata valueForKey:@"payment_type"]];
    NSMutableAttributedString *yourAttributedString8 = [[NSMutableAttributedString alloc] initWithString:yourString8];
    NSString *boldString8=@"Payment Type:";
    NSRange boldRange8 = [yourString8 rangeOfString:boldString8];
    
    [yourAttributedString8 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange8];
    [_paymenttypelabel setAttributedText:yourAttributedString8];
    
    
    
    NSString * chkdata;
    
    
    if ([[_holddata valueForKey:@"status"] isEqualToString:@"C"])
    {
       
        chkdata=@"Confirmed";
    }
    else
    {
        chkdata=@"Pending";
    }
    
    
    
    
    NSString *yourString9 = [NSString stringWithFormat:@"Status:   %@",chkdata];
    NSMutableAttributedString *yourAttributedString9 = [[NSMutableAttributedString alloc] initWithString:yourString9];
    NSString *boldString9=@"Status:";
    NSRange boldRange9= [yourString9 rangeOfString:boldString9];
    
    [yourAttributedString9 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange9];
    [_statuslabel setAttributedText:yourAttributedString9];
    
    NSString *chkdata2;
    
    if ([[_holddata valueForKey:@"payment_status"] isEqualToString:@"Y"])
    {
        chkdata2=@"Confirmed";
    }
    else
    {
        chkdata2=@"Pending";
    }
    
    
    
    
    NSString *yourString10 = [NSString stringWithFormat:@"Payment Status:   %@",chkdata2];
    NSMutableAttributedString *yourAttributedString10 = [[NSMutableAttributedString alloc] initWithString:yourString10];
    NSString *boldString10=@"Payment Status:";
    NSRange boldRange10= [yourString10 rangeOfString:boldString10];
    
    [yourAttributedString10 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:boldRange10];
    [_paymentstatuslabel setAttributedText:yourAttributedString10];
    
    
    
    
    
}

-(void)statusChangeCancelTapped:(UIButton *)sender
{
    blackOverlayView=[[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:blackOverlayView];
    blackOverlayView.backgroundColor=[UIColor blackColor];
    blackOverlayView.alpha=0.0;
    
    commentBoxView=[[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, -self.view.bounds.size.height/2.6, self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6)];
    [self.view addSubview:commentBoxView];
    commentBoxView.layer.cornerRadius=7.0f;
    commentBoxView.clipsToBounds=YES;
    commentBoxView.backgroundColor=[UIColor whiteColor];
    
    
    
    commentBox=[[UITextView alloc]initWithFrame:CGRectMake(9, 45, commentBoxView.frame.size.width-18, self.view.bounds.size.height/5)];
    commentBox.delegate=self;
    commentBox.backgroundColor=[UIColor greenColor];
    [commentBoxView addSubview:commentBox];
    
    commentBox.layer.cornerRadius=6;
    commentBox.clipsToBounds=YES;
    CGFloat borderWidth = 1.0f;
    commentBox.backgroundColor=[UIColor clearColor];
    commentBox.layer.borderColor = [UIColor darkGrayColor].CGColor;
    commentBox.layer.borderWidth = borderWidth;
    
    UIButton *commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(commentBox.frame.origin.x, commentBox.frame.size.height+commentBox.frame.origin.y+6, commentBox.frame.size.width, 40)];
    [commentBtn addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setTitle:@"POST COMMENT" forState:UIControlStateNormal];
    commentBtn.backgroundColor=[UIColor colorWithRed:24.0f/256 green:181.0f/256 blue:124.0f/256 alpha:1];
    commentBtn.titleLabel.textColor=[UIColor whiteColor];
    [commentBoxView addSubview:commentBtn];
    commentBtn.layer.cornerRadius=6;
    commentBtn.clipsToBounds=YES;
    
    
    
    UILabel *headingLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, commentBoxView.bounds.size.width, 18)];
    headingLbl.textAlignment=NSTextAlignmentCenter;
    headingLbl.text=[NSString stringWithFormat:@"COMMENT"];
    [commentBoxView addSubview:headingLbl];
    headingLbl.textColor=[UIColor darkGrayColor];
    headingLbl.backgroundColor=[UIColor colorWithRed:240.0f/256 green:240.0f/256 blue:240.0f/256 alpha:1];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        
    } completion:^(BOOL finished) {
        
        //[blackOverlayView removeFromSuperview];
        
        [UIView animateWithDuration:0.4 animations:^{
            
            
            commentBoxView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, (self.view.bounds.size.height-(self.view.bounds.size.height/2.6))/2, self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6);
            
            
            
            commentboxFrame=commentBoxView.frame;
        }completion:^(BOOL finished) {
            
            crossbtn=[[UIButton alloc]initWithFrame:CGRectMake(commentBoxView.frame.origin.x-15, commentBoxView.frame.origin.y-15, 30, 30)];
            [crossbtn setBackgroundImage:[UIImage imageNamed:@"close-128"] forState:UIControlStateNormal];
            [self.view addSubview:crossbtn];
            crossbtnframe=crossbtn.frame;
            [crossbtn addTarget:self action:@selector(crossBtnTapped) forControlEvents:UIControlEventTouchUpInside];
            
        }];
        
    }];
    
    
    
}
-(void)statusChangeConfirmTapped:(UIButton *)sender
{
    blackOverlayView=[[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:blackOverlayView];
    blackOverlayView.backgroundColor=[UIColor blackColor];
    blackOverlayView.alpha=0.0;
    
    commentBoxView=[[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, -self.view.bounds.size.height/2.6, self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6)];
    [self.view addSubview:commentBoxView];
    commentBoxView.layer.cornerRadius=7.0f;
    commentBoxView.clipsToBounds=YES;
    commentBoxView.backgroundColor=[UIColor whiteColor];
    

    
    commentBox=[[UITextView alloc]initWithFrame:CGRectMake(9, 45, commentBoxView.frame.size.width-18, self.view.bounds.size.height/5)];
    commentBox.delegate=self;
    commentBox.backgroundColor=[UIColor greenColor];
    [commentBoxView addSubview:commentBox];
    
    commentBox.layer.cornerRadius=6;
    commentBox.clipsToBounds=YES;
    CGFloat borderWidth = 1.0f;
    commentBox.backgroundColor=[UIColor clearColor];
    commentBox.layer.borderColor = [UIColor darkGrayColor].CGColor;
    commentBox.layer.borderWidth = borderWidth;

    UIButton *commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(commentBox.frame.origin.x, commentBox.frame.size.height+commentBox.frame.origin.y+6, commentBox.frame.size.width, 40)];
    [commentBtn addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setTitle:@"POST COMMENT" forState:UIControlStateNormal];
    commentBtn.backgroundColor=[UIColor colorWithRed:24.0f/256 green:181.0f/256 blue:124.0f/256 alpha:1];
    commentBtn.titleLabel.textColor=[UIColor whiteColor];
    [commentBoxView addSubview:commentBtn];
    commentBtn.layer.cornerRadius=6;
    commentBtn.clipsToBounds=YES;
    
    
    
    UILabel *headingLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, commentBoxView.bounds.size.width, 18)];
    headingLbl.textAlignment=NSTextAlignmentCenter;
    headingLbl.text=[NSString stringWithFormat:@"COMMENT"];
    [commentBoxView addSubview:headingLbl];
    headingLbl.textColor=[UIColor darkGrayColor];
    headingLbl.backgroundColor=[UIColor colorWithRed:240.0f/256 green:240.0f/256 blue:240.0f/256 alpha:1];

    [UIView animateWithDuration:0.2 animations:^{
        
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        blackOverlayView.alpha+=0.1;
        
    } completion:^(BOOL finished) {
        
        //[blackOverlayView removeFromSuperview];
        
        [UIView animateWithDuration:0.4 animations:^{
            
            
            commentBoxView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, (self.view.bounds.size.height-(self.view.bounds.size.height/2.6))/2, self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6);
            
           
            
            commentboxFrame=commentBoxView.frame;
        }completion:^(BOOL finished) {
        
            crossbtn=[[UIButton alloc]initWithFrame:CGRectMake(commentBoxView.frame.origin.x-15, commentBoxView.frame.origin.y-15, 30, 30)];
            [crossbtn setBackgroundImage:[UIImage imageNamed:@"close-128"] forState:UIControlStateNormal];
            [self.view addSubview:crossbtn];
            crossbtnframe=crossbtn.frame;
            [crossbtn addTarget:self action:@selector(crossBtnTapped) forControlEvents:UIControlEventTouchUpInside];

        
        }];
        
    }];
    


}

-(void)crossBtnTapped
{
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        // [commentBoxView removeFromSuperview];
        
        [crossbtn removeFromSuperview];
        
        commentBoxView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, -self.view.bounds.size.height/2.6, self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6);
        
        blackOverlayView.alpha-=0.1;
        blackOverlayView.alpha-=0.1;
        blackOverlayView.alpha-=0.1;
        blackOverlayView.alpha-=0.1;
        blackOverlayView.alpha-=0.2;
        
        [blackOverlayView removeFromSuperview];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}



-(void)postComment:(id)sender
{
    
    if([[commentBox.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0)
    {
    
        userid=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"];
        NSString *url= [NSString stringWithFormat:@"%@app_category/manage_view?booking_id=%@&userid=%@&message=%@",App_Domain_Url,[_holddata valueForKey:@"booking_id"],userid,commentBox.text];
        url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@">>>>>>> URL >>>>>> \n %@",url);
        
         globalobj=[[FW_JsonClass alloc]init];
        
        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            NSLog(@"Result >>>>>>>>>> %@",result);
            
                    if ([[result valueForKey:@"response" ]isEqualToString:@"success"])
                    {
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Confirmation message succefully receieved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        
                        
                        [UIView animateWithDuration:0.4 animations:^{
                            
                            [crossbtn removeFromSuperview];
                            commentBoxView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, -self.view.bounds.size.height/2.6, self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6);
                            
                            blackOverlayView.alpha-=0.1;
                            blackOverlayView.alpha-=0.1;
                            blackOverlayView.alpha-=0.1;
                            blackOverlayView.alpha-=0.1;
                            blackOverlayView.alpha-=0.2;
                            
                            [blackOverlayView removeFromSuperview];
                            
                        } completion:^(BOOL finished) {
                            
                            
                        }];

                        
                    }
            else
            {
                NSString *message=@"Confirmation message sending failed.";
                
                if([[result valueForKey:@"update_message"] isEqualToString:@"buyer_id is already confirm"])
                {
                   message=@"Already confirmation messgae receieved.";
                   
                }
                
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Try again" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                
                [UIView animateWithDuration:0.4 animations:^{
                    
                    [crossbtn removeFromSuperview];
                    commentBoxView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, -self.view.bounds.size.height/2.6, self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6);
                    
                    blackOverlayView.alpha-=0.1;
                    blackOverlayView.alpha-=0.1;
                    blackOverlayView.alpha-=0.1;
                    blackOverlayView.alpha-=0.1;
                    blackOverlayView.alpha-=0.2;
                    
                    [blackOverlayView removeFromSuperview];
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
            
            }
            
            
        }];
        

        
    
    }
    else
    {
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enter a valid comment." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }
    
    
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{

    commentBoxView.frame=CGRectMake((self.view.bounds.size.width-(self.view.bounds.size.width/1.2))/2, (self.view.bounds.size.height-(self.view.bounds.size.height/2.6))/2-(50), self.view.bounds.size.width/1.2, self.view.bounds.size.height/2.6);
    
    crossbtn.frame=CGRectMake(commentBoxView.frame.origin.x-15, commentBoxView.frame.origin.y-15, 30, 30);


}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        [UIView animateWithDuration:0.3 animations:^{
            
             commentBoxView.frame=commentboxFrame;
            crossbtn.frame=crossbtnframe;
            
        }];
        return NO;
    }
    
    return YES;
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

//------Side menu methods end here





//-(void)side
//{
//    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
//    // overlay.hidden=YES;
//    //overlay.userInteractionEnabled=YES;
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
//    }
//    
//    else
//    {
//        
//        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
//        
//    }
//    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    //  //(@"user name=%@",[prefs valueForKey:@"UserName"]);
//    sidemenu.lblUserName.text=[prefs valueForKey:@"UserName"];
//    
//    [sidemenu.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[prefs valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
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
//    }];
//    
//    
//    sidemenu.SlideDelegate=self;
//    [self.view addSubview:sidemenu];
//    
//    
//}
//
//
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
                // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}

-(void)backToPrevViewController
{

    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];


}

- (IBAction)backbtntapped:(id)sender
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}
@end
