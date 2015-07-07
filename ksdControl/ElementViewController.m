//
//  ElementViewController.m
//  ksdControl
//
//  Created by CMQ on 15/5/12.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "ElementViewController.h"
#import "SetViewController.h"
#import "GroupViewController.h"
#import "ComputerVO.h"
#import "RelayVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"
#import "GroupVO.h"
#import "AreaVO.h"
#import "Model.h"
#import "JsonControl.h"
@interface ElementViewController()

@end

@implementation ElementViewController

@synthesize elementTableView,computerDataList,projectorDataList,playerDataList,relayDataList;

@synthesize setTypeLabel,nameTextField,ipTextField,macUITextField,pictureUISwitch,relayUITextField,macLabel,pictureLabel,relayLabel,typeSegmented,portTextField;

@synthesize elementSections,curSelecetIndexPath;

//TabBarController的组合视图控制器
GroupViewController * groupViewController;

//保存左边列表原始位置
CGPoint elementViewOrignalPoint;

//是否修改元素
BOOL isModify;

//是否已经显示左边列表
BOOL isViewOn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化列表
-(void)initTable
{
    //初始化元素列表4个分区名称
    elementSections = [[NSArray alloc]initWithObjects:@"电脑",@"投影机",@"电路",@"播放器", nil];
    
    //初始化4种类型的数组
    computerDataList = [[NSMutableArray alloc] initWithObjects:nil];
    projectorDataList = [[NSMutableArray alloc] initWithObjects:nil];
    playerDataList = [[NSMutableArray alloc] initWithObjects:nil];
    relayDataList = [[NSMutableArray alloc] initWithObjects:nil];
    
    [self LoadElementJson];
    
    //获取组合视图控制器
    groupViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    
    
    //设置tableView的数据源
    elementTableView.dataSource = self;
    
    //设置tableView的委托
    elementTableView.delegate = self;
    
    
    isModify = FALSE;
    isViewOn = FALSE;
    
    elementViewOrignalPoint = elementTableView.center;
    
}

- (void)LoadElementJson
{
    //加载Json数据
    NSDictionary *dict = [NSDictionary dictionary];
    dict = [JsonControl jsonRead:@"ElementData"];
    if([dict count] != 0)
    {
        NSDictionary *computerDict = [dict objectForKey:@"电脑"];
        for(int i = 0;i < [computerDict count];i++)
        {
            NSString* eName = [NSString stringWithFormat:@"元素%d",i];
            NSDictionary *eDect = [computerDict objectForKey:eName];
            ComputerVO* computer = [ComputerVO new];
            [computer initVO];
            [computer setAType:@"电脑类型"];
            [computer setIp:[eDect objectForKey:@"ip"]];
            [computer setAName:[eDect objectForKey:@"name"]];
            [computer setPort:[[eDect objectForKey:@"port"] intValue]] ;
            [computer setAddressMac:[eDect objectForKey:@"mac"]];
            [computerDataList addObject:computer];
        }
        
        NSDictionary *projectDict = [dict objectForKey:@"投影机"];
        for(int i = 0;i < [projectDict count];i++)
        {
            NSString* pName = [NSString stringWithFormat:@"元素%d",i];
            NSDictionary *pDect = [projectDict objectForKey:pName];
            ProjectVO* project = [ProjectVO new];
            [project initVO];
            [project setAType:@"投影类型"];
            [project setIp:[pDect objectForKey:@"ip"]];
            [project setAName:[pDect objectForKey:@"name"]];
            [project setPort:[[pDect objectForKey:@"port"] intValue]] ;
            [projectorDataList addObject:project];
        }

        NSDictionary *relayDict = [dict objectForKey:@"电路"];
        for(int i = 0;i < [relayDict count];i++)
        {
            NSString* rName = [NSString stringWithFormat:@"元素%d",i];
            NSDictionary *rDect = [relayDict objectForKey:rName];
            RelayVO* relay = [RelayVO new];
            [relay initVO];
            [relay setAType:@"电路类型"];
            [relay setIp:[rDect objectForKey:@"ip"]];
            [relay setAName:[rDect objectForKey:@"name"]];
            [relay setPort:[[rDect objectForKey:@"port"] intValue]] ;
            [relay setCircuit:[[rDect objectForKey:@"电路数"] intValue]];
            [relayDataList addObject:relay];
        }
        
        NSDictionary *playerDict = [dict objectForKey:@"播放器"];
        for(int i = 0;i < [playerDict count];i++)
        {
            NSString* pName = [NSString stringWithFormat:@"元素%d",i];
            NSDictionary *pDect = [playerDict objectForKey:pName];
            PlayerVO* player = [PlayerVO new];
            [player initVO];
            [player setAType:@"播放器类型"];
            [player setIp:[pDect objectForKey:@"ip"]];
            [player setAName:[pDect objectForKey:@"name"]];
            [player setPort:[[pDect objectForKey:@"port"] intValue]] ;
            [player setIsPic:[[pDect objectForKey:@"是否播放图片"] boolValue]];
            [playerDataList addObject:player];
        }

    }

}


