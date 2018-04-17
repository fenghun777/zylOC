//
//  UIImage+ZyCategory.m
//  zylOC
//
//  Created by yy z on 2018/3/15.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "UIImage+ZyCategory.h"

@implementation UIImage (ZyCategory)

+ (UIImage *)zy_ResizableImage:(UIImage *)image{
    // 加载图片
//    UIImage *image = [UIImage imageNamed:@"default"];
    // 设置端盖的值
    CGFloat top = image.size.height * 0.25;
    CGFloat left = image.size.width * 0.25;
    CGFloat bottom = image.size.height * 0.25;
    CGFloat right = image.size.width * 0.25;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式，
//    UIImageResizingModeTile,//进行区域复制模式拉伸
//    UIImageResizingModeStretch,//进行渐变复制模式拉伸
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}

+ (UIImage *)zy_MakeDrawImage:(NSString *)wenzi{
    
    CGSize size = CGSizeMake(80, 80);
    CGRect rectangle = CGRectMake(0, 0, 80, 80);
    
    CGFloat w = size.width;
//    1.创建Bitmap图形上下文的方法
    //    UIGraphicsBeginImageContext(size);//方法1
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);//方法2
    
//    使用两个方法同样都可以创建，但是使用第一个方法将来创建的图片清晰度和质量没有第二种方法的好。
//    方法2接收三个参数：
//    CGSize size：指定将来创建出来的bitmap的大小
//    BOOL opaque：设置透明YES代表透明，NO代表不透明
//    CGFloat scale：代表缩放,0代表不缩放
//    创建出来的bitmap就对应一个UIImage对象
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 定义其rect
    
    // 在当前路径下添加一个椭圆路径
    //    CGContextAddEllipseInRect(context, rectangle);
    CGContextAddRect(context, rectangle);
    // 设置当前视图填充色
    CGContextSetFillColorWithColor(context, [UIColor zy_RandomColorSixteen].CGColor);
    // 绘制当前路径区域
    CGContextFillPath(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBFillColor (context, 1, 1, 1, 1);
//    CGSize wsize = [YgUtils getContentSize:username font:FONT(w / 2) width:MAXFLOAT];
    CGSize wsize = [wenzi sizeWithFont:FONT(17) constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    CGContextAddEllipseInRect(context, rectangle);
    //剪切可视范围
    //    CGContextClip(context);
    [wenzi drawInRect:CGRectMake(10, 20, wsize.width, wsize.height) withFont:FONT(w / 2)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 根据宽等比压缩图片
+ (UIImage *)zy_ResizeImage:(UIImage *)image ByWidth:(float) width{
    CGSize size = CGSizeMake(width, 0);
    return [UIImage zy_ResizeImage:image FromSize:size];
}

#pragma mark 等比压缩图片
+ (UIImage *)zy_ResizeImage:(UIImage *)image FromSize:(CGSize)fromSize{
    if (!image) {
        return nil;
    }
    fromSize = [self zy_ResizeSize:image.size fromsize:fromSize];
    if (fromSize.width == image.size.width) {
        return image;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(fromSize, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(fromSize);
    }
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0,0, fromSize.width, fromSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

+ (CGSize)zy_ResizeSize:(CGSize)osize fromsize:(CGSize)fromSize{
    float bl = MIN(fromSize.width / osize.width, fromSize.height / osize.height);
    if (bl == 0) {
        bl = MAX(fromSize.width / osize.width, fromSize.height / osize.height);
    }
    
    if (osize.width <= fromSize.width && osize.height <= fromSize.height) {
        return osize;
    }else{
        fromSize.width = osize.width * bl;
        fromSize.height = osize.height * bl;
    }
    return fromSize;
}













@end
