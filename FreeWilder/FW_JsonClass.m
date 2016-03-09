//
//  RS_JsonClass.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 22/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "FW_JsonClass.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>

@implementation FW_JsonClass
{
    Urlresponceblock _responce;
    NSString *check;
    
}

-(void)GlobalDict_post:(NSMutableURLRequest *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce
{
    
    
    
    connection = [[NSURLConnection alloc] initWithRequest:parameter delegate:self];
    
    
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
    NSLog(@"url is: %@",parameter);
    
}


-(void)GlobalDict:(NSString *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce
{
    
      NSLog(@"Main URL --- %@", parameter);
    
    NSURL *url = [NSURL URLWithString:parameter];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
    
}
-(void)globalPost:(NSMutableURLRequest *)request typerequest:(NSString *)type withblock:(Urlresponceblock)responce
{
    //  NSLog(@"url request=%@",request);
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    check = type;
    connection = nil;
    
    _responce = [responce copy];
}
/*
 -(void)globalPost:(NSString *)parameter Dictionary:(NSDictionary *)TempDic typerequest:(NSString *)type Withblock:(Urlresponceblock)responce
 {
 NSLog(@"url request=%@",parameter);
 NSLog(@"tempdic=%@",TempDic);
 NSError *localErr;
 
 NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:(NSDictionary *)TempDic options:NSJSONWritingPrettyPrinted error:&localErr];
 
 NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
 
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:parameter]];
 
 NSString *params = jsonString; //[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 
 [request setHTTPMethod:@"POST"];
 
 [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
 
 [request setHTTPShouldHandleCookies:NO];
 
 [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
 
 [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
 NSLog(@"request=%@",request);
 connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
 
 check = type;
 connection = nil;
 
 _responce = [responce copy];
 }
 */
-(NSString *) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter
{
    
    //  NSLog(@"Main URL --- %@", parameter);
    
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photoimg\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }
    
    
    NSURLResponse *response = nil;
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    
    NSString *result = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    return result;
    
}


-(void) GlobalDict_imageFile:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce

{
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"prof_up_img\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
    
}




-(void) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce
{
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
       // [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo_img\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photoimg\" filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
    
}

-(void) GlobalDict_image1:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce
{
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"front_doc\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
    
   
    
}

-(void) GlobalDict_image2:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce
{
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"back_doc\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
    
}




- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"no_internet" object:nil];
    
    NSLog(@"Did Fail");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if ([check  isEqual: @"array"])
    {
        
        
        id result=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        _responce(result,nil);
    }
    else
    {
        id result = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        _responce(result,nil);
        NSLog(@"result-- %@", result);
    }
    
    
    
}

-(void)Userdict:(NSDictionary *)userdetails
{
    UserData = [[NSUserDefaults alloc]init];
    
    [UserData setObject:[userdetails objectForKey:@"id"] forKey:@"id"];
    
    [UserData synchronize];
}
- (BOOL)connectedToNetwork
{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
