//
//  GroupControl.h
//  ksdControl
//
//  Created by CMQ on 15/7/7.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupControl : UICollectionViewCell

//背景
@property (strong, nonatomic) UIImageView* backgroup;

// 动态改变标题
@property (strong, nonatomic) UILabel* label;

// 打开组合
@property (strong, nonatomic) UIButton* openBtn;

// 关闭组合
@property (strong, nonatomic) UIButton* closeBtn;

//打开组合
-(void)openGroup :(id)sender;

//关闭组合
-(void)closeGroup :(id)sende;

@end
