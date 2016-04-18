//
//  EnterPasswordConrtolViewController.h
//  ksdControl
//
//  Created by CMQ on 15/9/17.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterPasswordConrtolViewController : UIViewController



@property (strong, nonatomic) IBOutlet UILabel *tipsLable;

@property (strong, nonatomic) IBOutlet UITextField *passwordFieldtext;

- (IBAction)okBt:(id)sender;
@end
