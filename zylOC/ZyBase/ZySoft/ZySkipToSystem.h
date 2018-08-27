//
//  ZySkipToSystem.h
//  GuangGaoRen
//
//  Created by 张钰营 on 2018/6/28.
//  Copyright © 2018年 hhdz. All rights reserved.
//

#import <Foundation/Foundation.h>

//标识
//然而跳到WiFi界面会被拒


//跳转到系统的各个界面
//最新的跳转方式 ：
//方式一：prefs:root=某项服务
//方式二：prefs:root=bundleID
//方式三： UIApplicationOpenSettingsURLString
@interface ZySkipToSystem : NSObject

+ (void)zy_SkipToSystemWIFI;

+ (void)zy_SkipToSystemLOCATION_SERVICES;

+ (void)zy_SkipToSystemBluetooth;

+ (void)zy_SkipToSystemNOTIFICATIONS_ID;
@end
