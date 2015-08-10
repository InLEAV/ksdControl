//
//  Sever.h
//  dengzhouControl
//
//  Created by LeafShadow on 14/11/5.
//  Copyright (c) 2014年 LeafShadows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "AppDelegate.h"
@interface Sever : NSObject
{
    int _port;
    NSString *_host;
    long _tag;
    
    GCDAsyncUdpSocket * _socket;
}

- (void) initSever:(int) port;

- (void) disConnect;

- (void) resume;

-(void)sendDataCommand:(NSData *)command toPort:(NSInteger)port toHost:(NSString *)host;

- (void)sendCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host;
@end
