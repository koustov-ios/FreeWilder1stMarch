//
//  DetailReviewViewController.m
//  FreeWilder
//
//  Created by Prosenjit Kolay on 30/11/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "DetailReviewViewController.h"
#import "FW_JsonClass.h"
#import "UIImageView+WebCache.h"
#define ButtonWidth 30
#define kLabelFrameMaxSize CGSizeMake(265.0, 200.0)

@interface DetailReviewViewController ()
{
    FW_JsonClass *globalobj;
    UILabel *lblOverall,*lblQuality,*lblService;
    UILabel *lblReviewDecs,*lblUserName,*lblRevLoct,*lblRevDate;
    UILabel *lblRevDecs;
    UIImageView *ImgRate,*ImgRate1,*ImgRate2;
    NSString *RateCount,*RateCount1,*RateCount2,*totalReview;
    NSMutableArray *ArrDictRevDesc,*ArrRevDesc;
    NSMutableDictionary *DictReview;
    UIImageView *UserImg;
    UITableViewCell  *cell;
}

@end

@implementation DetailReviewViewController
@synthesize Rtableview,serviceIde,UserIde;
- (void)viewDidLoad {
    [super viewDidLoad];
      globalobj=[[FW_JsonClass alloc]init];
    ArrRevDesc=[[NSMutableArray alloc]init];
    ArrDictRevDesc=[[NSMutableArray alloc]init];
    DictReview=[[NSMutableDictionary alloc]init];
    [self UrlCall];

}

#pragma mark Connection URL

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}


