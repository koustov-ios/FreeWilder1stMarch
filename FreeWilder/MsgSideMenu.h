//
//  MsgSideMenu.h
//  FreeWilder
//
//  Created by kausik on 29/10/15.
//  Copyright © 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgSideMenu : UIView
@property (strong, nonatomic) IBOutlet UIButton *AllmsgTap;
@property (strong, nonatomic) IBOutlet UILabel *allmsglbl;
@property (strong, nonatomic) IBOutlet UIButton *ArchiveTap;
@property (strong, nonatomic) IBOutlet UILabel *archivelbl;
@property (strong, nonatomic) IBOutlet UIButton *starBtnTap;
@property (strong, nonatomic) IBOutlet UILabel *starlbl;
@property (strong, nonatomic) IBOutlet UIButton *ReadTap;
@property (strong, nonatomic) IBOutlet UILabel *readlbl;
@property (strong, nonatomic) IBOutlet UIButton *unreadTap;
@property (strong, nonatomic) IBOutlet UILabel *unreadlbl;

@end
