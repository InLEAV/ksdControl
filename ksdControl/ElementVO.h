//
//  ElementVO.h
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "VO.h"

@interface ElementVO : VO
{
    NSString * ip,* aType;
    int port;
}

@property int port;
@property NSString* ip, * aType;

@end