// UITableViewDataSource协议中的方法，该方法的返回值决定表格包含多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == elementTableView)
    {
        return elementSections.count;
    }
    else
    {
        return 1;
    }
}

// UITableViewDataSource协议中的方法，返回列表页尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

// UITableViewDataSource协议中的方法，返回列表行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// UITableViewDataSource协议中的方法，返回列表每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    switch (section) {
        case 0:
            return [computerDataList count];
            break;
        case 1:
            return [projectorDataList count];
            break;
        case 2:
            return [relayDataList count];
            break;
        case 3:
            return [playerDataList count];
            break;
        default:
            break;
    }
    
    return count;
}

// UITableViewDataSource协议中的方法，创建每行的单元格
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
    switch (sectionNo) {
        case 0:
            cell.textLabel.text = [[computerDataList objectAtIndex:rowNo] aName];
            break;
        case 1:
            cell.textLabel.text = [[projectorDataList objectAtIndex:rowNo] aName];
            break;
        case 2:
            cell.textLabel.text = [[relayDataList objectAtIndex:rowNo] aName];
            break;
        case 3:
            cell.textLabel.text = [[playerDataList objectAtIndex:rowNo] aName];
            break;
        default:
            break;
    }
    return cell;
}

// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的页眉
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection
                      :(NSInteger)section
{
    return [elementSections objectAtIndex:section];
}


// UITableViewDelegate协议中定义的方法，该方法的返回值作为删除指定表格行时确定按钮的文本
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return @"确认删除";
}

// UITableViewDataSource协议中定义的方法，该方法的返回值决定某行是否可编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return YES;
}

// UITableViewDataSource协议中定义的方法,编辑（包括删除或插入）完成时激发该方法
- (void) tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果正在提交删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger rowNo = [indexPath row];
        
        // 从底层NSArray集合中删除指定数据项
        switch (indexPath.section)
        {
            case 0:
                [computerDataList removeObjectAtIndex: rowNo];
                break;
            case 1:
                [projectorDataList removeObjectAtIndex: rowNo];
                break;
            case 2:
                [relayDataList removeObjectAtIndex: rowNo];
                break;
            case 3:
                [playerDataList removeObjectAtIndex: rowNo];
                break;
            default:
                break;
        }
        
        // 从UITable程序界面上删除指定表格行。
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
       // [groupViewController.elementTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    
    // 如果正在提交插入操作
    if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        // 将当前行的数据插入到底层NSArray集合中
        switch (indexPath.section) {
            case 0:
                [computerDataList insertObject:[computerDataList objectAtIndex:indexPath.row]
                                       atIndex:indexPath.row + 1];
                break;
            case 1:
                [projectorDataList insertObject:[projectorDataList objectAtIndex:indexPath.row]
                                        atIndex:indexPath.row + 1];
                break;
            case 2:
                [relayDataList insertObject:[relayDataList objectAtIndex:indexPath.row]
                                    atIndex:indexPath.row + 1];
                break;
            case 3:
                [playerDataList insertObject:[playerDataList objectAtIndex:indexPath.row]
                                     atIndex:indexPath.row + 1];
                break;
            default:
                break;
        }
        
        // 为UITableView控件的界面上插入一行
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //[groupViewController.elementTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// UITableViewDataSource协议中定义的方法,选中返回列表行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath
{
    curSelecetIndexPath = indexPath;
    NSLog(@"curSelecetIndexPath.section:%ld  curSelecetIndexPath.row%ld",(long)curSelecetIndexPath.section,(long)curSelecetIndexPath.row);
    
    isModify = TRUE;
    
    switch (indexPath.section) {
        case 0:
        {
            [typeSegmented setSelectedSegmentIndex:0];
            
            ComputerVO *computer =  [computerDataList objectAtIndex:indexPath.row];
            nameTextField.text = computer.aName;
            ipTextField.text = computer.ip;
            macUITextField.text = computer.addressMac;
            portTextField.text = [NSString stringWithFormat:@"%d",computer.port];
        }
            break;
        case 1:
        {
            [typeSegmented setSelectedSegmentIndex:1];
            ProjectVO *project =  [projectorDataList objectAtIndex:indexPath.row];
            nameTextField.text = project.aName;
            ipTextField.text = project.ip;
            portTextField.text = [NSString stringWithFormat:@"%d",project.port];
            
        }
            break;
        case 2:
        {
            
            [typeSegmented setSelectedSegmentIndex:2];
            RelayVO *relay =  [relayDataList objectAtIndex:indexPath.row];
            nameTextField.text = relay.aName;
            ipTextField.text = relay.ip;
            relayUITextField.text = [NSString stringWithFormat:@"%d",relay.circuit];
            portTextField.text = [NSString stringWithFormat:@"%d",relay.port];
        }
            break;
        case 3:
        {
            [typeSegmented setSelectedSegmentIndex:3];
            PlayerVO *player =  [playerDataList objectAtIndex:indexPath.row];
            nameTextField.text = player.aName;
            ipTextField.text = player.ip;
            [pictureUISwitch setOn:player.isPic animated:TRUE];
            portTextField.text = [NSString stringWithFormat:@"%d",player.port];

            
            
        }
            break;
        default:
            break;
    }
    
    
}

