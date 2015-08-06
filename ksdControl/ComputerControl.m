//
//  ComputerControl.m
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ComputerControl.h"

@implementation ComputerControl

//初始单元格，添加控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.VO = [ComputerVO new];
    
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
        
        //这里创建一个圆角矩形的按钮，开电脑按钮
        self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openBtn.frame = CGRectMake(30, 70, 65, 65);
        self.openBtn.backgroundColor = [UIColor clearColor];
        [self.openBtn setImage:[UIImage imageNamed:@"on-normal.png"] forState:UIControlStateNormal];
        [self.openBtn setImage:[UIImage imageNamed:@"on-highlight.png"] forState:UIControlStateHighlighted];
        [self.openBtn addTarget:self action:@selector(openComputer:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.openBtn];
        
        //这里创建一个圆角矩形的按钮，关电脑按钮
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtn.frame = CGRectMake(130, 70, 65, 65);
        self.closeBtn.backgroundColor = [UIColor clearColor];
        [self.closeBtn setImage:[UIImage imageNamed:@"off-normal.png"] forState:UIControlStateNormal];
        [self.closeBtn setImage:[UIImage imageNamed:@"off-highlight.png"] forState:UIControlStateHighlighted];
        [self.closeBtn addTarget:self action:@selector(closeComputer:)forControlEvents:UIControlEventTouchUpInside];
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

-(void)updatePacket:(NSString *)macStr
{
    NSArray * macChilds = [macStr componentsSeparatedByString:@"-"];

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
    NSLog(@"计算完成");
    NSData *data = [NSData dataWithBytes:packet length:102];
    [_delegate sendUDPDataComputerCommand:data toPort:self.VO.port toHost:self.VO.ip];
    NSLog(@"ip:%@",self.VO.ip);
}


-(void)openComputer:(id)sender
{
    NSLog(@"OpenComputer!");
//    [self updatePacket:@"8C-DC-D4-36-C3-85"];
    [self updatePacket:self.VO.addressMac];
    
}

-(void)closeComputer:(id)sender
{
    NSLog(@"CloseComputer!");
    [_delegate sendUDPComputerCommand:@"computer&1&0" toPort:self.VO.port toHost:self.VO.ip];
}
@end
