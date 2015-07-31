//
//  ViewController.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
}
//激活面板
@property (strong, nonatomic) IBOutlet UIView *activePlane;

//展厅标签
@property (strong, nonatomic) IBOutlet UILabel *pavilionNameLabel;

//激活提示
@property (strong, nonatomic) IBOutlet UILabel *tipsLable;

//激活码输入
@property (strong, nonatomic) IBOutlet UITextField *numberInputText;

//确定
- (IBAction)sureBt:(id)sender;


@end
