//
//  RS_JsonClass.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 22/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "RS_JsonClass.h"
//#import <SystemConfiguration/SystemConfiguration.h>
//#import <sys/socket.h>
//#import <netinet/in.h>
//#import <arpa/inet.h>
//#import <netdb.h>

@implementation RS_JsonClass
{
    Urlresponceblock _responce;
    NSString *check;
     NSURLSessionDataTask *uploadTask;
    
}

-(void)GlobalDict:(NSMutableURLRequest *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce
{
    

    
   
     NSURLSession *session = [NSURLSession sharedSession];
    uploadTask = [session dataTaskWithRequest:parameter completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Process the response
        _responce=[responce copy];
        dispatch_async(dispatch_get_main_queue(), ^{
        if(data!=nil)
        {
        
            NSString *stringo = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"response hit: %@ ",stringo);
            check=parametercheck;
            
            if([check isEqualToString:@"array"])
            {
                
                id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"Result From Array...%@",result);
                _responce(result,nil);
            }
            if ([check isEqualToString:@"string"])
            {
                id  result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"Result From String...%@",result);
                _responce(result,nil);
            }
        
        }
        else
        {
            _responce(nil,error);
        }
            });
    }];
    [uploadTask resume];
    
}

-(void) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce
{
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"REQUEST.....%@",request);
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"prof_up_img\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
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

//-(void) GlobalDict_image2:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter Withblock:(Urlresponceblock)responce
//
//{
//    
//    
//    
//    //  check  = parametercheck;
//    
//    
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    
//    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    
//    [request setHTTPShouldHandleCookies:NO];
//    
//    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
//    
//    [request setTimeoutInterval:60];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    
//    
//    NSLog(@"REQUEST.....%@",request);
//    
//    
//    
//    
//    
//    if ( imageparameter.length > 0)
//        
//        
//        
//    {
//        
//        
//        
//        NSLog(@"Uploading.....");
//        
//        NSLog(@"image data..%@",imageparameter);
//        
//        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
//        
//        
//        
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        
//        
//        
//        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//        
//        
//        
//        NSMutableData *body = [NSMutableData data];
//        
//        
//        
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        
//        
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profile_image\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        
//        
//        
//        
//        
//        
//        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        
//        
//        [body appendData:imageparameter];
//        
//        
//        
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        
//        
//        [request setHTTPBody:body];
//        
//    }
//    
//    
//    
//    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
////    NSURLSession *session = [NSURLSession sharedSession];
////    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
////                                            completionHandler:
////                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
////                                      // ...
////                                  }];
////    
////    [task resume];
//    
//    
//    check  = parametercheck;
//    
//    connection=nil;
//    
//    _responce=[responce copy];
//    
//    
//    
//}

/*-(void)uploadImage
 {
 NSData *imageData = UIImagePNGRepresentation(yourImage);
 
 NSString *urlString = [NSString stringWithFormat:@"http://yourUploadImageURl.php?intid=%@",1];
 
 NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
 [request setURL:[NSURL URLWithString:urlString]];
 [request setHTTPMethod:@"POST"];
 
 NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
 NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
 [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 
 NSMutableData *body = [NSMutableData data];
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", 1]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[NSData dataWithData:imageData]];
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [request setHTTPBody:body];
 
 [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
 }*/


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
    
  if([check isEqualToString:@"array"])
    {
        
        id result=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        NSLog(@"Result...%@",result);
        _responce(result,nil);
    }
    if ([check isEqualToString:@"string"])
    {
        id  result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Result...%@",result);
        _responce(result,nil);
    }

}

-(void)Userdict:(NSDictionary *)userdetails
{
    UserData = [[NSUserDefaults alloc]init];
    
    [UserData setObject:[userdetails objectForKey:@"id"] forKey:@"id"];

    [UserData synchronize];
}
//- (BOOL)connectedToNetwork
//{
//    
//    struct sockaddr_in zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sin_len = sizeof(zeroAddress);
//    zeroAddress.sin_family = AF_INET;
//    
//
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    
//    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    
//    if (!didRetrieveFlags)
//    {
//        return NO;
//    }
//    
//    BOOL isReachable = flags & kSCNetworkFlagsReachable;
//    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
//    return (isReachable && !needsConnection) ? YES : NO;
//}
@end
