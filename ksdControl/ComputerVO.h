//
//  ComputerVO.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComputerVO : NSObject
{
    int kid,port;
    NSString *ip,*kname;
}

- (void) initSever:(int) port;

- (void) off;

- (void) on;

@end
