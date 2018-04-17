//
//  UILabel+Zy_Category.m
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "UILabel+Zy_Category.h"

@implementation UILabel (Zy_Category)
+ (UILabel *)zy_InitWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    return [self zy_InitWithTitle:title font:font color:color bkWhenTap:nil];
}
+ (UILabel *)zy_InitWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color bgcolor:(UIColor *)bgcolor radius:(float)radius bkWhenTap:(void (^)(void))whentap{
    UILabel *lbl = [self zy_InitWithTitle:title font:font color:color bkWhenTap:whentap];
    [lbl setBackgroundColor:bgcolor];
    if (radius > 0) {
        [lbl.layer setCornerRadius:radius];
    }
    return lbl;
}
+ (UILabel *)zy_InitWithTitle:(NSString *)title font:(UIFont*)font color:(UIColor *)color bkWhenTap:(void (^)(void))whentap{
    UILabel *lbl = [[UILabel alloc] init];
    [lbl setText:title];
    [lbl setFont:font];
    [lbl setTextColor:color];
    [lbl setBackgroundColor:[UIColor clearColor]];
    if (whentap != nil) {
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setUserInteractionEnabled:YES];
        [lbl bk_whenTapped:whentap];
    }
    return lbl;
}
@end
