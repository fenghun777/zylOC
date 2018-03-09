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

+ (void)nslogData:(id)response;

//MARK:模板
+ (void)api_BaseApi:(NSDictionary *)parameters onSuccess:(void (^)(ZyItemsModel *model))successBlcok onFail:(void (^)(NSError * fail))failBlcok;

@end
