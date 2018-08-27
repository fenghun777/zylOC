//
//  ZyUtils.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyUtils.h"

@implementation ZyUtils


+ (NSString *)zy_random:(NSInteger)max {
    return [NSString stringWithFormat:@"%ld",(long)(arc4random() % max) + 1];
}

+ (UIView *)zy_SetBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    return view;
}

+ (void)zy_SetBorderCorner:(UILabel *)lblOrg size:(CGSize)size{
    UIRectCorner corner = (UIRectCornerTopLeft | UIRectCornerTopRight);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lblOrg.bounds byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = lblOrg.bounds;
    maskLayer.path = maskPath.CGPath;
    lblOrg.layer.mask = maskLayer;
}

+ (CGSize)zy_GetContentSize:(NSString *)content font:(CGFloat)font size:(CGSize)size{
//    NSStringDrawingUsesLineFragmentOrigin = 1 << 0, // 指定的原点是线段原点，而不是基线原点。
//    NSStringDrawingUsesFontLeading = 1 << 1, // 依据字体大小计算线高度
//    NSStringDrawingUsesDeviceMetrics = 1 << 3, // 使用图像字形边界而不是印刷边界。
//    NSStringDrawingTruncatesLastVisibleLine 如果文本不符合指定的范围，则截断并将省略字符添加到最后一个可见行。如果NSStringDrawingUsesLineFragmentOrigin没有设置，则该项无效
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize titleSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return titleSize;
}

+ (NSInteger)zy_GetCountOfClass:(id)class{
    //    Ivar : runtime里面代表成员变量
    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UIButton class], &count);
    Ivar *ivars = class_copyIvarList(class, &count);
//    获取第一个属性
    Ivar ivar = ivars[0];
//    获取第一个属性的 命名
    const char *name = ivar_getName(ivar);
    echo(@"====%s", name);
    return count;
}



























@end
