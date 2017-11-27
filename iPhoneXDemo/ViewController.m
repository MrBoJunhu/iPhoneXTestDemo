//
//  ViewController.m
//  iPhoneXDemo
//
//  Created by BillBo on 2017/11/24.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
static NSString *AppStoreAppID = @"1098674572";

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
    
    
    //详情url
//    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", AppStoreAppID];

    NSString *version =  [self getVersionWithAppID:AppStoreAppID];
    

    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", AppStoreAppID];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:nil completionHandler:^(BOOL success) {
       
        
    }];
    
    @weakify(self);
    
    self.tbv.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        
        [weakself stopRefresh];
        
    }];

    [self.tbv.mj_header beginRefreshing];
    
}

- (NSString *)getVersionWithAppID:(NSString *)appid {
    
   __block  NSString *version = @"";
    
    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", appid];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    
    sessionManager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [sessionManager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *tempDic = [[NSDictionary alloc] initWithDictionary:dic];
        
        NSLog(@"tempDic : \n %@", tempDic);
        
        NSArray *arr = [tempDic objectForKey:@"results"];
        
        NSDictionary *resultDic = (NSDictionary *)arr.firstObject;
        
        NSString *version = [resultDic objectForKey:@"version"];
        
        NSLog(@"appstroeVersion : %@" ,version);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    return version;
    
}

- (BOOL)needUpdateNewestVersion:(NSString *)version {
   
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    
    if (version.floatValue > currentVersion.floatValue) {
        
        return YES;
        
    }else{
        
        return NO;
        
    }
    
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
