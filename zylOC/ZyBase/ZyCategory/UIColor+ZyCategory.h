//
//  UIColor+ZyCategory.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZyCategory)

#pragma mark 获取随机颜色
+ (UIColor *)zy_RandomColor;

#pragma mark - 随机颜色（十六进制）
+ (UIColor *)zy_RandomColorSixteen;

#pragma mark - 十六进制转颜色值
+ (UIColor *)zy_ColorWithHexString: (NSString *)color;


@end
