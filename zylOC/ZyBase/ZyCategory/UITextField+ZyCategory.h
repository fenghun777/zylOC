//
//  UITextField+ZyCategory.h
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ZyCategory)
+ (UITextField *)zy_InitWithPlace:(NSString *)place color:(UIColor*)color secure:(BOOL)secure maxlength:(NSInteger) length keyboard:(UIKeyboardType)keyboard returnBlock:(void (^)(UITextField *))returnBlock;

+ (UITextField *)zy_InitWithPlace:(NSString *)place color:(UIColor*)color secure:(BOOL)secure maxlength:(NSInteger) length keyboard:(UIKeyboardType)keyboard leftview:(UIView *)leftview rightview:(UIView *)rightview returnBlock:(void (^)(UITextField*))returnBlock;
@end
