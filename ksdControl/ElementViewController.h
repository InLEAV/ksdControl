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
@property (nonatomic, retain) NSMutableArray *playerVideoDataList;
@property (nonatomic, retain) NSMutableArray *playerImageDataList;
@property (nonatomic, retain) NSMutableArray *relayDataList;

//元素类别数组
@property (nonatomic,retain) NSArray* elementSections;

//当前选择已有的元素
@property (nonatomic,copy,readonly) NSIndexPath *curSelecetIndexPath;

//添加元素按钮
@property (strong, nonatomic) IBOutlet UIButton *addElementBtn;

//类型分段控件
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSegmented;

//设置类型标签
@property (strong, nonatomic) IBOutlet UILabel *setTypeLabel;

//名称输入框
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

//ID输入框
@property (strong, nonatomic) IBOutlet UITextField *ipTextField;


//端口号输入框
@property (strong, nonatomic) IBOutlet UITextField *portTextField;


//mac标签名
@property (strong, nonatomic) IBOutlet UILabel *macLabel;

//图片标签名
@property (strong, nonatomic) IBOutlet UILabel *idLabel;

//继电器标签
@property (strong, nonatomic) IBOutlet UILabel *relayLabel;

//视频或图片总数标签
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
//是否默认播放器或一搏
@property (weak, nonatomic) IBOutlet UISwitch *isDefaultSwitch;

//mac地址输入框
@property (strong, nonatomic) IBOutlet UITextField *macUITextField;

//图片切换开关
//@property (strong, nonatomic) IBOutlet UISwitch *pictureUISwitch;
@property (weak, nonatomic) IBOutlet UITextField *idUITextField;

//电路输入框
@property (strong, nonatomic) IBOutlet UITextField *relayUITextField;

@property (weak, nonatomic) IBOutlet UITextField *countUITextField;

@property (strong, nonatomic) IBOutlet UIView *setWindow;

//初始化列表
- (void)initTable;

//加载json元素列表
- (void)LoadElementJson;

//添加元素方法
- (IBAction)addElement:(id)sender;

//切换左侧列表按钮
//开关左边已有元素列表
- (IBAction)SwitchMoveView:(id)sender;

//开始编辑
- (IBAction)EditDidBegin:(id)sender;

//保存按钮
- (IBAction)EditDidEnd:(id)sender;

//完成编辑sender放弃作为第一响应者
- (IBAction)finishEdit:(id)sender;

- (IBAction)backTap:(id)sender;

//改变元素类型后操作方法
- (IBAction)segmentedChanged:(id)sender;

//创建新元素，编辑修改元素
- (void)createElement:(NSString*)className insert:(BOOL)isInsert replaceIndex:(int)index isImage:(BOOL)isImage;

//移动窗口
- (void)moveWindow:(UIView*)uiView desPoint:(CGPoint)point isCloseWin:(BOOL)isClose;

//当元素列表已移除其中元素，则移除组合中包含的元素
- (void)removeGroupElement:(id)obj;

- (IBAction)BackBt:(id)sender;


@end