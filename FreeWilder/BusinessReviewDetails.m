//
//  BusinessReviewDetails.m
//  FreeWilder
//
//  Created by kausik on 05/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "BusinessReviewDetails.h"
#import "UIImageView+WebCache.h"
#import "BusinessReviewServiceCell.h"
#import "ReviewsAboutMeCell.h"
#import "ReviewsFromSellerCell.h"


@interface BusinessReviewDetails ()<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UIImageView *topbar;
    NSMutableArray *backup;
}

@end

@implementation BusinessReviewDetails

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 //   mainTableView.frame=CGRectMake(0, topbar.frame.size.height, self.view.frame.size.width, mainTableView.frame.size.height);
    backup = [[NSMutableArray alloc]init];
    
    
    
    
   
    
    _topbarlbl.text =_service;
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.service isEqualToString:@"Service"])
    {
        return 200.00f;
    }
    
    else if([self.service isEqualToString:@"Reviews About Me"])
    {
        return 160.0f;
    }
    
    
    else if([self.service isEqualToString:@"Reviews From Seller"])
    {
        return 136.0f;
    }
    
    else
    {
        return 0;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.service isEqualToString:@"Service"])
    {
        return self.serviceArray.count;
    }
    else if([self.service isEqualToString:@"Reviews About Me"])
    {
        return _ReviewMe.count;
    }
    
   else if([self.service isEqualToString:@"Reviews From Seller"])
    {
        return _reviews_from_seller.count;
    }
    
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([self.service isEqualToString:@"Service"])
    {
    
   
    BusinessReviewServiceCell *servicecell =(BusinessReviewServiceCell *) [mainTableView dequeueReusableCellWithIdentifier:@"servicecell"];
    
    
    
    
    
    [servicecell.productImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[self.serviceArray objectAtIndex:indexPath.row] valueForKey:@"service_image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    servicecell.servicename.text = [[self.serviceArray objectAtIndex:indexPath.row]valueForKey:@"service_name"];
    
    servicecell.serviceLocation.text = [[self.serviceArray objectAtIndex:indexPath.row]valueForKey:@"service_location"];
        
        
       // Star Filled-50
        
      //  service_reviews
        
        
        if ([[[_serviceArray objectAtIndex:indexPath.row]valueForKey:@"service_reviews"]integerValue]==1)
        {
            servicecell.star1.image = [UIImage imageNamed:@"Star Filled-50"];
        }
        
     else   if ([[[_serviceArray objectAtIndex:indexPath.row]valueForKey:@"service_reviews"]integerValue]==2)
        {
            servicecell.star1.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star2.image = [UIImage imageNamed:@"Star Filled-50"];
        }
      else  if ([[[_serviceArray objectAtIndex:indexPath.row]valueForKey:@"service_reviews"]integerValue]==3)
        {
            servicecell.star1.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star2.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star3.image = [UIImage imageNamed:@"Star Filled-50"];
        }
        
     else   if ([[[_serviceArray objectAtIndex:indexPath.row]valueForKey:@"service_reviews"]integerValue]==4)
        {
            servicecell.star1.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star2.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star3.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star4.image = [UIImage imageNamed:@"Star Filled-50"];
        }
       else if ([[[_serviceArray objectAtIndex:indexPath.row]valueForKey:@"service_reviews"]integerValue]==5)
        {
            servicecell.star1.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star2.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star3.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star4.image = [UIImage imageNamed:@"Star Filled-50"];
            servicecell.star5.image = [UIImage imageNamed:@"Star Filled-50"];
        }
        
        else
        {
            
            servicecell.star1.image = [UIImage imageNamed:@"Star-50"];
            servicecell.star2.image = [UIImage imageNamed:@"Star-50"];
            servicecell.star3.image = [UIImage imageNamed:@"Star-50"];
            servicecell.star4.image = [UIImage imageNamed:@"Star-50"];
            servicecell.star5.image = [UIImage imageNamed:@"Star-50"];
            
        }
        
        
    
    
    
    return servicecell;
    }
    
    else if([self.service isEqualToString:@"Reviews About Me"])
    {
        ReviewsAboutMeCell *reviewME  = (ReviewsAboutMeCell *)[mainTableView dequeueReusableCellWithIdentifier:@"ReviewsMe"];
        
        reviewME.profileImageview.layer.cornerRadius = reviewME.profileImageview.frame.size.height/2;
        reviewME.profileImageview.clipsToBounds=YES;
        
        
        [reviewME.profileImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[self.ReviewMe objectAtIndex:indexPath.row] valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        
        reviewME.userName.text =[[self.ReviewMe objectAtIndex:indexPath.row] valueForKey:@"user_name"];
        reviewME.serviceName.text = [[self.ReviewMe objectAtIndex:indexPath.row]valueForKey:@"service_name"];
        
        
        reviewME.ReviewDesc.text= [[self.ReviewMe objectAtIndex:indexPath.row]valueForKey:@"review_desc"];
        
        reviewME.ReviewDate.text = [NSString stringWithFormat:@"%@ | %@",[[_ReviewMe objectAtIndex:indexPath.row] valueForKey:@"review_date"],[[_ReviewMe objectAtIndex:indexPath.row] valueForKey:@"review_time"]];
        
        
        NSString *check = [[self.ReviewMe objectAtIndex:indexPath.row]valueForKey:@"state_name"];
        
        
        if (check.length>0)
        {
            reviewME.state_name.text =[NSString stringWithFormat:@"From %@",[[self.ReviewMe objectAtIndex:indexPath.row]valueForKey:@"state_name"]];
            
            
            
        }
        else
        {
            reviewME.pinImage.hidden=YES;
            reviewME.state_name.hidden=YES;
        }
        
        
        
        
        if ([[[_ReviewMe objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==1)
        {
            reviewME.star1.image =[UIImage imageNamed:@"Star Filled-50"];
        }
      else  if ([[[_ReviewMe objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==2)
        {
            reviewME.star1.image =[UIImage imageNamed:@"Star Filled-50"];
            reviewME.star2.image =[UIImage imageNamed:@"Star Filled-50"];
        }
      else  if ([[[_ReviewMe objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==3)
      {
          reviewME.star1.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star2.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star3.image =[UIImage imageNamed:@"Star Filled-50"];
      }
      else  if ([[[_ReviewMe objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==4)
      {
          reviewME.star1.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star2.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star3.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star4.image =[UIImage imageNamed:@"Star Filled-50"];
      }
      else  if ([[[_ReviewMe objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==5)
      {
          reviewME.star1.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star2.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star3.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star4.image =[UIImage imageNamed:@"Star Filled-50"];
          reviewME.star5.image =[UIImage imageNamed:@"Star Filled-50"];
      }
        else
        {
            reviewME.star1.image = [UIImage imageNamed:@"Star-50"];
            reviewME.star2.image = [UIImage imageNamed:@"Star-50"];
            reviewME.star3.image = [UIImage imageNamed:@"Star-50"];
            reviewME.star4.image = [UIImage imageNamed:@"Star-50"];
            reviewME.star5.image = [UIImage imageNamed:@"Star-50"];
          
        
        
        
        }
        
        return reviewME;
        
        
        
        
    }
    
    
    
    else if([self.service isEqualToString:@"Reviews From Seller"])
    {
        
        ReviewsFromSellerCell *sellerReview = (ReviewsFromSellerCell *)[mainTableView dequeueReusableCellWithIdentifier:@"sellerreview"];
        
        sellerReview.profileImage.layer.cornerRadius = sellerReview.profileImage.frame.size.height/2;
        sellerReview.profileImage.clipsToBounds=YES;
        
        
        
        
         [sellerReview.profileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[self.reviews_from_seller objectAtIndex:indexPath.row] valueForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        
        
        
        sellerReview.username.text = [_reviews_from_seller[indexPath.row]valueForKey:@"user_name"];
        sellerReview.reviewdesc.text = [_reviews_from_seller[indexPath.row]valueForKey:@"review_desc"];
       
        sellerReview.stateName.text = [_reviews_from_seller[indexPath.row]valueForKey:@"state_name"];
        
        
        
        sellerReview.reviewdate.text = [NSString stringWithFormat:@"%@ | %@",[_reviews_from_seller[indexPath.row]valueForKey:@"review_date"],[_reviews_from_seller[indexPath.row]valueForKey:@"review_time"]];
        
        /*
        NSString *check = [[self.reviews_from_seller objectAtIndex:indexPath.row]valueForKey:@"state_name"];
        
        
        if (check.length>0)
        {
            sellerReview.stateName.text =[NSString stringWithFormat:@"From %@",[[self.ReviewMe objectAtIndex:indexPath.row]valueForKey:@"state_name"]];
            
            
            
        }
        else
        {
            sellerReview.pingImage.hidden=YES;
            sellerReview.stateName.hidden=YES;
        }
        */
        
        if ([[[_reviews_from_seller objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==1)
        {
            sellerReview.star1.image =[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if ([[[_reviews_from_seller objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==2)
        {
            sellerReview.star1.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star2.image =[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if ([[[_reviews_from_seller objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==3)
        {
            sellerReview.star1.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star2.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star3.image =[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if ([[[_reviews_from_seller objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==4)
        {
            sellerReview.star1.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star2.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star3.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star4.image =[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if ([[[_reviews_from_seller objectAtIndex:indexPath.row]valueForKey:@"service_review"]integerValue]==5)
        {
            sellerReview.star1.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star2.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star3.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star4.image =[UIImage imageNamed:@"Star Filled-50"];
            sellerReview.star5.image =[UIImage imageNamed:@"Star Filled-50"];
        }
        else
        {
            sellerReview.star1.image = [UIImage imageNamed:@"Star-50"];
            sellerReview.star2.image = [UIImage imageNamed:@"Star-50"];
            sellerReview.star3.image = [UIImage imageNamed:@"Star-50"];
            sellerReview.star4.image = [UIImage imageNamed:@"Star-50"];
            sellerReview.star5.image = [UIImage imageNamed:@"Star-50"];
            
            
            
            
        }
        
        
        
        
        
        
        
        return sellerReview;
        
        
        
        
        
        
        
        
        
        
        
    }
    
    else
    {
        return 0;
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

- (IBAction)BackTap:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
