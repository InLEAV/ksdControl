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
#import "ComputerVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"
#import "RelayVO.h"
#import "GroupVO.h"
#import "AreaVO.h"
#import "Model.h"

@interface AreaViewController()

@end

@implementation AreaViewController

@synthesize groupTableView,containerTableView,AreaTableView;
@synthesize containerDataList,areaDataList,areaNameFieldText,pavilionName;

//TabBarController子视图组合视图
GroupViewController* groupViewController;

//当前选中的组合选项
NSIndexPath* grouptDidSelectRowAtIndexPath;

//当前选中的展区选项
NSIndexPath* areaDidSelectRowAtIndexPath;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //获取TabBarController子视图组合视图
    groupViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    
    //初始化数组
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
    
    //初始化当前选中选项
    grouptDidSelectRowAtIndexPath= [NSIndexPath indexPathForRow:-1 inSection:4];
    areaDidSelectRowAtIndexPath= [NSIndexPath indexPathForRow:-1 inSection:0];
    
}

//当切换到当前视图是更新组合列表
- (void)viewDidAppear:(BOOL)animated
{
    if(groupTableView!=nil)
    {
        [groupTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UITableViewDataSource协议中的方法，该方法的返回值决定表格包含多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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

// UITableViewDataSource协议中的方法，该方法的返回值决定表格的单元格内容
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
    
    // 获取表格行的行号
    NSInteger rowNo = [indexPath row];
    
    
    // 将单元格的边框设置为圆角
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
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

// UITableViewDelegate协议中定义的方法，该方法的返回值作为删除指定表格行时确定按钮的文本
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return @"确认删除";
    
}


// UITableViewDelegate协议中定义的方法，该方法的返回是否可编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == groupTableView)
    {
        return NO;
    }
    
    return YES;
}

// UITableViewDataSource协议中定义的方法，编辑（包括删除或插入）完成时激发该方法
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

//UITableViewDataSource协议中定义的方法，选择列表选项
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

//添加组合到选中的展区数组并显示到中间列表
- (IBAction)AddGroupToContatiner:(id)sender
{
    if(grouptDidSelectRowAtIndexPath.row!=-1&&areaDidSelectRowAtIndexPath.row != -1)
    {
        
        AreaVO* area = (AreaVO*)[areaDataList objectAtIndex:(areaDidSelectRowAtIndexPath.row)];
        
        if(grouptDidSelectRowAtIndexPath.section == 0)
        {
            [area.groups addObject:[groupViewController.groupDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
            [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
        }
        
        [containerTableView reloadData];
    }
    else if(grouptDidSelectRowAtIndexPath.row==-1)
    {
        [SetViewController showUIAlertView:@"提示"content:@"请选择需要添加组合！" buttonTitle:@"确定"];
    }
    else if (areaDidSelectRowAtIndexPath.row == -1)
    {
        [SetViewController showUIAlertView:@"提示"content:@"请选择需要添加组合的展区！" buttonTitle:@"确定"];
        
    }
}

//判断输入的展区名称
- (IBAction)areaNameFiledText:(id)sender
{
    
}

//
- (IBAction)addArea:(id)sender
{
    if (areaNameFieldText.text!=nil&& areaNameFieldText.text.length==0)
    {
        [SetViewController showUIAlertView:@"提示"content:@"请输入添加展区的名称！" buttonTitle:@"确定"];
    }
    else
    {
        //创建展区对象并添加到展区数组
        AreaVO* area = [AreaVO new];
        [area initVO];
        [area setAName:areaNameFieldText.text];
        [areaDataList addObject:area];
        NSInteger row = [areaDataList count]-1;
        
        //插入列表并更新
        [AreaTableView beginUpdates];
        NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]];
        [AreaTableView insertRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
        [AreaTableView endUpdates];
        
        NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的展区!",area.aName]];
        [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
        
    }
}

//保存设置，创建json保存到本地
- (IBAction)save:(id)sender
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *sub2Dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *sub3Dict = [NSMutableDictionary dictionary];
    
    //保存展厅名称
    [mutableDict setValue:pavilionName.text forKey:@"展厅名"];
    
    for (int i = 0; i < areaDataList.count; i++)
    {
        AreaVO* area = (AreaVO*)[areaDataList objectAtIndex:i];
        for (int j = 0; j < area.groups.count; j++)
        {
            GroupVO* group = (GroupVO*)[area.groups objectAtIndex:j];
            
            for (int k = 0; k < group.elements.count ; k++)
            {
                sub3Dict = [NSMutableDictionary dictionary];
                if([group.elements[k] isMemberOfClass:ComputerVO.class])
                {
                    //保存电脑类型设置
                    ComputerVO *computer = (ComputerVO*)(group.elements[k]);
                    NSLog(@"type:%@ name:%@ ip:%@ port:%d address:%@",@"电脑类型",computer.aName,computer.ip,computer.port,computer.addressMac);
                    sub3Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电脑类型",@"type",computer.aName,@"name",computer.ip ,@"ip",[NSNumber numberWithInteger:computer.port],@"port",computer.addressMac,@"mac",nil];
                }
                else if([group.elements[k] isMemberOfClass:ProjectVO.class])
                {
                    //保存投影类型设置
                    ProjectVO *project = (ProjectVO*)(group.elements[k]);
                    sub3Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"投影机类型",@"type",project.aName,@"name",project.ip ,@"ip",[NSNumber numberWithInteger:project.port],@"port",nil];
                }
                else if([group.elements[k] isMemberOfClass:PlayerVO.class])
                {
                    //保存播放类型设置
                    PlayerVO *player = (PlayerVO*)(group.elements[k]);
                    sub3Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"播放类型",@"type",player.aName,@"name",player.ip ,@"ip",[NSNumber numberWithInteger:player.port],@"port",[NSNumber numberWithBool:player.isPic],@"是否播放图片",nil];
                }
                else if([group.elements[k] isMemberOfClass:RelayVO.class])
                {
                    //保存电路类型设置
                    RelayVO *relay = (RelayVO*)(group.elements[k]);
                    sub3Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电路类型",@"type",relay.aName,@"name",relay.ip ,@"ip",[NSNumber numberWithInteger:relay.port],@"port",[NSNumber numberWithInteger:relay.circuit],@"电路数",nil];
                }
                
                NSString* elementName = [NSString stringWithFormat:@"元素%d",k];
                [sub2Dict setValue:sub3Dict forKey:elementName];
            }
            
            //设置组合名键值
            [sub1Dict setValue:sub2Dict forKey:group.aName];
        }
        
         //保存展区
        [mutableDict setValue:sub1Dict forKey:area.aName];
    }
    
    //将Json保存到本地
    NSError *error = nil;
    
    NSData *JsonData = [NSJSONSerialization dataWithJSONObject:mutableDict options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error)
    {
        NSLog(@"Error %@",[error localizedDescription]);
    }
    
    //Json文件路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:  [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@.json!",pavilionName.text]]];
    NSLog(@"%@",Json_path);
    
    //写入文件
    NSLog(@"%@",[JsonData writeToFile:Json_path atomically:YES] ? @"Save Json Succeed":@"Save Json Failed");
}

@end
