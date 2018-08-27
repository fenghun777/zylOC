//
//  ZySkipToSystem.m
//  GuangGaoRen
//
//  Created by 张钰营 on 2018/6/28.
//  Copyright © 2018年 hhdz. All rights reserved.
//

#import "ZySkipToSystem.h"

@implementation ZySkipToSystem

+ (void)zy_SkipToSystemWIFI{
//    跳转到设置界面 ios11可以，
    [self openUrl:@"App-Prefs:root"];
    

}

+ (void)zy_SkipToSystemLOCATION_SERVICES{
    
}

+ (void)zy_SkipToSystemBluetooth{
    
}

+ (void)zy_SkipToSystemNOTIFICATIONS_ID{
    
}

+ (void)openUrl:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    if (@available(iOS 10.0, *)) {
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        }else{
            echo(@"地址打开失败:%@", urlStr);
        }
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            echo(@"地址打开失败:%@", urlStr);
        }
    }
}


//系统设置:prefs:root=INTERNET_TETHERING
//
//WIFI设置:prefs:root=WIFI
//
//蓝牙设置:prefs:root=Bluetooth
//
//系统通知:prefs:root=NOTIFICATIONS_ID
//
//通用设置:prefs:root=General
//
//显示设置:prefs:root=DISPLAY&BRIGHTNESS
//
//壁纸设置:prefs:root=Wallpaper
//
//声音设置:prefs:root=Sounds
//
//隐私设置:prefs:root=privacy
//
//蜂窝网路:prefs:root=MOBILE_DATA_SETTINGS_ID
//
//音乐:prefs:root=MUSIC
//
//APP Store:prefs:root=STORE
//
//Notes:prefs:root=NOTES
//
//Safari:prefs:root=Safari
//
//Music:prefs:root=MUSIC
//
//photo":prefs:root=Photos
//
//这种跳转方式，都是跳转到系统的设置界面。

//当 iOS系统版本 >= iOS8 ，支持跳转到第三方应用的设置界面中
//使用prefs:root=bundleID ,bundleID是你第三方应用工程的唯一ID
//局限性：只支持iOS8,iOS9系统,在iOS10系统上，不会跳转。
//在iOS7系统上，仅仅只是跳转到设置应用，不推荐使用。
//如果需要继续向项目内层进行跳转，可以通过添加path路径的方式，如下：
//关于本机:prefs:root=General&path=About
//软件升级:prefs:root=General&path=SOFTWARE_UPDATE_LINK
//日期时间:prefs:root=General&path=DATE_AND_TIME
//Accessibility:prefs:root=General&path=ACCESSIBILITY
//键盘设置:prefs:root=General&path=Keyboard
//VPN:prefs:root=General&path=VPN
//壁纸设置:@"prefs:root=Wallpaper
//声音设置:prefs:root=Sounds
//隐私设置:prefs:root=privacy
//APP Store:prefs:root=STORE
//还原设置:prefs:root=General&path=Reset
//应用通知:prefs:root=NOTIFICATIONS_ID&path=应用的boundleId
//定位：prefs:root=LOCATION_SERVICES
//蜂窝网络：prefs:root=MOBILE_DATA_SETTINGS_ID
//VPN — prefs:root=General&path=Network/VPN
//Wi-Fi：prefs:root=WIFI
//定位服务：prefs:root=LOCATION_SERVICES
//个人热点：prefs:root=INTERNET_TETHERING
//辅助功能：prefs:root=General&path=ACCESSIBILITY
//飞行模式：prefs:root=AIRPLANE_MODE
//锁定：prefs:root=General&path=AUTOLOCK
//亮度：prefs:root=Brightness
//蓝牙：prefs:root=General&path=Bluetooth
//时间设置：prefs:root=General&path=DATE_AND_TIME
//FaceTime：prefs:root=FACETIME
//设置：prefs:root=General
//键盘设置：prefs:root=General&path=Keyboard
//iCloud：prefs:root=CASTLE
//iCloud备份：prefs:root=CASTLE&path=STORAGE_AND_BACKUP
//语言：prefs:root=General&path=INTERNATIONAL
//音乐：prefs:root=MUSIC
//Music Equalizer — prefs:root=MUSIC&path=EQ
//Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
//Network — prefs:root=General&path=Network
//Nike + iPod — prefs:root=NIKE_PLUS_IPOD
//Notes — prefs:root=NOTES
//Notification — prefs:root=NOTIFICATIONS_ID
//Phone — prefs:root=Phone
//Photos — prefs:root=Photos
//Profile — prefs:root=General&path=ManagedConfigurationList
//Reset — prefs:root=General&path=Reset
//Safari — prefs:root=Safari
//Siri — prefs:root=General&path=Assistant
//Sounds — prefs:root=Sounds
//Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
//Store — prefs:root=STORE
//Twitter — prefs:root=TWITTER
//Usage — prefs:root=General&path=USAGE
//Wallpaper — prefs:root=Wallpaper
//
//方式三
//当 iOS系统版本 >= iOS8，支持跳转到自己应用设置，不支持跳转到系统设置
//NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//UIApplicationOpenSettingsURLString字段，是在iOS8上才提供的，支持iOS8,iOS9,iOS10系统，推荐使用。
//当iOS系统版本>= iOS10，支持跳转到自己应用设置，不支持跳转到系统设置
//只认：NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//跳转。而 prefs:root=bundleID和 prefs:root=服务 都将不起作用。
//总结一下:
//方式一：prefs:root=某项服务 适用于 小于 iOS10的系统；
//方式二：prefs:root=bundleID 适用于 大于等于iOS8系统，小于iOS10的系统
//方式三：UIApplicationOpenSettingsURLString 适用于 大于等于iOS8的系统


@end
