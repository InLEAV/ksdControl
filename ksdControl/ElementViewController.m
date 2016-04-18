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

@synthesize elementTableView,computerDataList,projectorDataList,playerVideoDataList,playerImageDataList,relayDataList;

@synthesize setTypeLabel,nameTextField,ipTextField,macUITextField,idUITextField,relayUITextField,macLabel,idLabel,relayLabel,typeSegmented,portTextField,countLable,countUITextField,setWindow,isDefaultSwitch,defaultLabel;

@synthesize elementSections,curSelecetIndexPath;

//TabBarController的组合视图控制器
GroupViewController * groupViewController;

//保存左边列表原始位置
CGPoint elementViewOrignalPoint;

//保存设置窗口的原始位置
CGPoint setWindowOrignalPoint;

//是否修改元素
BOOL isModify;

//是否向上移动
BOOL isMoveUp;

//是否已经显示左边列表
BOOL isViewOn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    curSelecetIndexPath= [NSIndexPath indexPathForRow:-1 inSection:-1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

//初始化列表
-(void)initTable
{
    //初始化元素列表4个分区名称
    elementSections = [[NSArray alloc]initWithObjects:@"电脑",@"投影机",@"电路",@"视频播放器",@"图片播放器", nil];
    
    //初始化4种类型的数组
    computerDataList = [[NSMutableArray alloc] initWithObjects:nil];
    projectorDataList = [[NSMutableArray alloc] initWithObjects:nil];
    playerVideoDataList = [[NSMutableArray alloc] initWithObjects:nil];
    playerImageDataList = [[NSMutableArray alloc] initWithObjects:nil];
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
    isMoveUp = FALSE;
    
    elementViewOrignalPoint = elementTableView.center;
    
    
    
    elementTableView.backgroundView = nil;
    elementTableView.backgroundColor = [UIColor colorWithRed:0.05 green:0.1 blue:0.2 alpha:0.6];
    elementTableView.opaque = NO;
    
    
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"*-----HideKeyBoard");
    if(isMoveUp)
    {
        CGPoint center=self.setWindow.center;
        center.y+=140;
        //首尾式设置动画效果
        [UIView beginAnimations:nil context:nil];
        self.setWindow.center=center;
        //设置时间
        [UIView setAnimationDuration:2.0];
        [UIView commitAnimations];
        isMoveUp = FALSE;
    }
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"*-----ShowKeyBoard");
    if(!isMoveUp)
    {
        CGPoint center=self.setWindow.center;
        center.y-=140;
        //首尾式设置动画效果
        [UIView beginAnimations:nil context:nil];
        self.setWindow.center=center;
        //设置时间
        [UIView setAnimationDuration:2.0];
        [UIView commitAnimations];
        isMoveUp = TRUE;
    }
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
            [computer setAType:typeComputer];
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
            [project setAType:typeProject];
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
            [relay setAType:typeRelay];
            [relay setIp:[rDect objectForKey:@"ip"]];
            [relay setAName:[rDect objectForKey:@"name"]];
            [relay setPort:[[rDect objectForKey:@"port"] intValue]] ;
            [relay setCircuit:[[rDect objectForKey:@"电路数"] intValue]];
            [relayDataList addObject:relay];
        }
        
        NSDictionary *playerVideoDict = [dict objectForKey:@"视频播放器"];
        for(int i = 0;i < [playerVideoDict count];i++)
        {
            NSString* pName = [NSString stringWithFormat:@"元素%d",i];
            NSDictionary *pDect = [playerVideoDict objectForKey:pName];
            PlayerVO* player = [PlayerVO new];
            [player initVO];
            [player setAType:typeVideoPlayer];
            [player setIp:[pDect objectForKey:@"ip"]];
            [player setAName:[pDect objectForKey:@"name"]];
            [player setPort:[[pDect objectForKey:@"port"] intValue]] ;
            [player setPlayerID:[[pDect objectForKey:@"ID"] intValue]];
            [player setCount:[[pDect objectForKey:@"数量"] intValue]];
            [player setIsPic:[[pDect objectForKey:@"是否图片"] boolValue]];
            [player setIsDefault:[[pDect objectForKey:@"是否默认"] boolValue]];
            [playerVideoDataList addObject:player];
        }

        NSDictionary *playerImageDict = [dict objectForKey:@"图片播放器"];
        for(int i = 0;i < [playerImageDict count];i++)
        {
            NSString* pName = [NSString stringWithFormat:@"元素%d",i];
            NSDictionary *pDect = [playerImageDict objectForKey:pName];
            PlayerVO* player = [PlayerVO new];
            [player initVO];
            [player setAType:typeImagePlayer];
            [player setIp:[pDect objectForKey:@"ip"]];
            [player setAName:[pDect objectForKey:@"name"]];
            [player setPort:[[pDect objectForKey:@"port"] intValue]] ;
            [player setPlayerID:[[pDect objectForKey:@"ID"] intValue]];
            [player setCount:[[pDect objectForKey:@"数量"] intValue]];
            [player setIsPic:[[pDect objectForKey:@"是否图片"] boolValue]];
            [playerImageDataList addObject:player];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}


