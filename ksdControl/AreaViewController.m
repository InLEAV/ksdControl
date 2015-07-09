//
//  AreaViewController.m
//  ksdControl
//
//  Created by CMQ on 15/5/15.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "AreaViewController.h"
#import "SetViewController.h"
#import "ElementViewController.h"
#import "GroupViewController.h"
#import "ComputerVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"
#import "RelayVO.h"
#import "GroupVO.h"
#import "AreaVO.h"
#import "Model.h"
#import "JsonControl.h"
#import "AppDelegate.h"

@interface AreaViewController()

@end

@implementation AreaViewController

@synthesize groupTableView,containerTableView,AreaTableView;
@synthesize containerDataList,areaDataList,areaNameFieldText,pavilionName;

//TabBarController子视图组合视图
ElementViewController* elementViewController;
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
    elementViewController = [self.tabBarController.viewControllers objectAtIndex:0];
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
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    for (int i=0; i < appDelegate.areaArray.count; i++)
    {
        [areaDataList addObject:((AreaVO*)appDelegate.areaArray[i])];
            
        
    }

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
    int sectionCount = 0;
    if(tableView == groupTableView)
    {
        sectionCount =  (int)elementViewController.elementSections.count + 1;
    }
    else
    {
        sectionCount =  1;
    }
    return sectionCount;
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
        switch (section) {
            case 0:
                count = [groupViewController.groupDataList count];
                break;
            case 1:
                count = [elementViewController.computerDataList count];
                break;
            case 2:
                count = [elementViewController.projectorDataList count];
                break;
            case 3:
                count = [elementViewController.relayDataList count];
                break;
            case 4:
                count = [elementViewController.playerDataList count];
                break;
            default:
                break;
        }
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
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text = [[groupViewController.groupDataList objectAtIndex:rowNo] aName];
                break;
            case 1:
                cell.textLabel.text = [[elementViewController.computerDataList objectAtIndex:rowNo] aName];
                break;
            case 2:
                cell.textLabel.text = [[elementViewController.projectorDataList objectAtIndex:rowNo] aName];
                break;
            case 3:
                cell.textLabel.text = [[elementViewController.relayDataList objectAtIndex:rowNo] aName];
                break;
            case 4:
                cell.textLabel.text = [[elementViewController.playerDataList objectAtIndex:rowNo] aName];
                break;
            default:
                break;
        }

        
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
    NSString *sectionName;
    if(tableView == groupTableView)
    {
        switch (section) {
            case 0:
                sectionName = @"元素组合";
                break;
            case 1:
                sectionName = @"电脑";
                break;
            case 2:
                sectionName = @"投影机";
                break;
            case 3:
                sectionName = @"电路";
                break;
            case 4:
                sectionName = @"播放器";
                break;
            default:
                break;
        }
    }
    else if (tableView == containerTableView)
    {
        sectionName = @"已添加含";
    }
    else
    {
        sectionName = @"展区";
    }
    
    return sectionName;
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
            [containerDataList removeAllObjects];
            [containerTableView reloadData];
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
    NSLog(@"curSelecetIndexPath.section:%ld  curSelecetIndexPath.row%ld",(long)indexPath.section,(long)indexPath.row);
    
    if(tableView == groupTableView)
    {
        grouptDidSelectRowAtIndexPath = indexPath;
    }
    else if(tableView == AreaTableView)
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
    if(grouptDidSelectRowAtIndexPath.row!=-1 && areaDidSelectRowAtIndexPath.row != -1)
    {
        
        AreaVO* area = (AreaVO*)[areaDataList objectAtIndex:(areaDidSelectRowAtIndexPath.row)];
        
        switch (grouptDidSelectRowAtIndexPath.section) {
            case 0:
                if([containerDataList count] == 0)
                {
                    [area.groups addObject:[groupViewController.groupDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                else
                {
                    for (int i=0;i<[containerDataList count];i++)
                    {
                        VO *vo1 =  [containerDataList objectAtIndex:i];
                        VO *vo2 =  [groupViewController.groupDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row];
                        if ([vo1.aName isEqualToString:vo2.aName])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的组合,请重新选择!",vo2.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            
                            return;
                        }
                    }
                    [area.groups addObject:[groupViewController.groupDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                break;
            case 1:
                if([containerDataList count] == 0)
                {
                    [area.groups addObject:[elementViewController.computerDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                else
                {
                    for (int i=0;i<[containerDataList count];i++)
                    {
                        VO *vo1 =  [containerDataList objectAtIndex:i];
                        VO *vo2 =  [elementViewController.computerDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row];
                        if ([vo1.aName isEqualToString:vo2.aName])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的组合,请重新选择!",vo2.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            
                            return;
                        }
                    }
                    [area.groups addObject:[elementViewController.computerDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                break;
            case 2:
                if([containerDataList count] == 0)
                {
                    [area.groups addObject:[elementViewController.projectorDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                else
                {
                    for (int i=0;i<[containerDataList count];i++)
                    {
                        VO *vo1 =  [containerDataList objectAtIndex:i];
                        VO *vo2 =  [elementViewController.projectorDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row];
                        if ([vo1.aName isEqualToString:vo2.aName])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的组合,请重新选择!",vo2.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            
                            return;
                        }
                    }
                    [area.groups addObject:[elementViewController.projectorDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }

                break;
            case 3:
                if([containerDataList count] == 0)
                {
                    [area.groups addObject:[elementViewController.relayDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                else
                {
                    for (int i=0;i<[containerDataList count];i++)
                    {
                        VO *vo1 =  [containerDataList objectAtIndex:i];
                        VO *vo2 =  [elementViewController.relayDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row];
                        if ([vo1.aName isEqualToString:vo2.aName])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的组合,请重新选择!",vo2.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            
                            return;
                        }
                    }
                    [area.groups addObject:[elementViewController.relayDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                break;
            case 4:
                if([containerDataList count] == 0)
                {
                    [area.groups addObject:[elementViewController.playerDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }
                else
                {
                    for (int i=0;i<[containerDataList count];i++)
                    {
                        VO *vo1 =  [containerDataList objectAtIndex:i];
                        VO *vo2 =  [elementViewController.playerDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row];
                        if ([vo1.aName isEqualToString:vo2.aName])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的组合,请重新选择!",vo2.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            
                            return;
                        }
                    }
                    [area.groups addObject:[elementViewController.playerDataList objectAtIndex:grouptDidSelectRowAtIndexPath.row]];
                    [containerDataList addObject:[area.groups objectAtIndex:area.groups.count-1]];
                }

                break;
            default:
                break;
        }

        areaNameFieldText.text=@"";
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

//添加展区
- (IBAction)addArea:(id)sender
{
    if (areaNameFieldText.text!=nil&& areaNameFieldText.text.length==0)
    {
        [SetViewController showUIAlertView:@"提示"content:@"请输入添加展区的名称！" buttonTitle:@"确定"];
    }
    else
    {
        if([areaDataList count] == 0)
        {
            [self createArea];
        }
        else
        {
            for (int i=0;i<[areaDataList count];i++)
            {
                AreaVO *area =  [areaDataList objectAtIndex:i];
                if ([area.aName isEqualToString:areaNameFieldText.text])
                {
                    NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的展区,请重新输入名称!",area.aName]];
                    [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                    return;
                }
            }
            [self createArea];
        }
        
        
    }
}

//创建展区对象
- (void)createArea
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

//textfield放弃作为第一响应者
- (IBAction)finishEdit:(id)sender
{
    [sender resignFirstResponder];
}

//textfield放弃作为第一响应者
- (IBAction)backTap:(id)sender
{
    [self.areaNameFieldText resignFirstResponder];
    //[self.pavilionName resignFirstResponder];
    [sender resignFirstResponder];
}

//保存设置，创建json保存到本地
- (IBAction)save:(id)sender
{
    //json多级字典，展厅全部数据（组合，元素）
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    
    for (int i = 0; i < areaDataList.count; i++)
    {
        AreaVO* area = (AreaVO*)[areaDataList objectAtIndex:i];
        NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionary];
        for (int j = 0; j < area.groups.count; j++)
        {
            //保存组合
            if([area.groups[j] isMemberOfClass:GroupVO.class])
            {
                GroupVO* group = (GroupVO*)[area.groups objectAtIndex:j];
                
                NSMutableDictionary *sub2Dict = [NSMutableDictionary dictionary];
                
               
                for (int k = 0; k < group.elements.count ; k++)
                {
                    //保存元素，命名“元素”，与“元素”名称区别，便于解析提取数据
                    NSMutableDictionary *sub3Dict = [NSMutableDictionary dictionary];
                    sub3Dict = [self addSubDic:group.elements[k]];
                    
                    NSString* elementName = [NSString stringWithFormat:@"元素%d",k];
                    [sub2Dict setValue:sub3Dict forKey:elementName];
                }
                
                 //[sub2Dict setValue:group.aName forKey:@"name"];
                //设置组合名键值
                 NSString* groupName = [NSString stringWithFormat:@"组合_%@",group.aName];
                [sub1Dict setValue:sub2Dict forKey:groupName];
            }
            else
            {
                //保存元素，命名“组元”，便于解析提取数据
                NSMutableDictionary *sub3Dict = [NSMutableDictionary dictionary];
                sub3Dict = [self addSubDic:area.groups[j]];
              
                NSString* elementName = [NSString stringWithFormat:@"组元%d",j];
                [sub1Dict setValue:sub3Dict forKey:elementName];
            }
        }
         //保存展区
        [mutableDict setValue:sub1Dict forKey:area.aName];
    }
    
    //保存展厅名称
    [mutableDict setValue:pavilionName.text forKey:@"展厅名"];
    
    //保存程序版本号
    [mutableDict setValue:@"V1.0.0" forKey:@"程序版本"];
    
    [JsonControl jsonWrite:mutableDict FileName:@"PavilionData"];
    
    //元素json
    NSMutableDictionary *mutableElementDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *elementDict = [NSMutableDictionary dictionary];
    for(int i =0;i < [elementViewController.computerDataList count];i++)
    {
        NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
        subDict = [self addSubDic:elementViewController.computerDataList[i]];
        
        NSString* elementName = [NSString stringWithFormat:@"元素%d",i];
        [elementDict setValue:subDict forKey:elementName];
    }
    [mutableElementDict setValue:elementDict forKey:@"电脑"];
    
    elementDict = [NSMutableDictionary dictionary];
    for(int i =0;i < [elementViewController.projectorDataList count];i++)
    {
        NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
        subDict = [self addSubDic:elementViewController.projectorDataList[i]];
        
        NSString* elementName = [NSString stringWithFormat:@"元素%d",i];
        [elementDict setValue:subDict forKey:elementName];
    }
    [mutableElementDict setValue:elementDict forKey:@"投影机"];
    
    elementDict = [NSMutableDictionary dictionary];
    for(int i =0;i < [elementViewController.relayDataList count];i++)
    {
        NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
        subDict = [self addSubDic:elementViewController.relayDataList[i]];
        
        NSString* elementName = [NSString stringWithFormat:@"元素%d",i];
        [elementDict setValue:subDict forKey:elementName];
    }
    [mutableElementDict setValue:elementDict forKey:@"电路"];
    
    elementDict = [NSMutableDictionary dictionary];
    for(int i =0;i < [elementViewController.playerDataList count];i++)
    {
        NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
        subDict = [self addSubDic:elementViewController.playerDataList[i]];
        
        NSString* elementName = [NSString stringWithFormat:@"元素%d",i];
        [elementDict setValue:subDict forKey:elementName];
    }
    [mutableElementDict setValue:elementDict forKey:@"播放器"];
    
    //保存展厅名称
    [mutableElementDict setValue:pavilionName.text forKey:@"展厅名"];
    
    //保存程序版本号
    [mutableElementDict setValue:@"V1.0.0" forKey:@"程序版本"];

    [JsonControl jsonWrite:mutableElementDict FileName:@"ElementData"];
}

//添加对象到字典中并返回字典
- (NSMutableDictionary*)addSubDic:(id)obj
{
    NSMutableDictionary* sub = [NSMutableDictionary dictionary];
    
    if([obj isMemberOfClass:ComputerVO.class])
    {
        //保存电脑类型设置
        ComputerVO *computer = (ComputerVO*)(obj);
        NSLog(@"type:%@ name:%@ ip:%@ port:%d address:%@",@"电脑类型",computer.aName,computer.ip,computer.port,computer.addressMac);
        sub = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电脑类型",@"type",computer.aName,@"name",computer.ip ,@"ip",[NSNumber numberWithInteger:computer.port],@"port",computer.addressMac,@"mac",nil];
    }
    else if([obj isMemberOfClass:ProjectVO.class])
    {
        //保存投影类型设置
        ProjectVO *project = (ProjectVO*)(obj);
        sub = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"投影机类型",@"type",project.aName,@"name",project.ip ,@"ip",[NSNumber numberWithInteger:project.port],@"port",nil];
    }
    else if([obj isMemberOfClass:PlayerVO.class])
    {
        //保存播放类型设置
        PlayerVO *player = (PlayerVO*)(obj);
        sub = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"播放类型",@"type",player.aName,@"name",player.ip ,@"ip",[NSNumber numberWithInteger:player.port],@"port",[NSNumber numberWithBool:player.isPic],@"是否播放图片",nil];
    }
    else if([obj isMemberOfClass:RelayVO.class])
    {
        //保存电路类型设置
        RelayVO *relay = (RelayVO*)(obj);
        sub = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电路类型",@"type",relay.aName,@"name",relay.ip ,@"ip",[NSNumber numberWithInteger:relay.port],@"port",[NSNumber numberWithInteger:relay.circuit],@"电路数",nil];
    }
    
    return sub;

}
@end
