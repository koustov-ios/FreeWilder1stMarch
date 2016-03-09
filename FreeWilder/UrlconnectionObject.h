//
//  UrlconnectionObject.h
//  QuickFindNew
//
//  Created by Prosenjit Kolay on 30/04/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "globalprotocol.h"


@interface UrlconnectionObject : NSObject<NSURLConnectionDelegate>
{
NSMutableData *_responseData;
NSURLConnection *conn;
    JsonBlock responceobj;
    NSString *typerequestobj;
    id result;
}

@property (copy) id (^JsonBlock)(void);
@property (weak,nonatomic) id json;

-(void)global:(NSString *)parameter typerequest:(NSString *)type withblock:(JsonBlock)responce;
- (BOOL)connectedToNetwork;
-(void)globalPost:(NSMutableURLRequest *)request typerequest:(NSString *)type withblock:(JsonBlock)responce;
@end
