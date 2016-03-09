//
//  Photos & Videos ViewController.m
//  FreeWilder
//
//  Created by kausik on 16/09/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Photos & Videos ViewController.h"
#import "ImageResize.h"
#import "FW_JsonClass.h"
#import "AFNetworking.h"

#pragma mark - Footer related imports
#import "FW_JsonClass.h"
#import "Footer.h"
#import "ServiceView.h"
#import "profile.h"
#import "ProductDetailsViewController.h"
#import "DashboardViewController.h"
#import "ForgotpasswordViewController.h"
#import "notificationsettingsViewController.h"
#import "ChangePassword.h"
#import "LanguageViewController.h"
#import "UserService.h"
#import "MyBooking & Request.h"
#import "userBookingandRequestViewController.h"
#import "myfavouriteViewController.h"
#import "Business Information ViewController.h"
#import "SettingsViewController.h"
#import "PaymentMethodViewController.h"
#import "PrivacyViewController.h"
#import "PayoutPreferenceViewController.h"
#import "Trust And Verification ViewController.h"
#import "Photos & Videos ViewController.h"
#import "rvwViewController.h"
#import "EditProfileViewController.h"
#import "BusinessProfileViewController.h"
//#import "Product_Details_ViewController.h"
#import "accountsubview.h"
#import "WishlistViewController.h"
#import "ViewController.h"
#import "sideMenu.h"


@interface Photos___Videos_ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate,Slide_menu_delegate,footerdelegate,Serviceview_delegate,Profile_delegate,accountsubviewdelegate,accountsubviewdelegate,sideMenu,UITextFieldDelegate>
{
    
    UIButton *closeBtn;
    
    UIImageView *scrollImageView,*zoomingImageView,*doubleTappedImageview;
    UIView *blackViewForZooming,*blackViewForImageSlider;
    UIScrollView *scrollViewForZooming;
    UIScrollView *imageScrollForSliding;
    UIButton *deleteImageBtn;
    BOOL deleteBtnVisible;
    int imageDeleteIndex;
    
    NSMutableArray *picarray;
    
    IBOutlet UIView *mainView;
    
    UIImageView *media;
    UIImage *img;
    
    IBOutlet UIButton *proImageBtn;
    IBOutlet UIActivityIndicatorView *spinner;
    FW_JsonClass *obj;
    UIView *imageDetailView;
    UIImageView * img1;
    NSMutableArray *imagelinkArray;
    UIButton *imageclearbtn;
    NSMutableArray *newArray,*btnTagArray;
    NSString *userid, *image_id;
    UIScrollView *imgscroll;
    
    int btnTag;
    
    BOOL dntCreate;
    
#pragma mark - Footer variables
    
    IBOutlet UIView *footer_base;
    sideMenu *leftMenu;
    UIView *overlay;
    NSMutableArray *ArrProductList;
    AppDelegate *appDelegate;
    bool data;
    UIView *loader_shadow_View;
    BOOL tapchk,tapchk1,tapchk2;
    NSMutableArray *jsonArray,*temp;
    UIView *blackview ,*popview;
    NSString *phoneno;
    ServiceView *service;
    profile *profileview;
    UITextField *phoneText;
    accountsubview *subview;
    FW_JsonClass *globalobj;

    
    
}

@end

@implementation Photos___Videos_ViewController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    dntCreate=YES;
    deleteBtnVisible=NO;
    
#pragma mark - Footer variables initialization
    
    Footer *footer=[[Footer alloc]init];
    footer.frame=CGRectMake(0,0,footer_base.frame.size.width,footer_base.frame.size.height);
    footer.Delegate=self;
    [footer_base addSubview:footer];
    temp= [[NSMutableArray alloc]init];
    
    // For Side menu
    
    overlay=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlay.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Slide_menu_off)];
    tapGesture.numberOfTapsRequired=1;
    [overlay addGestureRecognizer:tapGesture];
    
    leftMenu=[[sideMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 200, self.view.bounds.size.height)];
    
    leftMenu.delegate=self;
    
    
    
    
    ///Side menu ends here
    
    
    //Footer ends here------>

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid=[prefs valueForKey:@"UserId"];
    _imagePicker = [[UIImagePickerController alloc]init];
    videocodetxt.delegate=self;
    [spinner stopAnimating];
    obj = [[FW_JsonClass alloc]init];
    imagelinkArray = [[NSMutableArray alloc]init];
    profileImageview.layer.cornerRadius = profileImageview.frame.size.width/2;
    profileImageview.clipsToBounds=YES;
    
    NSString *url = [NSString stringWithFormat:@"%@/app_photo_video?userid=%@",App_Domain_Url,userid];
    
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         if ([[result valueForKey:@"response"] isEqualToString:@"success"])
         {
             
             imagelinkArray = [[result valueForKey:@"infoarray"]mutableCopy];
             
             
             videocodetxt.text= [result valueForKey:@"video_url"];
             
             if (imagelinkArray.count>0)
             {
                 
                 
                 
                 [profileImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagelinkArray [0] valueForKey:@"link"]]]];
                 
               //  [self performSelector:@selector(picBtnTap:) withObject:self afterDelay:0];
                 
                 
             }
             
             
         }
         
         NSLog(@"Image Array===%@",imagelinkArray);
         
     }];
    
    
    
    
    
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


