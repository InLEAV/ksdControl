//
//  RelayControl.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelayControl : UICollectionViewCell

// 动态改变标题
@property (strong, nonatomic) UILabel* label;

// 打开电路
@property (strong, nonatomic) UIButton* openBtn;

// 关闭电路
@property (strong, nonatomic) UIButton* closeBtn;

//打开电路
-(void)openRelay :(id)sender;

//关闭电路
-(void)closeRelay :(id)sende;
@end
