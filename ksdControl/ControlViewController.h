//
//  ControlViewController.h
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLUICollectionViewLayout.h"
#import "Sever.h"
#import "ComputerControl.h"
#import "RelayControl.h"
#import "PlayerImageControl.h"
#import "PlayerVideoControl.h"

@interface ControlViewController : UIViewController<UICollectionViewDataSource,
UICollectionViewDelegate,SLUICollectionViewDelegateLayout,computerDelegate,relayDelegate,playDelegate>
{
    Sever * sever;
}

//单元表格列表，显示展区的元素组件
@property (strong, nonatomic) IBOutlet UICollectionView *grid;

//水平的展区列表
@property (strong, nonatomic) IBOutlet UICollectionView *horizontalList;

//获取每个展区元素
-(NSMutableArray*)getElements:(int)areaIndex;

//展区标题
@property (strong, nonatomic) IBOutlet UILabel *zqTitle;

//控件数组
@property (nonatomic, strong) NSMutableArray *elementArray;

@end
