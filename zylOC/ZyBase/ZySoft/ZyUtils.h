//
//  ZyUtils.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyUtils : NSObject

//MARK: 获取随机数，范围是max
+ (NSString *)zy_random:(NSInteger)max;

//view加border，控制是否给上左下右加边框，可以扩展到button label等控件
+ (void)zy_SetBorderColor:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

//控制上面的两个角变为圆角（corner 圆角）
+ (void)zy_SetBorderCorner:(UILabel *)lblOrg size:(CGSize)size;


+ (CGSize)zy_GetContentSize:(NSString *)content font:(UIFont *)font width:(float)width;
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

#pragma mark -


@end
