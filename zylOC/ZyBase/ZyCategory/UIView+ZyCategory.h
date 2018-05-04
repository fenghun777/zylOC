//
//  UIView+ZyCategory.h
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZyCategory)

//点击背景，弹出框消失
+ (UIView *)zy_BackGroundViewTouchMove;

//点击背景，弹出框消失 同时执行 相应事件
+ (UIView *)zy_BackGroundViewTouchMove:(void (^)(void))UpdateContentBlock;

//点击背景，弹出框不消失
+ (UIView *)zy_BackGroundViewTouchMoveNot;

@end
