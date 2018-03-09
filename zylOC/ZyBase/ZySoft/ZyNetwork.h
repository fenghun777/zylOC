//
//  ZyNetwork.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFURLSessionManager.h"

typedef enum {
    HTTPRequestMethod_GET,
    HTTPRequestMethod_PUT,
    HTTPRequestMethod_POST,
    HTTPRequestMethod_DELETE,
    HTTPRequestMethod_PATCH
}HTTPRequestMethod;

@interface ZyNetwork : NSObject

/*!
 @method
 @brief HTTP 请求(方法包括GET/POST/PUT/PATCH/DELETE)
 @
 @param method 参考 HTTPRequestMethod
 @param url 请求地址
 @param parameters 请求参数
 @param notifyError 是否显示服务器本身返回的错误消息
 @param success 返回成功响应
 @param fail 返回失败响应
 @
 */
+ (void) httpRequestTask:(HTTPRequestMethod)method withUrl:(NSString *)url withData:(NSDictionary *)parameters notifiyError:(BOOL) notifyError onSuccess:(void (^)(id response))success onFail:(void (^)(NSError * fail))fail;

/*!
 @method
 @brief HTTP 请求(方法包括GET/POST/PUT/PATCH/DELETE)
 @
 @param method 参考 HTTPRequestMethod
 @param url 请求地址
 @param parameters 请求参数
 @param notifyError 是否显示服务器本身返回的错误消息
 @param success 返回成功响应
 @param fail 返回失败响应
 @
 */
+ (void) httpRequestJson:(HTTPRequestMethod)method withUrl:(NSString *)url withData:(NSDictionary *)parameters notifiyError:(BOOL) notifyError onSuccess:(void (^)(id data))success onFail:(void (^)(NSError * fail))fail;

@end
