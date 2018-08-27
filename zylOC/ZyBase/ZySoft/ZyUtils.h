//
//  ZyUtils.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyUtils : NSObject

/**
 * @brief 获取随机数。
 * @param max view的top
 */
+ (NSString *)zy_random:(NSInteger)max;

//MARK: 控制上面的两个角变为圆角（corner 圆角）
+ (void)zy_SetBorderCorner:(UILabel *)lblOrg size:(CGSize)size;

/**
 * @brief view加border，控制是否给上左下右加边框，可以扩展到button label等控件。
 * @param view 范围是视图
 * @param top view的top
 * @param left view的left
 * @param bottom view的bottom
 * @param right view的right
 * @param color view的color
 * @param width view的width
 */
+ (UIView *)zy_SetBorderColor:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;


/**
 * @brief 控制上面的两个角变为圆角（corner 圆角）。
 * @param lblOrg 控件
 * @param size label的size
 */
+ (void)zy_SetBorderCorner:(UILabel *)lblOrg size:(CGSize)size;

/**
 * @brief 获取字符串的尺寸，通过传入的字体大小和最大宽度判断。
 * @param content 传入的内容
 * @param font 字体大小（越大 高度越高）
 * @param size 可以设置最大宽度（设置为0为默认）， 设置高度无效（不知道为什么）
 */
+ (CGSize)zy_GetContentSize:(NSString *)content font:(CGFloat)font size:(CGSize)size;

#pragma mark - 获取类的属性个数
+ (NSInteger)zy_GetCountOfClass:(id)class;

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -


@end
