//
//  SetViewController.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "SetViewController.h"
#import "ComputerVO.h"
#import "RelayVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"
#import "Model.h"

@interface SetViewController ()

@end

@implementation SetViewController

@synthesize elementTableView,elementDataList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)creatVO
{
    ComputerVO * comp1 = [ComputerVO new];
    [comp1 initVO];
    [comp1 setIp:@"192.168.11.2"];
    [comp1 setAddressMac:@"AA-BB-CC-DD-DD"];
    [comp1 setAName:@"电脑1"];
    [comp1 setAType:typeComputer];
    [comp1 setPort:8800];
    
    ProjectVO * pro1 = [ProjectVO new];
    [pro1 initVO];
    [pro1 setIp:@"192.168.11.3"];
    [pro1 setAName:@"投影1"];
    [pro1 setAType:typeProject];
    [pro1 setPort:8800];
    
    PlayerVO * play1 = [PlayerVO new];
    [play1 initVO];
    [play1 setIp:@"192.168.11.4"];
    [play1 setAName:@"播放器1"];
    [play1 setAType:typePlayer];
    [play1 setPort:8800];
    
    RelayVO * relay1 = [RelayVO new];
    [relay1 initVO];
    [relay1 setIp:@"192.168.11.5"];
    [relay1 setAName:@"电路1"];
    [relay1 setAType:typeRelay];
    [relay1 setCircuit:1];
    [relay1 setPort:8800];
    
//    elementDataList
}

-(void)initTable
{
    
//    NSArray *list = [NSArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津", nil];
//    self.dataList = list;
    
    // 设置tableView的数据源
//    elementTableView.dataSource = self;
    // 设置tableView的委托
//    elementTableView.delegate = self;
    // 设置tableView的背景图
//    elementTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];

    
}

- (IBAction)addELementHandel:(id)sender
{
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [elementDataList count];
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
    NSInteger rowNo = [indexPath row];
    // 设置textLabel显示的文本
    cell.textLabel.text = [elementDataList objectAtIndex:rowNo];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
