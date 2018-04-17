//
//  UIImageView+ZyCategory.h
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZyCategory)

//MARK: 初始化UIImageView,设置网络图片带尺寸
+ (UIImageView *) zy_InitWithURLString:(NSString*) strurl placeImage:(UIImage *)placeimage size:(CGSize)size finish:(void (^)(UIImage *)) finish bkWhenTap:(void (^)(void))whentap;

//MARK: 初始化UIImageView,设置网络图片带圆角和尺寸
+ (UIImageView *) zy_InitWithURLString:(NSString*) strurl placeImage:(UIImage *)placeimage size:(CGSize)size radius:(float)radius finish:(void (^)(UIImage *)) finish bkWhenTap:(void (^)(void))whentap;

//MARK: 初始化UIImageView,设置网络图片
+ (UIImageView *) zy_InitWithURL:(NSURL*) url placeImage:(UIImage *)placeimage finish:(void (^)(UIImageView *)) finish bkWhenTap:(void (^)(void))whentap;
@end
