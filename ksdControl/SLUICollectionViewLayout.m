//
//  UICollectionViewLayout.m
//  ksdControl
//
//  Created by CMQ on 15/6/24.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "SLUICollectionViewLayout.h"


@interface SLUICollectionViewLayout()
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, strong) NSMutableArray *RowWidths; // height for each column
@property (nonatomic, strong) NSMutableArray *itemAttributes; // attributes for each item
@end

@implementation SLUICollectionViewLayout

#pragma mark - Accessors
//设置行数
- (void)setRowCount:(NSUInteger)rowCount
{
    if (_rowCount != rowCount) {
        _rowCount = rowCount;
        [self invalidateLayout];
    }
}

//设置每项高度
- (void)setItemHeight:(CGFloat)itemHeight
{
    if (_itemHeight != itemHeight) {
        _itemHeight = itemHeight;
        [self invalidateLayout];
    }
}

//设置边界距离
- (void)setSectionInset:(UIEdgeInsets)sectionInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}

#pragma mark - Init
//初始化
- (void)commonInit
{
    _rowCount = 2;
    _itemHeight = 156.0f;
    _sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);//UIEdgeInsetsZero;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Life cycle
- (void)dealloc
{
    [_RowWidths removeAllObjects];
    _RowWidths = nil;
    
    [_itemAttributes removeAllObjects];
    _itemAttributes = nil;
}

#pragma mark - Methods to Override
- (void)prepareLayout
{
    [super prepareLayout];
    
    //获取项数
    _itemCount = [[self collectionView] numberOfItemsInSection:0];
    
    NSAssert(_rowCount > 1, @"columnCount for UICollectionViewLayout should be greater than 1.");
    //获取每行间距
    CGFloat height = self.collectionView.frame.size.height - _sectionInset.top - _sectionInset.bottom;
    _lineSpacing = floorf((height - _rowCount * _itemHeight) / (_rowCount - 1));
    
    _itemAttributes = [NSMutableArray arrayWithCapacity:_itemCount];
    _RowWidths = [NSMutableArray arrayWithCapacity:_rowCount];
    for (NSInteger idx = 0; idx < _rowCount; idx++) {
        [_RowWidths addObject:@(_sectionInset.left)];
    }
    
    // 每一项都会放到最短的的行中
    for (NSInteger idx = 0; idx < _itemCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        CGFloat itemWidth = [self.delegate collectionView:self.collectionView
                                                   layout:self
                                  widthForItemAtIndexPath:indexPath];
        NSUInteger rowIndex = [self shortestRowIndex];
        CGFloat xOffset = [(_RowWidths[rowIndex]) floatValue];
        CGFloat yOffset = _sectionInset.top + (_itemHeight + _lineSpacing) * rowIndex;
        
        UICollectionViewLayoutAttributes *attributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(xOffset, yOffset, itemWidth,self.itemHeight);
        [_itemAttributes addObject:attributes];
        NSInteger InteritemSpacing = 15;
        _RowWidths[rowIndex] = @(xOffset + itemWidth + InteritemSpacing);// + _lineSpacing
    }
}

//获取每页内容的总宽高
- (CGSize)collectionViewContentSize
{
    if (self.itemCount == 0) {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.frame.size;
    NSUInteger rowIndex = [self longestRowIndex];
    CGFloat width = [self.RowWidths[rowIndex] floatValue];
    contentSize.width = width - 15 + self.sectionInset.right;
    return contentSize;
}

//获取每项的矩形属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    return (self.itemAttributes)[path.item];
}

//返回在可见区域的view的layoutAttribute信息
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

#pragma mark - Private Methods
// 找出最短的那行
- (NSUInteger)shortestRowIndex
{
    __block NSUInteger index = 0;
    __block CGFloat shortestWidth = MAXFLOAT;
    
    [self.RowWidths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat width = [obj floatValue];
        if (width < shortestWidth) {
            shortestWidth = width;
            index = idx;
        }
    }];
    
    return index;
}

// 找出最长的那行
- (NSUInteger)longestRowIndex
{
    __block NSUInteger index = 0;
    __block CGFloat longestwidth = 0;
    
    [self.RowWidths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat width = [obj floatValue];
        if (width > longestwidth) {
            longestwidth = width;
            index = idx;
        }
    }];
    
    return index;
}

@end
