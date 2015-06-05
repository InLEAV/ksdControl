//
//  GroupViewController.m
//  ksdControl
//
//  Created by CMQ on 15/5/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "GroupViewController.h"
#import "SetViewController.h"
#import "ElementViewController.h"
#import "ComputerVO.h"
#import "RelayVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"
#import "GroupVO.h"
#import "AreaVO.h"
#import "Model.h"
#import "JsonControl.h"
#import "AppDelegate.h"
@interface GroupViewController()

@end

@implementation GroupViewController

@synthesize groupDataList,containerDataList;

@synthesize elementTableView,groupTableView,containerTablleView,groupNameFieldText;

//TabBarController子视图元素视图
ElementViewController *elementViewController;

//当前选中的组合选项
NSIndexPath *groupDidSelectRowAtIndexPath;

//当前选中的元素选项
NSIndexPath *elementDidSelectRowAtIndexPath;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取元素的视图控制器
    elementViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    
    //初始化数组
    containerDataList = [[NSMutableArray alloc] initWithObjects:nil];
    groupDataList = [[NSMutableArray alloc] initWithObjects:nil];
    
    //加载组合设置列表
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    for (int i=0; i < appDelegate.areaArray.count; i++)
    {
        for (int j =0; j < ((AreaVO*)appDelegate.areaArray[i]).groups.count; j++)
        {
          
            if ([((AreaVO*)appDelegate.areaArray[i]).groups[j] isKindOfClass:[GroupVO class]])
            {
                [groupDataList addObject:((AreaVO*)appDelegate.areaArray[i]).groups[j]];
            }
        }
    }
    
    
    //设置tableView的数据源
    elementTableView.dataSource = self;
    containerTablleView.dataSource = self;
    groupTableView.dataSource = self;
    
    ////设置tableView的委托
    elementTableView.delegate = self;
    containerTablleView.delegate = self;
    groupTableView.delegate = self;
    
    //初始化当前选中的IndexPath
    groupDidSelectRowAtIndexPath= [NSIndexPath indexPathForRow:-1 inSection:4];
    elementDidSelectRowAtIndexPath= [NSIndexPath indexPathForRow:-1 inSection:0];
    
}


//当切换到当前视图是更新元素列表
- (void)viewDidAppear:(BOOL)animated
{
    if (elementTableView!=nil)
    {
        [elementTableView reloadData];
    }
    NSLog(@"GroupViewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UITableViewDataSource协议中的方法，该方法的返回值决定表格包含多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == elementTableView)
    {
        return elementViewController.elementSections.count -1 ;
    }
    else
    {
        return 1;
    }
}

// UITableViewDataSource协议中的方法，该方法的返回值决定表格分区页尾高
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

// UITableViewDataSource协议中的方法，该方法的返回值决定表格行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// UITableViewDataSource协议中的方法，该方法的返回值决定表格每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if(tableView == elementTableView)
    {
        switch (section) {
            case 0:
                count = [elementViewController.computerDataList count];
                break;
            case 1:
                count = [elementViewController.projectorDataList count];
                break;
            case 2:
                count= [elementViewController.relayDataList count];
                break;
            case 3:
                count = 0;
                //count= [elementViewController.playerDataList count];
                break;
            default:
                break;
        }
    }
    else if (tableView == containerTablleView)
    {
        count = [containerDataList count];
    }
    else
    {
        count = [groupDataList count];
    }
    
    return count;
}

// UITableViewDataSource协议中的方法，该方法的返回值决定表格的单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myId = @"moveCell";
    
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
    NSUInteger sectionNo = indexPath.section;
    
    // 获取表格行的行号
    NSInteger rowNo = [indexPath row];
    
    
    // 将单元格的边框设置为圆角
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置textLabel显示的文本
    if(tableView == elementTableView)
    {
        switch (sectionNo) {
            case 0:
                cell.textLabel.text = [[elementViewController.computerDataList objectAtIndex:rowNo] aName];
                break;
            case 1:
                cell.textLabel.text = [[elementViewController.projectorDataList objectAtIndex:rowNo] aName];
                break;
            case 2:
                cell.textLabel.text = [[elementViewController.relayDataList objectAtIndex:rowNo] aName];
                break;
            case 3:
                cell.textLabel.text = [[elementViewController.playerDataList objectAtIndex:rowNo] aName];
                break;
            default:
                break;
        }
    }
    else if (tableView == containerTablleView)
    {
        cell.textLabel.text = [[containerDataList objectAtIndex:rowNo] aName];
    }
    else
    {
        cell.textLabel.text = [[groupDataList objectAtIndex:rowNo] aName];
    }
    
    return cell;
}

// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的页眉
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection
                      :(NSInteger)section
{
    if(tableView == elementTableView)
        return [elementViewController.elementSections objectAtIndex:section];
    else if (tableView == containerTablleView)
        return @"元素";
    else
        return @"组合";
}

// UITableViewDelegate协议中定义的方法，该方法的返回值作为删除指定表格行时确定按钮的文本
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return @"确认删除";
    
}

//返回当前列表是否可编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == elementTableView)
    {
        return NO;
    }
    
    return YES;
}

