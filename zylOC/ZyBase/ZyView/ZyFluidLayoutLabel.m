//
//  ZyFluidLayoutLabel.m
//  zylOC
//
//  Created by 张钰营 on 2018/5/24.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyFluidLayoutLabel.h"

@implementation ZyFluidLayoutLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initData:(NSArray *)arrData andVertical:(CGFloat)VDistance andLevel:(CGFloat)LDistance font:(CGFloat)font labelHeight:(CGFloat)height viewWidth:(CGFloat)viewWidth{
    //    __block更改作用于，加上之后在block内 可以修改该值
    CGFloat leftMar = 0;//距离左边距离
    CGFloat topMar = 0;//距离顶部距离
    CGFloat labelHeight = 0;//标签高度
    CGFloat labelWidth = 0;//标签宽度
    for (int i = 0; i < arrData.count; i++) {
        NSString *title = arrData[i];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:height]};
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(0, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        labelHeight = titleSize.height;
        labelWidth = titleSize.width;
        
        UILabel *lbl = [UILabel zy_InitWithTitle:arrData[i] font:FONT(font) color:COLOR_TEXT_TITLE bgcolor:[UIColor yellowColor] radius:0 bkWhenTap:^{
            
        }];
        [self addSubview:lbl];
        lbl.layer.masksToBounds = true;
        lbl.layer.borderColor = [[UIColor redColor] CGColor];
        lbl.layer.borderWidth = 1;
        lbl.layer.cornerRadius = labelHeight/2;
        
        if ((leftMar + labelWidth + LDistance) > viewWidth) {
            if (leftMar == 0) {
                echo(@"单行距离超过一行");
                labelWidth = viewWidth;
            }
            topMar = VDistance + labelHeight + topMar;
            leftMar = 0;
        }
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(leftMar);
            make.top.equalTo(self).offset(topMar);
            make.size.mas_equalTo(CGSizeMake(labelWidth + font/2, labelHeight));
        }];
        leftMar = LDistance + labelWidth + leftMar;
    }    
    _viewHeight = topMar + labelHeight;
}




@end
