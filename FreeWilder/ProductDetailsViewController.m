//
//  ProductDetailsViewController.m
//  FreeWilder
//
//  Created by Rahul Singha Roy on 01/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProductDetailsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define kCellsPerRow 1
#define kCellsPerCol 1

@interface ProductDetailsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,assign) CGFloat cellWidth;
@property (nonatomic,assign) CGFloat cellHeight;

@end

@implementation ProductDetailsViewController

@synthesize detailsCollectionView;

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"PRODUCT DETAILS VIEW CONTROLLER");
    
    [detailsCollectionView registerClass:[ProductDetailsCollectionViewCell class] forCellWithReuseIdentifier:@"ProductDetailsCollectionViewCell"];

    
    detailsCollectionView.delegate = self;
    detailsCollectionView.dataSource = self;
//    detailsCollectionView.backgroundColor = [UIColor greenColor];
    
    
//    if ([UIScreen mainScreen].bounds.size.width > 320) {
//        
//        NSLog(@"iPhone 6   ^_^  ");
//        
//        detailsCollectionView.frame = CGRectMake(0.0f, 0.0f, 375.0f, detailsCollectionView.frame.size.height);
//    }
    
    NSLog(@"data====%@",_detailsDict);
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
//    NSLog(@"profile image-=-=-=-=-=-=-=-=-=-=-> %@",[self.detailsDict objectForKey:@"userimage"]);
    
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width/2.0f;
    self.profileImg.clipsToBounds = YES;
    
   
    
    [self.profileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.detailsDict objectForKey:@"userimage"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    if (self.profileImg.image==nil)
    {
        //   NSLog(@"data byte=%@",cell.UserImage.image);
        self.profileImg.image=[UIImage imageNamed:@"Profile_image_placeholder"];
    }
    
    self.itemName.text = [self.detailsDict objectForKey:@"productname"];
    self.price.text = [self.detailsDict objectForKey:@"price"];
    self.desc.text = [self.detailsDict objectForKey:@"desp"];
    self.date.text = [self.detailsDict objectForKey:@"date"];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ProductDetailsCollectionViewCell";
    
    ProductDetailsCollectionViewCell *Cell;
    Cell = (ProductDetailsCollectionViewCell *)[detailsCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    Cell.backgroundColor = [UIColor greenColor];
//    Cell.overlay.backgroundColor = [UIColor greenColor];
//    Cell.itemImage.backgroundColor = [UIColor redColor];
    
    //-----If image is from core data----//
    
    
        
        [Cell.itemImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.detailsDict objectForKey:@"productimage"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        Cell.itemImage.contentMode=UIViewContentModeScaleAspectFill;

        
   
    return Cell;
    
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
 
 
 [[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"name"], @"productname",
 [[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"description"], @"desp",
 [[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"product_image"], @"productimage",
 finalPrice, @"price",
 [[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"user_image"], @"userimage",
 [[ArrProductList objectAtIndex:indexPath.row] valueForKey:@"date"], @"date",nil];
 
 
*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.detailsCollectionView.collectionViewLayout;
    
    //------For width-----//
    
    CGFloat availableWidthForCells = CGRectGetWidth(self.detailsCollectionView.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    
    //-------For height------//
    
    CGFloat availableHeightForCells = CGRectGetHeight(self.detailsCollectionView.frame) - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    
    
    
    self.cellWidth = availableWidthForCells / kCellsPerRow;
    self.cellHeight = availableHeightForCells / kCellsPerCol;
    
    
    flowLayout.itemSize = CGSizeMake(self.cellWidth, self.cellHeight);
    
    
    
    return flowLayout.itemSize;
    
}
- (IBAction)back_button:(id)sender
{
    [self POPViewController];
}

- (IBAction)ShareBtnTap:(id)sender
{
    UIImage *imageToShare;
    
    
    
        imageToShare= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_detailsDict valueForKey:@"productimage"]]]]];
   
    
   
    //UIImage *imageToShare = media.image;
    NSLog(@"image %@",imageToShare);
    NSArray *itemsToShare = @[imageToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList]; //or whichever you don't need
    //[self presentViewController:activityVC animated:YES completion:nil];
    
    [self.parentViewController presentViewController:activityVC animated:YES completion:nil];
    
    
    
}
-(void)POPViewController
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}
@end
