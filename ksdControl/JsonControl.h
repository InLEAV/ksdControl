//
//  JsonControl.h
//  ksdControl
//
//  Created by CMQ on 15/5/22.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsonControl : UIViewController

//json文件写入，保存数据
+(void) jsonWrite:(NSMutableDictionary*)mutableDict FileName:(NSString*)fileName;

//Json文件读取并返回字典
+(NSDictionary*) jsonRead:(NSString*)fileName;

@end
