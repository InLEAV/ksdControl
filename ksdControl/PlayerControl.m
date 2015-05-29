//
//  PlayerControl.m
//  ksdControl
//
//  Created by CMQ on 15/5/20.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "PlayerControl.h"

@implementation PlayerControl

//初始单元格，添加控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建一个UILabel控件
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0,frame.size.width, 50)];
        self.label.backgroundColor = [UIColor clearColor];
        // 设置该控件的自动缩放属性
        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight|
        UIViewAutoresizingFlexibleWidth;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:50.0];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
        
        //这里创建一个圆角矩形的按钮，播放视频
        self.playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.playBtn.frame = CGRectMake(20, 100, 60, 40);
        self.playBtn.backgroundColor = [UIColor grayColor];
        self.playBtn.tintColor =[UIColor whiteColor];
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [self.playBtn addTarget:self action:@selector(playVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.playBtn];
        
        //这里创建一个圆角矩形的按钮，暂停视频
        self.pauseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.pauseBtn.frame = CGRectMake(100, 100, 60, 40);
        self.pauseBtn.backgroundColor = [UIColor grayColor];
        self.pauseBtn.tintColor =[UIColor whiteColor];
        [self.pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.pauseBtn addTarget:self action:@selector(pauseVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.pauseBtn];
        
        //这里创建一个圆角矩形的按钮，停止视频
        self.stopBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.stopBtn.frame = CGRectMake(180, 100, 60, 40);
        self.stopBtn.backgroundColor = [UIColor grayColor];
        self.stopBtn.tintColor =[UIColor whiteColor];
        [self.stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        [self.stopBtn addTarget:self action:@selector(stopVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.stopBtn];
        
        //这里创建一个圆角矩形的按钮，重播视频
        self.replayBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.replayBtn.frame = CGRectMake(260, 100, 60, 40);
        self.replayBtn.backgroundColor = [UIColor grayColor];
        self.replayBtn.tintColor =[UIColor whiteColor];
        [self.replayBtn setTitle:@"重播" forState:UIControlStateNormal];
        [self.replayBtn addTarget:self action:@selector(replayVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.replayBtn];
        
        //这里创建一个圆角矩形的按钮，视频快退
        self.fastBackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.fastBackBtn.frame = CGRectMake(340, 100, 60, 40);
        self.fastBackBtn.backgroundColor = [UIColor grayColor];
        self.fastBackBtn.tintColor =[UIColor whiteColor];
        [self.fastBackBtn setTitle:@"快退" forState:UIControlStateNormal];
        [self.fastBackBtn addTarget:self action:@selector(fastBackVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.fastBackBtn];

        //这里创建一个圆角矩形的按钮，视频快进
        self.fastForwardBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.fastForwardBtn.frame = CGRectMake(420, 100, 60, 40);
        self.fastForwardBtn.backgroundColor = [UIColor grayColor];
        self.fastForwardBtn.tintColor =[UIColor whiteColor];
        [self.fastForwardBtn setTitle:@"快进" forState:UIControlStateNormal];
        [self.fastForwardBtn addTarget:self action:@selector(fastForwardVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.fastForwardBtn];
        
        //这里创建一个滑动条，控制声音大小
        self.audioSlider = [[UISlider alloc]initWithFrame:CGRectMake(500, 110,80 , 20)];
        self.audioSlider.value = 0.5;
        self.audioSlider.backgroundColor = [UIColor clearColor];
        //滑块拖动时的事件
        [self.audioSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        //滑动拖动后的事件
        [self.audioSlider addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.audioSlider];
        
        // 设置边框
        self.contentView.layer.borderWidth = 2.0f;
        self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        
        // 设置圆角
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}

//播放视频
-(void)playVideo :(id)sender
{
    
}

//暂停视频
-(void)pauseVideo :(id)sende
{
    
}

//停止视频
-(void)stopVideo :(id)sende
{
    
}

//重播视频
-(void)replayVideo :(id)sende
{
    
}

//视频快进
-(void)fastForwardVideo :(id)sende
{
    
}

//视频快退
-(void)fastBackVideo :(id)sende
{
    
}

//拖拽滑动条
- (void)sliderValueChanged:(id)sender
{
    
}

//放开滑动条
- (void)sliderDragUp:(id)sender
{
    
}
@end
