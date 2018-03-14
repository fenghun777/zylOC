//
//  ZyUtils.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyUtils : NSObject

//MARK: 获取随机数，范围是max
+ (NSString *)zy_random:(NSInteger)max;

//view加border，控制是否给上左下右加边框，可以扩展到button label等控件
+ (void)zy_SetBorderColor:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

//控制上面的两个角变为圆角（corner 圆角）
+ (void)zy_SetBorderCorner:(UILabel *)lblOrg size:(CGSize)size;

+(NSMutableDictionary *)clientPrepareHttpParameters:(NSMutableDictionary *)dictionary;

+(NSString *)timeStamp;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

+(NSString *)formattedTime:(NSDate *)thedate;

//+(NSString *)encryptHash:(NSString *)token withDateline:(NSString *)dateline;

+ (UIColor *) colorWithHexString: (NSString *)color; // 十六进制转颜色值
+ (UIImage *) TileImage:(UIImage *)image AndEdgeInsets:(UIEdgeInsets) insets; //图片平铺
//时间戳转化为时间
+ (NSString *)changeTimeStamp:(NSString *)timeStamp WithFormat:format;
+ (UIImage *)makeDefaultHeadImage:(NSString *)username andUserId:(NSString *)uid andWidth:(float)w;
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize; // 裁剪正方形图片

+ (UIImage *) cutImageFromImage:(UIImage *)image cutToSize:(CGSize) newsize bgcolor:(UIColor *)color;

#pragma mark 根据宽等比压缩图片
+ (UIImage *)resizeImage:(UIImage *)image ByWidth:(float) width;

#pragma mark 等比压缩图片
+ (UIImage *)resizeImage:(UIImage *)image FromSize:(CGSize) size;

+ (CGSize)resizeSize:(CGSize)osize fromsize:(CGSize)size;


+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

+ (CGSize)getContentSize:(NSString *)content font:(UIFont *)font width:(float)width;

+ (NSString *)pinyinFirstCharactor:(NSString *)aString;

+ (NSDictionary *)sortByLetter:(NSArray *)arr;

//把字符串中的汉字转化成utf8
+ (NSString *)chineseToUTF8:(NSString *)str;

//把double转变成string 解决精度问题
+ (NSString *)doubleToString:(id)dou;

//设置商品打折标志
+ (NSString *)setProductRemark:(NSString *)typeStr;

//设置价格显示
+ (NSString *)setPriceShow:(double)price;

//自动计算UITextView高度
+ (float)textViewHeight:(UITextView *)textView andWidth:(float)width;

//设置UITextView行距
+ (void)textViewLineSpacing:(UITextView *)textView lineSpacing:(CGFloat)lineSpacing;

//获取客户类型名称
+ (NSString *)clientCategoryName:(int)category;

//显示服务器返回的错误
+ (void)showErrorMessage:(NSError *)error;

//证书有效期验证, 返回"":正常 danger:过期 warnging:一月内过期
+ (NSString *)certValidate:(NSString *)timeStampStr;

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -

#pragma mark -


@end
