//
//  UIViewController+ZyCategory.h
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZyCategory)
#pragma mark - 获取当前view的viewcontroller 必须知道当前view，zyrouter可以直接获取控制器
+ (UIViewController *)zy_GetCurrentViewController:(UIView *)currentView;
@end
