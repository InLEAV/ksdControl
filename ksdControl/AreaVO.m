//
//  AreaVO.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "AreaVO.h"

@implementation AreaVO

@synthesize areas;

-(void)initVO
{
    [super initVO];
    for (int i = 0; i < areas.count; i++) {
        VO * aa;
        aa=(VO *) areas[i];
        NSLog(@"groupSon:%d",i);
        [aa initVO];
    }
    
}
@end
