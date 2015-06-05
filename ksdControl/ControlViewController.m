//
//  ControlViewController.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "ControlViewController.h"
#import "JsonControl.h"
#import "ComputerControl.h"
#import "ProjectControl.h"
#import "PlayerControl.h"
#import "RelayControl.h"
#import "AppDelegate.h"
#import "AreaVO.h"
#import "GroupVO.h"
#import "ComputerVO.h"
#import "RelayVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"

@interface ControlViewController ()

@end

@implementation ControlViewController

@synthesize grid,horizontalList;


// 定义保存所有展区信息的NSDictionary对象
NSDictionary* areaDict;

// 定义保存所有组合键值的NSArray对象
NSArray* areaKeys;

NSIndexPath *indexPathArea;

//全局代理
AppDelegate *appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 为UICollectionView设置dataSource和delegate对象
    self.grid.dataSource = self;
    self.horizontalList.dataSource = self;
    self.grid.delegate = self;
    self.horizontalList.delegate = self;
    
    
    //为该控件的UICollectionView注册单元格控件
    [self.grid registerClass:[ComputerControl class]
  forCellWithReuseIdentifier:@"computerCellId"];
    [self.grid registerClass:[ProjectControl class]
  forCellWithReuseIdentifier:@"projectCellId"];
    [self.grid registerClass:[PlayerControl class]
  forCellWithReuseIdentifier:@"playerCellId"];
    [self.grid registerClass:[RelayControl class]
  forCellWithReuseIdentifier:@"relayCellId"];
    
    // 创建UICollectionViewFlowLayout布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置单元格控件的大小
    flowLayout.itemSize = CGSizeMake(100, self.horizontalList.bounds.size.height);
    // 设置UICollectionView的滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0 ;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 为UICollectionView设置布局管理器具
    self.horizontalList.collectionViewLayout = flowLayout;
    
    
    // 创建自定义FKFlowLayout布局管理器对象
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    // 设置UICollectionView的滚动方向
    flowLayout2.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    //flowLayout2.minimumInteritemSpacing = 50;
    flowLayout2.minimumLineSpacing =50 ;
    flowLayout2.sectionInset = UIEdgeInsetsMake(10,30, 10, 30);
    self.grid.collectionViewLayout = flowLayout2;
    
    //初始展区indexPathArea
    indexPathArea = [NSIndexPath indexPathForRow:0 inSection:1];
    
    //获取设置全局变量
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    //设置导航条的标题
    if(appDelegate.areaArray.count > 0)
    {
        NSString *name = ((AreaVO*)appDelegate.areaArray[0]).aName;
        self.navigationItem.title = name;
    }
    else
    {
        [appDelegate getElements];
    }
}

//获取每个展区元素
-(NSMutableArray*)getElements:(int)areaIndex
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i =0; i < ((AreaVO*)appDelegate.areaArray[areaIndex]).groups.count; i++)
    {
        
        if ([((AreaVO*)appDelegate.areaArray[areaIndex]).groups[i] isKindOfClass:[GroupVO class]])
        {
            for (int j =0; j < ((GroupVO*)(((AreaVO*)appDelegate.areaArray[areaIndex]).groups[i])).elements.count; j++)
            {
                [array addObject:((GroupVO*)(((AreaVO*)appDelegate.areaArray[areaIndex]).groups[i])).elements[j]];
            }
        }
        else
        {
            [array addObject:((AreaVO*)appDelegate.areaArray[areaIndex]).groups[i]];
        }
    }
    
    return array;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 该方法的返回值控制该UICollectionView包含多少个分区。
- (NSInteger) numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

