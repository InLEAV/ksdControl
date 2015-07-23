//
//  PlayerVideoControl.m
//  ksdControl
//
//  Created by CMQ on 15/5/20.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "PlayerVideoControl.h"

@implementation PlayerVideoControl

//初始单元格，添加控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.VO = [PlayerVO new];
    
    videoNum = 1;
    volumeNum = 80;
    
    if (self) {
        
        
        self.backgroup =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 488, 156)];
        [self.backgroup setImage:[UIImage imageNamed:@"playerBg.png"]];
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
        
        //这里创建一个圆角矩形的按钮，上一个视频
        self.preMovieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.preMovieBtn.frame = CGRectMake(35, 77, 70, 60);
        self.preMovieBtn.backgroundColor = [UIColor clearColor];
        [self.preMovieBtn setImage:[UIImage imageNamed:@"preMovie.png"] forState:UIControlStateNormal];
        [self.preMovieBtn setImage:[UIImage imageNamed:@"preMovie-highlight.png"] forState:UIControlStateHighlighted];
        [self.preMovieBtn addTarget:self action:@selector(preMovieBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.preMovieBtn];
        
        //这里创建一个圆角矩形的按钮，播放视频
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playBtn.frame = CGRectMake(105, 77, 70, 60);
        self.playBtn.backgroundColor = [UIColor clearColor];
        [self.playBtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"play-highlight.png"] forState:UIControlStateHighlighted];
        [self.playBtn addTarget:self action:@selector(playVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.playBtn];
        
        //这里创建一个圆角矩形的按钮，下一个视频
        self.nextMovieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextMovieBtn.frame = CGRectMake(175, 77, 70, 60);
        self.nextMovieBtn.backgroundColor = [UIColor clearColor];
        [self.nextMovieBtn setImage:[UIImage imageNamed:@"nextMovie.png"] forState:UIControlStateNormal];
        [self.nextMovieBtn setImage:[UIImage imageNamed:@"nextMovie-highlight.png"] forState:UIControlStateHighlighted];
        [self.nextMovieBtn addTarget:self action:@selector(nextMovieBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.nextMovieBtn];
        
        
        //这里创建一个圆角矩形的按钮，停止视频
        self.stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.stopBtn.frame = CGRectMake(245, 77, 70, 60);
        self.stopBtn.backgroundColor = [UIColor clearColor];
        [self.stopBtn setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        [self.stopBtn setImage:[UIImage imageNamed:@"stop-highlight.png"] forState:UIControlStateHighlighted];
        [self.stopBtn addTarget:self action:@selector(stopVideo:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.stopBtn];
        

        //这里创建一个圆角矩形的按钮，减小声量
        self.minusVolumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.minusVolumeBtn.frame = CGRectMake(315, 77, 70, 60);
        self.minusVolumeBtn.backgroundColor = [UIColor clearColor];
        [self.minusVolumeBtn setImage:[UIImage imageNamed:@"volumeMinus.png"] forState:UIControlStateNormal];
        [self.minusVolumeBtn setImage:[UIImage imageNamed:@"volumeMinus-highlight.png"] forState:UIControlStateHighlighted];
        [self.minusVolumeBtn addTarget:self action:@selector(minusVolumeBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.minusVolumeBtn];
        
        //这里创建一个圆角矩形的按钮，放大声量
        self.addVolumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addVolumeBtn.frame = CGRectMake(385, 77, 70, 60);
        self.addVolumeBtn.backgroundColor = [UIColor clearColor];
        [self.addVolumeBtn setImage:[UIImage imageNamed:@"volumeAdd.png"] forState:UIControlStateNormal];
        [self.addVolumeBtn setImage:[UIImage imageNamed:@"volumeAdd-highlight.png"] forState:UIControlStateHighlighted];
        [self.addVolumeBtn addTarget:self action:@selector(addVolumeBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addVolumeBtn];

        
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
    NSString * msg = [NSString stringWithFormat:@"%d&play&%d",self.VO.playerID,videoNum];
    [_delegate sendUDPPlayCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//暂停视频
-(void)pauseVideo :(id)sende
{
    NSString * msg = [NSString stringWithFormat:@"%d&pause&0",self.VO.playerID];
    [_delegate sendUDPPlayCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//停止视频
-(void)stopVideo :(id)sende
{
    NSString * msg = [NSString stringWithFormat:@"%d&stop&0",self.VO.playerID];
    [_delegate sendUDPPlayCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}


//播放上一个视频
-(void)preMovieBtn :(id)sende
{
    videoNum --;
    if (videoNum < 1) {
        videoNum = 1;
    }
    NSString * msg = [NSString stringWithFormat:@"%d&play&%d",self.VO.playerID,videoNum];
    [_delegate sendUDPPlayCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//播放下一个视频
-(void)nextMovieBtn :(id)sende
{
    videoNum ++;
    if (videoNum > self.VO.count) {
        videoNum = self.VO.count;
    }
    NSString * msg = [NSString stringWithFormat:@"%d&play&%d",self.VO.playerID,videoNum];
    [_delegate sendUDPPlayCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//声量放大
-(void)addVolumeBtn :(id)sende
{
    volumeNum = volumeNum + 10;
    if (volumeNum > 100) {
        volumeNum = 100;
    }
    NSString * msg = [NSString stringWithFormat:@"%d&volume&%d",self.VO.playerID,volumeNum];
    [_delegate sendUDPPlayCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//声量减小
- (void)minusVolumeBtn:(id)sender
{
    volumeNum = volumeNum - 10;
    if (volumeNum < 0) {
        volumeNum = 0;
    }
    NSString * msg = [NSString stringWithFormat:@"%d&volume&%d",self.VO.playerID,volumeNum];
    [_delegate sendUDPPlayCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}
@end
