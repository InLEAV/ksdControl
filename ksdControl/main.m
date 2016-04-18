//
//  main.m
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appKey = @"912b686bb2d5eb89dd8477e9ff6b23ca";
        [Bmob registerWithAppKey:appKey];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
