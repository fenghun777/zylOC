//
//  UILabel+Zy_Category.h
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Zy_Category)
+ (UILabel *)zy_InitWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;
+ (UILabel *)zy_InitWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color bgcolor:(UIColor *)bgcolor radius:(float)radius bkWhenTap:(void (^)(void))whentap;
+ (UILabel *)zy_InitWithTitle:(NSString *)title font:(UIFont*)font color:(UIColor *)color bkWhenTap:(void (^)(void))whentap;
@end
