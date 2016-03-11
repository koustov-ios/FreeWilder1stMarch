//
//  NSString+stringCategory.m
//  FreeWilder
//
//  Created by esolz1 on 24/02/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import "NSString+stringCategory.h"

@implementation NSString (stringCategory)

+(BOOL)isEmailAddress:(NSString *)string
{

    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:string];
    
}

+(NSString*)stringByTrimmingLeadingWhitespace:(NSString *)checkStr
{
    NSInteger i = 0;
    
    while ((i < [checkStr length])
           && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[checkStr characterAtIndex:i]]) {
        i++;
    }
    return [checkStr substringFromIndex:i];
}

@end
