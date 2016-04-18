//
//  GroupControl.m
//  ksdControl
//
//  Created by CMQ on 15/7/7.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "GroupControl.h"

@implementation GroupControl

//初始单元格，添加控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.VO = [GroupVO new];

    
    if (self)
    {
        self.backgroup =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 226, 148)];
        [self.backgroup setImage:[UIImage imageNamed:@"switchBg.png"]];
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
        
        //这里创建一个圆角矩形的按钮，开组合按钮
        self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openBtn.frame = CGRectMake(30, 70, 65, 65);
        self.openBtn.backgroundColor = [UIColor clearColor];
        [self.openBtn setImage:[UIImage imageNamed:@"on-normal.png"] forState:UIControlStateNormal];
        [self.openBtn setImage:[UIImage imageNamed:@"on-highlight.png"] forState:UIControlStateHighlighted];
        [self.openBtn addTarget:self action:@selector(openGroup:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.openBtn];
        
        //这里创建一个圆角矩形的按钮，关组合按钮
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtn.frame = CGRectMake(130, 70, 65, 65);
        self.closeBtn.backgroundColor = [UIColor clearColor];
        [self.closeBtn setImage:[UIImage imageNamed:@"off-normal.png"] forState:UIControlStateNormal];
        [self.closeBtn setImage:[UIImage imageNamed:@"off-highlight.png"] forState:UIControlStateHighlighted];
        [self.closeBtn addTarget:self action:@selector(closeGroup:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.closeBtn];
        
        // 设置边框
        self.contentView.layer.borderWidth = 2.0f;
        self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        
        // 设置圆角
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
        
        
    }
    return self;
}

-(void)computerOn:(ComputerVO *)comVO
{
    NSArray * macChilds = [comVO.addressMac componentsSeparatedByString:@"-"];
    
    unsigned char mac[6];
    unsigned char packet[102];
    
    for (int i = 0; i < macChilds.count; i++) {
        
        NSString * aa = macChilds[i];
        unsigned char bb = strtoul([aa UTF8String], 0, 16);
        mac[i] = bb;
    }
    for (int j = 0; j < 6; j++) {
        packet[j] = 0xff;
    }
    for (int k = 1; k < 17; k++) {
        for (int u = 0; u < 6; u++) {
            packet[k*6 + u] = mac[u];
        }
    }
    NSData *data = [NSData dataWithBytes:packet length:102];
    [_delegate sendUDPDataGroupCommand:data toPort:comVO.port toHost:@"255.255.255.255"];
}

//打开组合
-(void)openGroup:(id)sender
{
    NSLog(@"OpenALL!");
    
    for (int i = 0; i < self.VO.elements.count; i++)
    {
        if ([self.VO.elements[i] isKindOfClass:[ComputerVO class]]) {
            [self computerOn:(ComputerVO *)self.VO.elements[i]];
            NSLog(@"group for Computer");
        }
        if ([self.VO.elements[i] isKindOfClass:[ProjectVO class]])
        {
            ProjectVO * proVO =(ProjectVO *)self.VO.elements[i];
            [proVO PowerOn];
           NSLog(@"group for project");
        }
        if ([self.VO.elements[i] isKindOfClass:[RelayVO class]])
        {
            RelayVO * relVO =(RelayVO *)self.VO.elements[i];
            [self setRelayStatus:relVO.circuit toStatus:1 toRelayVO:relVO];
            NSLog(@"group for relay");
        }
        [NSThread sleepForTimeInterval:0.1];
    }
    
}

//关闭组合
-(void)closeGroup:(id)sender
{
    NSLog(@"CloseALL!");
    for (int i = 0; i < self.VO.elements.count; i++)
    {
        if ([self.VO.elements[i] isKindOfClass:[ComputerVO class]]) {
            ComputerVO * comVO =(ComputerVO *)self.VO.elements[i];
            [_delegate sendUDPGroupCommand:@"computer&1&0" toPort:comVO.port toHost:comVO.ip];
            NSLog(@"group for Computer");
        }
        if ([self.VO.elements[i] isKindOfClass:[ProjectVO class]])
        {
            NSLog(@"group for project");
            ProjectVO * proVO =(ProjectVO *)self.VO.elements[i];
            [proVO PowerOff];
        }
        if ([self.VO.elements[i] isKindOfClass:[RelayVO class]])
        {
            RelayVO * relVO =(RelayVO *)self.VO.elements[i];
            [self setRelayStatus:relVO.circuit toStatus:0 toRelayVO:relVO];
            NSLog(@"group for relay");
        }
        [NSThread sleepForTimeInterval:0.1];
    }
    
}

-(void)setIsShow:(BOOL)isShow2
{
    isShow = isShow2;
    
    for (int i = 0; i < self.VO.elements.count; i++)
    {
        if ([self.VO.elements[i] isKindOfClass:[ProjectVO class]])
        {
            ProjectVO * proVO =(ProjectVO *)self.VO.elements[i];
            if (isShow == YES) {
                [proVO setIsShow:YES];
            }
            else
            {
                [proVO setIsShow:NO];
            }
            
        }
    }
    
}

-(void)setRelayStatus:(int)index toStatus:(int)status toRelayVO:(RelayVO*) relayVO
{
    unsigned char packet[8];
    unsigned char _status;
    if (status == 0) {
        _status = 0x11;
    }
    else
    {
        _status = 0x12;
    }
    packet[0] = 0x55;
    packet[1] = 0x01;
    packet[2] = _status;
    packet[3] = 0;
    packet[4] = 0;
    packet[5] = index >> 8;
    packet[6] = index;
    
    int sum = 0;
    for (int i = 0; i <= 6; i++) {
        sum = sum + packet[i];
    }
    packet[7] = (sum % 256);
    
    NSData *data = [NSData dataWithBytes:packet length:sizeof(packet)];
    [_delegate sendUDPDataGroupCommand:data toPort:relayVO.port toHost:relayVO.ip];
}


@end
