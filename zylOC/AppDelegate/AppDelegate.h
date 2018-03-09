//
//  AppDelegate.h
//  jkbs_train
//
//  Created by iosdev1 on 16/8/25.
//  Copyright © 2016年 iosdev1. All rights reserved.
//

#import "ZyBaseAppDelegate.h"

@interface AppDelegate : ZyBaseAppDelegate<UITabBarControllerDelegate,UIAlertViewDelegate>

@property (assign, nonatomic)BOOL isDBMigrating;

- (void)signInApp;
- (void)enterApp;
- (void)signoutApp;
- (void)loginIm;
@end
