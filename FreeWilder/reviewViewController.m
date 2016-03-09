//
//  reviewViewController.m
//  FreeWilder
//
//  Created by koustov basu on 30/12/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import "reviewViewController.h"
#import "FWProductDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "reviewTableViewCell.h"

@interface reviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    
    
    reviewTableViewCell *reviewCell;
    
    int orCoutn,qrCount,srCount,trCount;
    
    CGFloat labelHeight;
    
    CGFloat labelWidth;
    
}

@end

@implementation reviewViewController

@synthesize imageArray,imageGallery,ratingsDic,reviewDescArr;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    orCoutn=(int)[[ratingsDic valueForKey:@"overall_review"]intValue];
    qrCount=(int)[[ratingsDic valueForKey:@"quality_review"]intValue];
    srCount=(int)[[ratingsDic valueForKey:@"service_review"]intValue];
    trCount=(int)[[ratingsDic valueForKey:@"total_review"]intValue];
   // NSLog(@"%d %d %d %d",orCoutn,trCount,srCount,qrCount);
    
   // NSLog(@"------> %@",reviewDescArr);
    
    [self createratings];
    
}

-(void)createratings
{
    
    if(trCount>=1)
    {
        
        if(trCount==1)
        {
            trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else   if(trCount==2)
        {
            trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else  if(trCount==3)
        {
            trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            
            
        }
        else if(trCount==4)
        {
            
            trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar4.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if(trCount==5)
        {
            trStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar4.image=[UIImage imageNamed:@"Star Filled-50"];
            trStar5.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        
    }
    
    if(trCount>=1)
    {
        
        if(orCoutn==1)
        {
            orStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else   if(orCoutn==2)
        {
            orStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else  if(orCoutn==3)
        {
            orStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            
            
        }
        else if(orCoutn==4)
        {
            
            orStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar4.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if(orCoutn==5)
        {
            
            
            orStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar4.image=[UIImage imageNamed:@"Star Filled-50"];
            orStar5.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        
    }
    
    
    if(qrCount>=1)
    {
        
        if(qrCount==1)
        {
            qrStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else   if(qrCount==2)
        {
            qrStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else  if(qrCount==3)
        {
            qrStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            
            
        }
        else if(qrCount==4)
        {
            
            qrStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar4.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if(qrCount==5)
        {
            qrStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar4.image=[UIImage imageNamed:@"Star Filled-50"];
            qrStar5.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        
    }
    
    
    if(srCount>=1)
    {
        
        if(srCount==1)
        {
            srStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else   if(srCount==2)
        {
            srStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            
        }
        else  if(srCount==3)
        {
            srStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            
            
        }
        else if(srCount==4)
        {
            
            srStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar4.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        else  if(srCount==5)
        {
            srStar1.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar2.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar3.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar4.image=[UIImage imageNamed:@"Star Filled-50"];
            srStar5.image=[UIImage imageNamed:@"Star Filled-50"];
        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return imageArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId=@"ceiiId";
    
    UICollectionViewCell *imageCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if(imageCell==nil)
    {
        
        imageCell=[[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, imageGallery.frame.size.height)];
        
    }
    
    
    UIImageView *cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, imageGallery.frame.size.height)];
    
    [cellImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray objectAtIndex:indexPath.row]]] placeholderImage:[UIImage imageNamed:@"placeholder_big"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    [imageCell addSubview:cellImageView];
    
    return imageCell;
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, imageGallery.frame.size.height);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return reviewDescArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //1.38528139
    
    // 7.78082192
    
    NSString *tempStr=[[reviewDescArr objectAtIndex:indexPath.row] valueForKey:@"review_desc"];
    
    CGSize  constraint = CGSizeMake(self.view.bounds.size.width/1.38528139, MAXFLOAT);
    
    CGRect textRect = [tempStr boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"lato" size:15]} context:nil];
    
    labelHeight = MAX(textRect.size.height, 21.0f);
    labelWidth=textRect.size.width;
    
    
    //NSLog(@"Height------ %f",labelHeight+self.view.bounds.size.height/7.78082192+self.view.bounds.size.height/15.7777777+8);
    
    return labelHeight+self.view.bounds.size.height/7.78082192+self.view.bounds.size.height/15.7777777+8;
    
    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    reviewCell.nameLbl.text=[[reviewDescArr objectAtIndex:indexPath.row] valueForKey:@"user_name"];
    reviewCell.locationLbl.text=[[reviewDescArr objectAtIndex:indexPath.row] valueForKey:@"place"];
    reviewCell.dateTimeLbl.text=[[reviewDescArr objectAtIndex:indexPath.row] valueForKey:@"review_date"];
    
    
    float prevHeight=reviewCell.descLbl.frame.size.height;
    
    reviewCell.descLbl.frame=CGRectMake(reviewCell.descLbl.frame.origin.x, reviewCell.descLbl.frame.origin.y,reviewCell.descLbl.frame.size.width , labelHeight);
    
    //    NSString *tempStr=@"No worries, I'll do that going forward ... as much as possible. However, for some cases I'll be sensitive to the time and instead I will read existing code w/o creating it from scratch. I wouldn't want to bore you with a 2 hour video on creating getters and setters LOL ;-)No worries, I'll do that going forward ... as much as possible. However, for some cases I'll be sensitive to the time and instead I will read existing code w/o creating it from scratch. I wouldn't want to bore you with a 2 hour video on creating getters and setters LOL ;-)No worries, I'll do that going forward ... as much as possible. However, for some cases I'll be sensitive to the time and instead I will read existing code w/o creating it from scratch. I wouldn't want to bore you with a 2 hour video on creating getters and setters LOL ;-)";
    
    reviewCell.descLbl.text=[[reviewDescArr objectAtIndex:indexPath.row] valueForKey:@"review_desc"];
    
    reviewCell.descLbl.numberOfLines=0;
    
    reviewCell.descLbl.adjustsFontSizeToFitWidth=YES;
    reviewCell.descLbl.clipsToBounds=YES;
    reviewCell.descLbl.textAlignment=NSTextAlignmentLeft;
    reviewCell.descLbl.font= [UIFont fontWithName:@"lato" size:15];
    reviewCell.descLbl.textColor=[UIColor colorWithRed:102.0f/256 green:102.0f/256 blue:102.0f/256 alpha:1];
    
    [reviewCell.profilePic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[reviewDescArr objectAtIndex:indexPath.row] valueForKey:@"user_image"]]] completed:nil];
    reviewCell.profilePic.layer.cornerRadius=reviewCell.profilePic.bounds.size.width/2;
    reviewCell.profilePic.clipsToBounds=YES;
    
    // reviewCell.descLbl.backgroundColor=[UIColor yellowColor];
    //reviewCell.descLbl.adjustsFontSizeToFitWidth=YES;
    
    
    if(reviewCell.descLbl.frame.size.height>prevHeight)
    {
        
        reviewCell.locationIcon.frame=CGRectMake(reviewCell.locationIcon.frame.origin.x, reviewCell.locationIcon.frame.origin.y+(reviewCell.descLbl.frame.size.height-prevHeight), reviewCell.locationIcon.frame.size.width, reviewCell.locationIcon.frame.size.height);
        
      //  NSLog(@"loc icon--->%f",reviewCell.locationIcon.frame.origin.y);
        
        reviewCell.locationLbl.frame=CGRectMake(reviewCell.locationLbl.frame.origin.x, reviewCell.locationLbl.frame.origin.y+(reviewCell.descLbl.frame.size.height-prevHeight), reviewCell.locationLbl.frame.size.width, reviewCell.locationLbl.frame.size.height);
      //  NSLog(@"loc text--->%f",reviewCell.locationLbl.frame.origin.y);
        
        
        reviewCell.datetTimeIcon.frame=CGRectMake(reviewCell.datetTimeIcon.frame.origin.x, reviewCell.datetTimeIcon.frame.origin.y+(reviewCell.descLbl.frame.size.height-prevHeight), reviewCell.datetTimeIcon.frame.size.width, reviewCell.datetTimeIcon.frame.size.height);
        
      //  NSLog(@"date icon--->%f",reviewCell.datetTimeIcon.frame.origin.y);
        
        
        reviewCell.dateTimeLbl.frame=CGRectMake(reviewCell.dateTimeLbl.frame.origin.x, reviewCell.dateTimeLbl.frame.origin.y+(reviewCell.descLbl.frame.size.height-prevHeight), reviewCell.dateTimeLbl.frame.size.width, reviewCell.dateTimeLbl.frame.size.height);
        
       // NSLog(@"date text--->%f",reviewCell.dateTimeLbl.frame.origin.y);
        
        reviewCell.divider.frame=CGRectMake(reviewCell.divider.frame.origin.x, reviewCell.divider.frame.origin.y+(reviewCell.descLbl.frame.size.height-prevHeight), reviewCell.divider.frame.size.width, reviewCell.divider.frame.size.height);
        
    }
    
    
    reviewCell.selectionStyle=UITableViewCellSelectionStyleNone;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    reviewCell=[tableView dequeueReusableCellWithIdentifier:@"reviewCell"];
    
    if(reviewCell==nil)
    {
        
        
        reviewCell=[[reviewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reviewCell"];
        
    }
    
    tableView.separatorColor=[UIColor clearColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    return reviewCell;
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