//添加元素并显示在左边列表上
- (IBAction)addElement:(id)sender
{
    isModify = FALSE;
    
    switch(typeSegmented.selectedSegmentIndex)
    {
        case 0:
        {
            if (nameTextField.text!=nil&& nameTextField.text.length==0)
            {
                [SetViewController showUIAlertView:@"提示"content:@"请输入添加电脑的名称！" buttonTitle:@"确定"];
            }
            else
            {
                if([computerDataList count]==0)
                {
                    [self createElement:@"ComputerVO" insert:TRUE replaceIndex:0];
                }
                else
                {
                    for (int i=0;i<[computerDataList count];i++)
                    {
                        ComputerVO *computer =  [computerDataList objectAtIndex:i];
                        if ([computer.aName isEqualToString:nameTextField.text])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的电脑元素,请重新输入名称!",computer.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            return;
                        }
                    }
                      [self createElement:@"ComputerVO" insert:TRUE replaceIndex:0];
                }

            }
        }
            break;
        case 1:
        {
            if (nameTextField.text!=nil&& nameTextField.text.length==0)
            {
                [SetViewController showUIAlertView:@"提示"content:@"请输入添加展区的名称！" buttonTitle:@"确定"];
            }
            else
            {
                if([projectorDataList count]==0)
                {
                    [self createElement:@"ProjectVO" insert:TRUE replaceIndex:0];

                }
                else
                {
                    for (int i=0;i<[projectorDataList count];i++)
                    {
                        ProjectVO *project =  [projectorDataList objectAtIndex:i];
                        if ([project.aName isEqualToString:nameTextField.text])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的投影机元素,请重新输入名称!",project.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            return;
                        }
                        
                    }
                    [self createElement:@"ProjectVO" insert:TRUE replaceIndex:0];
                    
                }

            }
            
        }
            break;
        case 2:
        {
            if (nameTextField.text!=nil&& nameTextField.text.length==0)
            {
                [SetViewController showUIAlertView:@"提示"content:@"请输入添加展区的名称！" buttonTitle:@"确定"];
            }
            else
            {
                if([relayDataList count]==0)
                {
                     [self createElement:@"RelayVO" insert:TRUE replaceIndex:0];
                }
                else
                {
                    for (int i=0;i<[relayDataList count];i++)
                    {
                        RelayVO *relay =  [relayDataList objectAtIndex:i];
                        if ([relay.aName isEqualToString:nameTextField.text])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的电路元素,请重新输入名称!",relay.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            return;
                        }
                        
                        
                    }
                     [self createElement:@"RelayVO" insert:TRUE replaceIndex:0];
                }

            }

            
        }
            break;
        case 3:
        {
            if (nameTextField.text!=nil&& nameTextField.text.length==0)
            {
                [SetViewController showUIAlertView:@"提示"content:@"请输入添加展区的名称！" buttonTitle:@"确定"];
            }
            else
            {
                if([playerDataList count]==0)
                {
                     [self createElement:@"PlayerVO" insert:TRUE replaceIndex:0];
                }
                else
                {
                    for (int i=0;i<[playerDataList count];i++)
                    {
                        PlayerVO *player =  [playerDataList objectAtIndex:i];
                        if ([player.aName isEqualToString:nameTextField.text])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的播放器元素,请重新输入名称!",player.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            return;
                        }
                        
                    }
                    
                    [self createElement:@"PlayerVO" insert:TRUE replaceIndex:0];
                }

            }
        }
            break;
    }
}


