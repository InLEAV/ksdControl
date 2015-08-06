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

//打开组合
-(void)openGroup:(id)sender
{
    NSLog(@"OpenRelay!");
}

//关闭组合
-(void)closeGroup:(id)sender
{
    NSLog(@"CloseRelay!");
}


@end
