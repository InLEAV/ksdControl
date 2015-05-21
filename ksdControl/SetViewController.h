//
//  SetViewController.h
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetViewController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>

//提示窗口
+(void)showUIAlertView:(NSString*)title content:(NSString*)msg buttonTitle:(NSString*)btTitle;

@end
