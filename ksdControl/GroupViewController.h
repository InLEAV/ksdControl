//
//  GroupViewController.h
//  ksdControl
//
//  Created by CMQ on 15/5/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//已添加的元素列表
@property (strong, nonatomic) IBOutlet UITableView *elementTableView;

//每个组合中所包含的元素列表
@property (strong, nonatomic) IBOutlet UITableView *containerTablleView;

//已添加的组合列表
@property (strong, nonatomic) IBOutlet UITableView *groupTableView;

//组合名称
@property (strong, nonatomic) IBOutlet UITextField *groupNameFieldText;

//组合数组
@property (nonatomic, retain) NSMutableArray *groupDataList;

//包含数组，添加的每个组合的所包含的元素的数组，用于切换不用的组合显示元素在中间的列表
@property (nonatomic, retain) NSMutableArray *containerDataList;

//添加元素到包含数组
- (IBAction)AddElementToContatiner:(id)sender;

//组合名称编辑
- (IBAction)nameFiledText:(id)sender;

//添加组合行到组合列表
- (IBAction)addGroup:(id)sender;

//添加组合对象
- (void)createGroup;

//完成编辑sender放弃作为第一响应者
- (IBAction)finishEdit:(id)sender;

- (IBAction)backTap:(id)sender;

//选中分区选项
-(void)SelectItem:(NSIndexPath *)didSelectRowAtIndexPath tableView:(UITableView*)tableView;
@end
