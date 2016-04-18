//
//  GroupVO.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "GroupVO.h"

@implementation GroupVO

@synthesize elements;

-(void)initVO
{
    [super initVO];
    elements = [[NSMutableArray alloc] initWithObjects:nil];
    
    for (int i = 0; i < elements.count; i++) {
        VO * aa;
        aa=(VO *) elements[i];
       // NSLog(@"groupSon:%d",i);
        [aa initVO];
    }
   
}

@end
