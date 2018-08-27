//
//  ZyTextFieldView.h
//  zylOC
//
//  Created by 张钰营 on 2018/6/20.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZyTextFieldView : UIView
@property(nonatomic)NSInteger maxLength;// 最大长度
@property(nonatomic)CGFloat font;// 字体大小
@property(nonatomic)CGFloat cornerRadius;// 圆角大小
@property(nonatomic, strong)NSString *placeStr;// 最大长度

- (void)initView;//初始化界面
@end
