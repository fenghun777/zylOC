//
//  UIImage+ZyCategory.h
//  zylOC
//
//  Created by yy z on 2018/3/15.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZyCategory)
//平铺拉伸图片,四个角不变形、以图片的1/4 拉伸
+ (UIImage *)zy_ResizableImage:(UIImage *)image;

// 根据文字(汉字，英文，以及各种符号都可以)画默认图
+ (UIImage *)zy_MakeDrawImage:(NSString *)wenzi;

#pragma mark 根据宽等比压缩图片
+ (UIImage *)zy_ResizeImage:(UIImage *)image ByWidth:(float) width;

#pragma mark 等比压缩图片
+ (UIImage *)zy_ResizeImage:(UIImage *)image FromSize:(CGSize) size;

//调整尺寸大小
+ (CGSize)zy_ResizeSize:(CGSize)osize fromsize:(CGSize)fromSize;
@end
