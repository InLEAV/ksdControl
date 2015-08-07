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

    
    NSMutableDictionary *kvPairs = (NSMutableDictionary *)[SLKeychain load:KEY_VALIDDATE_VALIDSTATE];
    NSLog(@"Date:  %@",[kvPairs objectForKey:KEY_VALIDDATE]);
    NSLog(@"State:  %@",[kvPairs objectForKey:KEY_VALIDSTATE]);
    
    if([kvPairs objectForKey:KEY_VALIDSTATE] == NULL || [[kvPairs objectForKey:KEY_VALIDSTATE] boolValue] == FALSE)
    {
        [activePlane setHidden:FALSE];
        
        tipsLable.text = @"请输入激活码激活该应用";
    }
    
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

- (IBAction)sureBt:(id)sender
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"User"];
    //查找User表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array)
        {
            if([numberInputText.text isEqualToString:[obj objectForKey:@"password"]])
            {
                //打印Name
                NSLog(@"obj.name = %@", [obj objectForKey:@"name"]);
                //打印objectId,createdAt,updatedAt,expirationtime
                NSLog(@"obj.password = %@", [obj objectForKey:@"password"]);
                NSLog(@"obj.objectId = %@", [obj objectId]);
                NSLog(@"obj.expirationtime = %@", [obj objectForKey:@"expirationtime"]);
                NSLog(@"obj.updatedAt = %@", [obj updatedAt]);
                
                NSMutableDictionary *KVPairs = [NSMutableDictionary dictionary];
                [KVPairs setObject:[obj objectForKey:@"expirationtime"] forKey:KEY_VALIDDATE];
                NSDate* date = [KVPairs objectForKey:KEY_VALIDDATE];
                NSDate *currentDate = [NSDate date];
                if ([currentDate compare:date]== NSOrderedAscending)
                {
                    [KVPairs setObject:@"TRUE" forKey:KEY_VALIDSTATE];
                    [activePlane setHidden:TRUE];
                }
                
                if ([currentDate compare:date]== NSOrderedDescending)
                {
                    [KVPairs setObject:@"FALSE" forKey:KEY_VALIDSTATE];
                    [activePlane setHidden:FALSE];
                    
                    tipsLable.text = @"该激活码已过期，请联系作者";
                }

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
