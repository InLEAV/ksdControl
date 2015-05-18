//
//  SetViewController.m
//  ksdControl
//
//  Created by HANQING on 15/4/28.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "SetViewController.h"
#import "ElementViewController.h"
#import "GroupViewController.h"
#import "AreaViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

//GroupViewController* groupViewController;
//AreaViewController* areaViewController;
//ElementViewController* elementViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // elementViewController = [[ElementViewController alloc]init];
    
    //groupViewController = [[GroupViewController alloc]init];
    //groupViewController = [self.tabBarController.viewControllers objectAtIndex:1];

    
   // areaViewController = [[AreaViewController alloc]init];
//    areaViewController = [self.tabBarController.view.subviews objectAtIndex:2];
//
    
//    self.tabBarController.viewControllers=[[NSArray alloc]initWithObjects:elementViewController,groupViewController,areaViewController,nil];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabbar didSelectItem:(UITabBarItem *)item
{
    
   if( tabbar.selectedItem.tag == 1)
   {
        //[groupViewController UpdateElementTableView];
        NSLog(@"TabBar tag 1!");
   }
   if (tabbar.selectedItem.tag == 2)
    {
        //[areaViewController UpdateGroupTableView];
        NSLog(@"TabBar tag 2!");
    }
}


+(void)showUIAlertView:(NSString*)title content:(NSString*)msg buttonTitle:(NSString*)btTitle;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:btTitle otherButtonTitles:nil];
    [alert show];
}

@end
