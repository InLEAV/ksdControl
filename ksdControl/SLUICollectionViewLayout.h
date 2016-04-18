//
//  UICollectionViewLayout.h
//  ksdControl
//
//  Created by CMQ on 15/6/24.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLUICollectionViewLayout;
@protocol SLUICollectionViewDelegateLayout <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
  widthForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SLUICollectionViewLayout : UICollectionViewLayout
@property (nonatomic, weak) id<SLUICollectionViewDelegateLayout> delegate;
//行数
@property (nonatomic, assign) NSUInteger rowCount;
//每一行的高度
@property (nonatomic, assign) CGFloat itemHeight;
//内容与边界距离
@property (nonatomic, assign) UIEdgeInsets sectionInset; @end
