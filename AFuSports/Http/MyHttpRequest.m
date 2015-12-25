//
//  MyHttpRequest.m
//  AFuSports
//
//  Created by chenshaohai on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyHttpRequest.h"

#import "AFHTTPRequestOperation.h"
#import "HttpUtil.h"



@implementation MyHttpRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestParams = [[NSMutableDictionary alloc] init];
    }
    return self;
}



- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> afFormData) {
        // loginSign
        if (self.authorize == YES) {
        }
        // formData
        NSMutableString *formDataStr = nil;
        if (self.formData != nil) {
        }
        // sign
        if (formDataStr != nil) {
        
        }
        
        // 文件
        for (id content in self.fileData) {
        }
    };
}


- (NSData *)responseData
{
    return self.requestOperation.responseData;
}

- (NSString *)responseString
{
    return self.requestOperation.responseString;
}

#pragma mark - GetterAndSetter
- (void)setHeaderAuthorize:(BOOL)headerAuthorize {
    self.headerAuthorize = headerAuthorize;
    
}

@end
