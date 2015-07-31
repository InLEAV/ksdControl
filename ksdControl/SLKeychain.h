//
//  CHKeychain.h
//  ksdControl
//
//  Created by CMQ on 15/7/30.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface SLKeychain : NSObject



+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end
