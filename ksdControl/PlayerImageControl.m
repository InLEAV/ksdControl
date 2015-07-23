//
//  PlayerImageControl.m
//  ksdControl
//
//  Created by CMQ on 15/7/15.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PlayerImageControl.h"

@implementation PlayerImageControl



//初始单元格，添加控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.VO = [PlayerVO new];
    imageNum = 1;
    
    if (self) {
        
        self.backgroup =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 237, 156)];
        [self.backgroup setImage:[UIImage imageNamed:@"imagePlayerBg.png"]];
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
        
        //这里创建一个圆角矩形的按钮，上一张图片
        self.preImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.preImageBtn.frame = CGRectMake(20, 90, 50, 43);
        self.preImageBtn.backgroundColor = [UIColor clearColor];
        [self.preImageBtn setImage:[UIImage imageNamed:@"preImage.png"] forState:UIControlStateNormal];
        [self.preImageBtn setImage:[UIImage imageNamed:@"preImage-highlight.png"] forState:UIControlStateHighlighted];
        [self.preImageBtn addTarget:self action:@selector(preImageBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.preImageBtn];
        
        //这里创建一个圆角矩形的按钮，播放图片
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playBtn.frame = CGRectMake(70, 90, 50, 43);
        self.playBtn.backgroundColor = [UIColor clearColor];
        [self.playBtn setImage:[UIImage imageNamed:@"imagePlay.png"] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"imagePlay-highlight.png"] forState:UIControlStateHighlighted];
        [self.playBtn addTarget:self action:@selector(playImage:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.playBtn];
        
        //这里创建一个圆角矩形的按钮，下一张图片
        self.nextImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextImageBtn.frame = CGRectMake(120, 90, 50, 43);
        self.nextImageBtn.backgroundColor = [UIColor clearColor];
        [self.nextImageBtn setImage:[UIImage imageNamed:@"nextImage.png"] forState:UIControlStateNormal];
        [self.nextImageBtn setImage:[UIImage imageNamed:@"nextImage-highlight.png"] forState:UIControlStateHighlighted];
        [self.nextImageBtn addTarget:self action:@selector(nextImageBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.nextImageBtn];
        
        
        //这里创建一个圆角矩形的按钮，停止播放图片
        self.stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.stopBtn.frame = CGRectMake(170, 90, 50, 43);
        self.stopBtn.backgroundColor = [UIColor clearColor];
        [self.stopBtn setImage:[UIImage imageNamed:@"imageStop.png"] forState:UIControlStateNormal];
        [self.stopBtn setImage:[UIImage imageNamed:@"imageStop-highlight.png.png"] forState:UIControlStateHighlighted];
        [self.stopBtn addTarget:self action:@selector(stopImage:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.stopBtn];
        
        // 设置边框
        self.contentView.layer.borderWidth = 2.0f;
        self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        
        // 设置圆角
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}


//播放图片
-(void)playImage :(id)sender
{
    NSString * msg = [NSString stringWithFormat:@"%d&image&0&%d.jpg",self.VO.playerID,imageNum];
    [_delegate sendUDPPlayImageCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//停止播放图片
-(void)stopImage :(id)sende
{
    NSString * msg = [NSString stringWithFormat:@"%d&stop&0",self.VO.playerID];
    [_delegate sendUDPPlayImageCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//播放上一张图片
-(void)preImageBtn :(id)sende
{
    if (imageNum < 1) {
        imageNum = 1;
    }
    NSString * msg = [NSString stringWithFormat:@"%d&image&0&%d.jpg",self.VO.playerID,imageNum];
    [_delegate sendUDPPlayImageCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}

//播放下一张图片
-(void)nextImageBtn :(id)sende
{
    if (imageNum > self.VO.count) {
        imageNum = self.VO.count;
    }
    NSString * msg = [NSString stringWithFormat:@"%d&image&0&%d.jpg",self.VO.playerID,imageNum];
    [_delegate sendUDPPlayImageCommand:msg toPort:self.VO.port toHost:self.VO.ip];
}



@end
