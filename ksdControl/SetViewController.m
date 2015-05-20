//
//  SetViewController.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "SetViewController.h"
#import "ElementViewController.h"
#import "GroupViewController.h"
#import "AreaViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

ElementViewController* elementViewController;
GroupViewController* groupViewController;
AreaViewController* areaViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabbar didSelectItem:(UITabBarItem *)item
{
  
}

+(void)showUIAlertView:(NSString*)title content:(NSString*)msg buttonTitle:(NSString*)btTitle;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:btTitle otherButtonTitles:nil];
    [alert show];
}

@end
