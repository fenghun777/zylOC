//
//  NSString+ZyCategory.h
//  zylOC
//
//  Created by yy z on 2018/3/12.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZyCategory)

#pragma mark - 把字符串中的汉字转化成utf8
+ (NSString *)zy_ChineseToUTF8:(NSString *)str API_DEPRECATED_WITH_REPLACEMENT("把字符串中的汉字转化成utf8",ios(2.0,14.0));

//sha加密
+(NSString *)zy_Sha1:(NSString *)input;

//MD5加密
+(NSString *)zy_Md5:(NSString *)input;

@end
