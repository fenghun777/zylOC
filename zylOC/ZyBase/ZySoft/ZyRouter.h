//
//  ZyRouter.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyRouter : NSObject

/*!
 @method 跳转到相应控制器
 @brief 弹出框
 @param routeStr 跳转到相应界面的key
 @
 */
+ (void)zy_route_pushController:(NSString *)routeStr;

/**
 * @brief 获取当前控制器。
 */
+ (UIViewController *)zy_route_visibleViewController;

/**
 * @brief 判断当前控制器类型，并获得当前控制器。
 * @param vc 需要上传的信息。
 * @return 返回当前控制器
 */
+ (UIViewController *)zy_route_getVisibleViewControllerFrom:(UIViewController *) vc;

/**
 * @brief 获取跳转到的控制器的名称。
 * @param route 自定义的key，通过key获取控制器的名称
 * @return 成功执行返回需要到达的控制器的名称，否则返回空字符串@“”。
 */
+ (NSString *)zy_route_getControllerName:(NSString *)route;
@end
