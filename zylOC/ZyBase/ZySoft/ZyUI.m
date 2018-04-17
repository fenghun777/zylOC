//
//  ZyUI.m
//  zylOC
//
//  Created by 吾诺瀚卓 on 2018/4/17.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyUI.h"

@implementation ZyUI

+ (void)zy_ShowMessage:(NSString *)message{
    {
        //#ifndef DEBUG
        if (message == nil || [message isEqualToString:@""]) {
            return;
        }
        //#endif
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *showview = [[UIView alloc] init];
        showview.frame = CGRectMake(1, 1, 1, 1);
        showview.alpha = 1.0f;
        showview.layer.cornerRadius = 5.0f;
        showview.layer.masksToBounds = YES;
        [showview setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
        [window addSubview:showview];
        
        UILabel *label = [[UILabel alloc] init];
        CGSize labelsize = [ZyUtils zy_GetContentSize:message font:FONT(17) width:290];
        label.frame = CGRectMake(10, 5, labelsize.width, labelsize.height);
        label.text = message;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = FONT(15);
        [showview addSubview:label];
        
        showview.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - labelsize.width - 20) / 2, [UIScreen mainScreen].bounds.size.height / 2, labelsize.width + 20, labelsize.height + 10);
        [UIView animateWithDuration:2 animations:^{
            showview.alpha = 0;
        } completion:^(BOOL finished) {
            [showview removeFromSuperview];
        }];
    }
}

+ (void)zy_AlertControllerWithMessage:(NSString *)message showCancelButton:(BOOL)cancelButton withCancelBlock:(void (^)(id sender))onCancelButtonClick withSureBlock:(void (^)(id sender))onSureButtonClick{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (onSureButtonClick) {
            onSureButtonClick(action);
        }
    }];
    
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (onCancelButtonClick) {
            onCancelButtonClick(action);
        }
    }];
    [alertcontroller addAction:sureAlert];
    if (cancelButton == YES) {
        [alertcontroller addAction:cancelAlert];
    }
    
    UIViewController *vc = [ZyRouter zy_route_visibleViewController];
    [vc presentViewController:alertcontroller animated:true completion:nil];
}

+ (UIView *)zy_SwitchWithTitle:(NSString *)titleStr WithOn:(void (^)(id sender))SwitchOnBlock andOff:(void (^)(id sender))SwitchOffBlock{{
    UIView *view = [[UIView alloc]init];
    
    UIImageView *ivImage = [[UIImageView alloc]init];
    [view addSubview:ivImage];
    [ivImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    NSMutableArray *arrImage = [[NSMutableArray alloc]initWithObjects:@"ico_open", nil];
    if ([titleStr isEqualToString:@"正常"]||[titleStr isEqualToString:@"无"]||!titleStr||[titleStr isEqualToString:@"0"]) {
        [ivImage setImage:[UIImage imageNamed:@"ico_close"]];
        arrImage[0] = @"ico_close";
    }else{
        [ivImage setImage:[UIImage imageNamed:@"ico_open"]];
        arrImage[0] = @"ico_open";
    }
    
    [view bk_whenTapped:^{
        if ([arrImage[0] isEqualToString:@"ico_close"]) {
            arrImage[0] = @"ico_open";
            [ivImage setImage:[UIImage imageNamed:arrImage[0]]];
            if (SwitchOnBlock) {
                SwitchOnBlock(@"SwitchOnBlock");
            }
        }else if ([arrImage[0] isEqualToString:@"ico_open"]){
            arrImage[0] = @"ico_close";
            [ivImage setImage:[UIImage imageNamed:arrImage[0]]];
            if (SwitchOffBlock) {
                SwitchOffBlock(@"SwitchOffBlock");
            }
        }else{
            [ZyUI zy_ShowMessage:@"异常"];
        }
    }];
    return view;
}
    
    
}

@end
