//
//  UIButton+ZyCategory.m
//  zylOC
//
//  Created by UNOHACHA on 2018/4/13.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "UIButton+ZyCategory.h"

@implementation UIButton (ZyCategory)
+ (UIButton *) zy_InitWithImage:(NSArray *)image radius:(float)radius bkHandler:(void (^)(id sender))handler{
    UIButton *btn = [[UIButton alloc] init];
    if (image != nil) {
        [btn setImage:[UIImage imageNamed:[image firstObject]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[image lastObject]] forState:UIControlStateHighlighted];
    }
    
    if (radius > 0) {
        [btn.layer setCornerRadius:radius];
    }
    [btn bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *) zy_InitWithTitle:(NSString *)title font:(UIFont*)font colors:(NSArray *)color bgcolors:(id)bgcolor radius:(float)radius bkHandler:(void (^)(id sender))handler{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    if (color != nil && color.count > 0) {
        [btn setTitleColor:[color firstObject] forState:UIControlStateNormal];
        [btn setTitleColor:[color lastObject] forState:UIControlStateHighlighted];
    }
    if (radius > 0) {
        [btn.layer setCornerRadius:radius];
    }
    if (([bgcolor isKindOfClass:[NSArray class] ]
         || [bgcolor isKindOfClass:[NSDictionary class]] ) && [(NSArray *)bgcolor count] > 0) {
        [btn setBackgroundColor:[bgcolor firstObject]];
    }else if ([bgcolor isKindOfClass:[UIColor class]]){
        [btn setBackgroundColor:bgcolor];
    }
    
    [btn bk_addEventHandler:^(id sender) {
        btn.selected = !btn.selected;
        if (([bgcolor isKindOfClass:[NSArray class] ]
             || [bgcolor isKindOfClass:[NSDictionary class]] ) && [(NSArray *)bgcolor count] > 0) {
            if (btn.selected) {
                [btn setTitleColor:[color lastObject] forState:UIControlStateNormal];
                [btn setBackgroundColor:[bgcolor lastObject]];
            }else{
                [btn setTitleColor:[color firstObject] forState:UIControlStateNormal];
                [btn setBackgroundColor:[bgcolor firstObject]];
            }
        }
        handler(sender);
    } forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