- (IBAction)backtap:(id)sender
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.3f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    img = [ImageResize imageWithImage:[info valueForKey:UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(150, 146)];
    
  //  [self processImageThenPostToServer:img];
    
    
    NSData *pictureData = UIImageJPEGRepresentation(img, .5);
    
    pictureData=[NSData dataWithData:pictureData];
    
   // NSString *finalImagePath = [self base64forData:pictureData];
    
    
     //  NSString *strImageData = [finalImagePath stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    // NSLog(@"Picture data-----> %@",strImageData);
    
   //[self image_uploadWithImage:pictureData];
    
    //NSData* pictureData=UIImageJPEGRepresentation(img, 1);

//    NSString *base64String = [pictureData base64EncodedStringWithOptions:kNilOptions];
//    NSString *encodedString2 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL,  (CFStringRef)base64String,    NULL,   CFSTR("!*'();:@&=+$,/?%#[]\" "),   kCFStringEncodingUTF8));
    
//    NSString *url = [NSString stringWithFormat:@"%@app_prof_img_upload?userid=%@&photo_img=%@",App_Domain_Url,userid,finalImagePath];
//    
//  
//    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
//        
//        NSLog(@"Result------> %@",result);
//        
//        
//    }];
//
 
    
//----------  USING JSON CLASS  ----------->>>>>>>
    
    
    if (pictureData.length>0)
    {
        [spinner startAnimating];
        
        
        NSString *url = [NSString stringWithFormat:@"%@app_prof_img_upload?userid=%@",App_Domain_Url,userid];
        
       [obj GlobalDict_image:url Globalstr_image:@"array" globalimage:pictureData Withblock:^(id result, NSError *error) {
            
            
            
            if ([[result valueForKey:@"response" ]isEqualToString:@"Success"])
            {
               // [self profilepic];
                
                profileImageview.image =[UIImage imageWithData:pictureData];
                
            }
            else
            {
                 NSLog(@"result====%@",result);
            }
            
            
        }];
        
        
        
    }
    
    
//--------------------->>>>>>>
    
    NSLog(@"Image===%@",img);
//
//    
    
    
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}


//
//- (void)processImageThenPostToServer:(UIImage *)image
//{
//    {
//        NSData   *imageFileData;
//        NSString *imageFileName;
//        // check if there is an image to upload
//        if (image != nil) {
//            // yes, let's convert the image
//            // UIImageJPEGRepresentation accepts a UIImage and compression parameter
//            // use UIImagePNGRepresentation(self.userImage) for .PNG types
//            
//            imageFileData = UIImageJPEGRepresentation(image, 0.33f);
//            
//            imageFileName = @"profileImage.jpg";
//            
//            // post to server
//            
//        [self uploadToServerUsingImage:imageFileData andFileName:imageFileName];
//        
//        }
//        else
//        {
//            NSLog(@"processImageThenPostToServer:self.userImage IS nil.");
//        }
//    }
//
//}

//- (void)uploadToServerUsingImage:(NSData *)imageData andFileName:(NSString *)filename {
//    // set this to your server's address
//    
//   // NSString *urlString = @"http://fineuploader.com/demos.html#amazon-demo";
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@app_prof_img_upload?userid=%@",App_Domain_Url,userid];
//    
//    // set the content type, in this case it needs to be: "Content-Type: image/jpg"
//    // Extract 'jpg' or 'png' from the last three characters of 'filename'
//    
//    if (([filename length] -3 ) > 0)
//    {
//        NSString *contentType = [NSString stringWithFormat:@"Content-Type: image/%@", [filename substringFromIndex:[filename length] - 3]];
//    }
//    
//    // allocate and initialize the mutable URLRequest, set URL and method.
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    
//    // define the boundary and newline values
//    NSString *boundary = @"uwhQ9Ho7y873Ha";
//    NSString *kNewLine = @"\r\n";
//    
//    // Set the URLRequest value property for the HTTP Header
//    // Set Content-Type as a multi-part form with boundary identifier
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    // prepare a mutable data object used to build message body
//    NSMutableData *body = [NSMutableData data] ;
//    
//    // set the first boundary
//    [body appendData:[[NSString stringWithFormat:@"--%@%@", boundary, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Set the form type and format
//    
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"%@", @"photoimg", filename, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Now append the image itself.  For some servers, two carriage-return line-feeds are necessary before the image
//    [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:imageData];
//    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Add the terminating boundary marker & append a newline
//    [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Setting the body of the post to the request.
//    [request setHTTPBody:body];
//    
//    // TODO: Next three lines are only used for testing using synchronous conn.
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"==> sendSyncReq returnString: %@", returnString);
//    
//    // You will probably want to replace above 3 lines with asynchronous connection
//    //    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//}


-(NSString *)base64forData:(NSData*)theData
{
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data1 = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data1.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6) & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0) & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data1 encoding:NSASCIIStringEncoding];
}

# pragma mark - Image Upload

