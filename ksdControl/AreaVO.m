//
//  AreaVO.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "AreaVO.h"

@implementation AreaVO

@synthesize groups;

-(void)initVO
{
    [super initVO];
    groups = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i = 0; i < groups.count; i++) {
        VO * aa;
        aa=(VO *) groups[i];
        //NSLog(@"groupSon:%d",i);
        [aa initVO];
    }
    
}
@end
