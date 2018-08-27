//
//  ZyFluidLayoutLabel.h
//  zylOC
//
//  Created by 张钰营 on 2018/5/24.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZyFluidLayoutLabel : UIView

//label的显示区域
@property (nonatomic) CGFloat viewHeight;
//@property (nonatomic) CGFloat viewHeight;

/*!
 * @method
 * @brief 设置流式布局的label
 * @param arrData 传入的数据
 * @param VDistance 垂直距离
 * @param LDistance 水平距离
 * @param font 字体大小
 */
- (void)initData:(NSArray *)arrData andVertical:(CGFloat)VDistance andLevel:(CGFloat)LDistance font:(CGFloat)font labelHeight:(CGFloat)height viewWidth:(CGFloat)viewWidth;

@end