-(void)image_uploadWithImage:(NSData *)imageData
{
    
    //[self loader];
    
    
    NSString *parameter =[NSString stringWithFormat:@"%@app_prof_img_upload?userid=%@",App_Domain_Url,userid];
    
    // [NSString stringWithFormat:@"%@edit_account_ios/update_accinfo?user_id=%@&%@",App_Domain_Url,user_id,link_main];
    
    NSString* encodedUrl = [parameter stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    
    AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:encodedUrl]];
    
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:nil parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData)
                                    {
                                        
                                                [formData appendPartWithFileData:imageData name:@"photo_img" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                                                
                                      }];
    
    
    
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _operation, id responseObject) {
        
        NSString *response = [_operation responseString];
        
        NSLog(@"response:------->>>>>> %@",response);
        
        NSError *error;
        
        NSString *dictString=[NSString stringWithFormat:@"%@", response];//or ur dict reference..
        
        NSData *jsonData = [dictString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                              
                                                             options:NSJSONReadingMutableContainers
                              
                                                               error:&error];
        
        
        NSLog(@"json.....%@",json);
        
        
        
        
    }
                                     failure:^(AFHTTPRequestOperation * _operation, NSError *error) {
                                         
                                         
                                         if([_operation.response statusCode] == 403){
                                             
                                             //  [self checkLoader];
                                             
                                             NSLog(@"Upload Failed");
                                             
                                             // [polygonView removeFromSuperview];
                                             
                                             
                                           //  [self stoploader];
                                             
                                             return;
                                             
                                         }
                                         
                                     }];
    
    [operation start];
    
    
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}





- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex)
    {
        case 0:
            _imagePicker.delegate=self;
            
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            break;
        case 1:
            
            _imagePicker.delegate=self;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            
            break;
            
        default:
            
            break;
    }
    
}

#pragma mark-Image Slider Creation

- (IBAction)picBtnTap:(id)sender
{

    NSLog(@"Imagelink array-----> %@",imagelinkArray);
    
    if(imagelinkArray.count>0)
    {
        

    
//    _slideImageViewController = [PEARImageSlideViewController new];
//    
//    [_slideImageViewController setImageLists:[imagelinkArray valueForKey:@"link"]];//imageArray
//    
//    [_slideImageViewController showAtIndex:0];
    
    
    
    blackViewForImageSlider=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    blackViewForImageSlider.backgroundColor=[UIColor blackColor];
    [self.view addSubview:blackViewForImageSlider];
    
    imageScrollForSliding=[[UIScrollView alloc]initWithFrame:blackViewForImageSlider.frame];
    imageScrollForSliding.pagingEnabled=YES;
    imageScrollForSliding.delegate=self;
    
    [blackViewForImageSlider addSubview:imageScrollForSliding];
    
    float updatedXValue=0;
    
    int j=1;
    
    for (int i=0; i<imagelinkArray.count; i++) {
        
        
        
        scrollImageView=[[UIImageView alloc]initWithFrame:CGRectMake(updatedXValue, (imageScrollForSliding.frame.size.height-(self.view.bounds.size.height/1.3))/2, imageScrollForSliding.frame.size.width, self.view.bounds.size.height/1.3)];
        
        
        scrollImageView.tag=i;
        
        scrollImageView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 2;
        
        [scrollImageView addGestureRecognizer:tapGestureRecognize];
        
        UITapGestureRecognizer *tapGestureRecognize1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapOnImage:)];
        
        tapGestureRecognize1.delegate = self;
        tapGestureRecognize1.numberOfTapsRequired =1;
        
        [scrollImageView addGestureRecognizer:tapGestureRecognize1];
        
        scrollImageView.contentMode=UIViewContentModeScaleAspectFit;
        
        
         [scrollImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[imagelinkArray objectAtIndex:i] valueForKey:@"link"]]] placeholderImage:[UIImage imageNamed:@"Image File-64"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        [imageScrollForSliding addSubview:scrollImageView];
        
        updatedXValue+=scrollImageView.frame.size.width;
        
        imageScrollForSliding.contentSize=CGSizeMake(j*scrollImageView.frame.size.width, scrollImageView.frame.size.height);
        
       
        
        j=j+1;
        
    }
    
    closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, 20, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeImageSlider:) forControlEvents:UIControlEventTouchUpInside];
    
    
    deleteImageBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-40)/2, self.view.bounds.size.height, 30, 40)];
    [deleteImageBtn setImage:[UIImage imageNamed:@"Trash-50"] forState:UIControlStateNormal];
    
    [deleteImageBtn addTarget:self action:@selector(deleteImageTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:deleteImageBtn];
    
    [self.view addSubview:closeBtn];
    
 }
    else
    {
    
        UIAlertView *noImageAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"No imges to display." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noImageAlert show];
    
    }

}

-(void)singleTapOnImage:(UITapGestureRecognizer *)tap
{
    
    UIView *tappedView=tap.view;
    
    imageDeleteIndex=(int)tappedView.tag;
    
    //NSLog(@"Single tap");
    
    if(deleteBtnVisible==NO)
    {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        deleteImageBtn.frame=CGRectMake((self.view.bounds.size.width-40)/2, self.view.bounds.size.height-50, 30, 40);
        
    }completion:^(BOOL finished) {
        
        deleteBtnVisible=YES;
    }];
        
    }
    else if(deleteBtnVisible==YES)
    {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            deleteImageBtn.frame=CGRectMake((self.view.bounds.size.width-40)/2, self.view.bounds.size.height, 30, 40);
            
        }completion:^(BOOL finished) {
            
            deleteBtnVisible=NO;
        }];
        
    }


   

}

