//
//  JsonControl.m
//  ksdControl
//
//  Created by CMQ on 15/5/22.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "JsonControl.h"

@interface JsonControl ()

@end

@implementation JsonControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//json文件写入，保存数据
+(void) jsonWrite:(NSMutableDictionary*) mutableDict FileName:(NSString*)fileName
{
    //将Json保存到本地
    NSError *error = nil;
    
    NSData *JsonData = [NSJSONSerialization dataWithJSONObject:mutableDict options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error)
    {
        NSLog(@"Error %@",[error localizedDescription]);
    }
    
    //Json文件路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:  [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@.json",fileName]]];
    NSLog(@"%@",Json_path);
    
    //写入文件
    NSLog(@"%@",[JsonData writeToFile:Json_path atomically:YES] ? @"Save Json Succeed":@"Save Json Failed");

}

//Json文件读取并返回字典
+(NSDictionary*) jsonRead:(NSString*)fileName
{
    NSDictionary *mutableDict=[NSDictionary dictionary];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@.json",fileName]]];

    
    //Json数据
    NSData *data=[NSData dataWithContentsOfFile:Json_path];
    
    NSError *error=nil;
    
    mutableDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
       //NSDictionary *weatherInfo = [weatherDic objectForKey"weatherinfo"];
    
    return mutableDict;
}

@end
