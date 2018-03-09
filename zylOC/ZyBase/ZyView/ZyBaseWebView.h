//
//  ZyBaseWebView.h
//  jkbs_base
//
//  Created by iosdev1 on 2017/2/21.
//  Copyright © 2017年 iosdev1. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef void(^GetWebTitleBlock)(NSString *strTitle);//获得web的title 传递给控制器
typedef void(^GetWebSizeBlock)(CGRect frame);//重新设置web的size
@interface ZyBaseWebView : WKWebView
@property (nonatomic, strong) GetWebTitleBlock getWebTitleBlock;
@property (nonatomic, strong) GetWebSizeBlock getWebSizeBlock;
/*!
 @method
 @brief 加载Url
 @discussion
 @param url
 */
- (void) ZyLoadUrl:(NSString *) url;

/*!
 @method 读取本地HTML
 @brief 加载Url
 @discussion
 @param url
 */
- (void) ZyLoadLocationUrl:(NSString *) url;

/*!
 @method 读取无参数HTML
 @brief 加载Url
 @discussion
 @param url
 */
- (void) ZyLoadNoneParaUrl:(NSString *) url;
@end
