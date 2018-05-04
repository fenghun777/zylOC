//
//  UIView+ZyCategory.m
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "UIView+ZyCategory.h"

@implementation UIView (ZyCategory)
+ (UIView *)zy_BackGroundViewTouchMove{
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    UIView *bgView = [[UIView alloc]init];
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [bgView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]];
    [bgView bk_whenTapped:^{
        [view removeFromSuperview];
    }];
    return view;
    
}

+ (UIView *)zy_BackGroundViewTouchMove:(void (^)(void))UpdateContentBlock{
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    UIView *bgView = [[UIView alloc]init];
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [bgView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7]];
    [bgView bk_whenTapped:^{
        [view removeFromSuperview];
        UpdateContentBlock();
    }];
    
    return view;
}

//点击背景，弹出框不消失
+ (UIView *)zy_BackGroundViewTouchMoveNot{
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    UIView *bgView = [[UIView alloc]init];
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [bgView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]];
    return view;
}

@end