//切换元素类型,显示编辑选项
- (IBAction)segmentedChanged:(id)sender
{
    switch([sender selectedSegmentIndex])
    {
        case 0:
            [setTypeLabel setText:@"电脑类型"];
            [macUITextField setHidden:false];
            [pictureUISwitch setHidden:true];
            [relayUITextField setHidden:true];
            [macLabel setHidden:FALSE];
            [pictureLabel setHidden:TRUE];
            [relayLabel setHidden:TRUE];
            break;
        case 1:
            [setTypeLabel setText:@"投影类型"];
            [macUITextField setHidden:true];
            [pictureUISwitch setHidden:true];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [pictureLabel setHidden:TRUE];
            [relayLabel setHidden:TRUE];
            break;
        case 2:
            [setTypeLabel setText:@"电路类型"];
            [macUITextField setHidden:true];
            [pictureUISwitch setHidden:true];
            [relayUITextField setHidden:false];
            [macLabel setHidden:TRUE];
            [pictureLabel setHidden:TRUE];
            [relayLabel setHidden:FALSE];
            break;
        case 3:
            [setTypeLabel setText:@"播放类型"];
            [macUITextField setHidden:true];
            [pictureUISwitch setHidden:false];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [pictureLabel setHidden:FALSE];
            [relayLabel setHidden:TRUE];

            break;
    }
//    nameTextField.text=@"";
//    ipTextField.text=@"";
//    portTextField.text=@"";
//    macUITextField.text=@"";
//    relayUITextField.text=@"";
    
    
}



//完成编辑判断输入字符是否正确
- (IBAction)EditDidEnd:(id)sender
{
    if([sender isEqual:ipTextField])
    {
        if(![SetViewController validateInput:ipTextField.text RegexString:@"\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b"])
        {
            [SetViewController showUIAlertView:@"提示" content:@"请正确输入IP格式" buttonTitle:@"确定"];
//            ipTextField.text=@"";
        }
        NSLog(@"Ip EditDidEnd");
    }
    else if([sender isEqual:macUITextField])
    {
        if(![SetViewController validateInput:macUITextField.text RegexString:@"^([0-9a-fA-F]{2})(([/\\s:][0-9a-fA-F]{2}){5})$"])
        {
            [SetViewController showUIAlertView:@"提示" content:@"请正确输入mac格式" buttonTitle:@"确定"];
//            macUITextField.text=@"";
        }
        NSLog(@"MAC EditDidEnd");
    }
    else if([sender isEqual:portTextField])
    {
        if(![SetViewController validateInput:portTextField.text RegexString:@"^[1-9]\\d*|0$"])
        {
            [SetViewController showUIAlertView:@"提示" content:@"请正确输入数字格式" buttonTitle:@"确定"];
//            portTextField.text=@"";
        }
        NSLog(@"Port EditDidEnd");
    }
    else if ([sender isEqual:relayUITextField])
    {
        if(![SetViewController validateInput:relayUITextField.text  RegexString:@"^[1-9]\\d*|0$"])
        {
            [SetViewController showUIAlertView:@"提示" content:@"请正确输入数字格式" buttonTitle:@"确定"];
//            relayUITextField.text=@"";
        }
        NSLog(@"Relay EditDidEnd");
    }
}

//sender放弃作为第一响应者
- (IBAction)finishEdit:(id)sender
{
    [sender resignFirstResponder];
}


//textfield放弃作为第一响应者
- (IBAction)backTap:(id)sender
{
    [self.nameTextField resignFirstResponder];
    [self.ipTextField resignFirstResponder];
    [self.portTextField resignFirstResponder];
    [self.macUITextField resignFirstResponder];
    [self.relayUITextField resignFirstResponder];
    [sender resignFirstResponder];
}


