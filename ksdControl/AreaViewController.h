//
//  AreaViewController.h
//  ksdControl
//
//  Created by CMQ on 15/5/15.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//已添加的组合列表
@property (strong, nonatomic) IBOutlet UITableView *groupTableView;

//每个展区中所包含的组合的列表
@property (strong, nonatomic) IBOutlet UITableView *containerTableView;

//已添加的展区列表
@property (strong, nonatomic) IBOutlet UITableView *AreaTableView;

//展区数组
@property (nonatomic, retain) NSMutableArray *areaDataList;

//包含数组，添加的每个展区的所包含的组合数组，用于切换不用的展区显示组合在中间的列表
@property (nonatomic, retain) NSMutableArray *containerDataList;

//返回展区名称
@property (strong, nonatomic) IBOutlet UITextField *areaNameFieldText;

//编辑返回展厅的名称
@property (strong, nonatomic) IBOutlet UITextField *PavilionName;

//添加已选定的组合到包含数组中
- (IBAction)AddGroupToContatiner:(id)sender;

//展区名称
- (IBAction)areaNameFiledText:(id)sender;

//添加展区行到展区列表
- (IBAction)addArea:(id)sender;

@end
