//
//  RelayControl.m
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "RelayControl.h"

@implementation RelayControl

//初始单元格，添加控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
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
        
        //这里创建一个圆角矩形的按钮，开电路按钮
        self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openBtn.frame = CGRectMake(30, 77, 70, 60);
        self.openBtn.backgroundColor = [UIColor clearColor];
        [self.openBtn setImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
        [self.openBtn setImage:[UIImage imageNamed:@"on-highlight.png"] forState:UIControlStateHighlighted];
        [self.openBtn addTarget:self action:@selector(openRelay:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.openBtn];
        
        //这里创建一个圆角矩形的按钮，关电路按钮
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtn.frame = CGRectMake(137, 77, 70, 60);
        self.closeBtn.backgroundColor = [UIColor clearColor];
        [self.closeBtn setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
        [self.closeBtn setImage:[UIImage imageNamed:@"off-highlight.png"] forState:UIControlStateHighlighted];
        [self.closeBtn addTarget:self action:@selector(closeRelay:)forControlEvents:UIControlEventTouchUpInside];
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

//打开电路
-(void)openRelay:(id)sender
{
    NSLog(@"OpenRelay!");
}

//关闭电路
-(void)closeRelay:(id)sender
{
    NSLog(@"CloseRelay!");
}


@end
