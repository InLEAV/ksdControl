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

@interface ElementViewController()

@end

@implementation ElementViewController

@synthesize elementTableView,computerDataList,projectorDataList,playerDataList,relayDataList;

@synthesize setTypeLabel,nameTextField,ipTextField,macUITextField,pictureUISwitch,relayUITextField,macLabel,pictureLabel,relayLabel,typeSegmented,portTextField;
@synthesize elementSections,curSelecetIndexPath;

GroupViewController * groupViewController;

//保存窗口原始位置
CGPoint elementViewOrignalPoint;
//修改元素
BOOL isModify;
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


-(void)initTable
{
    
    elementSections = [[NSArray alloc]initWithObjects:@"电脑",@"投影机",@"播放器",@"电路", nil];
    
    computerDataList = [[NSMutableArray alloc] initWithObjects:nil];
    projectorDataList = [[NSMutableArray alloc] initWithObjects:nil];
    playerDataList = [[NSMutableArray alloc] initWithObjects:nil];
    relayDataList = [[NSMutableArray alloc] initWithObjects:nil];
    
    
    groupViewController = [[GroupViewController alloc]init];
    groupViewController = [self.tabBarController.viewControllers objectAtIndex:1];

    
    //设置tableView的数据源
    elementTableView.dataSource = self;
    
    //设置tableView的委托
    elementTableView.delegate = self;
    
    isModify = FALSE;
    isViewOn = FALSE;
    
    elementViewOrignalPoint = elementTableView.center;

    //设置tableView的背景图
    //elementTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    //
    //    self.elementTableView.tableHeaderView = [[UIImageView alloc] initWithImage:
    //                                  [UIImage imageNamed:@"tableheader.png"]];
    //    // 为UITableView控件设置页脚控件
    //    self.elementTableView.tableFooterView = [[UIImageView alloc] initWithImage:
    //                                  [UIImage imageNamed:@"tableheader.png"]];
    
    
    
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
    
    switch (section) {
        case 0:
            return [computerDataList count];
            break;
        case 1:
            return [projectorDataList count];
            break;
        case 2:
            return [playerDataList count];
            break;
        case 3:
            return [relayDataList count];
            break;
        default:
            break;
    }
    
    return count;
}

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
    
    //    // 为UITableViewCell的左端设置图片
    //    cell.imageView.image = [UIImage imageNamed:@"ic_gray.png"];
    //    // 为UITableViewCell的左端设置高亮状态视时的图片
    //    cell.imageView.highlightedImage = [UIImage imageNamed:
    //                                       @"ic_highlight.png"];
    
    // 设置textLabel显示的文本
    
    switch (sectionNo) {
        case 0:
            cell.textLabel.text = [[computerDataList objectAtIndex:rowNo] aName];
            break;
        case 1:
            cell.textLabel.text = [[projectorDataList objectAtIndex:rowNo] aName];
            break;
        case 2:
            cell.textLabel.text = [[playerDataList objectAtIndex:rowNo] aName];
            break;
        case 3:
            cell.textLabel.text = [[relayDataList objectAtIndex:rowNo] aName];
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


// UITableViewDelegate协议中定义的方法。
// 该方法的返回值作为删除指定表格行时确定按钮的文本
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return @"确认删除";
}

// UITableViewDataSource协议中定义的方法。该方法的返回值决定某行是否可编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:
(NSIndexPath *)indexPath
{
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
                [playerDataList removeObjectAtIndex: rowNo];
                break;
            case 3:
                [relayDataList removeObjectAtIndex: rowNo];
                break;
            default:
                break;
        }
        
        
        
        // 从UITable程序界面上删除指定表格行。
        [tableView deleteRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        [groupViewController.elementTableView deleteRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];

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
                [playerDataList insertObject:[playerDataList objectAtIndex:indexPath.row]
                                     atIndex:indexPath.row + 1];
                break;
            case 3:
                [relayDataList insertObject:[relayDataList objectAtIndex:indexPath.row]
                                    atIndex:indexPath.row + 1];
                break;
            default:
                break;
        }
        
        
        
        
        // 为UITableView控件的界面上插入一行
        [tableView insertRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        [groupViewController.elementTableView insertRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath
{
    curSelecetIndexPath = indexPath;
    NSLog(@"curSelecetIndexPath.section:%d  curSelecetIndexPath.row%d",curSelecetIndexPath.section,curSelecetIndexPath.row);
    
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
            PlayerVO *player =  [playerDataList objectAtIndex:indexPath.row];
            nameTextField.text = player.aName;
            ipTextField.text = player.ip;
            [pictureUISwitch setOn:player.isPic animated:TRUE];
            portTextField.text = [NSString stringWithFormat:@"%d",player.port];
        }
            break;
        case 3:
        {
            [typeSegmented setSelectedSegmentIndex:3];
            RelayVO *relay =  [relayDataList objectAtIndex:indexPath.row];
            nameTextField.text = relay.aName;
            ipTextField.text = relay.ip;
            relayUITextField.text = [NSString stringWithFormat:@"%d",relay.circuit];
            portTextField.text = [NSString stringWithFormat:@"%d",relay.port];
        }
            break;
        default:
            break;
    }
    
    
}