-(void)deleteImageTapped:(UIButton *)btn
{
    NSMutableArray *priorDeleteArray=[[NSMutableArray alloc]init];
    
    priorDeleteArray=[imagelinkArray mutableCopy];

    [imagelinkArray removeObjectAtIndex:imageDeleteIndex];
    
     [blackViewForImageSlider removeFromSuperview];
     [deleteImageBtn removeFromSuperview];
    
    
    if(imagelinkArray.count>0)
    {
        NSLog(@"Image link----> %@",[NSString stringWithFormat:@"%@",[[imagelinkArray objectAtIndex:0] valueForKey:@"link"]]);
        
        [profileImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[imagelinkArray objectAtIndex:0] valueForKey:@"link"]]] placeholderImage:[UIImage imageNamed:@"profile"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        
        [userData setValue:[[imagelinkArray objectAtIndex:0] valueForKey:@"link"] forKey:@"UserImage"];
        
        [userData synchronize];

        //[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]//UserImage
        
        [self recreateImageViewAfterDelete];
    }
    
   // profileImageview.image=[UIImage imageNamed:@"profile"];
    
    
    NSString *url =[NSString stringWithFormat:@"%@app_delete_profimage?image_id=%@",App_Domain_Url,[[priorDeleteArray objectAtIndex:imageDeleteIndex] valueForKey:@"image_id"]];
    
    NSLog(@"url=====%@",url);
   
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"Result after delete .... \n %@",result);
        
        UILabel *alertLabel=[[UILabel alloc]init];
        
        alertLabel.frame=CGRectMake((self.view.bounds.size.width-150)/2, self.view.bounds.size.height-65, 150, 40);
        
        
        
        if(imagelinkArray.count>0)
        {
            alertLabel.backgroundColor=[UIColor whiteColor];
            alertLabel.textColor=[UIColor blackColor];
        
        }
        
        else if (imagelinkArray.count==0)
        {
        
            profileImageview.image=[UIImage imageNamed:@"profile"];
            alertLabel.backgroundColor=[UIColor blackColor];
            alertLabel.textColor=[UIColor whiteColor];
        
        }
        
        alertLabel.text=@"Deleted Successfully";
        alertLabel.layer.cornerRadius=5;
        
        alertLabel.clipsToBounds=YES;
        
        alertLabel.font=[UIFont fontWithName:@"Lato" size:14.0f];
        alertLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.view addSubview:alertLabel];
        
        alertLabel.alpha=0;
        
        [UIView animateWithDuration:2 animations:^{
            
            alertLabel.alpha=1;
            
        }
                         completion:^(BOOL finished) {
                             
                             
                             [UIView animateWithDuration:2 animations:^{
                                 
                                 alertLabel.alpha=0;
                                 
                                 
                             }
                                              completion:^(BOOL finished) {
                                                  
                                                  
                                                  [alertLabel removeFromSuperview];
                                                  
                                              }];
                             
                             
                         }];

        
        
    }];

}

-(void)recreateImageViewAfterDelete
{
    
    
    blackViewForImageSlider=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    blackViewForImageSlider.backgroundColor=[UIColor blackColor];
    [self.view addSubview:blackViewForImageSlider];
    
    imageScrollForSliding=[[UIScrollView alloc]initWithFrame:blackViewForImageSlider.frame];
    imageScrollForSliding.pagingEnabled=YES;
    imageScrollForSliding.delegate=self;
    
    [blackViewForImageSlider addSubview:imageScrollForSliding];
    
    float updatedXValue=0;
    
    int j=1;
    
    for (int i=0; i<imagelinkArray.count; i++) {
        
        
        
        scrollImageView=[[UIImageView alloc]initWithFrame:CGRectMake(updatedXValue, (imageScrollForSliding.frame.size.height-(self.view.bounds.size.height/1.3))/2, imageScrollForSliding.frame.size.width, self.view.bounds.size.height/1.3)];
        
        
        scrollImageView.tag=i;
        
        scrollImageView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 2;
        
        [scrollImageView addGestureRecognizer:tapGestureRecognize];
        
        UITapGestureRecognizer *tapGestureRecognize1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapOnImage:)];
        
        tapGestureRecognize1.delegate = self;
        tapGestureRecognize1.numberOfTapsRequired =1;
        
        [scrollImageView addGestureRecognizer:tapGestureRecognize1];
        
        scrollImageView.contentMode=UIViewContentModeScaleAspectFit;
        
        
        [scrollImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[imagelinkArray objectAtIndex:i] valueForKey:@"link"]]] placeholderImage:[UIImage imageNamed:@"Image File-64"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        [imageScrollForSliding addSubview:scrollImageView];
        
        updatedXValue+=scrollImageView.frame.size.width;
        
        imageScrollForSliding.contentSize=CGSizeMake(j*scrollImageView.frame.size.width, scrollImageView.frame.size.height);
        
        
        
        j=j+1;
        
    }
    
    closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, 20, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeImageSlider:) forControlEvents:UIControlEventTouchUpInside];
    
    
    deleteImageBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-40)/2, self.view.bounds.size.height, 30, 40)];
    [deleteImageBtn setImage:[UIImage imageNamed:@"Trash-50"] forState:UIControlStateNormal];
    
    [deleteImageBtn addTarget:self action:@selector(deleteImageTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:deleteImageBtn];
    
    [self.view addSubview:closeBtn];
    
}


