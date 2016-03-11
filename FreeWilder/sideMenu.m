//
//  sideMenu.m
//  Side Menu
//
//  Created by koustov basu on 11/02/16.
//  Copyright © 2016 koustov basu. All rights reserved.
//

#import "sideMenu.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"


@implementation sideMenu

@synthesize profilePic,sideTable;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
       
        
        self=[[[NSBundle mainBundle] loadNibNamed:@"sideMenu" owner:self options:nil]objectAtIndex:0];
        
        self.frame=frame;
        
        expansionDic=[[NSMutableDictionary alloc]init];
        
        menuWidth=frame.size.width;
        
        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        _nameLbl.text=[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"] ];
        
        
         [profilePic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"ProfileImage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        profilePic.layer.cornerRadius=profilePic.bounds.size.width/2;
        profilePic.clipsToBounds=YES;

        
        profileSubArray=[[NSArray alloc]init];
        profileSubArray=@[@"View Profile",@"Edit Details",@"Photos & Videos",@"Phone Verification",@"Trust & Verification",@"Review"];
        serviceSubArray=[[NSArray alloc]init];
        serviceSubArray=@[@"Your Services",@"Add Product/Services",@"User Booking & Requests",@"My Booking & Requests",@"Wishlist",@"Favourites"];
        accountSubArray=[[NSArray alloc]init];
        accountSubArray=@[@"Notification",@"Payment Method",@"Payout Preferences",@"Tansaction History",@"Security",@"Settings"];
        
        sideTable.delegate=self;
        sideTable.dataSource=self;
    }
    
    
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 8;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

   return tableView.frame.size.height/8;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *headerView=[[UIView alloc ]init];
    
    headerView.backgroundColor=[UIColor colorWithRed:236.0f/256 green:236.0f/256 blue:236.0f/256 alpha:1];
    
    headerView.frame=CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height/8);
    
    UIView *seperator=[[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height-1, tableView.frame.size.width, 1)];
    seperator.backgroundColor=[UIColor whiteColor];
    
     if(section!=7)
     {
          [headerView addSubview:seperator];
     }
    
    UIImageView *menuIcon=[[UIImageView alloc]initWithFrame:CGRectMake(5, (headerView.frame.size.height-(headerView.frame.size.height/2.5))/2, headerView.frame.size.width/10, headerView.frame.size.height/2.5)];
    
    [headerView addSubview:menuIcon];
    
    menuIcon.contentMode=UIViewContentModeScaleAspectFit;
    
    if(section==0)
    {
        
        menuIcon.image=[UIImage imageNamed:@"User Group-50"];
        
    }
    if(section==1)
    {
        
        menuIcon.image=[UIImage imageNamed:@"Paste Special-50"];
    }
    
    if(section==2)
    {
        
        menuIcon.image=[UIImage imageNamed:@"Checked User-50"];
        
    }
    if(section==3)
    {
        
        menuIcon.image=[UIImage imageNamed:@"Business-50"];
        
    }
    if(section==4)
    {
        
        menuIcon.image=[UIImage imageNamed:@"Services-50"];
        
    }
    
    if(section==5)
    {
        
        menuIcon.image=[UIImage imageNamed:@"Bill-50"];
        
    }
    if(section==6)
    {
        
        menuIcon.image=[UIImage imageNamed:@"Geography-50"];
        
    }
    if(section==7)
    {
        
        menuIcon.image=[UIImage imageNamed:@"External-50"];
        
    }

    UIButton *sectionHeaderBtn=[[UIButton alloc]initWithFrame:CGRectMake(menuIcon.frame.origin.x+menuIcon.frame.size.width+5, 0, tableView.frame.size.width-(menuIcon.frame.origin.x+menuIcon.frame.size.width+1), headerView.frame.size.height)];
    [headerView addSubview:sectionHeaderBtn];
    
    sectionHeaderBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [sectionHeaderBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    sectionHeaderBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:14.0f];
    
    
    
    
    sectionHeaderBtn.tag=section;
    
    
    
    if(section==0)
    {
    
       [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Invite Friends"] forState:UIControlStateNormal];
    
    }
    if(section==1)
    {
        
        [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Rate App"] forState:UIControlStateNormal];
        
    }
    
    if(section==2)
    {
        
        [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Profile"] forState:UIControlStateNormal];
        
    }
    if(section==3)
    {
        
        [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Business Information"] forState:UIControlStateNormal];
        
    }
    if(section==4)
    {
        
        [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Service"] forState:UIControlStateNormal];
        
    }
    
    if(section==5)
    {
        
        [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Account"] forState:UIControlStateNormal];
        
    }
    if(section==6)
    {
        
        [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Language & Currency"] forState:UIControlStateNormal];
        
    }
    if(section==7)
    {
        
        [sectionHeaderBtn setTitle:[NSString stringWithFormat:@"Log Out"] forState:UIControlStateNormal];
        
    }
    
    
    
    [sectionHeaderBtn addTarget:self action:@selector(sectionTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([[expansionDic valueForKey:[NSString stringWithFormat:@"%ld",section]] isEqualToString:@"YES"])
    {
    
        if(section==2)
        {
        
            return profileSubArray.count;
            
        }
        if(section==4)
        {
        
            return serviceSubArray.count;
        
        }
        if(section==5)
        {
            
            return accountSubArray.count;
            
        }

        
    }
    
    return 0;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return  (tableView.frame.size.height/8)-10;
    

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"Side menu cell creation....");

    static NSString *cellIdentifier=@"cellID";
    
    
    UITableViewCell *sidemenuCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(sidemenuCell == nil)
    {
    
        sidemenuCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    }

    if(indexPath.section==2)
    sidemenuCell.textLabel.text=[NSString stringWithFormat:@"%@",profileSubArray[indexPath.row]];
    
    if(indexPath.section==4)
    sidemenuCell.textLabel.text=[NSString stringWithFormat:@"%@",serviceSubArray[indexPath.row]];
    
    if(indexPath.section==5)
        sidemenuCell.textLabel.text=[NSString stringWithFormat:@"%@",accountSubArray[indexPath.row]];
    

    sidemenuCell.textLabel.font=[UIFont fontWithName:@"Helvetica" size:14.0f];
    
    sidemenuCell.textLabel.textAlignment=NSTextAlignmentLeft;

    
    sidemenuCell.backgroundColor=[UIColor colorWithRed:250.0f/256 green:250.0f/256 blue:250.0f/256 alpha:1];
    
    //sidemenuCell.selectedBackgroundView=[[UIView alloc]init];
    
    return  sidemenuCell;
}

//-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    //1. Setup the CATransform3D structure
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    
//    //2. Define the initial state (Before the animation)
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    //3. Define the final state (After the animation) and commit the animation
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
//
//}



//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    //1. Setup the CATransform3D structure
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    
//    //2. Define the initial state (Before the animation)
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    //3. Define the final state (After the animation) and commit the animation
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
//
//}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section==2)
    {
       if(indexPath.row==0)
       {
       
           int tag=2;
           
           [self.delegate sideMenuAction:tag];

       
       }
        if(indexPath.row==1)
        {
            
            int tag=3;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==2)
        {
            
            int tag=4;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==3)
        {
            
            int tag=5;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==4)
        {
            
            int tag=6;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==5)
        {
            
            int tag=7;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
       
    
    }
    if(indexPath.section==4)
    {
        if(indexPath.row==0)
        {
            
            int tag=9;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==1)
        {
            
            int tag=10;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==2)
        {
            
            int tag=11;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==3)
        {
            
            int tag=12;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==4)
        {
            
            int tag=13;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        if(indexPath.row==5)
        {
            
            int tag=14;
            
            [self.delegate sideMenuAction:tag];
            
            
        }
        
        
    }
    
   
    
    if(indexPath.section==5)
    {
    
        {
            if(indexPath.row==0)
            {
                
                int tag=50;
                
                [self.delegate sideMenuAction:tag];
                
                
            }
            if(indexPath.row==1)
            {
                
                int tag=51;
                
                [self.delegate sideMenuAction:tag];
                
                
            }
            if(indexPath.row==2)
            {
                
                int tag=52;
                
                [self.delegate sideMenuAction:tag];
                
                
            }
            if(indexPath.row==3)
            {
                
                int tag=53;
                
                [self.delegate sideMenuAction:tag];
                
                
            }
            if(indexPath.row==4)
            {
                
//                int tag=54;
//                
//                [self.delegate sideMenuAction:tag];
                
                int tag=55;
                
                [self.delegate sideMenuAction:tag];
                
                
            }
            if(indexPath.row==5)
            {
                
//                int tag=55;
//                
//                [self.delegate sideMenuAction:tag];
                
                int tag=56;
                
                [self.delegate sideMenuAction:tag];

                
                
            }
//            if(indexPath.row==6)
//            {
//                
//                int tag=56;
//                
//                [self.delegate sideMenuAction:tag];
//                
//                
//            }
            
            
        }
    
    }

    
    
  }




-(void)sectionTapped:(UIButton *)sender
{

    if(sender.tag==2 || sender.tag==4 || sender.tag==5)
    {
    
    if(![[expansionDic valueForKey:[NSString stringWithFormat:@"%ld",sender.tag]] isEqualToString:@"YES"])
    {
          [expansionDic setValue:@"YES" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
    
    }
    else
    {
        [expansionDic setValue:@"NO" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
        
    }
   
    
    [sideTable beginUpdates];
    
    [sideTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
    
    [sideTable endUpdates];
    
    }
    
    else
    {
    
        if(sender.tag==0)
        {
            int tag=0;
            [self.delegate sideMenuAction:tag];
        }
        
        if(sender.tag==1)
        {
            int tag=1;
            [self.delegate sideMenuAction:tag];
        }
        
        if(sender.tag==3)
        {
         int tag=8;
             [self.delegate sideMenuAction:tag];
        }
//        if(sender.tag==5)
//        { int tag=15;
//             [self.delegate sideMenuAction:tag];
//        }
        if(sender.tag==6)
        {   int tag=16;
             [self.delegate sideMenuAction:tag];
        }
        if(sender.tag==7)
        {   int tag=17;
             [self.delegate sideMenuAction:tag];

        }
        
    }
    

}




@end
