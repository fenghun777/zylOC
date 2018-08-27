//
//  ZyMarginHeader.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#ifndef ZyMarginHeader_h
#define ZyMarginHeader_h

//顶部状态栏的高度
#define STATUSBAR_HEIGHT ((WIDTH == 375.0 && HEIGHT == 812.0) ? 44:20)
//底部tabbar的高度
#define TABBAR_HEIGHT ((WIDTH == 375.0 && HEIGHT == 812.0) ? 79:45)
//顶部导航栏的高度
#define NAVBAR_HEIGHT ((STATUSBAR_HEIGHT) + 44)
//阴影部分
#define SHADOW_HEIGHT (17)
//根据667适配高度
#define HSCALE ([UIScreen mainScreen].bounds.size.height/667)
//根据375适配宽度
#define WSCALE ([UIScreen mainScreen].bounds.size.width/375)

//所有的边距的长度
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)

//控件距离控制器的距离
#define Margin_Top 16  //距离顶部
#define Margin_Left 16  //距离左边
#define Margin_Bottom -16  //距离底部
#define Margin_Right -16  //距离右边

//分割线的厚度
#define Margin_SegmentLine 1  //分割线的厚度




#endif /* ZyMarginHeader_h */
