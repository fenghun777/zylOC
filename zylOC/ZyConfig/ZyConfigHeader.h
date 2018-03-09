//
//  ZyConfigHeader.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#ifndef ZyConfigHeader_h
#define ZyConfigHeader_h

//这个文件定义所有的宏定义

#define CLIENT @"10"//安卓（20）还是iOS（10）

#define theAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]//获取AppDelegate

//MARK:iOS系统版本
#define IS_IOS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_IOS_10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_IOS_11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#define VERSION_CODE @"1" //提示更新的内部版本号


//所有的NSUserDefaults数据都在这里用宏来定义
//以下是登录缓存
#pragma mark - the Key's name of NSUserDefaults
#define UD_access_token       @"UD_access_token"
#define UD_id                 @"UD_id"
#define UD_username           @"UD_username"
#define UD_mobile             @"UD_mobile"

#define UD_deviceToken         @"UD_deviceToken"//推送需要deviceToken

//自这里开始 进入debug模式
//#define WWWDEBUG @"打开注释即可开启外网调试"

#ifndef DEBUG
#ifdef WWWDEBUG
#define API_HOST_API        @"https://www.zjwanchang.com"  //如果定义了WWWDEBUG，线上真实数据
#else
#define API_HOST_API        @"http://www.test.zjwanchang.com" //内网测试
#endif
#else
#define API_HOST_API        @"https://www.zjwanchang.com"  // 线上测试
#endif

#define API_HOST_IMG    @"https://img.zjwanchang.com/"

//有时间试验一下debug模式
#ifdef DEBUG
#define echo(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define echo(...)
#define debugMethod()
#endif

#endif /* ZyConfigHeader_h */