// UITableViewDataSource协议中的方法，返回列表页尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

// UITableViewDataSource协议中的方法，返回列表行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
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
            return [playerVideoDataList count];
            break;
        case 4:
            return [playerImageDataList count];
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
//    cell.layer.cornerRadius = 12;
//    cell.layer.masksToBounds = YES;
    cell.backgroundColor = [UIColor colorWithRed:0.05 green:0.1 blue:0.3 alpha:0.6];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView =  [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.05 green:0.15 blue:0.4 alpha:0.7];
    
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
            cell.textLabel.text = [[playerVideoDataList objectAtIndex:rowNo] aName];
            break;
        case 4:
            cell.textLabel.text = [[playerImageDataList objectAtIndex:rowNo] aName];
            break;
        default:
            break;
    }
    return cell;
}

//设定开头的分类样式
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 35)];
//    [sectionView setBackgroundColor:[UIColor colorWithRed:0.05 green:0.1 blue:0.3 alpha:0.7]];
    
    //增加UILabel
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 35)];
    [text setTextColor:[UIColor whiteColor]];
    //[text setBackgroundColor:[UIColor grayColor]];
    [text setText:[elementSections objectAtIndex:section]];
    [text setAlpha:1.0f];
    [text setFont:[UIFont boldSystemFontOfSize:20]];
    
    [sectionView addSubview:text];
    return sectionView;  
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 35)];
    
    [sectionView setBackgroundColor:[UIColor colorWithRed:0.05 green:0.1 blue:0.2 alpha:0.6]];
    
    return sectionView;
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
                [self removeGroupElement:computerDataList[rowNo]];
                [computerDataList removeObjectAtIndex: rowNo];
                break;
            case 1:
                [self removeGroupElement:projectorDataList[rowNo]];
                [projectorDataList removeObjectAtIndex: rowNo];
                break;
            case 2:
                [self removeGroupElement:relayDataList[rowNo]];
                [relayDataList removeObjectAtIndex: rowNo];
                break;
            case 3:
                [self removeGroupElement:playerVideoDataList[rowNo]];
                [playerVideoDataList removeObjectAtIndex: rowNo];
                break;
            case 4:
                [self removeGroupElement:playerImageDataList[rowNo]];
                [playerImageDataList removeObjectAtIndex: rowNo];
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
                [playerVideoDataList insertObject:[playerVideoDataList objectAtIndex:indexPath.row]
                                     atIndex:indexPath.row + 1];
                break;
            case 4:
                [playerImageDataList insertObject:[playerImageDataList objectAtIndex:indexPath.row]
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

//当元素列表已移除其中元素，则移除组合中包含的元素
- (void)removeGroupElement:(id)obj
{
    for(int i=0;i < groupViewController.groupDataList.count;i++)
    {
        
        GroupVO* group = (GroupVO*)[groupViewController.groupDataList objectAtIndex:i];
        for (int j = 0; j < group.elements.count; j++)
        {
            //computerDataList[rowNo]).aName
            if(((VO*) obj).aName ==  ((VO*)(group.elements[j])).aName)
            {
                NSLog(@"%@   %@",((VO*) obj),((VO*)(group.elements[j])).aName);
                
                [group.elements removeObjectAtIndex: j];
                
            }
        }
    }

}

- (IBAction)BackBt:(id)sender
{

    if([SetViewController getCanBack]==TRUE)
    {
        [self performSegueWithIdentifier:@"eletomain" sender:self];
    }else
    {
        [SetViewController showUIAlertView:@"提示"content:@"请到展区页面保存操作！" buttonTitle:@"确定"];
        [SetViewController setCanBack:TRUE];
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
            
            [macUITextField setHidden:FALSE];
            [idUITextField setHidden:TRUE];
            [relayUITextField setHidden:TRUE];
            [macLabel setHidden:FALSE];
            [idLabel setHidden:TRUE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:TRUE];
            [countUITextField setHidden:TRUE];
            [isDefaultSwitch setHidden:TRUE];
            [defaultLabel setHidden:TRUE];
        }
            break;
        case 1:
        {
            [typeSegmented setSelectedSegmentIndex:1];
            ProjectVO *project =  [projectorDataList objectAtIndex:indexPath.row];
            nameTextField.text = project.aName;
            ipTextField.text = project.ip;
            portTextField.text = [NSString stringWithFormat:@"%d",project.port];
            
            [macUITextField setHidden:true];
            [idUITextField setHidden:true];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:TRUE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:TRUE];
            [countUITextField setHidden:TRUE];
            [isDefaultSwitch setHidden:TRUE];
              [defaultLabel setHidden:TRUE];
            
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
            
            [macUITextField setHidden:true];
            [idUITextField setHidden:true];
            [relayUITextField setHidden:false];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:TRUE];
            [relayLabel setHidden:FALSE];
            [countLable setHidden:TRUE];
            [countUITextField setHidden:TRUE];
              [defaultLabel setHidden:TRUE];
            [isDefaultSwitch setHidden:TRUE];
        }
            break;
        case 3:
        {
            [typeSegmented setSelectedSegmentIndex:3];
            PlayerVO *player =  [playerVideoDataList objectAtIndex:indexPath.row];
            nameTextField.text = player.aName;
            ipTextField.text = player.ip;
            idUITextField.text = [NSString stringWithFormat:@"%d",player.playerID];
            
            //[idUITextField setOn:player.isPic animated:TRUE];
            
            portTextField.text = [NSString stringWithFormat:@"%d",player.port];
            isDefaultSwitch.on = player.isDefault;
            
            [macUITextField setHidden:true];
            [idUITextField setHidden:false];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:FALSE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:FALSE];
            [countUITextField setHidden:FALSE];
              [defaultLabel setHidden:FALSE];
            [isDefaultSwitch setHidden:FALSE];
            
        }
            break;
        case 4:
        {
            [typeSegmented setSelectedSegmentIndex:4];
            PlayerVO *player =  [playerVideoDataList objectAtIndex:indexPath.row];
            nameTextField.text = player.aName;
            ipTextField.text = player.ip;
            idUITextField.text = [NSString stringWithFormat:@"%d",player.playerID];
            
            //[idUITextField setOn:player.isPic animated:TRUE];
            portTextField.text = [NSString stringWithFormat:@"%d",player.port];
            
            [macUITextField setHidden:true];
            [idUITextField setHidden:false];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:FALSE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:FALSE];
            [countUITextField setHidden:FALSE];
              [defaultLabel setHidden:TRUE];
            [isDefaultSwitch setHidden:TRUE];
            
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
                    [self createElement:@"ComputerVO" insert:TRUE replaceIndex:0 isImage:FALSE];
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
                      [self createElement:@"ComputerVO" insert:TRUE replaceIndex:0  isImage:FALSE];
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
                    [self createElement:@"ProjectVO" insert:TRUE replaceIndex:0  isImage:FALSE];

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
                    [self createElement:@"ProjectVO" insert:TRUE replaceIndex:0  isImage:FALSE];
                    
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
                     [self createElement:@"RelayVO" insert:TRUE replaceIndex:0  isImage:FALSE];
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
                     [self createElement:@"RelayVO" insert:TRUE replaceIndex:0  isImage:FALSE];
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
                if([playerVideoDataList count]==0)
                {
                     [self createElement:@"PlayerVO" insert:TRUE replaceIndex:0  isImage:FALSE];
                }
                else
                {
                    for (int i=0;i<[playerVideoDataList count];i++)
                    {
                        PlayerVO *player =  [playerVideoDataList objectAtIndex:i];
                        if ([player.aName isEqualToString:nameTextField.text])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的播放器元素,请重新输入名称!",player.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            return;
                        }
                        
                    }
                    
                    [self createElement:@"PlayerVO" insert:TRUE replaceIndex:0  isImage:FALSE];
                }

            }
        }
            break;
        case 4:
        {
            if (nameTextField.text!=nil&& nameTextField.text.length==0)
            {
                [SetViewController showUIAlertView:@"提示"content:@"请输入添加展区的名称！" buttonTitle:@"确定"];
            }
            else
            {
                if([playerImageDataList count]==0)
                {
                    [self createElement:@"PlayerVO" insert:TRUE replaceIndex:0  isImage:TRUE];
                }
                else
                {
                    for (int i=0;i<[playerImageDataList count];i++)
                    {
                        PlayerVO *player =  [playerImageDataList objectAtIndex:i];
                        if ([player.aName isEqualToString:nameTextField.text])
                        {
                            NSString *name = [[NSString alloc] initWithString:[NSString stringWithFormat:@"您已添加名称为%@的播放器元素,请重新输入名称!",player.aName]];
                            [SetViewController showUIAlertView:@"提示" content:name buttonTitle:@"确定"];
                            return;
                        }
                        
                    }
                    
                    [self createElement:@"PlayerVO" insert:TRUE replaceIndex:0  isImage:TRUE];
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
            [idUITextField setHidden:true];
            [relayUITextField setHidden:true];
            [macLabel setHidden:FALSE];
            [idLabel setHidden:TRUE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:TRUE];
            [countUITextField setHidden:TRUE];
            [isDefaultSwitch setHidden:TRUE];
              [defaultLabel setHidden:TRUE];
            portTextField.text = @"8870";
            break;
        case 1:
            [setTypeLabel setText:@"投影类型"];
            [macUITextField setHidden:true];
            [idUITextField setHidden:true];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:TRUE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:TRUE];
            [countUITextField setHidden:TRUE];
            [isDefaultSwitch setHidden:TRUE];
              [defaultLabel setHidden:TRUE];
            portTextField.text = @"4352";
            break;
        case 2:
            [setTypeLabel setText:@"电路类型"];
            [macUITextField setHidden:true];
            [idUITextField setHidden:true];
            [relayUITextField setHidden:false];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:TRUE];
            [relayLabel setHidden:FALSE];
            [countLable setHidden:TRUE];
            [countUITextField setHidden:TRUE];
            [isDefaultSwitch setHidden:TRUE];
              [defaultLabel setHidden:TRUE];
            break;
        case 3:
            [setTypeLabel setText:@"视频播放"];
            [macUITextField setHidden:true];
            [idUITextField setHidden:false];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:FALSE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:FALSE];
            [countUITextField setHidden:FALSE];
            [isDefaultSwitch setHidden:FALSE];
              [defaultLabel setHidden:FALSE];
            
            portTextField.text = @"21392";
            break;
        case 4:
            [setTypeLabel setText:@"图片播放"];
            [macUITextField setHidden:true];
            [idUITextField setHidden:false];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [idLabel setHidden:FALSE];
            [relayLabel setHidden:TRUE];
            [countLable setHidden:FALSE];
            [countUITextField setHidden:FALSE];
            [isDefaultSwitch setHidden:TRUE];
              [defaultLabel setHidden:TRUE];
            
            portTextField.text = @"21392";
            break;
    }
    
    
}



