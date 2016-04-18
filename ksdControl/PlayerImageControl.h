//
//  PlayerImageControl.h
//  ksdControl
//
//  Created by CMQ on 15/7/15.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerVO.h"

@protocol playimageDelegate <NSObject>
- (void)sendUDPPlayImageCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host;
@end
@interface PlayerImageControl : UICollectionViewCell
{
    int imageNum;
}

//模型
@property(nonatomic, retain) PlayerVO * VO;

//代理
@property (nonatomic, retain) id <playimageDelegate> delegate;

//动态改变标题
@property (strong, nonatomic) UILabel* label;

//背景
@property (strong, nonatomic) UIImageView* backgroup;

//播放图片
@property (strong, nonatomic) UIButton* playBtn;


//停止播放图片
@property (strong, nonatomic) UIButton* stopBtn;

//播放上一张图片
@property (strong, nonatomic) UIButton* preImageBtn;

//播放下一张图片
@property (strong, nonatomic) UIButton* nextImageBtn;


//播放图片
-(void)playImage :(id)sender;

//停止播放图片
-(void)stopImage :(id)sende;

//播放上一张图片
-(void)preImageBtn :(id)sende;

//播放下一张图片
-(void)nextImageBtn :(id)sende;
@end
