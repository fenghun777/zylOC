
//  AppDelegate.m
//  jkbs_train
//
//  Created by iosdev1 on 16/8/25.
//  Copyright © 2016年 iosdev1. All rights reserved.
//

#import "AppDelegate.h"
#import "ZyBaseViewController.h"
#import "SignInViewController.h"
//#import "RedPacketUserConfig.h"
#import <UserNotifications/UserNotifications.h>

#import "UMessage.h"

#import <AMapFoundationKit/AMapFoundationKit.h>

#import "MineViewController.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate, UITabBarDelegate, UITabBarControllerDelegate>

@end

@implementation AppDelegate

// 程序完成加载  创建window窗口
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [super application:application didFinishLaunchingWithOptions:launchOptions];
//    判断是否联网
    [self setIsLinking];
//    设置环信
    //[self setEaseMobApplication:application andOptions:launchOptions];
//    设置友盟推送
    [self setUMessageApplication:application andOptions:launchOptions];
//    设置高德地图
    [self setAMapData];
    
//    进入app主界面
    [self enterApp];

    return YES;
}


//当点击command+H时,程序取消激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    [super applicationWillResignActive:application];
}

//程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [super applicationDidEnterBackground:application];
//    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

//点击进入工程,程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [super applicationWillEnterForeground:application];
//    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

//程序被激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [super applicationDidBecomeActive:application];
}

//当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值
- (void)applicationWillTerminate:(UIApplication *)application {
    [super applicationWillTerminate:application];
}

// 将得到的deviceToken传给SDK
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
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    echo(@"%@", error);
    [ZyRouter route_visibleViewController];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭U-Push自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"didReceiveRemoteNotification" message:@"userInfo" delegate:self cancelButtonTitle:@"quxiao" otherButtonTitles:nil];
//    [alertView show];
    //[self easemobApplication:application didReceiveRemoteNotification:userInfo];
    
    [self onReceiveZyMessage:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"didReceiveLocalNotification" message:@"userInfo" delegate:self cancelButtonTitle:@"quxiao" otherButtonTitles:nil];
//    [alertView show];
    NSDictionary *userInfo = notification.userInfo;
    [self onReceiveZyMessage:userInfo];
}

//iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    //[self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
    
    if (@available(iOS 10.0, *)) {
        if (@available(iOS 10.0, *)) {
            if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
                //应用处于前台时的远程推送接受
                //关闭U-Push自带的弹出框
                [UMessage setAutoAlert:NO];
                //必须加这句代码
                [UMessage didReceiveRemoteNotification:userInfo];
                
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

//iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于后台时的远程推送接受
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
        }else{
            //应用处于后台时的本地推送接受
            echo(@"应用处于后台时的本地推送接受");
        }
    } else {
        // Fallback on earlier versions
    }
    [self onReceiveZyMessage:userInfo];
}



//进入app
- (void)enterApp{
    NSArray *viewcontrollers = @[
  @{@"title" : @"首页", @"controller":@"HomePageViewController", @"ico_selected":@"tabbar_buy_s",   @"ico_unSelected":@"tabbar_buy_n"},
  @{@"title" : @"分类", @"controller":@"ClassifyViewController", @"ico_selected":@"tabbar_class_s", @"ico_unSelected":@"tabbar_class_n"},
  @{@"title" : @"我的", @"controller":@"MineViewController",     @"ico_selected":@"tabbar_my_s",    @"ico_unSelected":@"tabbar_my_n"}
  ];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSDictionary *dicControler in viewcontrollers) {
        UIImage *imageSelected = [UIImage imageNamed:dicControler[@"ico_selected"]];
        imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *imageUnSelected = [UIImage imageNamed:dicControler[@"ico_unSelected"]];
        imageUnSelected = [imageUnSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        Class c = NSClassFromString([NSString stringWithFormat:@"%@", [dicControler valueForKey:@"controller"]]);
        ZyBaseViewController *basecontroller = [c new];
        [basecontroller setTitle:[dicControler valueForKey:@"title"]];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:basecontroller];
        navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[dicControler valueForKey:@"title"] image:imageUnSelected selectedImage:imageSelected];
        
         //未选中字体颜色
//        [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor],NSFontAttributeName:FONT(14)} forState:UIControlStateNormal];
        
        //选中字体颜色
        [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:FONT(14)} forState:UIControlStateSelected];
        [viewControllers addObject:navController];
    }
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = viewControllers;
    [tabBarController setDelegate:self];
    UINavigationController *navMain = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    [navMain setNavigationBarHidden:YES];
    [self setNav];
    tabBarController.selectedIndex = 0;
    self.window.rootViewController = navMain;

    [self loginIm];
    
    [self updateApp];
}

//判断选中状态，时候跳转，若 未登录，跳到登录界面，已登录，正常跳转
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    NSString *tokenStr = [userdefault objectForKey:UD_access_token];
//
//    UIViewController *selController = viewController.childViewControllers.firstObject;
//    if ([selController isKindOfClass:[MineViewController class]]||[selController isKindOfClass:[MineViewController class]]||[selController isKindOfClass:[MineViewController class]]) {
//        if (tokenStr) {
//            return true;
//        } else {
//            [self signInApp];
//            return false;
//        }
//    }
    return true;
}

//判断是否联网
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

//跳转到登录界面
- (void)signInApp{
    SignInViewController *vc = [[SignInViewController alloc]init];
    UIViewController *uivc = [ZyRouter route_visibleViewController];
    [uivc presentViewController:vc animated:true completion:^{
        
    }];
    [self updateApp];
}

-(void)signoutApp{
    
    [self resetDefaults];
    //退出登录
    [self setZySelectedView:0];
}

- (void)loginIm {
    

}


//userdefaults清除
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

//设置navigationbar的背景颜色
- (void)setNav{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
    bar.barTintColor = [UIColor whiteColor];
    
    //设置字体颜色
    bar.tintColor = [UIColor blackColor];
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

//MARK:友盟推送
- (void)setUMessageApplication:(UIApplication *)application andOptions:(NSDictionary *)launchOptions{
    [UMessage startWithAppkey:UM_PushKey launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        center.delegate=self;
        [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                //这里可以添加一些自己的逻辑
            } else {
                //点击不允许
                //这里可以添加一些自己的逻辑
            }
        }];
    } else {
        // Fallback on earlier versions
    }
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
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
    [ZyRouter route_pushController:dicInfo[@"cmd"]];
    // TODO 添加本地推送通知
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController.childViewControllers.lastObject;
    NSInteger badgeValue = tabBarController.tabBar.items[2].badgeValue.intValue;
    [tabBarController.tabBar.items[2] setBadgeValue:[NSString stringWithFormat:@"%ld", badgeValue + 1]];
}

@end
