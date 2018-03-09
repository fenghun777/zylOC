//
//  ZyRouter.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyRouter : NSObject
+ (void)route_pushController:(NSString *)routeStr;
+ (UIViewController *)route_visibleViewController;
+ (UIViewController *)route_getVisibleViewControllerFrom:(UIViewController *) vc;

+ (NSString *)route_getControllerName:(NSString *)route;
@end
