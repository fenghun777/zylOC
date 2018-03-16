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
















@end
