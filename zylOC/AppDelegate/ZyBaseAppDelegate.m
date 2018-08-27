//
//  ZyBaseAppDelegate.m
//  jkbs_train
//
//  Created by iosdev1 on 16/8/25.
//  Copyright © 2016年 iosdev1. All rights reserved.
//

#import "ZyBaseAppDelegate.h"

@interface ZyBaseAppDelegate ()

@end

@implementation ZyBaseAppDelegate

// 程序完成加载  创建window窗口
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}


//当点击command+H时,程序取消激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    echo(@"程序取消激活状态");
}

//程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    echo(@"程序进入后台");
}

//点击进入工程,程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    echo(@"点击进入工程,程序进入前台");
}

//程序被激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    echo(@"程序被激活");
}

//当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值
- (void)applicationWillTerminate:(UIApplication *)application {
    echo(@"程序将要退出");
}


@end
