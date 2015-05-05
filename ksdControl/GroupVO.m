//
//  GroupVO.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "GroupVO.h"

@implementation GroupVO

@synthesize groups;

-(void)initVO
{
    [super initVO];
    for (int i = 0; i < groups.count; i++) {
        VO * aa;
        aa=(VO *) groups[i];
        NSLog(@"groupSon:%d",i);
        [aa initVO];
    }
   
}

@end
