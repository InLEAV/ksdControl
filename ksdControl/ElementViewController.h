//
//  ElementViewController.h
//  ksdControl
//
//  Created by CMQ on 15/5/12.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElementViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//元素属性
@property (nonatomic, retain) IBOutlet UITableView *elementTableView;
@property (nonatomic, retain) NSMutableArray *computerDataList;
@property (nonatomic, retain) NSMutableArray *projectorDataList;
@property (nonatomic, retain) NSMutableArray *playerDataList;
@property (nonatomic, retain) NSMutableArray *relayDataList;
@property (strong, nonatomic) IBOutlet UIButton *addElementBtn;
- (IBAction)addElement:(id)sender;

//元素类别数组
@property (nonatomic,retain) NSArray* elementSections;
@property (nonatomic,copy,readonly) NSIndexPath *curSelecetIndexPath;
- (void)initTable;


//类型分段控件
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSegmented;
- (IBAction)segmentedChanged:(id)sender;

//设置类型标签
@property (strong, nonatomic) IBOutlet UILabel *setTypeLabel;
//名称输入框
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
//ID输入框
@property (strong, nonatomic) IBOutlet UITextField *ipTextField;
//端口号输入框
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
//第三栏标签名
@property (strong, nonatomic) IBOutlet UILabel *macLabel;
@property (strong, nonatomic) IBOutlet UILabel *pictureLabel;
@property (strong, nonatomic) IBOutlet UILabel *relayLabel;

//mac地址输入框
@property (strong, nonatomic) IBOutlet UITextField *macUITextField;
//图片切换开关
@property (strong, nonatomic) IBOutlet UISwitch *pictureUISwitch;
//电路输入框
@property (strong, nonatomic) IBOutlet UITextField *relayUITextField;

- (IBAction)SwitchMoveView:(id)sender;

//保存按钮
- (IBAction)EditDidEnd:(id)sender;

//完成编辑sender放弃作为第一响应者
- (IBAction)finishEdit:(id)sender;

- (IBAction)backTap:(id)sender;


//创建新元素，编辑修改元素，移动窗口
- (void)createElement:(NSString*)className insert:(BOOL)isInsert replaceIndex:(int)index;
- (void)moveWindow:(UIView*)uiView desPoint:(CGPoint)point isCloseWin:(BOOL)isClose;

@end