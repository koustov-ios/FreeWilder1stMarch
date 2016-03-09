//
//  payoutsecondpageViewController.m
//  FreeWilder
//
//  Created by subhajit ray on 18/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "payoutsecondpageViewController.h"
#import "payoutsecondCell.h"
#import "addpayoutmethod.h"

@interface payoutsecondpageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation payoutsecondpageViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _maintableview.delegate=self;
    _maintableview.dataSource=self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    payoutsecondCell *cell=(payoutsecondCell *)[tableView dequeueReusableCellWithIdentifier:@"payoutsecound"];
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexpath %ld",(long)indexPath.row);
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

- (IBAction)closeBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
