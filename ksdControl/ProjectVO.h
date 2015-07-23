//
//  ProjectVO.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "ElementVO.h"
#import "libs/GCDAsyncSocket.h"

@interface ProjectVO : ElementVO
{
    BOOL isShow;
    GCDAsyncSocket *tcpSocket;
    NSString * powerOn, *powerOff, *powerQuery;
    int _tag1;
}

@property NSString * linkType;

-(void)setIsShow:(BOOL)isShow2;

-(void)PowerOn;

-(void)PowerOff;


@end
