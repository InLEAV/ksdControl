//
//  PlayerControl.h
//  ksdControl
//
//  Created by CMQ on 15/5/20.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerControl  : UICollectionViewCell


//动态改变标题
@property (strong, nonatomic) UILabel* label;

//播放视频或
@property (strong, nonatomic) UIButton* playBtn;

//暂停视频
@property (strong, nonatomic) UIButton* pauseBtn;

//停止视频
@property (strong, nonatomic) UIButton* stopBtn;

//重新开始播放视频
@property (strong, nonatomic) UIButton* replayBtn;


//视频快退
@property (strong, nonatomic) UIButton* fastBackBtn;

//视频快进
@property (strong, nonatomic) UIButton* fastForwardBtn;


//控制声音播放
@property (strong, nonatomic) UISlider* audioSlider;

//播放视频
-(void)playVideo :(id)sender;

//暂停视频
-(void)pauseVideo :(id)sende;

//停止视频
-(void)stopVideo :(id)sende;

//重播视频
-(void)replayVideo :(id)sende;

//视频快进
-(void)fastForwardVideo :(id)sende;

//视频快退
-(void)fastBackVideo :(id)sende;

//拖拽滑动条
- (void)sliderValueChanged:(id)sender;

//放开滑动条
- (void)sliderDragUp:(id)sender;

@end
