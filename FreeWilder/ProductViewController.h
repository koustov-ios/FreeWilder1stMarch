

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "FW_JsonClass.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@interface ProductViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,Slide_menu_delegate>

{
    // Creating Side menu object
    
    Side_menu *sidemenu;
    UIView *overlay;
    FW_JsonClass *globalobj;
    NSMutableArray *ArrProductList;
    AppDelegate *appDelegate;
    bool data;
    UIView *loader_shadow_View;
    
    IBOutlet UIImageView *topbar;
    
    BOOL netcheck;
    
    
}

@property (weak, nonatomic) IBOutlet UIView *footer_base;
@property (strong, nonatomic) NSString *CategoryId;
@property(nonatomic,strong) NSString *headerTitle;
- (IBAction)back_button:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (weak, nonatomic) IBOutlet UITableView *ProductListingTable;
@property (weak, nonatomic) IBOutlet UILabel *lblPageTitle;

@property (weak, nonatomic) IBOutlet UILabel *noDataFoundLbl;
@property(strong,nonatomic) NSMutableArray *cellindex;
@property(strong,nonatomic) NSMutableArray *arrtotal;
//@property(strong,nonatomic) IBOutlet UIButton *BtnLike;
//-(IBAction)Btn_Like:(id)sender;



@end
