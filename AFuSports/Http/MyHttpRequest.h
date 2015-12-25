//
//  MyHttpRequest.h
//  AFuSports
//
//  Created by chenshaohai on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@protocol HttpUtilDelegate;
@protocol AFMultipartFormData;

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);


@interface MyHttpRequest : NSObject
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;// 请求操作
@property (weak, nonatomic) id<HttpUtilDelegate> callbackObject;// 回调对象
@property (assign, nonatomic) BOOL handleResponse;// 是否处理响应
@property (assign, nonatomic) BOOL authorize;// 是否需要授权
@property (assign, nonatomic) BOOL headerAuthorize;//header验证
@property (assign, nonatomic) BOOL version;// 是否需要版本信息
@property (strong, nonatomic) NSMutableDictionary *requestParams;// 请求参数
@property (strong, nonatomic) NSMutableDictionary *headerAuthParams;// 头部验证参数
@property (copy, nonatomic) NSString *apiUrl;// 请求地址
@property (nonatomic, assign) NSInteger tag;// 请求标示
@property (nonatomic, strong) NSObject *formData;// formData数据
@property (nonatomic, strong) NSArray *fileData;// 文件数据
@property (nonatomic, copy) AFConstructingBlock constructingBodyBlock;// 构造请求数据的代码块
@property (nonatomic, strong) NSData *responseData;//
@property (nonatomic, copy) NSString *responseString;//

@end

