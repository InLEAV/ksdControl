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
#import "JsonControl.h"
#import "AreaVO.h"
#import "GroupVO.h"
#import "ComputerVO.h"
#import "ProjectVO.h"
#import "PlayerVO.h"
#import "RelayVO.h"

@interface SetViewController ()

@end

@implementation SetViewController


ElementViewController* elementViewController;
GroupViewController* groupViewController;
AreaViewController* areaViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
//self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"elementItem-highlight.png"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//TabBar协议，选中TabBarItem
- (void)tabBar:(UITabBar *)tabbar didSelectItem:(UITabBarItem *)item
{
    if(item.tag==0){
        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"elementItem-highlight.png"];
    }
    if(item.tag==1){
        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"groupItem-highlight.png"];
    }
    if(item.tag==2){
        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"areaItem-highlight.png"];
    }
}

//判断字符输入是否正确
+ (BOOL)validateInput:(NSString *) textString RegexString:(NSString *)regexStr
{
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:textString options:0 range:NSMakeRange(0, [textString length])];
    
    if (result)
    {
        return true;
    }
    return false;
    
}

//判断字符串为整形
+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}


//提示窗口，提示标题，内容，按钮名称
+(void)showUIAlertView:(NSString*)title content:(NSString*)msg buttonTitle:(NSString*)btTitle;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:btTitle otherButtonTitles:nil];
    [alert show];
}



@end
