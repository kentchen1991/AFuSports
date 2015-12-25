//
//  HttpUtil.m
//  AFuSports
//
//  Created by chenshaohai on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HttpUtil.h"

@implementation HttpUtil {
    NSMutableDictionary *_requestsRecord;
    AFHTTPRequestOperationManager *_operationManager;
}

+ (HttpUtil *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init {
    self = [super init];
    if (self) {
        _requestsRecord = [NSMutableDictionary dictionary];
        _operationManager = [AFHTTPRequestOperationManager manager];
        _operationManager.operationQueue.maxConcurrentOperationCount = 4;
        _operationManager.requestSerializer.timeoutInterval = 60;
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    return self;
}

+ (MyHttpRequest *) getWithURL:(NSString *)url
                      formData:(NSObject *)formData
                      fileData:(NSArray *)fileData
               headerAuthorize:(BOOL)headerAuthorize
                callbackObject:(id<HttpUtilDelegate> )callbackObject
                    requestTag:(NSInteger)tag
                       version:(BOOL)version
                handleResponse:(BOOL)handleResponse {
    /**
     *  创建请求，设置参数
     */
    MyHttpRequest *request = [[MyHttpRequest alloc] init];
    request.apiUrl = url;
    request.callbackObject = callbackObject;
    request.tag = tag;
    request.headerAuthorize = headerAuthorize;
    request.handleResponse = handleResponse;
    request.version = version;
    request.formData = formData;
    request.fileData = fileData;
    
    AFHTTPRequestOperationManager *manager = [HttpUtil sharedInstance]->_operationManager;
    request.requestOperation = [manager GET:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
     [[HttpUtil sharedInstance] addOperation:request];
    
    // 传给回调对象
    if ([callbackObject respondsToSelector:@selector(uploadStart:)]) {
        [callbackObject uploadStart:request];
    }
    
    return request;
}

- (NSString *)requestHashKey:(AFHTTPRequestOperation *)operation {
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[operation hash]];
    return key;
}

- (void)removeOperation:(AFHTTPRequestOperation *)operation {
    NSString *key = [self requestHashKey:operation];
    @synchronized(self) {
        [_requestsRecord removeObjectForKey:key];
    }
//    DLog(@"Request queue size = %lu", (unsigned long)[_requestsRecord count]);
}

- (void)addOperation:(MyHttpRequest *)request {
    if (request.requestOperation != nil) {
        NSString *key = [self requestHashKey:request.requestOperation];
        @synchronized(self) {
            _requestsRecord[key] = request;
        }
    }
}

- (void)handleRequestResult:(AFHTTPRequestOperation *)operation success:(BOOL)success
{
    NSString *key = [self requestHashKey:operation];
    MyHttpRequest *request = _requestsRecord[key];
    
    // 从操作队列中移除请求操作
    [self removeOperation:operation];
    
    
    // 打印日志
#ifdef DEBUG
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    [logString appendFormat:@"ApiUrl:\t\t%@\n", request.apiUrl];
    [logString appendFormat:@"Request:\t\t%@\n", request.requestParams];
    [logString appendFormat:@"Response:\t\t%@\n", [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
    NSLog(@"%@",logString);
    
#endif
    // 如果不需要处理响应数据
    if (request.handleResponse == NO) {
        return;
    }
    
    // 如果请求已取消
    if (operation.cancelled) {
        return;
    }
    
    
    
    if (success == NO) {
        // 请求失败
        // 传给回调对象
        id callbackObject =  request.callbackObject;
        if ([callbackObject respondsToSelector:@selector(uploadFail:)]) {
            [callbackObject uploadFail:request];
        }
        
    } else {
        // 传给回调对象
        id callbackObject =  request.callbackObject;
        if ([callbackObject respondsToSelector:@selector(uploadFinish:)]) {
            [callbackObject uploadFinish:request];
        }
    }
    
}
@end
