//
//  NSDate+ZyCategory.h
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZyCategory)

//获取当前时间的时间戳
+ (NSString *)zy_TimeStamp;

//获取系统是24小时制或者12小时制
+ (BOOL)zy_DateIs24Or12;

/*标准时间日期描述*/
+(NSString *)zy_FormattedTime:(NSDate *)thedate;

@end
