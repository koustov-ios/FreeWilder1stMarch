//
//  globalprotocol.h
//
//  Created by anirban on 20/04/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol globalprotocol <NSObject>

typedef void (^JsonBlock)(id result, NSError *error,BOOL completed);

@end
