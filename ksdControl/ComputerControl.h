//
//  ComputerControl.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComputerControl : UICollectionViewCell


//文本允许动态改变标题
@property (strong, nonatomic) UILabel* label;

//允许打开电脑
@property (strong, nonatomic) UIButton* openBtn;

//允许关闭电脑
@property (strong, nonatomic) UIButton* closeBtn;

//打开电脑
-(void)openComputer:(id)sender;

//关闭电脑
-(void)closeComputer:(id)sende;
@end
