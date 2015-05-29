//
//  ControlViewController.h
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlViewController : UIViewController<UICollectionViewDataSource,
UICollectionViewDelegate>

//单元表格列表，显示展区的元素组件
@property (strong, nonatomic) IBOutlet UICollectionView *grid;

//水平的展区列表
@property (strong, nonatomic) IBOutlet UICollectionView *horizontalList;

- (NSMutableDictionary*)getElements:(int)areaIndex;
@end