-(void)closeImageSlider:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         blackViewForImageSlider.alpha = 0.0;
         blackViewForImageSlider.transform = CGAffineTransformMakeScale(10.0, 0.1);
     }
                     completion:^(BOOL finished)
     {
         [blackViewForImageSlider removeFromSuperview];
         [closeBtn removeFromSuperview];
         //view = nil;
     }];


}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{

    return zoomingImageView;

}

-(void)tapped:(UITapGestureRecognizer *)tapGesture
{
    
    blackViewForZooming=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    blackViewForZooming.backgroundColor=[UIColor blackColor];
    [self.view addSubview:blackViewForZooming];
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelZoomingView:)];
    
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 2;
    [blackViewForZooming addGestureRecognizer:tapGestureRecognize];
    
    scrollViewForZooming.showsHorizontalScrollIndicator=NO;
    scrollViewForZooming.showsVerticalScrollIndicator=NO;
    scrollViewForZooming=[[UIScrollView alloc]initWithFrame:blackViewForZooming.frame];
    scrollViewForZooming.bounces=YES;
    scrollViewForZooming.pagingEnabled=NO;
    
    scrollViewForZooming.minimumZoomScale=1.0;
    scrollViewForZooming.maximumZoomScale=4.0;
    
    scrollViewForZooming.delegate=self;
    
    [blackViewForZooming addSubview:scrollViewForZooming];
    
    UIImageView *imageView=(UIImageView *)tapGesture.view;
    
    doubleTappedImageview=(UIImageView *)tapGesture.view;
    
//    zoomingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, (scrollViewForZooming.frame.size.height-(self.view.bounds.size.height/1.3))/2, scrollViewForZooming.frame.size.width, self.view.bounds.size.height/1.3)];
    
       zoomingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, (scrollViewForZooming.frame.size.height-(self.view.bounds.size.height/1.3))/2, scrollViewForZooming.frame.size.height/1.3, self.view.bounds.size.height/1.3)];
    
    scrollViewForZooming.contentSize=CGSizeMake(scrollViewForZooming.frame.size.height/1.3, scrollViewForZooming.frame.size.height);
    
    scrollViewForZooming.contentOffset=CGPointMake((scrollViewForZooming.frame.size.height/1.3)/5, scrollViewForZooming.contentOffset.y);
    
    zoomingImageView.image=imageView.image;
    
    [scrollViewForZooming addSubview:zoomingImageView];
    
}

-(void)cancelZoomingView:(UITapGestureRecognizer *)tapGesture
{

     UIView *view=tapGesture.view;
    
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         view.alpha = 0.0;
         view.transform = CGAffineTransformMakeScale(10.0, 0.1);
     }
                     completion:^(BOOL finished)
     {
         [view removeFromSuperview];
         //view = nil;
     }];


}




-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
    NSLog(@"Zoom ends at scale... %f",scale);
    
    
}





-(CGRect )calculateClientRectOfImageInUIImageView:(UIImageView *)img_view
{
    CGSize imageSize = img_view.image.size;
    CGFloat imageScale = fminf(CGRectGetWidth(img_view.bounds)/imageSize.width, CGRectGetHeight(img_view.bounds)/imageSize.height);
    CGSize scaledImageSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
    CGRect imageFrame = CGRectMake(roundf(0.5f*(CGRectGetWidth(img_view.bounds)-scaledImageSize.width)), roundf(0.5f*(CGRectGetHeight(img_view.bounds)-scaledImageSize.height)), roundf(scaledImageSize.width), roundf(scaledImageSize.height));
    
    return(imageFrame);
}

-(void)closeTapped
{
    [imageDetailView removeFromSuperview];
    
    profileImageview.hidden=NO;
    //
    //    [imgscroll removeFromSuperview];
    //    imageDetailView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    //
    //
    //    imageDetailView.layer.cornerRadius= imageDetailView.frame.size.width/2;
    //    imageDetailView.clipsToBounds=YES;
    //
    //    [imageDetailView setAlpha: .8f];
    
    UIImageView *tapclose = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.width)];
    
    tapclose.image = profileImageview.image;
    
    tapclose.layer.cornerRadius= tapclose.frame.size.width/2;
    tapclose.clipsToBounds=YES;
    
    [self.view addSubview:tapclose];
    
    
    
    [UIView animateWithDuration:.2f animations:^{
        
        //       imageDetailView.frame= CGRectMake(profileImageview.frame.origin.x,profileImageview.frame.origin.y,profileImageview.frame.size.width,profileImageview.frame.size.height);
        //
        //        imageDetailView.layer.cornerRadius= imageDetailView.frame.size.height/2;
        //        imageDetailView.clipsToBounds=YES;
        //
        //
        //        [imageDetailView setAlpha: .04f];
        
        
        tapclose.frame= CGRectMake(profileImageview.frame.origin.x,profileImageview.frame.origin.y,profileImageview.frame.size.width,profileImageview.frame.size.height);
        
        tapclose.layer.cornerRadius= tapclose.frame.size.width/2;
        tapclose.clipsToBounds=YES;
        
        tapclose.alpha =.4f;
        
    }
                     completion:^(BOOL finished)
     {
         
         
         [UIView animateWithDuration:2 animations:^{
             
             
             //[imageDetailView setAlpha: .000020f];
             
             tapclose.layer.cornerRadius= tapclose.frame.size.width/2;
             tapclose.clipsToBounds=YES;
             
             tapclose.alpha = .000020f;
             
             
             
         }
                          completion:^(BOOL finished)
          {
              
              // [imageDetailView removeFromSuperview];
              
              
              [tapclose removeFromSuperview];
              
              
          }];
         
         
         
     }];
    
    
    
    
    
    
}

