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
@interface RS_JsonClass : NSObject<NSURLConnectionDelegate>
{
    NSDictionary *DataDictionary;
    NSMutableData *responseData;
    NSURLConnection *connection;
    NSUserDefaults *UserData;
}

-(void)GlobalDict:(NSMutableURLRequest *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce;
//-(void)GlobalDict2:(NSString *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce;
-(void) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce;
//-(void) GlobalDict_image2:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce;
//- (BOOL)connectedToNetwork;
-(void)Userdict:(NSDictionary *)userdetails;

@property NSString *error_str;

@end
