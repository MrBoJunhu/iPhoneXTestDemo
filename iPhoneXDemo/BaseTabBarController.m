//
//  BaseTabBarController.m
//  iPhoneXDemo
//
//  Created by BillBo on 2017/11/24.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "BaseTabBarController.h"

#import "CutNavigationController.h"

#import "ViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
  
    [super viewDidLoad];

    ViewController *vc = [[ViewController alloc] init];
    
    CutNavigationController *cutNav = [[CutNavigationController alloc] initWithRootViewController: vc];
    
    cutNav.tabBarItem.title = @"首页";
    
    cutNav.tabBarItem.selectedImage = [UIImage imageNamed:@"客户管理_green"];
    
    cutNav.tabBarItem.image = [UIImage imageNamed:@"客户管理_gray"];
    
    [self addChildViewController:cutNav];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
