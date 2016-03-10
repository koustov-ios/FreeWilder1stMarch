//
//  RS_JsonClass.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 22/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RS_ios_customBlock.h"
#import "RS_PCH.pch"
@interface FW_JsonClass : NSObject<NSURLConnectionDelegate>
{
    NSDictionary *DataDictionary;
    NSMutableData *responseData;
    NSURLConnection *connection;
    NSUserDefaults *UserData;
}

-(void)GlobalDict:(NSString *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce;
//-(void)globalPost:(NSString *)parameter Dictionary:(NSDictionary *)TempDic typerequest:(NSString *)type Withblock:(Urlresponceblock)responce;
-(void)globalPost:(NSMutableURLRequest *)request typerequest:(NSString *)type withblock:(Urlresponceblock)responce;
-(NSString *) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter ;

-(void)GlobalDict_post:(NSMutableURLRequest *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce;

-(void) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce;
-(void) GlobalDict_image_new:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce;

-(void) GlobalDict_image1:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce;

-(void) GlobalDict_image2:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce;

-(void) GlobalDict_imageFile:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce;

- (BOOL)connectedToNetwork;
-(void)Userdict:(NSDictionary *)userdetails;

@property NSString *error_str;

@end
