//
//  NSString+stringCategory.h
//  FreeWilder
//
//  Created by esolz1 on 24/02/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (stringCategory)

+(BOOL)isEmailAddress:(NSString *)string;
+(NSString*)stringByTrimmingLeadingWhitespace:(NSString *)checkStr;

@end
