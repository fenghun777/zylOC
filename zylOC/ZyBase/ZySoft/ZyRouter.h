//
//  ZyRouter.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyRouter : NSObject

//跳转到相应控制器
+ (void)route_pushController:(NSString *)routeStr;

//获取当前控制器
+ (UIViewController *)route_visibleViewController;

//判断当前控制器类型，并获得当前控制器
+ (UIViewController *)route_getVisibleViewControllerFrom:(UIViewController *) vc;

//获取跳转到的控制器的名称
+ (NSString *)route_getControllerName:(NSString *)route;
@end
