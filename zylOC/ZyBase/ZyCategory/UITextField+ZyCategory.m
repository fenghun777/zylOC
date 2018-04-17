//
//  UITextField+ZyCategory.m
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "UITextField+ZyCategory.h"

@implementation UITextField (ZyCategory)
+ (UITextField *)zy_InitWithPlace:(NSString *)place color:(UIColor*)color secure:(BOOL)secure maxlength:(NSInteger) length keyboard:(UIKeyboardType)keyboard returnBlock:(void (^)(UITextField *))returnBlock{
    
    return [self zy_InitWithPlace:place color:color secure:secure maxlength:length keyboard:keyboard leftview:nil rightview:nil returnBlock:returnBlock];
}

+ (UITextField *)zy_InitWithPlace:(NSString *)place color:(UIColor*)color secure:(BOOL)secure maxlength:(NSInteger) length keyboard:(UIKeyboardType)keyboard leftview:(UIView *)leftview rightview:(UIView *)rightview returnBlock:(void (^)(UITextField*))returnBlock{
    UITextField *tfd = [[UITextField alloc] init];
    [tfd setPlaceholder:place];
    [tfd setKeyboardType:keyboard];
    [tfd setLeftView:leftview];
    [tfd setRightView:rightview];
    [tfd setSecureTextEntry:secure];
    [tfd setTextColor:color];
    tfd.returnKeyType = UIReturnKeyDone;
    if (length > 0) {
        [tfd setBk_shouldChangeCharactersInRangeWithReplacementStringBlock:^BOOL(UITextField * textfield, NSRange range, NSString * str) {
            return textfield.text.length <= length - 1 || [str isEqualToString:@""];
        }];
    }
    if (returnBlock) {
        [tfd setBk_shouldReturnBlock:^BOOL(UITextField *textfield) {
            return [textfield resignFirstResponder];
        }];
        [tfd setBk_didEndEditingBlock:^(UITextField *textfield) {
            returnBlock(textfield);
        }];
    }
    return tfd;
}

@end
