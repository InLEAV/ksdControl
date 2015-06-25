//
//  ProjectControl.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProjectControl : UICollectionViewCell


//背景
@property (strong, nonatomic) UIImageView* backgroup;

//动态改变标题
@property (strong, nonatomic) UILabel* label;

//打开投影机
@property (strong, nonatomic) UIButton* openBtn;

//关闭投影机
@property (strong, nonatomic) UIButton* closeBtn;

//打开投影机
-(void)openProject:(id)sender;

//关闭投影机
-(void)closeProject:(id)sende;
@end
