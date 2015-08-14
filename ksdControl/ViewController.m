//
//  ViewController.m
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ComputerControl.h"
#import "SLKeychain.h"
#import <BmobSDK/Bmob.h>

NSString * const KEY_VALIDDATE_VALIDSTATE = @"com.sl.app.validdatestate";
NSString * const KEY_VALIDDATE = @"com.sl.app.validdate";
NSString * const KEY_VALIDSTATE = @"com.sl.app.validstate";

@interface ViewController ()

@end

@implementation ViewController

@synthesize pavilionNameLabel,activePlane,numberInputText,tipsLable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    tipsLable.text = @"";
    
    //获取设置全局变量
   AppDelegate* appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    pavilionNameLabel.text = appDelegate.pavilionName;

    //加载密钥
    NSMutableDictionary *kvPairs = (NSMutableDictionary *)[SLKeychain load:KEY_VALIDDATE_VALIDSTATE];
    NSLog(@"Date:  %@",[kvPairs objectForKey:KEY_VALIDDATE]);
    NSLog(@"State:  %@",[kvPairs objectForKey:KEY_VALIDSTATE]);
    
    //判断密钥key是否存在
    if([kvPairs objectForKey:KEY_VALIDSTATE] == NULL || [[kvPairs objectForKey:KEY_VALIDSTATE] boolValue] == FALSE)
    {
        [activePlane setHidden:FALSE];
        
        tipsLable.text = @"请输入激活码激活该应用";
    }
    
    //判断密钥是否已经激活
    if([[kvPairs objectForKey:KEY_VALIDSTATE] boolValue] == TRUE)
    {
        NSDate* date = [kvPairs objectForKey:KEY_VALIDDATE];
        NSDate *currentDate = [NSDate date];
        
        if ([currentDate compare:date] == NSOrderedDescending)
        {
            NSMutableDictionary *KVPairs = [NSMutableDictionary dictionary];
            [KVPairs setObject:@"FALSE" forKey:KEY_VALIDSTATE];
            
            [SLKeychain save:KEY_VALIDDATE_VALIDSTATE data:KVPairs];
            
            [activePlane setHidden:FALSE];
            
            tipsLable.text = @"请输入激活码激活该应用";
        }
    }
    
    
    NSMutableDictionary *kvPairs2 = (NSMutableDictionary *)[SLKeychain load:KEY_VALIDDATE_VALIDSTATE];
    
    if([[kvPairs2 objectForKey:KEY_VALIDSTATE] boolValue] == TRUE)
    {
        NSLog(@"StateN:  %@",[kvPairs2 objectForKey:KEY_VALIDSTATE]);

        [activePlane setHidden:TRUE];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//确认激活
- (IBAction)sureBt:(id)sender
{
    //获取User表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"User"];
    //查找User表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array)
        {
            if([numberInputText.text isEqualToString:[obj objectForKey:@"password"]])
            {
                //打印Name
               
                
                NSMutableDictionary *KVPairs = [NSMutableDictionary dictionary];
                [KVPairs setObject:[obj objectForKey:@"expirationtime"] forKey:KEY_VALIDDATE];
                NSDate* validDate = [obj objectForKey:@"expirationtime"];
                NSDate *currentDate = [NSDate date];
                
                NSLog(@"NOW:  %@",currentDate);
                NSLog(@"ValidDate:  %@",validDate);
                
                if ([currentDate compare:validDate]== NSOrderedAscending)
                {
                    [KVPairs setObject:@"TRUE" forKey:KEY_VALIDSTATE];
                    [activePlane setHidden:TRUE];
                }
                
                if ([currentDate compare:validDate]== NSOrderedDescending)
                {
                    [KVPairs setObject:@"FALSE" forKey:KEY_VALIDSTATE];
                    [activePlane setHidden:FALSE];
                    
                    tipsLable.text = @"该激活码已过期，请联系作者";
                }

                //保存密钥
                [SLKeychain save:KEY_VALIDDATE_VALIDSTATE data:KVPairs];
            }
            else
            {
                tipsLable.text = @"请输入正确的激活码";
            }
        }
    }];
}

@end
