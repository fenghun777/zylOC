//
//  ZyBaseViewController.h
//  jkbs_train
//
//  Created by iosdev1 on 16/8/25.
//  Copyright © 2016年 iosdev1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZyBaseViewController : UIViewController

@property (nonatomic) BOOL TabBarHidden;//为true下面的tabbar 隐藏    为false的时候下面的tabbar显示

/*!
 @method
 @brief 初始化界面
 */
-(void)controllerInit;

/*!
 @method
 @brief 获取数据
 */
- (void)initData:(NSString *)dataStr;


- (void)initUIRectEdge:(NSInteger)edg;

- (void) showHUD:(NSString *)title AndContent:(NSString *)content;

- (void) hideHUD;

- (void) navBack:(BOOL) animated;

/*!
 @method
 @brief 后退 简化
 
 @param animated 是否动画
 */
- (void)backController:(BOOL) animated;

/*!
 @method
 @brief 后退几个controller
 
 @param lever 几个controller
 @param animated 是否动画
 */
- (void) backController:(NSInteger) lever animated:(BOOL) animated;

/*!
 @method
 @brief 后退最后一个controller
 @param animated 是否动画
 */
- (void) backToRootViewControllerAnimated:(BOOL) animated;

/*!
 @method
 @brief push controller 简化 animated 默认 YES
 */
- (void) pushController:(UIViewController *)controller;

/*!
 @method
 @brief push controller 简化
 @param animated 是否动画
 */
- (void) pushController:(UIViewController *)controller animated:(BOOL) animated;

/*!
 @method
 @brief push 多个controller
 @param lever 几个controller
 @param animated 是否动画
 */
- (void) pushController:(UIViewController *)controller toLever:(NSInteger) lever animated:(BOOL) animated;
@end
