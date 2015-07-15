//
//  ProjectControl.m
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ProjectControl.h"

@implementation ProjectControl

//初始单元格，添加控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _tag1 = 200;
    self.VO = [ProjectVO new];
    
    isShow = NO;
    
    powerOff = [NSString stringWithFormat:@"%1%POWR 0\r"];
    powerOn = [NSString stringWithFormat:@"%1%POWR 1\r"];
    powerQuery = [NSString stringWithFormat:@"%1%POWR ?\r"];
    
    if (self)
    {
        self.backgroup =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 237, 156)];
        [self.backgroup setImage:[UIImage imageNamed:@"controlBg.png"]];
        [self.contentView addSubview:self.backgroup];
        
        // 创建一个UILabel控件
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,frame.size.width, 35)];
        self.label.backgroundColor = [UIColor clearColor];
        
        // 设置该控件的自动缩放属性
        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight|
        UIViewAutoresizingFlexibleWidth;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:35];
        self.label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label];
        
        //这里创建一个圆角矩形的按钮，开电脑按钮
        self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openBtn.frame = CGRectMake(30, 77, 70, 60);
        self.openBtn.backgroundColor = [UIColor clearColor];
        [self.openBtn setImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
        [self.openBtn setImage:[UIImage imageNamed:@"on-highlight.png"] forState:UIControlStateHighlighted];
        [self.openBtn addTarget:self action:@selector(openProject:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.openBtn];
        
        //这里创建一个圆角矩形的按钮，关电脑按钮
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtn.frame = CGRectMake(137, 77, 70, 60);
        self.closeBtn.backgroundColor = [UIColor clearColor];
        [self.closeBtn setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
        [self.closeBtn setImage:[UIImage imageNamed:@"off-highlight.png"] forState:UIControlStateHighlighted];
        [self.closeBtn addTarget:self action:@selector(closeProject:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.closeBtn];
        
        // 设置边框
        self.contentView.layer.borderWidth = 2.0f;
        self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        
        // 设置圆角
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
        
        dispatch_queue_t tcpSocketQueue = dispatch_queue_create("com.manmanlai.tcpSocketQueue",DISPATCH_QUEUE_CONCURRENT);
        tcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:tcpSocketQueue];
    }
    
    return self;
}

-(void)setIsShow:(BOOL)isShow2
{
    isShow = isShow2;
    if (isShow == YES)
    {
        NSLog(@"show:YES:ip:%@.port:%d",self.VO.ip,self.VO.port);
        NSError *error = nil;
        if (![tcpSocket connectToHost:self.VO.ip
                               onPort:self.VO.port
                                error:&error])
        {
            NSLog(@"Error connecting: %@", error);
            
        } else
        {
            NSLog(@"Connected: %@",self.VO.aName);
            [tcpSocket readDataWithTimeout:-1 tag:_tag1++];
        }
    }
    else
    {
         NSLog(@"DisConnected: %@",self.VO.aName);
        [tcpSocket disconnect];
    }
}

// TCP socket已连接
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"socket已连接: %@",self.VO.aName);
}
// TCP socket已断开
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socket已断开: %@",self.VO.aName);
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

//打开投影机
-(void)openProject:(id)sender
{
    NSLog(@"OpenProject!");
    NSData *data = [@"%1POWR 1\r" dataUsingEncoding:NSUTF8StringEncoding];
    [tcpSocket writeData:data withTimeout:-1 tag:_tag1++];
    
}

//关闭投影机
-(void)closeProject:(id)sender
{
    NSLog(@"CloseProject!");
    NSData *data = [@"%1POWR 0\r" dataUsingEncoding:NSUTF8StringEncoding];
    [tcpSocket writeData:data withTimeout:-1 tag:_tag1++];
}


@end
