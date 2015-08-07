//
//  ViewController.h
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
}
@property (strong, nonatomic) IBOutlet UIView *activePlane;

@property (strong, nonatomic) IBOutlet UILabel *pavilionNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *tipsLable;

@property (strong, nonatomic) IBOutlet UITextField *numberInputText;

- (IBAction)sureBt:(id)sender;


@end
