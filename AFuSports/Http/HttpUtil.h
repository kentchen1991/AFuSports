//
//  HttpUtil.h
//  AFuSports
//
//  Created by chenshaohai on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyHttpRequest.h"
#import "AFHTTPRequestOperationManager.h"
@protocol HttpUtilDelegate <NSObject>
@optional
- (void)uploadFail:(MyHttpRequest *)request;
- (void)uploadStart:(MyHttpRequest *)request;
- (void)uploadFinish:(MyHttpRequest *)request;
@end

@interface HttpUtil : NSObject

/**
*  GET请求
*
*  @param postUrl          url字符串
*  @param formData         get数据
*  @param fileData         get的文件数组
*  @param authorize 是否需要用户登录授权
*  @param callbackObject   回调对象
*  @param requestTag       请求的tag,用来区分不同的请求
*  @param version        是否需要版本检查
*  @param handleResponse 是否处理响应
*
*/
+ (MyHttpRequest *) getWithURL:(NSString *)url
                         formData:(NSObject *)formData
                         fileData:(NSArray *)fileData
                            headerAuthorize:(BOOL)headerAuthorize
                   callbackObject:(id<HttpUtilDelegate> )callbackObject
                    requestTag:(NSInteger)tag
                       version:(BOOL)version
                handleResponse:(BOOL)handleResponse;

/**
 *  简单POST请求
 *
 *  @param postUrl          url字符串
 *  @param formData         post数据
 *  @param fileData         post的文件数组
 *  @param authorize 是否需要用户登录授权
 *  @param callbackObject   回调对象
 *  @param requestTag       请求的tag,用来区分不同的请求
 */
+ (MyHttpRequest *) uploadWithURL:(NSString *)url
                         formData:(NSObject *)formData
                         fileData:(NSArray *)fileData
                        authorize:(BOOL)authorize
                   callbackObject:(id<HttpUtilDelegate> )callbackObject
                       requestTag:(NSInteger)tag;


/**
 *  可定制的POST请求
 *
 *  @param url              请求的URL
 *  @param formData         请求数据，可以是NSDictionary，NSString，JSONModel类型
 *  @param fileData         上传的文件数组
 *  @param authorize        是否需要授权
 *  @param version          是否需要版本检查
 *  @param callbackObject   回调对象，对象可以按需要实现HttpUtilDelegate协议
 *  @param tag              请求标示，用来区分不同的请求
 *  @param handleResponse   是否处理响应
 */
+ (MyHttpRequest *)  uploadWithURL:(NSString *)url
                          formData:(NSObject *)formData
                          fileData:(NSArray *)fileData
                         authorize:(BOOL)authorize
                    callbackObject:(id<HttpUtilDelegate> )callbackObject
                        requestTag:(NSInteger)tag
                           version:(BOOL)version
                    handleResponse:(BOOL)handleResponse;




/**
 *  取消某个请求
 *
 *  @param request
 */
- (void)cancelRequest:(MyHttpRequest *)request;


/**
 *  取消所有请求
 */
- (void)cancelAllRequests;



// 设置是否正在处理异常
+ (void)setHandlingUnusual:(BOOL)b;
@end
