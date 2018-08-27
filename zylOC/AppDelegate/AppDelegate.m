
//  AppDelegate.m
//  jkbs_train
//
//  Created by iosdev1 on 16/8/25.
//  Copyright © 2016年 iosdev1. All rights reserved.
//

#import "AppDelegate.h"
#import "ZyBaseViewController.h"
#import "SignInViewController.h"
#import <UserNotifications/UserNotifications.h>

#import <AMapFoundationKit/AMapFoundationKit.h>

#import "MineViewController.h"

#import "ZyTabBarController.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate, UITabBarDelegate, JPUSHRegisterDelegate>

@end

@implementation AppDelegate

// 程序完成加载  创建window窗口
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [super application:application didFinishLaunchingWithOptions:launchOptions];
//    判断是否联网
    [self setIsLinking];
//    设置极光推送
    [self setJPushApplication:application andOptions:launchOptions];
//    设置高德地图
    [self setAMapData];
    
//    进入app主界面
    [self enterApp];
    
    return YES;
}


//MARK: 当点击command+H时,程序取消激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    [super applicationWillResignActive:application];
}

//MARK: 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [super applicationDidEnterBackground:application];
//    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

//MARK: 点击进入工程,程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [super applicationWillEnterForeground:application];
//    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

//MARK: 程序被激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [super applicationDidBecomeActive:application];
}

//MARK: 当程序将要退出时被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值
- (void)applicationWillTerminate:(UIApplication *)application {
    [super applicationWillTerminate:application];
}

// MARK: 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    echo(@"devicetoken===%@",deviceToken);

    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@", deviceToken];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSUserDefaults *userdefauts = [NSUserDefaults standardUserDefaults];
    [userdefauts setObject:deviceTokenStr forKey:UD_deviceToken];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //[[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
    echo(@"===devicetoken===%@",deviceTokenStr);
    
    [JPUSHService registerDeviceToken:deviceToken];
}
// MARK: 实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    echo(@"%@", error);
    [ZyRouter zy_route_visibleViewController];
}

//MARK: 只是在程序处于运行状态和前台状态调用，但是你强制杀死程序之后，来了远程推送，系统不会自动进入你的程序，这个时候application:didReceiveRemoteNotification:就不会被调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", userInfo);
    [self onReceiveZyMessage:userInfo];
}
//MARK: 那么当你手动进入程序（或者点击系统的推送提示），当程序launch完毕之后，就会调用- application:didReceiveRemoteNotification:fetchCompletionHandler:
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", userInfo);
    [self onReceiveZyMessage:userInfo];
}

//MARK:当运行再后台的时候，会有弹窗提示用户另外一个App有通知，对于本地通知单的处理
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    [self onReceiveZyMessage:userInfo];
}

// MARK: iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10_0)
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    //[self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
    
    if (@available(iOS 10.0, *)) {
        if (@available(iOS 10.0, *)) {
            if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
                //应用处于前台时的远程推送接受
                
            }else{
                //应用处于前台时的本地推送接受
            }
        } else {
            // Fallback on earlier versions
        }
    } else {
        // Fallback on earlier versions
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    [self onReceiveZyMessage:userInfo];
}

//MARK: iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(10_0){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            echo(@"应用处于后台时的远程推送接受");
        }else{
            echo(@"应用处于后台时的本地推送接受");
        }
    } else {
        // Fallback on earlier versions
    }
    [self onReceiveZyMessage:userInfo];
}

//MARK: 进入app
- (void)enterApp{
    ZyTabBarController *tabBarController = [[ZyTabBarController alloc] init];
    UINavigationController *navMain = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    [navMain setNavigationBarHidden:YES];
    [self setNav];
    tabBarController.selectedIndex = 0;
    self.window.rootViewController = navMain;
    
    [self updateApp];
}

//MARK: 判断是否联网
- (void)setIsLinking{
    AFNetworkReachabilityManager*netStatus = [AFNetworkReachabilityManager sharedManager];
    
    [netStatus setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            echo(@"不可达的网络(未连接)");
        }else if (status == AFNetworkReachabilityStatusUnknown){
            echo(@"未识别的网络");
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            echo(@"2G,3G,4G...的网络");
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            echo(@"wifi的网络");
        }
    } ];
     [netStatus startMonitoring];
}

//MARK: 跳转到登录界面
- (void)signInApp{
    SignInViewController *vc = [[SignInViewController alloc]init];
    UIViewController *uivc = [ZyRouter zy_route_visibleViewController];
    [uivc presentViewController:vc animated:true completion:^{
        
    }];
    [self updateApp];
}

//MARK:退出登录
-(void)signoutApp{
    [self resetDefaults];
}

//MARK: userdefaults清除
- (void)resetDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //            删除所有缓存，只保留DeviceToken
    NSString *deviceToken = [userDefaults objectForKey:UD_deviceToken];
    
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
    
    NSDictionary * dict = [userDefaults dictionaryRepresentation];
    for (id key in dict) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
    [userDefaults setObject:deviceToken forKey:UD_deviceToken];
}

//MARK: 设置navigationbar的背景颜色
- (void)setNav{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
    bar.barTintColor = [UIColor whiteColor];
    
    //设置字体颜色
    bar.tintColor = [UIColor blackColor];
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

//MARK: 极光推送
- (void)setJPushApplication:(UIApplication *)application andOptions:(NSDictionary *)launchOptions{
    
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // 3.0.0以前版本旧的注册方式
    //  if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
    //#ifdef NSFoundationVersionNumber_iOS_9_x_Max
    //    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    //    entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
    //    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //#endif
    //  } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    //      //可以添加自定义categories
    //      [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
    //                                                        UIUserNotificationTypeSound |
    //                                                        UIUserNotificationTypeAlert)
    //                                            categories:nil];
    //  } else {
    //      //categories 必须为nil
    //      [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
    //                                                        UIRemoteNotificationTypeSound |
    //                                                        UIRemoteNotificationTypeAlert)
    //                                            categories:nil];
    //  }
    
    //    开发环境和发布环境需要不同，后期调试 修改
    BOOL isProduction = true;
#if DEBUG
    isProduction = false;
#else
    isProduction = true;
#endif
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:JPushChannel
                 apsForProduction:false
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    
//    [[NSBundle mainBundle] loadNibNamed:@"JpushTabBarViewController"
//                                  owner:self
//                                options:nil];
}

- (void)setAMapData{
    [AMapServices sharedServices].apiKey = AMap_Key;
}

//自动跟新相关
- (void)updateApp{
    
}


//收到通知 进行统一处理
- (void)onReceiveZyMessage:(NSDictionary *)dicInfo{
    echo(@"%@", dicInfo);
    [ZyRouter zy_route_pushController:dicInfo[@"cmd"]];
    // TODO 添加本地推送通知
    ZyTabBarController *tabBarController = (ZyTabBarController *)self.window.rootViewController.childViewControllers.lastObject;
    NSInteger badgeValue = tabBarController.tabBar.items[2].badgeValue.intValue;
    [tabBarController.tabBar.items[2] setBadgeValue:[NSString stringWithFormat:@"%ld", badgeValue + 1]];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end
