//
//  ZyConstant.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyConstant.h"

@implementation ZyConstant
+ (NSString *)urlWithKey:(NSString *)key{
    key = [self getUrlDict:key];
    return key;
}

+ (NSString *)urlWithKey:(NSString *)key andParam:(NSString *)param{
    key = [self getUrlDict:key];
    key = [NSString stringWithFormat:@"%@/%@", key, param];
    return key;
}

+ (NSString *) getUrlDict:(NSString *)key{
    NSDictionary *dicUrl = @{
#pragma mark Common部分
                             @"auth_account_login":@"/auth/account-login",//帐号登录
                             
                             
#pragma mark My部分
                             
#pragma mark ChatList部分

                             
#pragma mark Classfy部分

                             
#pragma mark cart部分
                             
#pragma mark purchase部分
                             
                             };
    if ([dicUrl.allKeys containsObject:key]) {
        key = [NSString stringWithFormat:@"%@%@",API_HOST_API,dicUrl[key]];
    }else{
//        [YgUI showMessage:@"url拼接错误"];
        key = API_HOST_API;
    }
    
    return key;
}

@end
