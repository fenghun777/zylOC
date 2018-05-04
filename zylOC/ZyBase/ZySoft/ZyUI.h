//
//  ZyUI.h
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyUI : NSObject
//通用的弹出框 2S后消失
+ (void)zy_ShowMessage:(NSString *)message;

/*!
 @method
 @brief 弹出框
 @param message 信息
 @param cancelButton 时候显示取消按钮
 @
 */
+ (void)zy_AlertControllerWithMessage:(NSString *)message showCancelButton:(BOOL)cancelButton withCancelBlock:(void (^)(id sender))onCancelButtonClick withSureBlock:(void (^)(id sender))onSureButtonClick;

/**
 * @brief 按钮切换
 * @param titleStr 是否选中
 * @param SwitchOnBlock 打开执行
 * @param SwitchOffBlock 关闭执行
 */
+ (UIView *)zy_SwitchWithTitle:(NSString *)titleStr WithOn:(void (^)(id sender))SwitchOnBlock andOff:(void (^)(id sender))SwitchOffBlock;

@end
