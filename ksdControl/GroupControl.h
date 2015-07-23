//
//  GroupControl.h
//  ksdControl
//
//  Created by CMQ on 15/7/7.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupVO.h"
#import "ElementVO.h"
#import "ComputerVO.h"
#import "RelayVO.h"
#import "ProjectVO.h"
#import "libs/GCDAsyncSocket.h"

@protocol groupDelegate <NSObject>
- (void)sendUDPGroupCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host;
- (void)sendUDPDataGroupCommand:(NSData *)command toPort:(NSInteger)port toHost:(NSString *)host;
@end

@interface GroupControl : UICollectionViewCell
{
    BOOL isShow;
}


//模型
@property(nonatomic, retain) GroupVO * VO;

//代理
@property (nonatomic, retain) id <groupDelegate> delegate;

//背景
@property (strong, nonatomic) UIImageView* backgroup;

// 动态改变标题
@property (strong, nonatomic) UILabel* label;

// 打开组合
@property (strong, nonatomic) UIButton* openBtn;

// 关闭组合
@property (strong, nonatomic) UIButton* closeBtn;

//是否显示了此组件
-(void)setIsShow:(BOOL)isShow2;

//打开组合
-(void)openGroup :(id)sender;

//关闭组合
-(void)closeGroup :(id)sende;

@end
