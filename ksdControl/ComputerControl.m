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
    
    if (self)
    {
        // 创建一个UILabel控件
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0,frame.size.width, 35)];
        self.label.backgroundColor = [UIColor clearColor];
        // 设置该控件的自动缩放属性
        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight|
        UIViewAutoresizingFlexibleWidth;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:35];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
        
        //这里创建一个圆角矩形的按钮，开电脑按钮
        self.openBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.openBtn.frame = CGRectMake(20, 50, 70, 40);
        self.openBtn.backgroundColor = [UIColor grayColor];
        self.openBtn.tintColor =[UIColor whiteColor];
        [self.openBtn setTitle:@"开" forState:UIControlStateNormal];
        [self.openBtn addTarget:self action:@selector(openComputer:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.openBtn];
        
        //这里创建一个圆角矩形的按钮，关电脑按钮
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.closeBtn.frame = CGRectMake(120, 50, 70, 40);
        self.closeBtn.backgroundColor = [UIColor grayColor];
        self.closeBtn.tintColor =[UIColor whiteColor];
        [self.closeBtn setTitle:@"关" forState:UIControlStateNormal];
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

-(void)openComputer:(id)sender
{
    NSLog(@"OpenComputer!");
}

-(void)closeComputer:(id)sender
{
    NSLog(@"CloseComputer!");
}
@end
