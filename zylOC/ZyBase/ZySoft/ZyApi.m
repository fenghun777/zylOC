//
//  ZyApi.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyApi.h"
#import "ZyConstant.h"

@implementation ZyApi

+ (void)nslogData:(id)response{
    id data = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *arr = data;
        echo(@"得到的数据是数组:%@",arr);
    }else if ([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = data;
        echo(@"得到的数据是字典:%@",dic);
    }else {
        echo(@"得到的数据是未知格式:%@",data);
    }
}

//MARK:模板
+ (void)api_BaseApi:(NSDictionary *)parameters onSuccess:(void (^)(ZyItemsModel *model))successBlcok onFail:(void (^)(NSError * fail))failBlcok{
    [ZyNetwork httpRequestTask:HTTPRequestMethod_GET withUrl:[ZyConstant urlWithKey:@"API"] withData:parameters notifiyError:YES onSuccess:^(id response) {
        [self nslogData:response];
        //        NSArray *arrModel = [ZyItemsModel mj_objectArrayWithKeyValuesArray:response];
        ZyItemsModel *model = [ZyItemsModel mj_objectWithKeyValues:response];
        if (successBlcok) {
            successBlcok(model);
        }
    } onFail:^(NSError *fail) {
        if (failBlcok) {
            failBlcok(fail);
        }
    }];
}

+ (void)api_Signature:(NSDictionary *)parameters onSuccess:(void (^)(NSArray *arr))successBlcok onFail:(void (^)(NSError * fail))failBlcok{
    [ZyNetwork httpRequestTask:HTTPRequestMethod_POST withUrl:@"http://192.168.1.162:8000/api/v2/Home/signature" withData:parameters notifiyError:YES onSuccess:^(id response) {
        [self nslogData:response];
        NSArray *arrData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        if (successBlcok) {
            successBlcok(arrData);
        }
    } onFail:^(NSError *fail) {
        if (failBlcok) {
            failBlcok(fail);
        }
    }];
}















































@end