//创建新元素和修改元素
- (void)createElement:(NSString*)className insert:(BOOL)isInsert replaceIndex:(int)index
{
    NSUInteger section = 0;
    NSUInteger row = 0;
    
    Class class = NSClassFromString(className);
    
    id obj = [class new];
    [obj initVO];
    [obj setIp:ipTextField.text];
    [obj setAName:nameTextField.text];
    
    if(class == ComputerVO.class)
    {
        //创建电脑对象
        [obj setAddressMac:macUITextField.text];
        [(ComputerVO*)obj setPort:[portTextField.text intValue]];
        [obj setAType:typeComputer];
        if(isInsert)
        {
            //把对象插入到指定行里
            [computerDataList insertObject:obj atIndex:[computerDataList count]];
            section = 0;
            row = [computerDataList count]-1;
            
        }
        else
        {
            //在computerDataList末尾添加对象
            [computerDataList replaceObjectAtIndex:index withObject:obj];
            NSArray *arr = [elementTableView visibleCells];
            UITableViewCell *cell = [arr objectAtIndex:index];
            cell.textLabel.text =nameTextField.text;
            [elementTableView reloadData];
        }
    }
    else if(class == ProjectVO.class)
    {
         //创建投影机对象
        [obj setAType:typeProject];
        [(ProjectVO*)obj setPort:[portTextField.text intValue]];
        if(isInsert)
        {
            [projectorDataList insertObject:obj atIndex:[projectorDataList count]];
            section = 1;
            row = [projectorDataList count]-1;
        }
        else
        {
            [projectorDataList replaceObjectAtIndex:index withObject:obj];
            
            NSArray *arr = [elementTableView visibleCells];
            UITableViewCell *cell = [arr objectAtIndex:index];
            cell.textLabel.text =nameTextField.text;
            [elementTableView reloadData];
        }
    } else if(class == RelayVO.class)
    {
        //创建电路对象
        [obj setAType:typeRelay];
        [obj setCircuit:[relayUITextField.text intValue]];
        [(RelayVO*)obj setPort:[portTextField.text intValue]];
        if(isInsert)
        {
            [relayDataList insertObject:obj atIndex:[relayDataList count]];
            section = 2;
            row = [relayDataList count]-1;
        }
        else
        {
            [relayDataList replaceObjectAtIndex:index withObject:obj];
            
            NSArray *arr = [elementTableView visibleCells];
            UITableViewCell *cell = [arr objectAtIndex:index];
            //[cell setBackgroundColor:[UIColor redColor]];
            cell.textLabel.text = nameTextField.text;
            [elementTableView reloadData];
        }
    }
    else if(class == PlayerVO.class)
    {
        //创建播放器对象
        [obj setIsPic:pictureUISwitch.isOn];
        [obj setAType:typePlayer];
        [(PlayerVO*)obj setPort:[portTextField.text intValue]];
        if(isInsert)
        {
            [playerDataList insertObject:obj atIndex:[playerDataList count]];
            section = 3;
            row = [playerDataList count]-1;
        }
        else
        {
            [playerDataList replaceObjectAtIndex:index withObject:obj];
            NSArray *arr = [elementTableView visibleCells];
            UITableViewCell *cell = [arr objectAtIndex:index];
            cell.textLabel.text =nameTextField.text;
            [elementTableView reloadData];
        }
        
    }
    
    if(isInsert)
    {
        //插入元素对象并更新
        [elementTableView beginUpdates];
        NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]];
        [elementTableView insertRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
        [elementTableView endUpdates];
    }
    
//    nameTextField.text=@"";
//    ipTextField.text=@"";
//    portTextField.text=@"";
//    macUITextField.text=@"";
//    relayUITextField.text=@"";
    
}

//移动窗口，完成动画是否隐藏窗口
- (void)moveWindow:(UIView*) uiView desPoint:(CGPoint)point isCloseWin:(BOOL)isClose
{
    [UIView transitionWithView:uiView duration:0.3
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        uiView.center = point;
                    }
                    completion:^(BOOL finished)
     {
         if(finished&&isClose)
             [uiView setHidden:true];
     }];
    
}

//开关显示左侧列表
- (IBAction)SwitchMoveView:(id)sender
{
    
    if(isViewOn)
    {
        [(UIButton*)sender setImage:[UIImage imageNamed:@"arrowRight.png"] forState:UIControlStateNormal];
        
        //关闭左侧列表
        CGPoint point = CGPointMake(elementViewOrignalPoint.x, elementTableView.center.y);
        [self moveWindow:elementTableView desPoint:point isCloseWin:FALSE];
        CGPoint bntPoint = CGPointMake((((UIButton*)sender).frame.size.width/2), elementTableView.center.y);
        [self moveWindow:sender desPoint:bntPoint isCloseWin:FALSE];

        isViewOn = FALSE;
    }
    else
    {
        
        [(UIButton*)sender setImage:[UIImage imageNamed:@"arrowLeft.png"] forState:UIControlStateNormal];

        //打开左侧列表
        CGPoint point = CGPointMake(elementViewOrignalPoint.x+elementTableView.frame.size.width, elementTableView.center.y);
        [self moveWindow:elementTableView desPoint:point isCloseWin:FALSE];
        CGPoint bntPoint = CGPointMake(elementViewOrignalPoint.x + elementTableView.frame.size.width*1.5+(((UIButton*)sender).frame.size.width/2), elementTableView.center.y);
        [self moveWindow:sender desPoint:bntPoint isCloseWin:FALSE];
        
        isViewOn = TRUE;
    }
}


@end