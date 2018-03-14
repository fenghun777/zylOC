//
//  ZyRouter.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyRouter.h"
#import "ZyBaseViewController.h"

@implementation ZyRouter

+ (void)route_pushController:(NSString *)routeStr{
    echo(@"界面跳转===%@", routeStr);
    if (routeStr != nil&&![routeStr isEqualToString:@""]) {
        NSArray *arrRoute = [routeStr componentsSeparatedByString:@"/"];
        NSString *route = arrRoute[0];
        NSString *dataStr = @"";
        if (arrRoute.count >= 2) {
            if ([route isEqualToString:@"web"]) {
                //            判断跳转到web
                dataStr = [routeStr substringFromIndex:4];
            }else{
                dataStr = arrRoute[1];
            }
        }
        
        NSString *controllerStr = [ZyRouter route_getControllerName:route];
        Class c = NSClassFromString([NSString stringWithFormat:@"%@", controllerStr]);
        ZyBaseViewController *basecontroller = [c new];
        
        UIViewController *vcRoot = [ZyRouter route_visibleViewController];
        if ([vcRoot isKindOfClass:[ZyBaseViewController class]]) {
            ZyBaseViewController *yvc = (ZyBaseViewController *)vcRoot;
            [yvc pushController:basecontroller];
            [basecontroller initData:dataStr];
        }else{
            UIViewController *yvc = (UIViewController *)vcRoot;
            [yvc.navigationController pushViewController:basecontroller animated:YES];
            [basecontroller initData:dataStr];
        }
    }else{
        echo(@"cmd路由为空");
    }
}

//下面两个函数获取当前控制器
+ (UIViewController *)route_visibleViewController{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIViewController *rootViewController = window.rootViewController;
    return [ZyRouter route_getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)route_getVisibleViewControllerFrom:(UIViewController *) vc{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [ZyRouter route_getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [ZyRouter route_getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [ZyRouter route_getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

+ (NSString *)route_getControllerName:(NSString *)route;{
    NSDictionary *dicController =@{
                                   @"Zy_Web":@"WebViewController",//跳转到网页
                                   @"Zy_Default":@"DefaultViewController",//跳转到默认网页
                                   };
    if ([dicController.allKeys containsObject:route]) {
        route = [NSString stringWithFormat:@"%@",dicController[route]];
    }else{
//        [YgUI showMessage:@"敬请期待"];
    }
    return route;
}

@end
