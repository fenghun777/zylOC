//
//  ZyNetwork.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyNetwork.h"
#import "AppDelegate.h"
#import "ZyErrorModel.h"

@implementation ZyNetwork
+ (void) httpRequestTask:(HTTPRequestMethod)method withUrl:(NSString *)url withData:(NSDictionary *)parameters notifiyError:(BOOL) notifyError onSuccess:(void (^)(id response))success onFail:(void (^)(NSError * fail))fail{
    
    AFNetworkReachabilityManager*netStatus = [AFNetworkReachabilityManager sharedManager];
    [netStatus startMonitoring];
    
    [netStatus setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            if (fail) {
                fail(nil);
            }
//            [ZyUI showMessage:@"网络连接失败"];
        }else if (status == AFNetworkReachabilityStatusUnknown){
//            [ZyUI showMessage:@"网络错误，网络不可用"];
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            //            [ZyUI showMessage:@"正在使用无线网络"];
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            //            [ZyUI showMessage:@"正在使用到wifi"];
        }
    } ];
    
    //    parameters = [YgUtils clientPrepareHttpParameters:[parameters mutableCopy]];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:CLIENT forHTTPHeaderField:@"client"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:UD_access_token];
    if(token != nil && ![token isEqualToString:@""]){
//        把Token放入请求头
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"access-token"];
    }

    echo(@"headers内的参数：%@", manager.requestSerializer.HTTPRequestHeaders);
    void (^r_success)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject){
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        echo(@"打印网址：%@",[NSString stringWithFormat:@"%@",response.URL]);
        //        echo(@"headers内的参数：%@", [response allHeaderFields]);
        switch (statusCode) {
            case 200:{
                echo(@"请求成功");
            }
                break;
            case 201:{
                echo(@"创建成功");
            }
                break;
            default:{
                echo(@"自定义");
                if(notifyError){
                    
                }
            }
                break;
        }
        if (success) {
            success(responseObject);
        }
        if (statusCode == 201 || statusCode == 204){
            return;
        }
    };
    
    void (^r_failure)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject){
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        echo(@"打印网址：%@",[NSString stringWithFormat:@"%@",response.URL]);
        NSError *error = (NSError *)responseObject;
        
        //        id errorInfo = error.userInfo;
        //        if ([errorInfo isKindOfClass:[NSDictionary class]]) {
        //            echo(@"这是错误的网址：%@", errorInfo[@"NSErrorFailingURLKey"]);
        //            echo(@"这是错误的代号：%@", errorInfo[@"NSLocalizedDescription"]);
        //            NSData *dataError = errorInfo[@"com.alamofire.serialization.response.error.data"];
        //
        //            id errorData = [NSJSONSerialization JSONObjectWithData:dataError options:NSJSONReadingMutableContainers error:nil];
        //            echo(@"%@", errorData);
        //            echo(@"%@", errorInfo[@"com.alamofire.serialization.response.error.response"]);
        //        }else{
        //            echo(@"错误不是字典");
        //        }
        switch (statusCode) {
            case 400:{
                ZyErrorModel *eModel = [ZyErrorModel mj_objectWithKeyValues:error.userInfo[@"com.alamofire.serialization.response.error.data"]];
//                [ZyUI showMessage:eModel.message];
                echo(@"自定义错误:%@",eModel.message);
            }
                break;
            case 401:{
                echo(@"未登录");
                [theAppDelegate signInApp];//需要引入头文件
                return ;
            }
                break;
            case 403:{
                echo(@"没有权限");
            }
                break;
            case 404:{
                echo(@"请求的资源没有找到");
            }
                break;
            case 405:{
                echo(@"不支持此方法");
            }
                break;
            case 422:{
                echo(@"数据格式验证失败");
            }
                break;
            case 500:{
//                [ZyUI showMessage:@"服务器错误"];
                echo(@"服务器错误");
            }
                break;
            case 502:{
                echo(@"网关错误");
            }
                break;
            case 503:{
                echo(@"当前服务不可用");
            }
                break;
            case 504:{
                echo(@"请求超时");
            }
                break;
            default:{
                echo(@"自定义错误,错误详情见message字段");
                if(notifyError){
                    echo(@"检查是否是https证书不正确，改成http，再次尝试");
                    echo(@"%@", error);
                }
            }
                break;
        }
        if (fail) {
            fail(responseObject);
        }
    };
    
    // Get，post请求才有
    void (^r_progress)(NSProgress *downloadProgress) = ^(NSProgress *downloadProgress){
        echo(@"Get，post请求才有的进程：%@",downloadProgress);
    };
    
    // post请求才有
    void (^r_constructingBodyWithBlock)(id formData) = ^(id formData){
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        echo(@"post请求才有拼接Body%@",formData);
        
    };
    
    if (method == HTTPRequestMethod_PATCH) {
        echo(@"PATCH请求方式");
        [manager PATCH:url parameters:parameters success:r_success failure:r_failure];
    }else if (method == HTTPRequestMethod_PUT){
        echo(@"PUT请求方式");
        [manager PUT:url parameters:parameters success:r_success failure:r_failure];
    }else if (method == HTTPRequestMethod_DELETE){
        echo(@"DELETE请求方式");
        [manager DELETE:url parameters:parameters success:r_success failure:r_failure];
    }else if (method == HTTPRequestMethod_GET){
        echo(@"GET请求方式");
        [manager GET:url parameters:parameters progress:r_progress success:r_success failure:r_failure];
    }else if(method == HTTPRequestMethod_POST){
        echo(@"POST请求方式");
        NSMutableDictionary *newDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        echo(@"post的参数：%@", newDic);
        echo(@"post的网址：%@", url);
        [manager POST:url parameters:newDic constructingBodyWithBlock:r_constructingBodyWithBlock progress:r_progress success:r_success failure:r_failure];
    }
}

+ (void) httpRequestJson:(HTTPRequestMethod)method withUrl:(NSString *)url withData:(NSDictionary *)parameters notifiyError:(BOOL) notifyError onSuccess:(void (^)(id data))success onFail:(void (^)(NSError * fail))fail{
//    parameters = [YgUtils clientPrepareHttpParameters:[parameters mutableCopy]];
    NSDictionary *dic = parameters;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSData *postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            //            获得的json先转换成字符串
            NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (success) {
                success(receiveStr);
            }
            //            echo(@"%@", receiveStr);
            //            NSString *str = [receiveStr substringFromIndex:9];
            ////            字符串再生成NSData
            //            NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
            ////            再解析
            //            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //            NSLog(@"jsonDict: %@", jsonDict);
            
            //            id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            //            NSLog(@"data: %@", data);
        } else {
            id data = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            echo(@"失败的数据:%@",data);
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)data;
                if ([dic.allKeys containsObject:@"message"]) {
//                    [ZyUI showMessage:dic[@"message"]];
                }
            }
            if (fail) {
                fail(data);
            }
        }
    }] resume];//至此这个问题算是解决了，也可以正常拿到后台返回的数据。
}

@end
