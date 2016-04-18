//
//  EnterPasswordConrtolViewController.m
//  ksdControl
//
//  Created by CMQ on 15/9/17.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "EnterPasswordConrtolViewController.h"

@interface EnterPasswordConrtolViewController ()

@end

@implementation EnterPasswordConrtolViewController


@synthesize passwordFieldtext,tipsLable;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)okBt:(id)sender
{
    if([passwordFieldtext.text isEqual:@"12341234"])
    {
        [self performSegueWithIdentifier:@"switchenter" sender:self];
    }else
    {
        [tipsLable setText:@"密码错误请重新输入" ];
    }
    
}

@end
