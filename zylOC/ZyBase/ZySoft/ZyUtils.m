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

+ (void)zy_SetBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width {
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
}

+ (void)zy_SetBorderCorner:(UILabel *)lblOrg size:(CGSize)size{
    UIRectCorner corner = (UIRectCornerTopLeft | UIRectCornerTopRight);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lblOrg.bounds byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = lblOrg.bounds;
    maskLayer.path = maskPath.CGPath;
    lblOrg.layer.mask = maskLayer;
}

+ (CGSize)zy_GetContentSize:(NSString *)content font:(UIFont *)font width:(float)width{
    CGSize bubbleSize = [content sizeWithFont:font constrainedToSize:CGSizeMake(width , MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];

    return bubbleSize;
}




























@end
