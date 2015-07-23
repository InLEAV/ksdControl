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
#import "PlayerVideoControl.h"
#import "RelayControl.h"
#import "AppDelegate.h"
#import "AreaVO.h"
#import "GroupVO.h"
#import "ComputerVO.h"
#import "RelayVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"
#import "GroupControl.h"

#define CELL_Height 156

@interface ControlViewController ()
@end

@implementation ControlViewController

@synthesize grid,horizontalList,zqTitle,elementArray;


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
    
    sever = [[Sever alloc] init];
    [sever initSever:8873];
    
    SLUICollectionViewLayout *layout = [[SLUICollectionViewLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(40, 15, 40, 15);
    layout.delegate = self;
    self.grid.collectionViewLayout = layout;
    self.grid.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // 为UICollectionView设置dataSource和delegate对象
    self.grid.dataSource = self;
    self.grid.delegate = self;
    
    //为该控件的UICollectionView注册单元格控件
    [self.grid registerClass:[ComputerControl class] forCellWithReuseIdentifier:@"computerCellId"];
    [self.grid registerClass:[ProjectControl class] forCellWithReuseIdentifier:@"projectCellId"];
    [self.grid registerClass:[PlayerVideoControl class] forCellWithReuseIdentifier:@"playerVideoCellId"];
    [self.grid registerClass:[PlayerImageControl class] forCellWithReuseIdentifier:@"playerImageCellId"];
    [self.grid registerClass:[RelayControl class] forCellWithReuseIdentifier:@"relayCellId"];
    [self.grid registerClass:[GroupControl class] forCellWithReuseIdentifier:@"groupCellId"];
    
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
    // 为UICollectionView设置dataSource和delegate对象
    self.horizontalList.dataSource = self;
    self.horizontalList.delegate = self;
    
    //初始展区indexPathArea
    indexPathArea = [NSIndexPath indexPathForRow:0 inSection:0];
    
    //获取设置全局变量
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate getElements];
    
    //设置导航条的标题
    if(appDelegate.areaArray.count > 0)
    {
        NSString *name = ((AreaVO*)appDelegate.areaArray[0]).aName;
        zqTitle.text = name;
        elementArray = [self getElements:(int)indexPathArea.row];
    }

    [self updateLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


//当切换到当前视图是更新元素列表
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(appDelegate.areaArray.count > 0)
    {
        [appDelegate getElements];
        elementArray = [self getElements:(int)indexPathArea.row];
        [self updateLayout];
        
        //[self collectionView:self.horizontalList didSelectItemAtIndexPath:indexPathArea];
    }
}

//获取每个展区元素
-(NSMutableArray*)getElements:(int)areaIndex
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i =0; i < ((AreaVO*)appDelegate.areaArray[areaIndex]).groups.count; i++)
    {
            if ([((AreaVO*)appDelegate.areaArray[areaIndex]).groups[i] isKindOfClass:[PlayerVO class]])
            {
                [array insertObject:((AreaVO*)appDelegate.areaArray[areaIndex]).groups[i] atIndex:0];
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

//当旋转完成时更新布局
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self updateLayout];
    [self.grid reloadData];
}

//当设备旋转时自动更新布局
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
    [self updateLayout];
}

//更新布局，设定横屏竖屏的行数
- (void)updateLayout
{
    SLUICollectionViewLayout *layout = (SLUICollectionViewLayout *)self.grid.collectionViewLayout;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
    {
        
        layout.rowCount =  3;
    }
    else
    {
        layout.rowCount = self.grid.bounds.size.height / CELL_Height;
    }
    
    layout.itemHeight = CELL_Height;
    
}

#pragma mark - UICollectionViewDataSource
// 该方法的返回值控制该UICollectionView指定分区包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if((long)collectionView.tag == 0)
    {
        count = (int)appDelegate.areaArray.count;
    }
    
    if((long)collectionView.tag  == 1)
    {
        count = (int)elementArray.count;
    }
    
    return count;
}

