//
//  Notificationcell.h
//  FreeWilder
//
//  Created by Soumen on 01/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Notificationcell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *subjectlbl;
@property (strong, nonatomic) IBOutlet UILabel *timelbl;
@property (strong, nonatomic) IBOutlet UILabel *msgBodylbl;
@property (strong, nonatomic) IBOutlet UIButton *starimageTap;
@property (strong, nonatomic) IBOutlet UIView *cellview;
@property (strong, nonatomic) IBOutlet UIButton *starBtnTap;
@property (strong, nonatomic) IBOutlet UIImageView *attachmentImage;
@property (strong, nonatomic) IBOutlet UIButton *DownloadTap;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;

@end