-(void)imageTapped:(UIButton *)sender
{
    
    
    /*
     for (int i=0; i<btnTagArray.count; i++)
     {
     
     
     
     if (i==sender.tag)
     {
     newArray = [NSMutableArray arrayWithArray:imagelinkArray];
     
     
     
     image_id=  [[imagelinkArray objectAtIndex:i]valueForKey:@"image_id"];
     
     [newArray removeObjectAtIndex:i];
     
     NSLog(@"Image==============id======%@",image_id);
     
     imagelinkArray =[[NSMutableArray alloc]init];
     imagelinkArray=[newArray mutableCopy];
     
     newArray = [[NSMutableArray alloc]init];
     break;
     }
     */
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure to Delete this Photo?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    
    
    [alert show];
    
    
    btnTag=(int)sender.tag;
    
    
    
    /*
     newArray = [NSMutableArray arrayWithArray:imagelinkArray];
     
     image_id=  [[imagelinkArray objectAtIndex:sender.tag]valueForKey:@"image_id"];
     
     NSString *url =[NSString stringWithFormat:@"%@/app_delete_profimage?image_id=%@",App_Domain_Url,image_id];
     
     NSLog(@"url=====%@",url);
     [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
     if([[result valueForKey:@"response"]isEqualToString:@"success"])
     {
     [newArray removeObjectAtIndex:sender.tag];
     
     NSLog(@"Image==============id======%@",image_id);
     
     imagelinkArray =[[NSMutableArray alloc]init];
     imagelinkArray=[newArray mutableCopy];
     
     newArray = [[NSMutableArray alloc]init];
     
     
     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     
     [alrt show];
     
     
     
     }
     
     }];
     
     
     */
    
    
    //  }
    
    
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 1)
        
    {
        profileImageview.hidden=NO;
        newArray = [NSMutableArray arrayWithArray:imagelinkArray];
        
        image_id=  [[imagelinkArray objectAtIndex:btnTag]valueForKey:@"image_id"];
        
        NSString *url =[NSString stringWithFormat:@"%@/app_delete_profimage?image_id=%@",App_Domain_Url,image_id];
        
        NSLog(@"url=====%@",url);
        [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             if([[result valueForKey:@"response"]isEqualToString:@"success"])
             {
                 // [imageDetailView removeFromSuperview];
                 
                 [newArray removeObjectAtIndex:btnTag];
                 
                 NSLog(@"Image==============id======%@",image_id);
                 
                 imagelinkArray =[[NSMutableArray alloc]init];
                 imagelinkArray=[newArray mutableCopy];
                 
                 newArray = [[NSMutableArray alloc]init];
                 
                 [imgscroll removeFromSuperview];
                 imageDetailView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
                 
                 
                 imageDetailView.layer.cornerRadius= imageDetailView.frame.size.width/2;
                 imageDetailView.clipsToBounds=YES;
                 
                 [imageDetailView setAlpha: 1];
                 
                 
                 [UIView animateWithDuration:.2 animations:^{
                     
                     imageDetailView.frame= CGRectMake(profileImageview.frame.origin.x,profileImageview.frame.origin.y,profileImageview.frame.size.width,profileImageview.frame.size.height);
                     
                     imageDetailView.layer.cornerRadius= imageDetailView.frame.size.height/2;
                     imageDetailView.clipsToBounds=YES;
                     
                     
                     [imageDetailView setAlpha: .04f];
                     
                     
                     
                 }
                                  completion:^(BOOL finished)
                  {
                      
                      
                      [UIView animateWithDuration:.1 animations:^{
                          
                          
                          [imageDetailView setAlpha: .000020f];
                          
                          
                          
                      }
                                       completion:^(BOOL finished)
                       {
                           
                           [imageDetailView removeFromSuperview];
                           
                           
                       }];
                      
                      
                      
                  }];
                 
                 
                 
                 
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 
                 [alrt show];
                 
                 NSLog(@"1-------");
                 
             }
             
         }];
        
        
    }
    
    
    
}



- (IBAction)uploadImage:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    
    [popup showInView:mainView];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //  [textField resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
        
        CGRect mainFrame=self.view.frame;
        
        CGRect tempFrame=mainFrame;
        
        tempFrame.origin.y=0;
        
        self.view.frame=tempFrame;
        
        [textField resignFirstResponder];
        
        
    }];
    return YES;
}






- (IBAction)udateurl:(id)sender

{
    if (videocodetxt.text.length==0)
    {
        videocodetxt.text=@"";
    }
    
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@/app_save_video?userid=%@&video_url=%@",App_Domain_Url,userid,videocodetxt.text];
    
    
    NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [ obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        if ([[result valueForKey:@"response"]isEqualToString:@"success"])
        {
            
            NSString *url = [NSString stringWithFormat:@"%@/app_photo_video?userid=%@",App_Domain_Url,userid];
            
            
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Upadte" message:[result valueForKey:@"response"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alrt show];
            
            
            [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 
                 if ([[result valueForKey:@"response"] isEqualToString:@"success"])
                 {
                     
                     imagelinkArray =[[NSMutableArray alloc]init];
                     
                     
                     
                     imagelinkArray = [[result valueForKey:@"infoarray"]mutableCopy];
                     
                     
                     videocodetxt.text= [result valueForKey:@"video_url"];
                     
                     if (imagelinkArray.count>0)
                     {
                         [profileImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagelinkArray objectAtIndex:0]]]];
                         
                         
                         
                         
                     }
                     
                     
                 }
                 
                 
                 
             }];
            
            
            
        }
        
        
        
        
        
    }];
    
    
    
    
}



