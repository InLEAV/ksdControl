//
//  AreaViewController.m
//  ksdControl
//
//  Created by CMQ on 15/5/15.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "AreaViewController.h"
#import "SetViewController.h"
#import "GroupViewController.h"
#import "GroupVO.h"
#import "AreaVO.h"
#import "Model.h"

@interface AreaViewController()

@end

@implementation AreaViewController

@synthesize groupTableView,containerTableView,AreaTableView;
@synthesize containerDataList,areaDataList;

GroupViewController* groupViewController;
NSIndexPath* grouptDidSelectRowAtIndexPath;
NSIndexPath* areaDidSelectRowAtIndexPath;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // Do any additional setup after loading the view.
    //groupViewController = [[GroupViewController alloc]init];
    groupViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    
    containerDataList = [[NSMutableArray alloc] initWithObjects:nil];
    areaDataList = [[NSMutableArray alloc] initWithObjects:nil];
    
    //设置tableView的数据源
    groupTableView.dataSource = self;
    containerTableView.dataSource = self;
    AreaTableView.dataSource = self;
    
    ////设置tableView的委托
    groupTableView.delegate = self;
    containerTableView.delegate = self;
    AreaTableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddGroupToContatiner:(id)sender
{
    
}

- (IBAction)areaNameFiledText:(id)sender
{
    
}



- (IBAction)addArea:(id)sender
{
    
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if(tableView == groupTableView)
    {
        count = [groupViewController.groupDataList count];
    }
    else if (tableView == containerTableView)
    {
        count = [containerDataList count];
    }
    else
    {
        count = [areaDataList count];
    }
    
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *myId = @"cell";
    
    // 获取可重用的单元格
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:myId];
    
    // 如果单元格为nil
    if(cell == nil)
    {
        // 创建UITableViewCell对象
        cell = [[UITableViewCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:myId];
    }
    
    // 获取分区号
   // NSUInteger sectionNo = indexPath.section;
    
    // 获取表格行的行号
    NSInteger rowNo = [indexPath row];
    
    
    // 将单元格的边框设置为圆角
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //    // 为UITableViewCell的左端设置图片
    //    cell.imageView.image = [UIImage imageNamed:@"ic_gray.png"];
    //    // 为UITableViewCell的左端设置高亮状态视时的图片
    //    cell.imageView.highlightedImage = [UIImage imageNamed:
    //                                       @"ic_highlight.png"];
    
    // 设置textLabel显示的文本
    if(tableView == groupTableView)
    {
        cell.textLabel.text = [[groupViewController.groupDataList objectAtIndex:rowNo] aName];
       
    }
    else if (tableView == containerTableView)
    {
        cell.textLabel.text = [[containerDataList objectAtIndex:rowNo] aName];
    }
    else
    {
        cell.textLabel.text = [[areaDataList objectAtIndex:rowNo] aName];
    }
    return cell;
}

// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的页眉
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection
                      :(NSInteger)section
{
    if(tableView == groupTableView)
        return @"组合";
    else if (tableView == containerTableView)
        return @"已添加含组合";
    else
        return @"展区";
}

// UITableViewDelegate协议中定义的方法。
// 该方法的返回值作为删除指定表格行时确定按钮的文本
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return @"确认删除";
    
}

//返回是否可编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == groupTableView)
    {
        return NO;
    }
    
    return YES;
}

// UITableViewDataSource协议中定义的方法。
// 编辑（包括删除或插入）完成时激发该方法
- (void) tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果正在提交删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger rowNo = [indexPath row];
        
        if (tableView == containerTableView)
        {
            [containerDataList removeObjectAtIndex: rowNo];
            
            
            AreaVO* area = (AreaVO*)[areaDataList objectAtIndex:(areaDidSelectRowAtIndexPath.row)];
            [area.groups removeObjectAtIndex:rowNo];
            //NSLog(@"%@:%d",group.aName,group.elements.count);
        }
        else
        {
            [areaDataList removeObjectAtIndex: rowNo];
        }
        
        // 从UITable程序界面上删除指定表格行。
        [tableView deleteRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    // 如果正在提交插入操作
    if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        // 将当前行的数据插入到底层NSArray集合中
        if (tableView == containerTableView)
        {
            [containerDataList insertObject:[containerDataList objectAtIndex:indexPath.row]
                                    atIndex:indexPath.row + 1];
            
        }
        else
        {
            [areaDataList insertObject:[areaDataList objectAtIndex:indexPath.row]
                                atIndex:indexPath.row + 1];
        }
        
        // 为UITableView控件的界面上插入一行
        [tableView insertRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

//选择列表选项
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath
{
    
    NSLog(@"curSelecetIndexPath.section:%d  curSelecetIndexPath.row%d",indexPath.section,indexPath.row);
    
    if(tableView == groupTableView)
    {
        grouptDidSelectRowAtIndexPath = indexPath;
    }
    else
    {
        if(areaDidSelectRowAtIndexPath != indexPath)
        {
            [containerDataList removeAllObjects];
            AreaVO* area = (AreaVO*)[areaDataList objectAtIndex:(indexPath.row)];
            
            for(int i = 0;i < area.groups.count;i++)
            {
                [containerDataList addObject:[area.groups objectAtIndex:i]];
            }
            [containerTableView reloadData];
        }
        
        areaDidSelectRowAtIndexPath = indexPath;
    }
    
}

- (void)UpdateGroupTableView
{
    NSLog(@"Update GroupTable:%d",groupViewController.groupDataList.count);
    if (groupTableView!=nil) {
        [groupTableView reloadData];
    }
}


@end
