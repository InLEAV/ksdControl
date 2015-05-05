//
//  ElementVO.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "ElementVO.h"

@implementation ElementVO

@synthesize aType,ip,port;

-(void) initVO
{
    [super initVO];
    NSLog(@"type:%@",aType);
    NSLog(@"ip:%@",ip);
    NSLog(@"port:%d",port);
}

@end