//开始编辑
- (IBAction)EditDidBegin:(id)sender
{

    
}

- (IBAction)Modify:(id)sender {
    if (curSelecetIndexPath.section!=-1)
    {
        switch (curSelecetIndexPath.section) {
            case 0:
            {
                if(computerDataList.count!=0)
                {
                    ComputerVO *computer =  [computerDataList objectAtIndex:curSelecetIndexPath.row];
                    computer.aName = nameTextField.text;
                    computer.ip = ipTextField.text;
                    computer.port= [portTextField.text intValue];
                    computer.addressMac = macUITextField.text;
                }
                
            }
                break;
            case 1:
            {
                if(projectorDataList.count!=0)
                {
                    ProjectVO *project =  [projectorDataList objectAtIndex:curSelecetIndexPath.row];
                    project.aName = nameTextField.text;
                    project.ip = ipTextField.text;
                    project.port= [portTextField.text intValue];
                }
            }
                break;
            case 2:
            {
                if(relayDataList.count!=0)
                {
                    RelayVO *relay =  [relayDataList objectAtIndex:curSelecetIndexPath.row];
                    relay.aName = nameTextField.text;
                    relay.ip = ipTextField.text;
                    relay.port= [portTextField.text intValue];
                    relay.circuit = [relayUITextField.text intValue];
                }
            }
                break;
            case 3:
            {
                if(playerVideoDataList.count!=0)
                {
                    
                    PlayerVO *player =  [playerVideoDataList objectAtIndex:curSelecetIndexPath.row];
                    player.aName = nameTextField.text;
                    player.ip = ipTextField.text;
                    player.port= [portTextField.text intValue];
                    player.playerID = [idUITextField.text intValue];
                    player.count = [countUITextField.text intValue];
                    player.isDefault = isDefaultSwitch.isOn;
                }
            }
                break;
            case 4:
            {
                if(playerImageDataList.count!=0)
                {
                    PlayerVO *player =  [playerImageDataList objectAtIndex:curSelecetIndexPath.row];
                    player.aName = nameTextField.text;
                    player.ip = ipTextField.text;
                    player.port= [portTextField.text intValue];
                    player.playerID = [idUITextField.text intValue];
                    player.count = [countUITextField.text intValue];
                }
            }
                break;
            default:
                break;
        }
    }
    
    [elementTableView reloadData];
}