// 该方法的返回值控制该UICollectionView包含多少个分区。
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

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
        
        
        if( indexPathArea != indexPath)
        {
            UIImageView* iv = (UIImageView*)[cell viewWithTag:1];
            [iv setImage:[UIImage imageNamed:@"zq.png"]];
        }
        else
        {
            UIImageView* iv = (UIImageView*)[cell viewWithTag:1];
            [iv setImage:[UIImage imageNamed:@"zq-highlight.png"]];
        }
        UILabel* label = (UILabel*)[cell viewWithTag:2];
        label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
        // 为单元格内的UILabel控件设置文本
        label.text = areaName;
        
        return cell;
    }
    
    //展区网格控件cell
    if(collectionView.tag == 1)
    {
        // NSMutableArray *eleArray =[self getElements:(int)indexPathArea.row];
        NSInteger rowNo = indexPath.row;
        
        if (rowNo < elementArray.count)
        {
            if([elementArray[rowNo] isKindOfClass:[ComputerVO class]])
            {
                //生产电脑机控制单元格
                ComputerControl *cell = [collectionView
                                         dequeueReusableCellWithReuseIdentifier:@"computerCellId"
                                         forIndexPath:indexPath];
                cell.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
                cell.label.text = ((ComputerVO*)elementArray[rowNo]).aName;
                cell.VO = ((ComputerVO*)elementArray[rowNo]);
                cell.delegate = self;
                return cell;
            }
            else if([elementArray[rowNo] isKindOfClass:[ProjectVO class]])
            {
                //生产投影机控制单元格
                ProjectControl *cell = [collectionView
                                        dequeueReusableCellWithReuseIdentifier:@"projectCellId"
                                        forIndexPath:indexPath];
                cell.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
                cell.label.text = ((ProjectVO*)elementArray[rowNo]).aName;
                cell.VO = ((ProjectVO*)elementArray[rowNo]);
                [cell setIsShow:YES];
                
                return cell;
            }
            else if ([elementArray[rowNo] isKindOfClass:[RelayVO class]])
            {
                //生产电路控制单元格
                RelayControl *cell = [collectionView
                                      dequeueReusableCellWithReuseIdentifier:@"relayCellId"
                                      forIndexPath:indexPath];
                cell.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
                cell.label.text = ((RelayVO*)elementArray[rowNo]).aName;
                cell.VO = ((RelayVO*)elementArray[rowNo]);
                cell.delegate = self;
                return cell;
                
            }
            else if([elementArray[rowNo] isKindOfClass:[PlayerVO class]])
            {
                
                PlayerVO *player =((PlayerVO*)elementArray[rowNo]);
                
                if(!player.isPic)
                {
                    //生产播放控制单元格
                    PlayerVideoControl *cell = [collectionView
                                                dequeueReusableCellWithReuseIdentifier:@"playerVideoCellId"
                                                forIndexPath:indexPath];
                    cell.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
                    cell.label.text = player.aName;
                    cell.VO = player;
                    cell.delegate = self;
                    return cell;

                }
                else
                {
                    //生产播放控制单元格
                    PlayerImageControl *cell = [collectionView
                                                dequeueReusableCellWithReuseIdentifier:@"playerImageCellId"
                                                forIndexPath:indexPath];
                    cell.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
                    cell.label.text = player.aName;
                    cell.VO = player;
                    cell.delegate = self;
                    return cell;

                }
                
            }
            else if([elementArray[rowNo] isKindOfClass:[GroupVO class]])
            {
                GroupVO * group = ((GroupVO *) elementArray[rowNo]);
                
                //生产播放控制单元格
                GroupControl *cell = [collectionView
                                       dequeueReusableCellWithReuseIdentifier:@"groupCellId"
                                       forIndexPath:indexPath];
                cell.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
                cell.label.text = ((GroupVO*)elementArray[rowNo]).aName;
                
                cell.VO = group;
                cell.delegate = self;
                [cell setIsShow:YES];
                return cell;
                
            }

        }
    }
    
    return nil;
}

