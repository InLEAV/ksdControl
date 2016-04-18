//
//  Sever.m
//  dengzhouControl
//
//  Created by LeafShadow on 14/11/5.
//  Copyright (c) 2014年 LeafShadows. All rights reserved.
//

#import "Sever.h"

@implementation Sever

-(void) initSever:(int) port
{
    _tag = 1000;
    
    _port = port;
    
    if (_port < 0 || _port > 65535)
    {
        _port = 0;
    }
    
    if (_socket != nil)
        return;
    
    _socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError *err = nil;
    
    if (![_socket bindToPort:_port error:&err]) {
        NSLog(@"Error binding:%@",err.description);
        return;
    }
    if (![_socket beginReceiving:&err])
    {
        [_socket close];
        NSLog(@"Error receiving: %@", err);
        return;
    }
    
    [_socket enableBroadcast:YES error:nil];
}

- (void)sendplayCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF16LE);
    NSData *data = [command dataUsingEncoding:enc];
    
    [_socket sendData:data toHost:host port:port withTimeout:-1 tag:_tag];
    _tag++;
}

- (void)sendCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    
    NSData *data = [command dataUsingEncoding:NSUTF8StringEncoding];
    [_socket sendData:data toHost:host port:port withTimeout:-1 tag:_tag];
    _tag++;
}

-(void)sendDataCommand:(NSData *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    [_socket sendData:command toHost:host port:port withTimeout:-1 tag:_tag];
    
    _tag++;
}

- (void)bindTo
{
    if(_socket != nil)
    {
        [_socket close];
    }
    
    //创建套接字对象
    _socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [_socket enableBroadcast:YES error:nil];
    
}

- (void)pause
{
    if(_socket != nil)
    {
        [_socket close];
    }
}

- (void) disConnect
{
    [self pause];
}

- (void)resume
{
    [self pause];
    [self bindTo];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
}
@end