//完成编辑判断输入字符是否正确
- (IBAction)EditDidEnd:(id)sender
{
    
     if([sender isEqual:ipTextField])
    {
        
        if(![SetViewController validateInput:ipTextField.text RegexString:@"\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b"])
        {
            [SetViewController showUIAlertView:@"提示" content:@"请正确输入IP格式" buttonTitle:@"确定"];
        }
        NSLog(@"Ip EditDidEnd");
    }
    else if([sender isEqual:macUITextField])
    {
        
        NSLog(@"MAC EditDidEnd");
    }
    else if([sender isEqual:portTextField])
    {
        if(![SetViewController validateInput:portTextField.text RegexString:@"^[1-9]\\d*|0$"])
        {
            [SetViewController showUIAlertView:@"提示" content:@"请正确输入数字格式" buttonTitle:@"确定"];
        }
        NSLog(@"Port EditDidEnd");
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
    [self.idUITextField resignFirstResponder];
    [self.countUITextField resignFirstResponder];
    [sender resignFirstResponder];
    
    if(isMoveUp)
    {
        CGPoint center=self.setWindow.center;
        center.y+=150;
        //首尾式设置动画效果
        [UIView beginAnimations:nil context:nil];
        self.setWindow.center=center;
        //设置时间
        [UIView setAnimationDuration:2.0];
        [UIView commitAnimations];
        isMoveUp = FALSE;
    }
}


//创建新元素和修改元素
- (void)createElement:(NSString*)className insert:(BOOL)isInsert replaceIndex:(int)index isImage:(BOOL)isImage
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
        //[obj setIsPic:pictureUISwitch.isOn];
        
        [(PlayerVO*)obj setPort:[portTextField.text intValue]];
        [(PlayerVO*)obj setCount:[countUITextField.text intValue]];
        [(PlayerVO*)obj setPlayerID:[idUITextField.text intValue]];
        
        if(!isImage)
        {
            [obj setAType:typeVideoPlayer];
            [(PlayerVO*)obj setIsPic:FALSE];
            [(PlayerVO*)obj setIsDefault:isDefaultSwitch.isOn];
            

        }
        else
        {
            [obj setAType:typeImagePlayer];
            [(PlayerVO*)obj setIsPic:TRUE];
        }
        
        if(isInsert)
        {
            if(!isImage)
            {
                [playerVideoDataList insertObject:obj atIndex:[playerVideoDataList count]];
                section = 3;
                row = [playerVideoDataList count]-1;
            }
            else
            {
                [playerImageDataList insertObject:obj atIndex:[playerImageDataList count]];
                section = 4;
                row = [playerImageDataList count]-1;
            }
          
        }
        else
        {
            if(!isImage)
            {
                [playerVideoDataList replaceObjectAtIndex:index withObject:obj];

            }
            else
            {
                [playerImageDataList replaceObjectAtIndex:index withObject:obj];

            }
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
//        [(UIButton*)sender setImage:[UIImage imageNamed:@"arrowRight.png"] forState:UIControlStateNormal];
        
        //关闭左侧列表
        CGPoint point = CGPointMake(elementViewOrignalPoint.x, elementTableView.center.y);
        [self moveWindow:elementTableView desPoint:point isCloseWin:FALSE];
        CGPoint bntPoint = CGPointMake((((UIButton*)sender).frame.size.width/2), elementTableView.center.y);
        [self moveWindow:sender desPoint:bntPoint isCloseWin:FALSE];

        isViewOn = FALSE;
    }
    else
    {
        
//        [(UIButton*)sender setImage:[UIImage imageNamed:@"arrowLeft.png"] forState:UIControlStateNormal];

        //打开左侧列表
        CGPoint point = CGPointMake(elementViewOrignalPoint.x+elementTableView.frame.size.width, elementTableView.center.y);
        [self moveWindow:elementTableView desPoint:point isCloseWin:FALSE];
        CGPoint bntPoint = CGPointMake(elementViewOrignalPoint.x + elementTableView.frame.size.width*1.5+(((UIButton*)sender).frame.size.width/2), elementTableView.center.y);
        [self moveWindow:sender desPoint:bntPoint isCloseWin:FALSE];
        
        isViewOn = TRUE;
    }
}


@end