-(void)profilepic
{
    NSString *url = [NSString stringWithFormat:@"%@/app_photo_video?userid=%@",App_Domain_Url,userid];
    
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         if ([[result valueForKey:@"response"] isEqualToString:@"success"])
         {
             
             imagelinkArray = [[result valueForKey:@"infoarray"]mutableCopy];
             
             
             videocodetxt.text= [result valueForKey:@"video_url"];
             
             if (imagelinkArray.count>0)
             {
                 
                 
                 
                 
                 
                 
                 [profileImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagelinkArray [0] valueForKey:@"link"] ]] placeholderImage:profileImageview.image options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                 
                 [spinner stopAnimating];
             }
             
             
         }
         
         NSLog(@"Image Array===%@",imagelinkArray);
         
     }];
    
}


#pragma mark - Footer related methods

//------Side menu methods Starts here

-(void)side
{
    [self.view addSubview:overlay];
    [self.view addSubview:leftMenu];
    
}


-(void)sideMenuAction:(int)tag
{
    
    NSLog(@"You have tapped menu %d",tag);
    
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    
    if(tag==0)
    {
        
        DashboardViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==1)
    {
        // Do Rate App related work here
        
    }
    if(tag==2)
    {
        
        userid=[prefs valueForKey:@"UserId"];
        
        BusinessProfileViewController *objvc = [self.storyboard instantiateViewControllerWithIdentifier:@"busniessprofile"];
        
        objvc.BusnessUserId = userid;
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==3)
    {
        EditProfileViewController    *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_profile_page"];
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==4)
    {
        Photos___Videos_ViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==5)
    {
        
        blackview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelByTap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        
        [blackview addGestureRecognizer:tapGestureRecognize];
        
        
        
        
        popview =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3)];
        
        
        UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(10, popview.bounds.origin.y+10, popview.frame.size.width-20, 40)];
        
        phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, header.frame.size.height+20, popview.frame.size.width-20, 45)];
        phoneText.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0];
        
        phoneText.delegate=self;
        phoneText.placeholder=@"Enter Phone Number";
        
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        phoneText.leftView = paddingView;
        phoneText.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(popview.bounds.origin.x+100, header.frame.size.height+phoneText.frame.size.height+40, phoneText.frame.size.width-180, 30)];
        
        submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:79/255.0 alpha:1];
        
        submit.layer.cornerRadius = 5;
        
        [submit setTitle:@"Save" forState:UIControlStateNormal];
        // [imageCloseBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        phoneText.layer.cornerRadius=5;
        
        header.text = @"Phone Verification";
        
        //  header.backgroundColor = [UIColor redColor];
        
        [header setFont:[UIFont fontWithName:@"Lato" size:16]];
        [phoneText setFont:[UIFont fontWithName:@"Lato" size:14]];
        
        // header.textColor=[UIColor redColor];
        
        header.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:blackview];
        [popview addSubview:header];
        [popview addSubview:submit];
        [popview addSubview:phoneText];
        popview.backgroundColor=[UIColor whiteColor];
        popview.layer.cornerRadius =5;
        
        [self.view addSubview:popview];
        
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            phoneText.text=[prefs valueForKey:@"phone_no"];
            
            
        }];
        
    }
    if(tag==6)
    {
        Trust_And_Verification_ViewController  *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"trust"];
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==7)
    {
        
        rvwViewController  *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"review_vc"];
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    if(tag==8)
    {
        Business_Information_ViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"Business"];
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==9)
    {
        UserService *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"myservice"];
        
        [self.navigationController pushViewController:objvc animated:NO];
        
    }
    if(tag==10)
    {
        //Add product---//---service
    }
    if(tag==11)
    {
        
        userBookingandRequestViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userbookingandrequestviewcontoller"];
        [self.navigationController pushViewController:objvc animated:NO];
        
    }
    if(tag==12)
    {
        MyBooking___Request *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"Mybooking_page"];
        
        [self.navigationController pushViewController:objvc animated:NO];
        
    }
    if(tag==13)
    {
        WishlistViewController    *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
        
        [self.navigationController pushViewController:objvc animated:NO];
        
    }
    if(tag==14)
    {
        myfavouriteViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"favouriteviewcontroller"];
        [self.navigationController pushViewController:objvc animated:NO];
    }
    if(tag==15)
    {
        // Account....
        
    }
    
    if(tag==16)
    {
        LanguageViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"language"];
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    if(tag==17)
    {
        // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [self deleteAllEntities:@"ProductList"];
        [self deleteAllEntities:@"WishList"];
        [self deleteAllEntities:@"CategoryFeatureList"];
        [self deleteAllEntities:@"CategoryList"];
        // [self deleteAllEntities:@"ContactList"];
        [self deleteAllEntities:@"ServiceList"];
        
        
        [[FBSession activeSession] closeAndClearTokenInformation];
        
        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        
        [userData removeObjectForKey:@"status"];
        
        [userData removeObjectForKey:@"logInCheck"];
        
        ViewController   *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
        
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
        
    }
    
    // accountSubArray=@[@"Notification",@"Payment Method",@"payout Preferences",@"Tansaction History",@"Privacy",@"Security",@"Settings"];
    
    if(tag==50)
    {
        
        notificationsettingsViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsfornotification"];
        [self.navigationController pushViewController:objvc animated:NO];
        
        
    }
    if(tag==51)
    {
        PaymentMethodViewController *objvc =[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
        [self.navigationController pushViewController:objvc animated:NO];
        
        
    }
    if(tag==52)
    {
        PayoutPreferenceViewController *objvc =[self.storyboard instantiateViewControllerWithIdentifier:@"payout"];
        [self.navigationController pushViewController:objvc animated:NO];
        
    }
    if(tag==53)
    {
        NSLog(@"i am from transaction history");
        
        
    }
    if(tag==54)
    {
        PrivacyViewController *objvc =[self.storyboard instantiateViewControllerWithIdentifier:@"privacy"];
        [self.navigationController pushViewController:objvc animated:NO];
    }
    if(tag==55)
    {
        ChangePassword *objvc =[self.storyboard instantiateViewControllerWithIdentifier:@"changepass"];
        [self.navigationController pushViewController:objvc animated:NO];
        
        
    }
    if(tag==56)
    {
        SettingsViewController *objvc =[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
        [self.navigationController pushViewController:objvc animated:NO];
        
    }
    
    
}

-(void)Slide_menu_off
{
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6
                        options:1 animations:^{
                            
                            
                            
                            
                            leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                            
                        }
     
     
     
                     completion:^(BOOL finished)
     
     {
         
         [leftMenu removeFromSuperview];
         [overlay removeFromSuperview];
         
         
         
     }];
    
}


