//
//  PlayerVideoControl.h
//  ksdControl
//
//  Created by CMQ on 15/5/20.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerVO.h"

@protocol playDelegate <NSObject>
- (void)sendUDPPlayCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host;
@end

@interface PlayerVideoControl  : UICollectionViewCell
{
    int videoNum,volumeNum;
}

//模型
@property(nonatomic, retain) PlayerVO * VO;

//代理
@property (nonatomic, retain) id <playDelegate> delegate;

//动态改变标题
@property (strong, nonatomic) UILabel* label;

//背景
@property (strong, nonatomic) UIImageView* backgroup;

//播放视频或
@property (strong, nonatomic) UIButton* playBtn;

//暂停视频
@property (strong, nonatomic) UIButton* pauseBtn;

//停止视频
@property (strong, nonatomic) UIButton* stopBtn;

//播放上一个视频
@property (strong, nonatomic) UIButton* preMovieBtn;

//视频快退
@property (strong, nonatomic) UIButton* nextMovieBtn;

//视频快进
@property (strong, nonatomic) UIButton* addVolumeBtn;

//视频快进
@property (strong, nonatomic) UIButton* minusVolumeBtn;


//播放视频
-(void)playVideo :(id)sender;

//暂停视频
-(void)pauseVideo :(id)sende;

//停止视频
-(void)stopVideo :(id)sende;

//播放上一个视频
-(void)preMovieBtn :(id)sende;

//播放下一个视频
-(void)nextMovieBtn :(id)sende;

//声量放大
-(void)addVolumeBtn :(id)sende;

//声量减小
- (void)minusVolumeBtn:(id)sender;


@end