//下菜单单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if(collectionView.tag == 0)
    {
        size = CGSizeMake(256, 100);
    }
    
    return size;

}

#pragma mark - UICollectionViewWaterfallLayoutDelegate
//返回控件的宽度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(SLUICollectionViewLayout *)collectionViewLayout
  widthForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger width = 0;
    if(collectionView.tag == 1)
    {
        if(indexPath.item < elementArray.count)
        {
            if([elementArray[indexPath.item] isKindOfClass:[PlayerVO class]])
            {
                
                PlayerVO *player =((PlayerVO*)elementArray[indexPath.item]);
                if(!player.isPic)
                {
                    
                    width = 488;
                }
                else
                {
                    width = 237;
                }
            }
            else
            {
                width = 237;
            }
        }
    }
    return width;
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 0)
    {
        
        NSLog(@"Row: %d  Section:  %d",(int)indexPath.row,(int)indexPath.section);
       
        UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPathArea];
        UIImageView* iv = (UIImageView*)[cell viewWithTag:1];
        [iv setImage:[UIImage imageNamed:@"zq.png"]];
        
        NSMutableArray * arr = [self getElements:(int)indexPathArea.row];
        
        for (int i = 0; i < arr.count; i++)
        {
            NSIndexPath *new_indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UICollectionViewCell * newcell = [self.grid cellForItemAtIndexPath:new_indexPath];
            
            if([newcell isKindOfClass:[ProjectControl class]])
            {
                [((ProjectControl *) newcell) setIsShow:NO];
            }
            else if([newcell isKindOfClass:[GroupControl class]])
            {
                [((GroupControl *) newcell) setIsShow:NO];
            }
        }
        
        //保存当前选中的展区IndexPath
        indexPathArea = indexPath;
        elementArray = [self getElements:(int)indexPathArea.row];
        
        UICollectionViewCell * cell1 = [collectionView cellForItemAtIndexPath:indexPathArea];
        UIImageView* iv1 = (UIImageView*)[cell1 viewWithTag:1];
        [iv1 setImage:[UIImage imageNamed:@"zq-highlight.png"]];
        
        
        //更新展区网格单元格数据
        [self.grid reloadData];
        
        //设置导航条的标题
        if(appDelegate.areaArray.count > 0)
        {
            NSString *name = ((AreaVO*)appDelegate.areaArray[indexPathArea.row]).aName;
            //self.navigationItem.title = name;
            zqTitle.text = name;
        }
        
    }
    
}

- (void)sendUDPDataComputerCommand:(NSData *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    NSLog(@"发送数据给电脑端");
    [sever sendDataCommand:command toPort:port toHost:host];
}

- (void)sendUDPComputerCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    NSLog(@"发送字符串类型给电脑端");
    [sever sendCommand:command toPort:port toHost:host];
}

- (void)sendUDPDataRelayCommand:(NSData *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    [sever sendDataCommand:command toPort:port toHost:host];
     NSLog(@"发送数据给继电器端");
}

- (void)sendUDPPlayCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    [sever sendCommand:command toPort:port toHost:host];
    NSLog(@"发送字符串类型给play");
}

- (void)sendUDPPlayImageCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    [sever sendCommand:command toPort:port toHost:host];
    NSLog(@"发送字符串类型给play");
}

- (void)sendUDPGroupCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    [sever sendCommand:command toPort:port toHost:host];
    NSLog(@"发送字符串类型给各种设备");
}

- (void)sendUDPDataGroupCommand:(NSData *)command toPort:(NSInteger)port toHost:(NSString *)host
{
    [sever sendDataCommand:command toPort:port toHost:host];
}

@end
