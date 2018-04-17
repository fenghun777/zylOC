//
//  UIButton+ZyCategory.h
//  zylOC
//
//  Created by UNOHACHA on 2018/4/13.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZyCategory)
+ (UIButton *) zy_InitWithImage:(NSArray *)image radius:(float)radius bkHandler:(void (^)(id sender))handler;
+ (UIButton *) zy_InitWithTitle:(NSString *)title font:(UIFont*)font colors:(NSArray *)color bgcolors:(id)bgcolor radius:(float)radius bkHandler:(void (^)(id sender))handler;
@end