//添加元素
- (IBAction)addElement:(id)sender
{
    isModify = FALSE;
    
    switch(typeSegmented.selectedSegmentIndex)
    {
        case 0:
        {
            [self createElement:@"ComputerVO" insert:TRUE replaceIndex:0];
        }
            break;
        case 1:
        {
            [self createElement:@"ProjectVO" insert:TRUE replaceIndex:0];
            
        }
            break;
        case 2:
        {
            [self createElement:@"PlayerVO" insert:TRUE replaceIndex:0];
            
        }
            break;
        case 3:
        {
            [self createElement:@"RelayVO" insert:TRUE replaceIndex:0];
            
        }
            break;
            
    }
    
    
}


//切换元素类型
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
            [setTypeLabel setText:@"播放类型"];
            [macUITextField setHidden:true];
            [pictureUISwitch setHidden:false];
            [relayUITextField setHidden:true];
            [macLabel setHidden:TRUE];
            [pictureLabel setHidden:FALSE];
            [relayLabel setHidden:TRUE];            break;
        case 3:
            [setTypeLabel setText:@"电路类型"];
            [macUITextField setHidden:true];
            [pictureUISwitch setHidden:true];
            [relayUITextField setHidden:false];
            [macLabel setHidden:TRUE];
            [pictureLabel setHidden:TRUE];
            [relayLabel setHidden:FALSE];            break;
    }
}



//完成编辑判断输入字符是否正确
- (IBAction)EditDidEnd:(id)sender
{
    if([sender isEqual:ipTextField])
    {
        NSLog(@"IP EditDidEnd");
    }
    else if([sender isEqual:macUITextField])
    {
        NSLog(@"MAC EditDidEnd");
    }
    else if ([sender isEqual:relayUITextField])
    {
        NSLog(@"Relay EditDidEnd");
    }
}

//sender放弃作为第一响应者
- (IBAction)finishEdit:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)backTap:(id)sender
{
    //textfield放弃作为第一响应者
    [self.nameTextField resignFirstResponder];
    [self.ipTextField resignFirstResponder];
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
        [obj setAddressMac:ipTextField.text];
        [(ComputerVO*)obj setPort:[portTextField.text intValue]];
        [obj setAType:typeComputer];
        if(isInsert)
        {
            [computerDataList insertObject:obj atIndex:[computerDataList count]];
            section = 0;
            row = [computerDataList count]-1;
            
        }
        else
        {
            [computerDataList replaceObjectAtIndex:index withObject:obj];
            NSArray *arr = [elementTableView visibleCells];
            UITableViewCell *cell = [arr objectAtIndex:index];
            cell.textLabel.text =nameTextField.text;
            [elementTableView reloadData];
        }
    }
    else if(class == ProjectVO.class)
    {
        
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
    }
    else if(class == PlayerVO.class)
    {
        [obj setIsPic:pictureUISwitch.isOn];
        [obj setAType:typePlayer];
        [(PlayerVO*)obj setPort:[portTextField.text intValue]];
        if(isInsert)
        {
            [playerDataList insertObject:obj atIndex:[playerDataList count]];
            section = 2;
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
    else if(class == RelayVO.class)
    {
        [obj setAType:typeRelay];
        [obj setCircuit:[relayUITextField.text intValue]];
        [(RelayVO*)obj setPort:[portTextField.text intValue]];
        if(isInsert)
        {
            [relayDataList insertObject:obj atIndex:[relayDataList count]];
            section = 3;
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
    
    if(isInsert)
    {
        
        [elementTableView beginUpdates];
        NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]];
        [elementTableView insertRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
        [elementTableView endUpdates];
    }
    
}


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

- (IBAction)SwitchMoveView:(id)sender
{
    if(isViewOn)
    {
        CGPoint point = CGPointMake(elementViewOrignalPoint.x, elementTableView.center.y);
        [self moveWindow:elementTableView desPoint:point isCloseWin:FALSE];
        CGPoint bntPoint = CGPointMake((((UIButton*)sender).frame.size.width/2), elementTableView.center.y);
        [self moveWindow:sender desPoint:bntPoint isCloseWin:FALSE];
        isViewOn = FALSE;
    }
    else
    {
        NSLog(@"%f:%f",elementViewOrignalPoint.x,elementTableView.frame.size.width);
        CGPoint point = CGPointMake(elementViewOrignalPoint.x+elementTableView.frame.size.width, elementTableView.center.y);
        [self moveWindow:elementTableView desPoint:point isCloseWin:FALSE];
        CGPoint bntPoint = CGPointMake(elementViewOrignalPoint.x + elementTableView.frame.size.width*1.5+(((UIButton*)sender).frame.size.width/2), elementTableView.center.y);
        [self moveWindow:sender desPoint:bntPoint isCloseWin:FALSE];
        isViewOn = TRUE;
    }
}


@end