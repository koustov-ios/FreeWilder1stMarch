//
//  SearchCategoryViewController.h
//  FreeWilder
//
//  Created by Soumen on 03/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "UIImageView+WebCache.h"

@interface SearchCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,Slide_menu_delegate>
{
    // Creating Side menu object
    
    Side_menu *sidemenu;
    UIView *overlay;
}
@property (strong, nonatomic) IBOutlet UIView *footer_base;
//- (IBAction)more_interests:(id)sender;
//- (IBAction)get_started_button:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *searchcategorytxt;

@end
