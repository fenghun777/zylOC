//
//  UIImageView+ZyCategory.m
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "UIImageView+ZyCategory.h"
#import <UIImageView+AFNetworking.h>

@implementation UIImageView (ZyCategory)
+ (UIImageView *) zy_InitWithURLString:(NSString*) strurl placeImage:(UIImage *)placeimage size:(CGSize)size finish:(void (^)(UIImage *)) finish bkWhenTap:(void (^)(void))whentap{
    return [self zy_InitWithURLString:strurl placeImage:placeimage size:size radius:0 finish:finish bkWhenTap:whentap];
}

+ (UIImageView *) zy_InitWithURLString:(NSString*) strurl placeImage:(UIImage *)placeimage size:(CGSize)size radius:(float)radius finish:(void (^)(UIImage *)) finish bkWhenTap:(void (^)(void))whentap{
    NSURL *url = [NSURL URLWithString:strurl];
    UIImageView *imageView = [self zy_InitWithURL:url placeImage:placeimage finish:^(UIImageView * view){
        UIImage *image = [UIImage zy_ResizeImage:view.image FromSize:size];
        [view setImage:image];
        if (radius != 0) {
            [view.layer setMasksToBounds:YES];
        }
        if (radius > 1) {
            [view.layer setCornerRadius:radius];
        }else if(radius < 1){
            [view.layer setCornerRadius:MIN(image.size.width, image.size.height) * radius];
        }
        if (finish) {
            finish(image);
        }
    }  bkWhenTap:whentap];
    return imageView;
}

//MARK: 初始化UIImageView
+ (UIImageView *) zy_InitWithURL:(NSURL*) url placeImage:(UIImage *)placeimage finish:(void (^)(UIImageView *)) finish bkWhenTap:(void (^)(void))whentap{
    UIImageView *imageview = [[UIImageView alloc] init];
    __block UIImageView *iview = imageview;
    [imageview setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:placeimage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [iview setImage:image];
        finish(iview);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [iview setImage:placeimage];
    }];
    if (whentap != nil) {
        [imageview setUserInteractionEnabled:YES];
        [imageview bk_whenTapped:whentap];
    }
    return imageview;
}

@end
