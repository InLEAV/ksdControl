//
//  ProjectVO.m
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "ProjectVO.h"

@implementation ProjectVO


-(void)initVO
{
    [super initVO];
    dispatch_queue_t tcpSocketQueue = dispatch_queue_create("com.manmanlai.tcpSocketQueue",DISPATCH_QUEUE_CONCURRENT);
    tcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:tcpSocketQueue];
}

-(void)setIsShow:(BOOL)isShow2
{
    isShow = isShow2;
    if (isShow == YES)
    {
        NSLog(@"show:YES:ip:%@.port:%d",ip,port);
        NSError *error = nil;
        if (![tcpSocket connectToHost:ip
                               onPort:port
                                error:&error])
        {
            NSLog(@"Error connecting: %@", error);
            
        } else
        {
            NSLog(@"Connected: %@",self.aName);
            [tcpSocket readDataWithTimeout:-1 tag:_tag1++];
        }
    }
    else
    {
        NSLog(@"DisConnected: %@",self.aName);
        [tcpSocket disconnect];
        
    }
}

// TCP socket已连接
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"socket已连接: %@",self.aName);
}
// TCP socket已断开
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socket已断开: %@",self.aName);
    if (isShow == YES) {
        [self setIsShow:YES];
    }
}
// TCP socket已写入数据
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"socket已写入数据");
}
// TCP socket已发送数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"socket已发送数据");
}

-(void)PowerOn
{
    NSData *data = [@"%1POWR 1\r" dataUsingEncoding:NSUTF8StringEncoding];
    [tcpSocket writeData:data withTimeout:-1 tag:_tag1++];
}

-(void)PowerOff
{
    NSData *data = [@"%1POWR 0\r" dataUsingEncoding:NSUTF8StringEncoding];
    [tcpSocket writeData:data withTimeout:-1 tag:_tag1++];
}

@end
