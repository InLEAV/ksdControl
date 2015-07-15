//
//  ComputerControl.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComputerVO.h"
@protocol computerDelegate <NSObject>
- (void)sendUDPDataComputerCommand:(NSData *)command toPort:(NSInteger)port toHost:(NSString *)host;
- (void)sendUDPComputerCommand:(NSString *)command toPort:(NSInteger)port toHost:(NSString *)host;
@end

@interface ComputerControl : UICollectionViewCell
{
   unsigned char mac[6];
   unsigned char packet[102];
}

@property(nonatomic, retain) ComputerVO * VO;

@property (nonatomic, retain) id <computerDelegate> delegate;

//背景
@property (strong, nonatomic) UIImageView* backgroup;

//文本允许动态改变标题
@property (strong, nonatomic) UILabel* label;

//允许打开电脑
@property (strong, nonatomic) UIButton* openBtn;

//允许关闭电脑
@property (strong, nonatomic) UIButton* closeBtn;

//打开电脑
-(void)openComputer:(id)sender;

//关闭电脑
-(void)closeComputer:(id)sende;

-(void)updatePacket:(NSString *)mac;
@end