-(void) UrlCall
{
    NSString *str=[NSString stringWithFormat:@"%@app_product_det?service_id=%@&userid=%@",App_Domain_Url,self.serviceIde,self.UserIde];
    
    [globalobj GlobalDict:str Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        NSLog(@"%@",result);
        
        ArrRevDesc=[[result valueForKey:@"infoarray"] valueForKey:@"review_desc"];
        NSLog(@"ArrayReviewDescription----%@",ArrRevDesc);
        
        
        
        DictReview=[[result valueForKey:@"infoarray"] valueForKey:@"review_stars"];
        NSLog(@"DictReview+++++++++++%@",DictReview);
        
        //        RateCount=(long)[[DictReview valueForKey:@"overall_review"] longValue];
        //        NSLog(@"-----+++++++++RateCount--------%ld",RateCount);
        //         RateCount1=(long)[[DictReview valueForKey:@"quality_review "] longValue];
        //         RateCount2=(long)[[DictReview valueForKey:@"service_review"] longValue];
        
        // totalReview=(long)[[DictReview valueForKey:@"total_review"] longValue];
        
        
        RateCount=[[[result valueForKey:@"infoarray"] valueForKey:@"review_stars"] valueForKey:@"overall_review"];
        NSLog(@"RATECOUNTTTTTTTTTTTTTTTTTTTTTT+++++++++++%@",RateCount);
        RateCount1=[[[result valueForKey:@"infoarray"] valueForKey:@"review_stars"] valueForKey:@"quality_review"];
        NSLog(@"RATECOUNTTTTTTTTTTTTTTTTTTTTTT+++++++++++%@",RateCount1);
        RateCount2=[[[result valueForKey:@"infoarray"] valueForKey:@"review_stars"] valueForKey:@"service_review"];
        NSLog(@"RATECOUNTTTTTTTTTTTTTTTTTTTTTT+++++++++++%@",RateCount2);
        
        
        
        
        for (int i=0; i< ArrRevDesc.count; i++) {
            
            
            NSString *UsrImg=[NSString stringWithFormat:@"%@",[ArrRevDesc [i] objectForKey:@"user_image"]];
            NSLog(@"UsrImg%@",UsrImg);
            NSString *UsrName=[NSString stringWithFormat:@"%@",[ArrRevDesc [i] objectForKey:@"user_name"]];
            NSLog(@"UsrName%@",UsrName);
            NSString *Revdesc=[NSString stringWithFormat:@"%@",[ArrRevDesc [i] objectForKey:@"review_desc"]];
            NSLog(@"UsrImg%@",Revdesc);
            NSString *loc=[NSString stringWithFormat:@"%@",[ArrRevDesc [i] objectForKey:@"place"]];
            NSLog(@"UsrName%@",loc);
            NSString *RevDate=[NSString stringWithFormat:@"%@",[ArrRevDesc [i] objectForKey:@"review_date"]];
            NSLog(@"RevDate%@",RevDate);
            
            NSMutableDictionary *Dictn=[[NSMutableDictionary alloc]init];
            [Dictn setValue:UsrImg forKey:@"user_image"];
            [Dictn setValue:UsrName forKey:@"user_name"];
            [Dictn setValue:Revdesc forKey:@"review_desc"];
            [Dictn setValue:loc forKey:@"place"];
            [Dictn setValue:RevDate forKey:@"review_date"];
            
            [ArrDictRevDesc addObject:Dictn];
            
            
            [Rtableview reloadData];
            
            
        }
        NSLog(@"---------888888----Review%@",ArrDictRevDesc);
        
        // NSLog(@"---====arraydict%@",arrayDict);
        
        
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
    return 1;
    }
    if(section==1)
    {
        return ArrDictRevDesc.count;
    }
    else
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 60.0f;
    if(section==1)
    {
        return 00.0f;
    }
    
    else
        return 00.0f;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    if(cell==nil)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    }
    
    if(indexPath.section==0 && indexPath.row==0)
    {
        
            lblOverall=[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.origin.x+30,cell.frame.origin.y,cell.frame.size.width/3-20,cell.frame.size.height/3+20)];
            lblOverall.textColor = [UIColor blackColor];
            lblOverall.text=@"Overall";
            //lblOverall.backgroundColor=[UIColor redColor];
            
            lblQuality=[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.origin.x+30,lblOverall.frame.origin.y+lblOverall.frame.size.height,cell.frame.size.width/3-20,cell.frame.size.height/3+20)];
            lblQuality.textColor = [UIColor blackColor];
            lblQuality.text=@"Quality";
            // lblQuality.backgroundColor=[UIColor redColor];
            
            lblService=[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.origin.x+30,lblQuality.frame.origin.y+lblQuality.frame.size.height-5,cell.frame.size.width/3-20,cell.frame.size.height/3+20)];
            lblService.textColor = [UIColor blackColor];
            lblService.text=@"Service";
            // lblService.backgroundColor=[UIColor redColor];
            cell.backgroundColor=[UIColor colorWithRed:(245/255.0) green:(249/255.0) blue:(250/255.0) alpha:1];
            
            
            
            for(int ImgIndex=1;ImgIndex<6;ImgIndex++)
            {
                ImgRate=[[UIImageView alloc]init];
                
                
                
                //NSString *str=[NSString stringWithFormat:@"%d",ImgIndex];
                int chk =(int)[RateCount integerValue];
                
                if (ImgIndex<=chk)
                {
                    [ImgRate setImage:[UIImage imageNamed:@"Star Filled-50"]];
                    ImgRate.frame=CGRectMake(cell.frame.size.width/2-70+ButtonWidth*ImgIndex, cell.frame.origin.y+10, 20, 20);
                    [ImgRate setTag:ImgIndex];
                }
                else
                {
                    ImgRate.frame=CGRectMake(cell.frame.size.width/2-70+ButtonWidth*ImgIndex, cell.frame.origin.y+10, 20, 20);
                    [ImgRate setImage:[UIImage imageNamed:@"Star-50"]];
                    
                }
                
                [cell.contentView addSubview:ImgRate];
                
            }
            
            
            
            for(int ImgIndex=1;ImgIndex<6;ImgIndex++)
            {
                ImgRate1=[[UIImageView alloc]init];
                
                // NSString *str=[NSString stringWithFormat:@"%d",ImgIndex];
                int chk =(int)[RateCount1 integerValue];
                
                if(ImgIndex<=chk)
                {
                    [ImgRate1 setImage:[UIImage imageNamed:@"Star Filled-50"]];
                    ImgRate1.frame=CGRectMake(cell.frame.size.width/2-70+ButtonWidth*ImgIndex, lblOverall.frame.origin.y+lblOverall.frame.size.height+5, 20, 20);
                    [ImgRate1 setTag:ImgIndex];
                }
                else
                {
                    ImgRate1.frame=CGRectMake(cell.frame.size.width/2-70+ButtonWidth*ImgIndex, lblOverall.frame.origin.y+lblOverall.frame.size.height+5, 20, 20);
                    [ImgRate1 setImage:[UIImage imageNamed:@"Star-50"]];
                    
                }
                [cell.contentView addSubview:ImgRate1];
                
            }
            
            for(int ImgIndex=1;ImgIndex<6;ImgIndex++)
            {
                ImgRate2=[[UIImageView alloc]init];
                //NSString *str=[NSString stringWithFormat:@"%d",ImgIndex];
                int chk =(int)[RateCount2 integerValue];
                if(ImgIndex<=chk)
                {
                    [ImgRate2 setImage:[UIImage imageNamed:@"Star Filled-50"]];
                    ImgRate2.frame=CGRectMake(cell.frame.size.width/2-70+ButtonWidth*ImgIndex, lblQuality.frame.origin.y+lblQuality.frame.size.height, 20, 20);
                    [ImgRate2 setTag:ImgIndex];
                }
                else
                {
                    ImgRate2.frame=CGRectMake(cell.frame.size.width/2-70+ButtonWidth*ImgIndex, lblQuality.frame.origin.y+lblQuality.frame.size.height, 20, 20);
                    [ImgRate2 setImage:[UIImage imageNamed:@"Star-50"]];
                }
                [cell.contentView addSubview:ImgRate2];
                
            }
            
            [cell.contentView addSubview:lblOverall];
            [cell.contentView addSubview:lblQuality];
            [cell.contentView addSubview:lblService];
            
        }
        
    
    
    if(indexPath.section==1)
    {
        UserImg=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.origin.x+10,cell.frame.origin.y+2,cell.frame.size.width/3-45,cell.frame.size.height/2+40)];
       [UserImg sd_setImageWithURL:[NSURL URLWithString:[[ArrDictRevDesc objectAtIndex:indexPath.row] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];;
       //  UserImg.backgroundColor=[UIColor grayColor];
        UserImg.layer.cornerRadius =UserImg.frame.size.width / 2;
        UserImg.layer.borderWidth = 1.0f;
        UserImg.layer.borderColor = [UIColor whiteColor].CGColor;
        UserImg.clipsToBounds = YES;
        
        UserImg.contentMode = UIViewContentModeScaleAspectFill;
        
        
        
        
        
        lblUserName=[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.origin.x+20,UserImg.frame.origin.y+UserImg.frame.size.height+10,cell.frame.size.width/3-40,cell.frame.size.height/3)];
        lblUserName.textColor = [UIColor blackColor];
        lblUserName.text=[[ArrDictRevDesc objectAtIndex:indexPath.row] valueForKey:@"user_name"];
        lblUserName.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
       // lblUserName.backgroundColor=[UIColor redColor];
        
        
        lblRevLoct=[[UILabel alloc]initWithFrame:CGRectMake(UserImg.frame.origin.x+UserImg.frame.size.width+12,cell.bounds.origin.y+35,cell.frame.size.width/3+100,cell.frame.size.height/3)];
        lblRevLoct.textColor = [UIColor blueColor];
        lblRevLoct.text=[[ArrDictRevDesc objectAtIndex:indexPath.row] valueForKey:@"place"];
        lblRevLoct.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        // lblRevLoct.backgroundColor=[UIColor redColor];
        
        
        lblRevDate=[[UILabel alloc]initWithFrame:CGRectMake(UserImg.frame.origin.x+UserImg.frame.size.width+12,cell.frame.origin.y+5,cell.frame.size.width/3+100,cell.frame.size.height/3)];
        lblRevDate.textColor = [UIColor redColor];
        lblRevDate.text=[[ArrDictRevDesc objectAtIndex:indexPath.row] valueForKey:@"review_date"];
        lblRevDate.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        // lblRevDate.backgroundColor=[UIColor redColor];
        
        
        
        lblReviewDecs=[[UILabel alloc]initWithFrame:CGRectMake(UserImg.frame.origin.x+UserImg.frame.size.width+12,cell.frame.origin.y+55,cell.frame.size.width/3+100,cell.frame.size.height/3)];
        lblReviewDecs.numberOfLines=0;
        lblReviewDecs.baselineAdjustment=UIBaselineAdjustmentAlignBaselines;
       
        lblReviewDecs.adjustsFontSizeToFitWidth = YES;
        lblReviewDecs.textColor = [UIColor blackColor];
        lblReviewDecs.clipsToBounds = YES;
        lblReviewDecs.textAlignment = NSTextAlignmentJustified;
        
        lblReviewDecs.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
       
         UIFont *cellFont =[UIFont fontWithName:@"Helvetica Neue" size:14];
         CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGRect textRect = [[[ArrDictRevDesc objectAtIndex:indexPath.row] valueForKey:@"review_desc"] boundingRectWithSize:constraintSize                                                 options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cellFont} context:nil];
        
        CGRect ReviewDecs_Frame=lblReviewDecs.frame;
        ReviewDecs_Frame.size.height=textRect.size.height;
        lblReviewDecs.frame=ReviewDecs_Frame;
        
        
        NSLog(@"%f",lblReviewDecs.frame.size.height);

         lblReviewDecs.text=[[ArrDictRevDesc objectAtIndex:indexPath.row] valueForKey:@"review_desc"];
         lblReviewDecs.lineBreakMode=NSLineBreakByWordWrapping|| NSLineBreakByCharWrapping ;
        [lblReviewDecs sizeToFit];
       // lblReviewDecs.backgroundColor=[UIColor redColor];
        
        
        
        [cell.contentView addSubview:UserImg];
        [cell.contentView addSubview:lblUserName];
        [cell.contentView addSubview:lblRevDate];
        [cell.contentView addSubview:lblRevLoct];
        [cell.contentView addSubview:lblReviewDecs];
        
        
        
    }
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 100;
    }
    if (indexPath.section == 1) {
        
   
        return  lblReviewDecs.frame.size.height+80;
    }
    
    else
        return 00.0f;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(section==0) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 290)];
        UIButton *BtnBack=[[UIButton alloc]initWithFrame:CGRectMake(0,0,60,60)];
        [BtnBack setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
        [BtnBack addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
       // BtnBack.backgroundColor=[UIColor greenColor];
        
        UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width/2-40, headerView.frame.origin.y+15, 80, 40)];
        lblTitle.text=@"Reviews";
        lblTitle.textColor=[UIColor blackColor];
     
        [headerView addSubview:BtnBack];
        [headerView addSubview:lblTitle];
        
        return headerView;
    }
    return nil;
}

-(void)Back
{
    [self.navigationController popViewControllerAnimated:NO];
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

@end
