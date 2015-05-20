//
//  AreaViewController.h
//  ksdControl
//
//  Created by CMQ on 15/5/15.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *groupTableView;

@property (strong, nonatomic) IBOutlet UITableView *containerTableView;

@property (strong, nonatomic) IBOutlet UITableView *AreaTableView;


@property (nonatomic, retain) NSMutableArray *areaDataList;
@property (nonatomic, retain) NSMutableArray *containerDataList;

@property (strong, nonatomic) IBOutlet UITextField *areaNameFieldText;
@property (strong, nonatomic) IBOutlet UITextField *PavilionName;
- (IBAction)AddGroupToContatiner:(id)sender;

- (IBAction)areaNameFiledText:(id)sender;

- (IBAction)addArea:(id)sender;

@end
