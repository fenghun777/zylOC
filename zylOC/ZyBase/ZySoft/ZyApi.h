//
//  ZyApi.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZyBaseModel.h"//基础model
#import "ZyItemsModel.h"//带分页的model

@interface ZyApi : NSObject

/**
 * @brief 打印接口返回的数据。
 * @param response 接口数据
 */
+ (void)nslogData:(id)response;

/**
 * @brief 接口模板。
 * @param parameters 需要传入的参数
 * @param successBlcok 成功执行的block
 * @param failBlcok 失败执行的block
 */
+ (void)api_BaseApi:(NSDictionary *)parameters onSuccess:(void (^)(ZyItemsModel *model))successBlcok onFail:(void (^)(NSError * fail))failBlcok;

@end
