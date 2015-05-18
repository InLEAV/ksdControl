//
//  GroupViewController.h
//  ksdControl
//
//  Created by CMQ on 15/5/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *elementTableView;

@property (strong, nonatomic) IBOutlet UITableView *containerTablleView;

@property (strong, nonatomic) IBOutlet UITableView *groupTableView;

@property (strong, nonatomic) IBOutlet UITextField *groupNameFieldText;

@property (nonatomic, retain) NSMutableArray *groupDataList;
@property (nonatomic, retain) NSMutableArray *containerDataList;


- (IBAction)AddElementToContatiner:(id)sender;

- (IBAction)nameFiledText:(id)sender;

- (IBAction)addGroup:(id)sender;

- (void)UpdateElementTableView;

@end
