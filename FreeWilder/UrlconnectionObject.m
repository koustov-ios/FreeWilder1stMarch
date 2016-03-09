//
//  UrlconnectionObject.m
//  QuickFindNew
//
//  Created by Prosenjit Kolay on 30/04/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "UrlconnectionObject.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>

@implementation UrlconnectionObject
@synthesize JsonBlock;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    
   
}
-(void)global:(NSString *)parameter typerequest:(NSString *)type withblock:(JsonBlock)responce
{
 //NSLog(@"url parameter=%@",parameter);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",parameter]]];
    
    // Create url connection and fire request
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    typerequestobj = type;
    conn = nil;
    
    responceobj = [responce copy];
    
    
}
-(void)globalPost:(NSMutableURLRequest *)request typerequest:(NSString *)type withblock:(JsonBlock)responce
{
    NSLog(@"url request=%@",request);
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    typerequestobj = type;
    conn = nil;
    
    responceobj = [responce copy];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *error = nil;
 //   NSLog(@"response data=%@",_responseData);
   //
    
    if ([typerequestobj isEqualToString:@"string"])
    {
       result = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    }
else
{
    result = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    NSLog(@"urlconnection result=%@",result);
  
}
    
  //
    responceobj(result,nil,YES);
   
   
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
   
    NSLog(@"Did Fail");
    
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
