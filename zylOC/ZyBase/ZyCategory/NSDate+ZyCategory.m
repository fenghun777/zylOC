//
//  NSDate+ZyCategory.m
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSDate+ZyCategory.h"

@implementation NSDate (ZyCategory)

+(NSString *)zy_TimeStamp{    
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

+ (BOOL)zy_DateIs24Or12{
//    NSString *formatStringForHours=[NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
//    NSRange containsA=[formatStringForHours rangeOfString:@"a"];
//    BOOL hasAMPM=containsA.location!=NSNotFound;
//    if (hasAMPM==true)
//    {
//        echo(@"为12小时制");
//    }
//    else
//    {
//        echo(@"为24小时制");
//    }
//    return hasAMPM;
    
    
    BOOL is24Hours = YES;
    NSString *dateStr = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    NSArray  *sysbols = @[[[NSCalendar currentCalendar] AMSymbol],[[NSCalendar currentCalendar] PMSymbol]];
    for (NSString *symbol in sysbols) {
        if ([dateStr rangeOfString:symbol].location != NSNotFound) {//find
            is24Hours = NO;
            break;
        }
    }
    return is24Hours;
}

+ (NSString *)zy_ChangeTimeStamp:(NSString *)timeStamp WithFormat:(NSString *)format{
    //    @"YYYY-MM-dd HH:mm:ss"//设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    if ([format containsString:@"HH"]) {
        if ([NSDate zy_DateIs24Or12]) {
            [format stringByReplacingOccurrencesOfString:@"HH" withString:@"hh"];
        }
    }else if ([format containsString:@"hh"]) {
        if (![NSDate zy_DateIs24Or12]) {
            [format stringByReplacingOccurrencesOfString:@"hh" withString:@"HH"];
        }
    }
    
    if (![timeStamp isKindOfClass:[NSString class]]) {
        timeStamp = [NSString stringWithFormat:@"%@", timeStamp];
    }
    if([timeStamp isEqualToString:@"0"]) {
        return @"-";
    }
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]]];
}



















@end