// 该方法的返回值控制该UICollectionView指定分区包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    int count = 0;
    if((long)collectionView.tag == 0)
    {
        count = appDelegate.areaArray.count;
        
    }else if((long)collectionView.tag  == 1)
    {
        //返回每个展区控件单元格的个数
        NSMutableArray *elementArray = [self getElements:indexPathArea.row];
        count = elementArray.count;
        
    }
    
    return count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if(collectionView.tag == 0)
    {
        size = CGSizeMake(100, 100);
    }
    else
    {
        NSMutableArray *eleArray =[self getElements:indexPathArea.row];
        if(indexPath.row < eleArray.count)
        {
            if([eleArray[indexPath.row] isKindOfClass:[PlayerVO class]])
            {
                size = CGSizeMake(450, 150);
                
            }
            else
            {
                size = CGSizeMake(200, 150);
            }
        }
    }
    return size;
}

// 该方法返回值决定各单元格的控件。
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //展区列表cell
    if(collectionView.tag == 0)
    {
        // 为表格行定义一个静态字符串作为标示符
        static NSString* cellId = @"Cell";
        // 从可重用单元格队列中取出一个单元格
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        
        // 设置圆角
        cell.layer.cornerRadius = 8;
        cell.layer.masksToBounds = YES;
        // 获取正在处理的单元格所在分区号、行号
        NSInteger rowNo = indexPath.row;
        
        NSString* areaName = ((AreaVO*)appDelegate.areaArray[rowNo]).aName;
        
        // 通过tag属性获取单元格内的UIImageView控件
        UIImageView* iv = (UIImageView*)[cell viewWithTag:1];
        iv.backgroundColor = [UIColor redColor];
        UILabel* label = (UILabel*)[cell viewWithTag:2];
        // 为单元格内的UILabel控件设置文本
        label.text = areaName;
        
        return cell;
    }
    
    //展区网格控件cell
    if(collectionView.tag == 1)
    {
        NSMutableArray *eleArray =[self getElements:indexPathArea.row];
         NSInteger rowNo = indexPath.row;
        
        if (rowNo < eleArray.count)
        {
            if([eleArray[rowNo] isKindOfClass:[ComputerVO class]])
            {
                //生产电脑机控制单元格
                ComputerControl *cell = [collectionView
                                         dequeueReusableCellWithReuseIdentifier:@"computerCellId"
                                         forIndexPath:indexPath];
                cell.label.text = ((ComputerVO*)eleArray[rowNo]).aName;
                
                return cell;
                
            }
            else if([eleArray[rowNo] isKindOfClass:[ProjectVO class]])
            {
                //生产投影机控制单元格
                ProjectControl *cell = [collectionView
                                        dequeueReusableCellWithReuseIdentifier:@"projectCellId"
                                        forIndexPath:indexPath];
                cell.label.text = ((ProjectVO*)eleArray[rowNo]).aName;
                
                return cell;
                
            }
            else if ([eleArray[rowNo] isKindOfClass:[RelayVO class]])
            {
                //生产电路控制单元格
                RelayControl *cell = [collectionView
                                      dequeueReusableCellWithReuseIdentifier:@"relayCellId"
                                      forIndexPath:indexPath];
                cell.label.text = ((RelayVO*)eleArray[rowNo]).aName;
                
                
                return cell;
                
            }
            else if([eleArray[rowNo] isKindOfClass:[PlayerVO class]])
            {
                //生产播放控制单元格
                PlayerControl *cell = [collectionView
                                       dequeueReusableCellWithReuseIdentifier:@"playerCellId"
                                       forIndexPath:indexPath];
                cell.label.text = ((PlayerVO*)eleArray[rowNo]).aName;
                
                
                return cell;
                
            }
            

        }
    }
    
    return nil;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if(collectionView.tag == 0)
    {
        //保存当前选中的展区IndexPath
        indexPathArea = indexPath;
        
        
        //设置导航条的标题
        if(appDelegate.areaArray.count > 0)
        {
            NSString *name = ((AreaVO*)appDelegate.areaArray[indexPathArea.row]).aName;
            self.navigationItem.title = name;
        }
        
        
        //更新展区网格单元格数据
        [self.grid reloadData];
    }
    
}

@end
