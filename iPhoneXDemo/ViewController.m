//
//  ViewController.m
//  iPhoneXDemo
//
//  Created by BillBo on 2017/11/24.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>

#define weakify(x) autoreleasepool{} __weak typeof(x) weak##x= x;
@interface ViewController ()

@property (nonatomic, strong) UITableView * tbv;

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"测试";
    
    self.tbv = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:self.tbv];
    
    self.tbv.backgroundColor = [UIColor whiteColor];

    @weakify(self);
    
    self.tbv.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        
        [weakself stopRefresh];
        
    }];

    [self.tbv.mj_header beginRefreshing];
    
}

- (void)stopRefresh {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
