//
//  ViewController.m
//  AFuSports
//
//  Created by apple on 15/12/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "NSString+Helper.h"
#import "ApiDetail.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor redColor];
    [self getCodeTest];
}

- (void)getCodeTest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置返回类型
    NSString *urlkey = [NSString stringWithFormat:@"/api/member/captcha/%@/%@",@"login",@"13400645310"];
    [self addHeaderTokenWithRequest:manager.requestSerializer andUrlString:urlkey];
    NSLog(@"%@",manager.requestSerializer.HTTPRequestHeaders);
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    NSString *baseurl = [NSString stringWithFormat:@"%@%@",AFuBaseAPI,urlkey];
    [manager GET:baseurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", operation.responseString);
        // 提问:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        NSLog(@"%@", [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)addHeaderTokenWithRequest:(AFHTTPRequestSerializer*)request andUrlString:(NSString*)urlStr {
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
    [request setValue:@"APP" forHTTPHeaderField:@"Api-Id"];
    [request setValue:timeStr forHTTPHeaderField:@"Api-Timestamp"];
    [request setValue:[NSString sha256:[NSString stringWithFormat:@"%@%@%@%@",@"APP",urlStr,timeStr,privateKey]] forHTTPHeaderField:@"Api-Sign"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
