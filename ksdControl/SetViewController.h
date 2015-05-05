//
//  SetViewController.h
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *elementTableView;

@property (nonatomic, retain) NSMutableArray *elementDataList;

@property (nonatomic, retain) IBOutlet UIButton *addElementBtn;

- (IBAction)addELementHandel:(id)sender;

- (void)initTable;



@end
