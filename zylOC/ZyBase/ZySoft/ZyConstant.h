//
//  ZyConstant.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyConstant : NSObject

/**
 * @brief 获取接口。
 * @param key 自定义的key，通过key获取接口字段
 * @return 成功执行返回接口的名称，否则返回未拼接的接口。
 */
+ (NSString *)urlWithKey:(NSString *)key;

/**
 * @brief 获取接口。
 * @param key 自定义的key，通过key获取接口字段
 * @param param 需要拼接的参数，拼接到接口后面？之前 https://www.zjwanchang.com/zyy/123?id=12&er=100
 * @return 成功执行返回接口的名称，否则返回未拼接的接口。
 */
+ (NSString *)urlWithKey:(NSString *)key andParam:(NSString *)param;
@end