// UITableViewDataSource协议中定义的方法， 编辑（包括删除或插入）完成时激发该方法
- (void) tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果正在提交删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger rowNo = [indexPath row];
        
        if (tableView == containerTablleView)
        {
            [containerDataList removeObjectAtIndex: rowNo];
            
            GroupVO* group = (GroupVO*)[groupDataList objectAtIndex:(groupDidSelectRowAtIndexPath.row)];
            [group.elements removeObjectAtIndex:rowNo];
            NSLog(@"%@:%lu",group.aName,(unsigned long)group.elements.count);
        }
        else
        {
            [groupDataList removeObjectAtIndex: rowNo];
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
        if (tableView == containerTablleView)
        {
            [containerDataList insertObject:[containerDataList objectAtIndex:indexPath.row]
                                    atIndex:indexPath.row + 1];
            
        }
        else
        {
            [groupDataList insertObject:[groupDataList objectAtIndex:indexPath.row]
                                atIndex:indexPath.row + 1];
        }
        
        // 为UITableView控件的界面上插入一行
        [tableView insertRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

//选择列表选项,返回当前所选择的列表行信息
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath
{
    
    NSLog(@"curSelecetIndexPath.section:%ld  curSelecetIndexPath.row%ld",(long)indexPath.section,(long)indexPath.row);
    
    if(tableView == elementTableView)
    {
        elementDidSelectRowAtIndexPath = indexPath;
    }
    else if (tableView == groupTableView)
    {
        if(groupDidSelectRowAtIndexPath != indexPath)
        {
            [containerDataList removeAllObjects];
            GroupVO* group = (GroupVO*)[groupDataList objectAtIndex:(indexPath.row)];
            for(int i = 0;i < group.elements.count;i++)
            {
                [containerDataList addObject:[group.elements objectAtIndex:i]];
            }
            [containerTablleView reloadData];
        }
        
        groupDidSelectRowAtIndexPath = indexPath;
    }
    
}


//添加元素到组合元素列表
- (IBAction)AddElementToContatiner:(id)sender
{
    if(elementDidSelectRowAtIndexPath.row!=-1&&groupDidSelectRowAtIndexPath.row != -1)
    {
        GroupVO* group = (GroupVO*)[groupDataList objectAtIndex:(groupDidSelectRowAtIndexPath.row)];
        
        switch (elementDidSelectRowAtIndexPath.section)
        {
            case 0:
            {
                [group.elements addObject:[elementViewController.computerDataList objectAtIndex:elementDidSelectRowAtIndexPath.row]];
                [containerDataList addObject:[group.elements objectAtIndex:group.elements.count-1]];
                
            }
                break;
            case 1:
            {
                [group.elements addObject:[elementViewController.projectorDataList objectAtIndex:elementDidSelectRowAtIndexPath.row]];
                [containerDataList addObject:[group.elements objectAtIndex:group.elements.count-1]];
            }
                break;
            case 2:
            {
                [group.elements addObject:[elementViewController.relayDataList objectAtIndex:elementDidSelectRowAtIndexPath.row]];
                [containerDataList addObject:[group.elements objectAtIndex:group.elements.count-1]];
            }
                break;
            case 3:
            {
                [group.elements addObject:[elementViewController.playerDataList objectAtIndex:elementDidSelectRowAtIndexPath.row]];
                [containerDataList addObject:[group.elements objectAtIndex:group.elements.count-1]];
            }
                break;
        }
        
        [containerTablleView reloadData];
        
    }
    else if(elementDidSelectRowAtIndexPath.row==-1)
    {
        [SetViewController showUIAlertView:@"提示"content:@"请选择需要添加元素！" buttonTitle:@"确定"];
        
    }
    else if(groupDidSelectRowAtIndexPath.row==-1)
    {
        [SetViewController showUIAlertView:@"提示"content:@"请选择需要添加元素的组合！" buttonTitle:@"确定"];
    }
}

//判断输入的组合名称
- (IBAction)nameFiledText:(id)sender
{
    
}

//添加组合到组合列表
- (IBAction)addGroup:(id)sender
{
    if (groupNameFieldText.text!=nil&& groupNameFieldText.text.length==0)
    {
        [SetViewController showUIAlertView:@"提示"content:@"请输入添加组合的名称！" buttonTitle:@"确定"];
    }
    else
    {
        if([groupDataList count] == 0)
        {
            [self createGroup];
        }
        else
        {
            for (int i=0;i<[groupDataList count];i++)
            {
                GroupVO *group =  [groupDataList objectAtIndex:i];
                if ([group.aName isEqualToString:groupNameFieldText.text])
                {
                    NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的元素组合,请重新输入名称!",group.aName]];
                    [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                    
                    return;
                }
            }
            
            [self createGroup];
        }
       
      
    }
    
    
}

//创建组合对象
- (void)createGroup
{
    //创建展区对象并添加到展区数组
    GroupVO* group = [GroupVO new];
    [group initVO];
    [group setAName:groupNameFieldText.text];
    [groupDataList addObject:group];
    NSInteger row = [groupDataList count]-1;
    
    //插入列表并更新
    [groupTableView beginUpdates];
    NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]];
    [groupTableView insertRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
    [groupTableView endUpdates];
    
    NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的组合!",group.aName]];
    [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];

}

//textfield放弃作为第一响应者
- (IBAction)finishEdit:(id)sender
{
    [sender resignFirstResponder];
}

//textfield放弃作为第一响应者
- (IBAction)backTap:(id)sender
{
    [self.groupNameFieldText resignFirstResponder];
    [sender resignFirstResponder];
}
@end