-(void)pushmethod:(UIButton *)sender
{
    
    NSLog(@"Test_mode....%ld",(long)sender.tag);
    tapchk=false;
    tapchk1=false;
    tapchk2=false;
    
    
    
    
    
    if (sender.tag==5)
    {
        [self side];
        
        NSLog(@"Creating side menu.....");
        
        
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6
                            options:1 animations:^{
                                
                                leftMenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-leftMenu.frame.size.width,0,leftMenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                
                                
                            }
         
                         completion:^(BOOL finished)
         {
             
             // overlay.userInteractionEnabled=YES;
             
             // [service removeFromSuperview];
             
             
             
             
         }];
        
        
    }
    else if (sender.tag==4)
    {
        
        
        DashboardViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"add_service_page"];
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==3)
    {
        
        DashboardViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"msg_page"];
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==2)
    {
        
        
        DashboardViewController *objvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchProductViewControllersid"];
        [self PushViewController:objvc WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==1)
    {
        
        NSLog(@"I am here dashboard...");
        
        DashboardViewController *dashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
        [self PushViewController:dashVC WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    
    
}


-(void)save
{
    
    if (phoneText.text.length==0)
    {
        phoneText.placeholder = @"Please Enter Phone Number";
    }
    else
    {
        //(@"url");
        
        NSString *url = [NSString stringWithFormat:@"%@/app_phone_verify_add?userid=%@&phone_no=%@",App_Domain_Url,userid,[phoneText text]];
        
        [globalobj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            
            if ([[result valueForKey:@"response"]isEqualToString:@"success"])
            {
                phoneno=phoneText.text;
                
                
                [UIView animateWithDuration:.3 animations:^{
                    
                    
                    
                    popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
                    [phoneText resignFirstResponder];
                    
                }
                                 completion:^(BOOL finished)
                 {
                     
                     
                     
                     [blackview removeFromSuperview];
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"response"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     
                 }];
                
            }
            
            
        }];
        
        
    }
    
}


-(void)doneWithNumberPad{
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        popview.frame =CGRectMake(10, self.view.frame.size.height * .35, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        [phoneText resignFirstResponder];
        
    }];
    
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
    
    
    if (textField==phoneText)
    {
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        phoneText.inputAccessoryView = numberToolbar;
        
        
        phoneText.keyboardType =UIKeyboardTypePhonePad;
        [UIView animateWithDuration:.3 animations:^{
            
            popview.frame =CGRectMake(10, self.view.frame.size.height * .12, self.view.frame.size.width-20, self.view.frame.size.height * .3);
            
            
        }];
        
        
    }
    
    else if (textField==videocodetxt)
    {
    
        textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        [UIView animateWithDuration:0.8 animations:^{
            
            CGRect tempFrame=CGRectMake(0, self.view.frame.origin.y-80, self.view.bounds.size.width, self.view.bounds.size.height);
            
            self.view.frame=tempFrame;
            
        }];

    
    }
    
    
    
    return YES;
}



- (void)deleteAllEntities:(NSString *)nameEntity
{
    NSManagedObjectContext *theContext=[appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [theContext deleteObject:object];
    }
    
    error = nil;
    [theContext save:&error];
}


-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.2f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}


-(void)cancelByTap
{
    [UIView animateWithDuration:.3 animations:^{
        
        
        
        popview.frame =CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height * .3);
        [phoneText resignFirstResponder];
        
    }
                     completion:^(BOOL finished)
     {
         
         
         
         [blackview removeFromSuperview];
         
     }];
    
}


// ------- FOOTER METHOD ENDS HERE --------

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self Slide_menu_off];
    
}


@end
