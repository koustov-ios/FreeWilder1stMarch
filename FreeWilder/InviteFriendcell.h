//
//  InviteFriendcell.h
//  FreeWilder
//
//  Created by Soumen on 01/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteFriendcell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *tickimg;
@property (weak, nonatomic) IBOutlet UILabel *invitefriendName;
@property (weak, nonatomic) IBOutlet UILabel *invitefriendPhonenumber;
@property (weak, nonatomic) IBOutlet UIImageView *invitefriendImage;

@end
