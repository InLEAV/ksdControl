//
//  ProjectControl.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProjectVO.h"
#import "libs/GCDAsyncSocket.h"

@interface ProjectControl : UICollectionViewCell
{
    BOOL isShow;
    GCDAsyncSocket *tcpSocket;
    NSString * powerOn, *powerOff, *powerQuery;
    int _tag1;
}

@property(nonatomic, retain) ProjectVO * VO;


//背景
@property (strong, nonatomic) UIImageView* backgroup;

//动态改变标题
@property (strong, nonatomic) UILabel* label;

//打开投影机
@property (strong, nonatomic) UIButton* openBtn;

//关闭投影机
@property (strong, nonatomic) UIButton* closeBtn;

//是否显示了此组件
-(void)setIsShow:(BOOL)isShow2;

//打开投影机
-(void)openProject:(id)sender;

//关闭投影机
-(void)closeProject:(id)sende;
@end
